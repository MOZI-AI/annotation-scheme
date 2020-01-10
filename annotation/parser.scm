;;; MOZI-AI Annotation Scheme
;;; Copyright © 2019 Abdulrahman Semrie
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
    #:use-module (annotation main)
    #:use-module (nyacc lalr)
    #:use-module (nyacc lex)
    #:use-module (nyacc parse)
    #:use-module (opencog)
    #:use-module (opencog exec)
    #:use-module (opencog bioscience)
    #:use-module (json)
    #:use-module (ice-9 optargs)
;    #:use-module (rnrs base)
    #:use-module (rnrs exceptions)
    #:use-module (ice-9 textual-ports)
    #:use-module (ice-9 regex)
    #:use-module (ice-9 threads)
    #:use-module (srfi srfi-1)
    #:use-module (ice-9 atomic)
    #:export (atomese-parser
            handle-node
            handle-eval-ln
            handle-ln
    )
)

(define annts '("main" "gene-go-annotation" "gene-pathway-annotation" "biogrid-interaction-annotation" "rna-annotation"))

(define-public (handle-eval-ln predicate lns)
    (call/cc (lambda (k)
            (let* ()
                (cond ([or (string=? predicate "expresses")
                        (string=? predicate "interacts_with") 
                        (string=? predicate "inferred_interaction")
                        (string=? predicate "transcribed_to")
                        (string=? predicate "translated_to")]
                            (begin  
                                (edges (append (list (create-edge (cadr lns) (car lns) predicate (list (annotation)) "" predicate)) (edges)))
                                '()                
                            )   
                        )
                    ((or (string=? predicate "has_name") (string=? predicate "GO_name"))
                        (begin  
                                (if (member (car lns) (atoms))
                                (if (and (not (string-null? (prev-annotation)))
                                        (not (string=? (prev-annotation) (annotation)))
                                    )
                                     (let* (
                                        [node (car (filter (lambda (n) 
                                            (string=? (node-info-id (node-data n)) (car lns))
                                        ) (nodes)))]
                                        [node-group (node-info-group (node-data node))]
                                    )   
                                        ;;check if it is the same node and exit if it is
                                        (if (string=? (car node-group) (annotation))
                                            (k '())
                                        )
                                        (node-info-group-set! (node-data node)  (append node-group (list (annotation))))
                                    )
                                    
                                )
                                (begin 
                                    (nodes (append (list (create-node (car lns) (cadr lns) (build-desc-url (car lns)) "" (list (annotation)) (find-subgroup (car lns)))) (nodes)))
                                    (atoms (append (list (car lns)) (atoms)))
                                )
                            )
                            '()
                        )
                        
                    )
                    ((string=? predicate "GO_namespace")
                      (begin  
                        (if (and (member (car lns) (atoms)) (string=? (car lns)                   (node-info-id (node-data (car (nodes))))))
                                (node-info-subgroup-set! (node-data (car (nodes))) (cadr lns))
                            )
                        '()
                       )
                    )

                    ((string=? predicate "has_pubmedID")
                        (begin  
                            (edge-info-pubid-set! (edge-data (car (edges))) (string-join lns ","))
                            '()
                        )
                    )
                    ((string=? predicate "has_location")
                        (begin  (if (and (member (car lns) (atoms)) (string=? (car lns) (node-info-id (node-data (car (nodes))))))
                        (let* ([info (node-data (car (nodes)))]
                               [old-loc (node-info-location info)]
                               [new-loc (cadr lns)]
                            )
                            (if (string=? old-loc "")
                                (node-info-location-set! info new-loc)
                                (if (not (string-contains old-loc new-loc))
                                    (node-info-location-set! info (string-append old-loc "," new-loc))
                                )
                            )
                           '()
                        
                        )))
                    )
                    (else (error "Unrecognized predicate" predicate))
                    
                )
            )
    )
    )
)

(define-public (handle-ln node-a node-b link)
        (begin 
             (edges (append (list (create-edge node-a node-b link (list (annotation)) "" link)) (edges)))
            '()
        )
)

(define-public (handle-list-ln node)
    (let ()
            (cond [(string? node) (list node)]
                    [else   (flatten node)]
            )
        
    )
)

(define-public (handle-node node)
      (begin (if (member node annts)
          (begin 
              (prev-annotation (annotation))
              (annotation node)
          )
      ))
      node   
)

(define* (atomese-parser port #:optional (mode #f))
    (let* (
        [spec (lalr-spec


                (start input)
                (grammar
                    (input 
                        ("(" links ")")
                        (links)
                    )
                    (links
                        (link ($$ $1))
                        (links link ($$ (list $1 $2)))
                    )

                    (link 
                        (list-ln)
                        (eval-ln)
                        (inheritance-ln)
                        (member-ln)
                        (and-ln)
                        (or-ln)
                    )

                    (and-ln
                        ("(" "And" links ")")
                        ("(" "AndLink" links ")")
                    )
                    (or-ln
                        ("(" "Or" links ")")
                        ("(" "OrLink" links ")")
                    )

                    (list-ln 
                        ("(" "List" nodes ")" ($$ (handle-list-ln $3)))
                        ("(" "List" links ")" ($$ (handle-list-ln $3)))
                        ("(" "List" links nodes ")" ($$ (handle-list-ln $4)))
                        ("(" "List" nodes links ")" ($$ (handle-list-ln $3)))
                        ("(" "List" ")") ;empty ListLink
                        ("(" "ListLink" nodes ")" ($$ (handle-list-ln $3)))
                        ("(" "ListLink" links ")" ($$ (handle-list-ln $3)))
                        ("(" "ListLink" links nodes ")" ($$ (handle-list-ln $4)))
                        ("(" "ListLink" nodes links ")" ($$ (handle-list-ln $3)))
                        ("(" "ListLink" ")") ;empty ListLink
                    )

                    (eval-ln
                        ("(" "Evaluation" node list-ln ")" ($$ (handle-eval-ln $3 $4)))
                        ("(" "Evaluation" "(" "stv" $fixed $fixed ")" node list-ln ")" ($$ (handle-eval-ln $8 $9)))
                        ("(" "EvaluationLink" node list-ln ")" ($$ (handle-eval-ln $3 $4)))
                        ("(" "EvaluationLink" "(" "stv" $fixed $fixed ")" node list-ln ")" ($$ (handle-eval-ln $8 $9)))
                    )

                    (member-ln
                        ("(" "Member" node node ")" ($$ (handle-ln $3 $4 "annotates")))
                        ("(" "Member" "(" "stv" $fixed $fixed ")" node node ")" ($$ (handle-ln $8 $9 "annotates")))
                        ("(" "MemberLink" node node ")" ($$ (handle-ln $3 $4 "annotates")))
                        ("(" "MemberLink" "(" "stv" $fixed $fixed ")" node node ")" ($$ (handle-ln $8 $9 "annotates")))
                    )
                    (inheritance-ln 
                        ("(" "Inheritance" node node ")" ($$ (handle-ln $3 $4 "child_of")))
                        ("(" "Inheritance" "(" "stv" $fixed $fixed ")" node node ")" ($$ (handle-ln $8 $9 "child_of")))
                        ("(" "InheritanceLink" node node ")" ($$ (handle-ln $3 $4 "child_of")))
                        ("(" "InheritanceLink" "(" "stv" $fixed $fixed ")" node node ")" ($$ (handle-ln $8 $9 "child_of")))
                    )
                    (nodes
                        (node ($$ $1))
                        (nodes node ($$ (list $1 $2)))
                    )

                    (node
                        ("(" "Predicate" $string ")" ($$ $3))
                        ("(" "PredicateNode" $string ")" ($$ $3))
                        ("(" "Concept" $string ")" ($$ (handle-node $3)))
                        ("(" "ConceptNode" $string ")" ($$ (handle-node $3)))
                        ("(" "Gene" $string ")" ($$ $3))
                        ("(" "GeneNode" $string ")" ($$ $3))
                        ("(" "MoleculeNode" $string ")" ($$ $3))
                        ("(" "Molecule" $string ")" ($$ $3))
                        ("(" "Variable" $string ")")
                        ("(" "VariableNode" $string  ")")
                    )
            ))]
        [mach (make-lalr-machine spec)]
        [mtab (lalr-match-table mach)]
        [gen-lexer (make-lexer-generator mtab)]
        [raw-parser (make-lalr-parser mach)])

    (begin 
        (with-input-from-string port 
                (lambda () (raw-parser (gen-lexer) #:debug mode)
            )
        )
        (make-graph (nodes) (edges))
        )
    )

)
