;;; MOZI-AI Annotation Scheme
;;; Copyright © 2019 Abdulrahman Semrie
;;; Copyright © 2019 Hedra Seid
;;;
;;; This file is part of MOZI-AI Annotation Scheme
;;;
;;; MOZI-AI Annotation Scheme is free software; you can redistribute
;;; it and/or modify it under the terms of the GNU General Public
;;; License as published by the Free Software Foundation; either
;;; version 3 of the License, or (at your option) any later version.
;;;
;;; This software is distributed in the hope that it will be useful,
;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;;; General Public License for more details.
;;;
;;; You should have received a copy of the GNU General Public License
;;; along with this software.  If not, see
;;; <http://www.gnu.org/licenses/>.


(define-module (annotation main)
    #:use-module (annotation util)
    #:use-module (annotation gene-go)
    #:use-module (annotation gene-pathway)
    #:use-module (annotation graph)
    #:use-module (annotation gene-record)
    #:use-module (annotation biogrid)
    #:use-module (annotation string)
    #:use-module (annotation writer)
    #:use-module (annotation parser)
    #:use-module (opencog)
    #:use-module (opencog exec)
    #:use-module (opencog bioscience)
    #:use-module (ice-9 match)
    #:use-module (ice-9 threads)
    #:use-module (srfi srfi-43)
    #:use-module (rnrs bytevectors)
    #:use-module (rnrs hashtables)
    #:use-module (ice-9 futures)
    #:use-module (fibers)
    #:use-module (fibers channels)
    #:use-module (fibers conditions)
    #:use-module (ice-9 suspendable-ports)
    #:use-module (ice-9 textual-ports)
    #:use-module (srfi srfi-1)
    #:use-module (json)
    #:use-module (annotation functions)
    #:use-module (annotation rna)
    #:use-module (annotation go)
)

(install-suspendable-ports!)

(define protein-funcs '("gene-go-annotation" "gene-pathway-annotation" "biogrid-interaction-annotation" "string-interaction-annotation" "include-rna"))
(define go-funcs '("go-annotation"))

(define mods '((annotation biogrid) (annotation gene-pathway) (annotation gene-go) (annotation rna) (annotation string) (annotation go)))

(define-public (find-genes gene-list)
"
   find-genes GENE-LIST
   Validate if given gene strings in GENE-LIST exist in the atomspace.
"
  (let* ((records (filter-map (lambda (g)
                    (if (atom-exists? "GeneNode" g)
                        (let* ([curr (find-current-symbol g)])
                          (if (null? curr)
                            #f
                            (make-gene g (car curr) '())))
                        (make-gene g  "" (find-similar-gene g))
                        )) gene-list)))
        (if (null? records)
          "[]"
          (scm->json-string (list->vector (map gene-record->scm records))))))

(define-public (main-node-info nodes chans)
  "Add main node infos"
  (send-message (Concept "main") chans)
  (for-each (lambda (node)
                (send-message (node-info node) chans)
                (send-message (locate-node node) chans)
            ) nodes)
)

(define-public (parse-request req)
    (let (
        (table (if (string? req) (json-string->scm req) (json-string->scm (utf8->string (u8-list->bytevector req)))))
        (func-table (make-eq-hashtable)))

      (vector-for-each (lambda (i elm)
        (let*  ((func-name (assoc-ref elm "functionName"))
                (func (find-module func-name mods)))
          (if func 
            (let* (                
              (filters (assoc-ref elm "filters"))
              (args  (flatten (vector->list (vector-map (lambda (index f)
                (let* (
                  (filter (assoc-ref f "filter"))
                  (val (assoc-ref f "value")))
                  (list (with-input-from-string (string-append "#:" filter) read) 
                    (if (string->number val)
                        (string->number val)
                        (if (or (string=? val "True") (string=? val "False"))
                          (str->tv val)
                          val ))))) filters)))))
                (hashtable-set! func-table func-name (cons func args)))))) table)
      func-table))

(define (start-fiber atom inputs chans)
    (catch #t 
        (lambda ()                           
          (apply (car inputs) atom chans (cdr inputs))) 
        (lambda _
          (send-message 'eof chans))
        (let ((err (current-error-port)))
          (lambda (key . args)
            (false-if-exception
            (let ((stack (make-stack #t 4)))
              (format err "Uncaught exception in task:\n")
              ;; FIXME: Guile's display-backtrace isn't respecting
              ;; stack narrowing; manually passing stack-length as
              ;; depth is a workaround.
              (display-backtrace stack err 0 (stack-length stack))
              (print-exception err (stack-ref stack 0)
                                key args))))))
)

(define (process-request item-list file-name request)
  (let ((table (find-atom-type item-list)))
      (if (not (null? (hash-ref table "not-found")))
          (string-append "#f: " (string-join (hash-ref table "not-found") " "))
          (run-fibers
            (lambda ()
              (let* ((atom-lst (hash-ref table "found"))
                    (parser-chan (make-channel))
                    (writer-chan (make-channel))
                    (chans (list writer-chan parser-chan))
                    (functions (parse-request request))
                    (parser-port (open-file (get-file-path file-name file-name ".json") "w"))
                    (writer-port (open-file (get-file-path file-name "result") "w"))
                    (parser-cond (make-condition))
                    (writer-cond (make-condition)))

                    (spawn-fiber (lambda () (output-to-file (lambda () (get-message writer-chan)) writer-port writer-cond)))
                    (spawn-fiber (lambda () (atomese-parser (lambda () (get-message parser-chan)) parser-port parser-cond)))
                    
                    (main-node-info atom-lst chans)
                    (for-each (lambda (atom) 
                      (match (cog-type atom)
                        ((or 'UniprotNode 'GeneNode)
                          ;; Using the defualt guile hashtable association functions like hash-for-each creates a continuation barrier
                          ;; Hence why I'm using (rnrs hashtable) functions
                          (vector-for-each (lambda (index key) 
                            (if (member key protein-funcs)
                              (start-fiber atom (hashtable-ref functions key '()) chans))) (hashtable-keys functions)))
                        ((or 'CellularComponentNode 'BiologicalProcessNode 'MolecularFunctionNode)
                          (vector-for-each (lambda (index key) 
                            (if (member key go-funcs)
                              (start-fiber atom (hashtable-ref functions key '()) chans))) (hashtable-keys functions)))
                        (_ (send-message 'eof chans) (format #t "Unsupport annotation for ~a" atom)))) atom-lst)
                        
                        (send-message 'eof chans)             
                        (wait writer-cond)
                        (wait parser-cond))
        #:drain? #t)))))

(define-public (annotate-genes genes-list file-name request)
  (parameterize ((intr-genes (make-atom-set))
                 (gene-pairs (make-atom-set))
                 (biogrid-reported-pathways (make-atom-set))
                )
    (process-request genes-list file-name request)))

(define-public (annotate-go go-terms file-name request)
  (parameterize ()
    (process-request go-terms file-name request)))