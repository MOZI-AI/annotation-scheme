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
    #:use-module (annotation biogrid)
    #:use-module (annotation parser)
    #:use-module (opencog)
    #:use-module (opencog query)
    #:use-module (opencog exec)
    #:use-module (opencog bioscience)
    #:use-module (json)
    #:use-module (ice-9 match)
    #:use-module (ice-9 threads)
    #:use-module (rnrs base)
    #:use-module (rnrs bytevectors)
    #:use-module (ice-9 futures)
)

(define-public (find-genes gene-list)
  "Validate if given gene strings in GENE-LIST exist in the
atomspace."
  (let ((unknown (filter (lambda (gene)
                           (null? (cog-node 'GeneNode gene)))
                         gene-list)))
    (match unknown
      (() "0")
      (_ (string-append "1:" (string-join unknown ","))))))

(define-public (gene-info genes)
  "Add the name and description of gene nodes to the given list of GENES."
  (let* ((info
         (map (lambda (gene)
                (list (ListLink (node-info (GeneNode gene))
                                (ListLink (locate-node (GeneNode gene))))))
              genes))
              
        (res (ListLink (ConceptNode "main") info))     
        )
        (write-to-file res (id) "main")
        res
  )
)

(define-public (mapSymbol gene-list)
  "Map gene symbols into GeneNodes."
  (map GeneNode gene-list))


(define-public (parse-request gene-list req)
    (let (
        (table (if (string? req) (json-string->scm req) (json-string->scm (utf8->string (u8-list->bytevector req))) ))
    )
      (append (list (lambda () (gene-info gene-list))) (map (lambda (ht) 
    (let* (
        (func-name (string->symbol (hash-ref ht "function_name")))
        (func (variable-ref (module-variable (current-module) func-name)))
        (filters (hash-ref ht "filters"))
        (args  (flatten (map (lambda (f)
         (list (eval-string (string-append "#:" (hash-ref f "filter"))) 
            (if (string->number (hash-ref f "value"))
                (string->number (hash-ref f "value"))
                (hash-ref f "value")
            ))
         ) filters))))
        (lambda () (apply func gene-list args))
    )) table)) )
)

(define-public (annotate-genes genes-list file-name request)
  (parameterize ( (id file-name)
                  (nodes '()) 
                  (edges '()) 
                  (atoms '()) 
                  (biogrid-genes '())
                  (biogrid-pairs '())
                  (annotation "")
                  (prev-annotation "")
              )
      (let* (
        [fns (parse-request genes-list request)]
        [result (par-map (lambda (x) (x)) fns)]
        )
         (scm->json-string (atomese-parser (format #f "~a" result)))
      )
  )
)