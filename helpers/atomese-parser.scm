(use-modules (srfi srfi-1))
(use-modules (rnrs io ports))
(use-modules (ice-9 popen))
(use-modules (ice-9 optargs))
(use-modules (ice-9 rdelim))
(use-modules (ice-9 regex))
(use-modules (ice-9 getopt-long))
(use-modules (ice-9 eval-string))
(use-modules (ice-9 receive))
(use-modules (nyacc lalr))
(use-modules (nyacc lex))
(use-modules (nyacc parse))

(define nodes (make-parameter '()))
(define edges (make-parameter '()))
(define atoms (make-parameter '()))
(define genes (make-parameter '()))

(define handle-eval-ln (lambda (predicate lns)
            (let* ()
                (cond ([or (string=? predicate "expresses")
                        (string=? predicate "interacts_with")]
                        (begin 
                        (edges (append (list (create-edge (cadr lns) (car lns) predicate annotation "" predicate)) (edges)))
                        '()
                        )
                    )
                    ((string=? predicate "has_name")
                        (if (not (member (car lns) (atoms)))
                            (begin 
                                
                                (nodes (append (list (create-node (genes) (car lns) (cadr lns) "" "" annotation)) (nodes)))
                                (atoms (append (list (car lns)) (atoms)))
                            )
                        )
                       '()
                        
                    )
                    ((string=? predicate "has_definition")
                        (if (member (car lns) (atoms))
                            (node-info-defn-set! (node-data (car (nodes))) (cadr lns))
                        )
                        '()
                    )

                    ((string=? predicate "GO_namespace")
                      (if (member (car lns) (atoms))
                            (node-info-subgroup-set! (node-data (car (nodes))) (cadr lns))
                        )
                       '()
                    )

                    ((string=? predicate "has_pubmedId")
                        (begin 
                        (edge-info-pubid-set! (edge-data (car (edges))) (string-join (cdr lns) ","))
                        '()
                        )
                    )
                    ((string=? predicate "has_location")
                        (let* ([info (node-data (car (nodes)))]
                               [loc (node-info-location info)]
                            )
                            (if (string=? loc "")
                                (node-info-location-set! info (cadr lns))
                                (node-info-location-set! info (string-append loc "," (cadr lns)))
                            )
                           '()
                        
                        )
                    )
                    (else (error (format #f "Unrecognized predicate ~a" predicate)))
                    
                )
 )))

(define handle-ln (lambda (node-a node-b link)
        (let ()
            (edges (append (list (create-edge node-a node-b link annotation "" link)) (edges)))
            '()           
        ))
)

(define handle-list-ln (lambda (node)
        (let ()
                (cond [(and (string? node) (member node annts))
                    (begin 
                        (set! annotation node)
                        node
                    )]
                    [(string? node) (list node)]
                    [else   (flatten node)]
                )
            
    )))
(define annts '("gene-go-annotation" "gene-pathway-annotation" "biogrid-interaction-annotation"))
(define (atomese-parser port)
    (let* (
        [spec (lalr-spec


                (start links)
                (grammar
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
                    ("(" "List" ")" ($$ '()) ) ;empty ListLink
                    ("(" "ListLink" nodes ")" ($$ (handle-list-ln $3)))
                    ("(" "ListLink" links ")" ($$ (handle-list-ln $3)))
                    ("(" "ListLink" links nodes ")" ($$ (handle-list-ln $4)))
                    ("(" "ListLink" nodes links ")" ($$ (handle-list-ln $3)))
                    ("(" "ListLink" ")" ($$ '()) ) ;empty ListLink
                )

                (eval-ln
                    ("(" "Evaluation" node list-ln ")" ($$ (handle-eval-ln $3 $4)))
                    ("(" "Evaluation" "(" "stv" $fixed $fixed ")" node list-ln ")" ($$ (handle-eval-ln $4 $5)))
                    ("(" "EvaluationLink" node list-ln ")" ($$ (handle-eval-ln $3 $4)))
                    ("(" "EvaluationLink" "(" "stv" $fixed $fixed ")" node list-ln ")" ($$ (handle-eval-ln $4 $5)))
                )

                (member-ln
                    ("(" "Member" node node ")" ($$ (handle-ln $3 $4 "annotates")))
                    ("(" "Member" "(" "stv" $fixed $fixed ")" node node ")" ($$ (handle-ln $4 $5 "annotates")))
                    ("(" "MemberLink" node node ")" ($$ (handle-ln $3 $4 "annotates")))
                    ("(" "MemberLink" "(" "stv" $fixed $fixed ")" node node ")" ($$ (handle-ln $4 $5 "annotates")))
                )
                (inheritance-ln 
                    ("(" "Inheritance" node node ")" ($$ (handle-ln $3 $4 "child_of")))
                    ("(" "Inheritance" "(" "stv" $fixed $fixed ")" node node ")" ($$ (handle-ln $4 $5 "child_of")))
                    ("(" "InheritanceLink" node node ")" ($$ (handle-ln $3 $4 "child_of")))
                    ("(" "InheritanceLink" "(" "stv" $fixed $fixed ")" node node ")" ($$ (handle-ln $4 $5 "child_of")))
                )
                (nodes
                    (node ($$ $1))
                    (nodes node ($$ (list $1 $2)))
                )

                (node
                    ("(" "Predicate" $string ")" ($$ $3))
                    ("(" "PredicateNode" $string ")" ($$ $3))
                    ("(" "Concept" $string ")" ($$ $3))
                    ("(" "ConceptNode" $string ")" ($$ $3))
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
                (lambda () (raw-parser (gen-lexer))
            )
        )
        (make-graph (nodes) (edges))
)))