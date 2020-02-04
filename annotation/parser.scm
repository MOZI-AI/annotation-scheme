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
    #:use-module (annotation util)
    #:use-module (json)
    #:use-module (ice-9 match)
    #:export (atomese->graph
              atomese-parser))

(define annts '("main" "gene-go-annotation" "gene-pathway-annotation" "biogrid-interaction-annotation" "rna-annotation"))

(define *nodes* '())
(define *edges* '())
(define *atoms* '())
(define *annotation* "")
(define *prev-annotation* "")

(define-public (handle-eval-ln predicate lns)
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

(define-public (handle-ln node-a node-b link)
  (set! *edges*
        (cons (create-edge node-a node-b link (list *annotation*) "" link)
              *edges*)))

(define-public (handle-list-ln node)
  (cond [(string? node) (list node)]
        [else   (flatten node)]))

(define-public (handle-node node)
  (when (member node annts)
    (set! *prev-annotation* *annotation*)
    (set! *annotation* node))
  node)

(define (atomese->graph expr)
  "Recursively traverse the Atomese expression EXPR and build up a
graph by mutating global variables."
  (define (expr->graph thing)
    (match thing
      ;; nodes
      (((or 'Predicate 'PredicateNode
             'Gene 'GeneNode
             'Molecule 'MoleculeNode)
        (? string? something)) something)
      (((or 'Concept 'ConceptNode)
        (? string? something))
       (handle-node something))
      (((or 'Variable 'VariableNode)
        (? string? anything))
       #false) ; ignore

      ;; member links
      ((or ((or 'Member 'MemberLink) ('stv _ _) node1 node2)
           ((or 'Member 'MemberLink) node1 node2))
       (handle-ln (expr->graph node1)
                  (expr->graph node2)
                  "annotates"))

      ;; inheritance links
      ((or ((or 'Inheritance 'InheritanceLink) ('stv _ _) node1 node2)
           ((or 'Inheritance 'InheritanceLink) node1 node2))
       (handle-ln (expr->graph node1)
                  (expr->graph node2)
                  "child_of"))

      ;; eval links
      ((or ((or 'Evaluation 'EvaluationLink) ('stv _ _) node1 list-link)
           ((or 'Evaluation 'EvaluationLink) node1 list-link))
       (handle-eval-ln (expr->graph node1)
                       (expr->graph list-link)))

      ;; lists
      (((or 'List 'ListLink) . children)
       (map expr->graph children))
      (((or 'And 'AndLink 'Or 'OrLink) . links)
       (map expr->graph links))

      ;; This shouldn't happen
      (unknown (pk 'unknown unknown #false))))
  (expr->graph expr))

(define* (atomese-parser port #:optional mode)
  (set! *nodes* '())
  (set! *edges* '())
  (set! *atoms* '())
  (set! *annotation* "")
  (set! *prev-annotation* "")
  (atomese->graph
   (with-input-from-string port
     read))
  (make-graph *nodes* *edges*))
