;;; MOZI-AI Annotation Scheme
;;; Copyright © 2019 Abdulrahman Semrie
;;; Copyright © 2020 Ricardo Wurmus
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

(define-module (annotation parser)
  #:use-module (opencog)
  #:use-module (opencog exec)
  #:use-module (annotation graph)
  #:use-module (annotation util)
  #:use-module (ice-9 match)
  #:export (atomese->graph
            atomese-parser))

(define annts '("main" "gene-go-annotation" "gene-pathway-annotation" "biogrid-interaction-annotation" "rna-annotation"))

(define *nodes* '())
(define *edges* '())
(define *atoms* '())
(define *annotation* "")
(define *prev-annotation* "")

(define (handle-eval-ln predicate lns)
  (match predicate
    ((or "expresses"
         "interacts_with"
         "inferred_interaction"
         "transcribed_to"
         "translated_to")
     (set! *edges* (cons (create-edge (cadr lns)
                                      (car lns)
                                      predicate
                                      (list *annotation*)
                                      "" predicate)
                         *edges*))
     '())
    ((or "has_name" "GO_name")
     (if (member (car lns) *atoms*)
         (when (and (not (string-null? *prev-annotation*))
                    (not (string=? *prev-annotation* *annotation*)))
           (let* ([node (car (filter (lambda (n)
                                       (string=? (node-info-id (node-data n))
                                                 (car lns)))
                                     *nodes*))]
                  [node-group (node-info-group (node-data node))])
             ;;check if it is the same node and exit if it is
             (when (string=? (car node-group) *annotation*)
               '())
             (node-info-group-set! (node-data node)
                                   (append node-group (list *annotation*)))))
         (begin
           (set! *nodes*
                 (cons (create-node (car lns) (cadr lns)
                                    (build-desc-url (car lns))
                                    ""
                                    (list *annotation*)
                                    (find-subgroup (car lns)))
                       *nodes*))
           (set! *atoms*
                 (cons (car lns) *atoms*))))
     '())
    ("GO_namespace"
     (if (and (member (car lns) *atoms*)
              (string=? (car lns) (node-info-id (node-data (car *nodes*)))))
         (node-info-subgroup-set! (node-data (car *nodes*)) (cadr lns)))
     '())
    ("has_pubmedID"
     (edge-info-pubid-set! (edge-data (car *edges*)) (string-join (flatten lns) ","))
     '())
    ("has_location"
     (when (and (member (car lns) *atoms*)
                (string=? (car lns) (node-info-id (node-data (car *nodes*)))))
       (let* ([info (node-data (car *nodes*))]
              [old-loc (node-info-location info)]
              [new-loc (cadr lns)])
         (if (string-null? old-loc)
             (node-info-location-set! info new-loc)
             (unless (string-contains old-loc new-loc)
               (node-info-location-set! info (string-append old-loc "," new-loc))))
         '())))
    (_ (error "Unrecognized predicate" predicate))))

(define (handle-ln node-a node-b link)
  (set! *edges*
        (cons (create-edge node-a node-b link (list *annotation*) "" link)
              *edges*)))

(define (handle-list-ln node)
  (cond [(string? node) (list node)]
        [else   (flatten node)]))

(define (handle-node node)
  (when (member node annts)
    (set! *prev-annotation* *annotation*)
    (set! *annotation* node))
  node)

(define (atomese->graph expr)
  "Recursively traverse the Atomese expression EXPR and build up a
graph by mutating global variables."
  (define (expr->graph thing)
    (match (cog-type thing)
      ;; nodes
      ((or 'PredicateNode
             'GeneNode
             'MoleculeNode) (cog-name thing)) 
      ('ConceptNode
       (handle-node (cog-name thing)))
      ('VariableNode
       #f) ; ignore

      ;; member links
      ('MemberLink
       (handle-ln (expr->graph (gar thing))
                  (expr->graph (gdr thing))
                  "annotates"))

      ;; inheritance links
      ('InheritanceLink
       (handle-ln (expr->graph (gar thing))
                  (expr->graph (gdr thing))
                  "child_of"))

      ;; eval links
      ('EvaluationLink
       (handle-eval-ln (expr->graph (gar thing))
                       (expr->graph (gdr thing))))

      ;; lists
      ((or 'ListLink 'SetLink 'AndLink OrLink)
       (map expr->graph (cog-outgoing-set thing)))

      ;; This shouldn't happen
      (unknown (pk 'unknown unknown #false))))
  (expr->graph expr))

(define* (atomese-parser port #:optional mode)
  (set! *nodes* '())
  (set! *edges* '())
  (set! *atoms* '())
  (set! *annotation* "")
  (set! *prev-annotation* "")
  (atomese->graph port)
  (make-graph *nodes* *edges*))
