(use-modules (srfi srfi-1))
(use-modules (rnrs io ports))
(use-modules (ice-9 popen))
(use-modules (ice-9 optargs))
(use-modules (ice-9 rdelim))
(use-modules (ice-9 regex))
(use-modules (ice-9 getopt-long))
(use-modules (ice-9 eval-string))
(use-modules (ice-9 receive))
(use-modules (system base lalr))
(use-modules (ice-9 hash-table))

(define hash-tb (alist->hash-table `((ConceptNode .  ,(make-regexp (string-append "^[ \t]*" "ConceptNode" "[ \t]*"))) (Concept . ,(make-regexp (string-append "^[ \t]*" "Concept" "[ \t]*"))) 
   (PredicateNode .  ,(make-regexp (string-append "^[ \t]*" "PredicateNode" "[ \t]*"))) (Predicate . ,(make-regexp (string-append "^[ \t]*" "Predicate" "[ \t]*"))) 

   (GeneNode . ,(make-regexp (string-append "^[ \t]*" "GeneNode" "[ \t]*"))) (Gene . ,(make-regexp (string-append "^[ \t]*" "Gene" "[ \t]*")))
   (MoleculeNode . ,(make-regexp (string-append "^[ \t]*" "MoleculeNode" "[ \t]*"))) (Molecule . ,(make-regexp (string-append "^[ \t]*" "Molecule" "[ \t]*")))
    (ListLink . ,(make-regexp (string-append "^[ \t]*" "ListLink" "[ \t]*"))) (List . ,(make-regexp (string-append "^[ \t]*" "List" "[ \t]*")))
   (EvaluationLink . ,(make-regexp (string-append "^[ \t]*" "EvaluationLink" "[ \t]*"))) (Evaluation . ,(make-regexp (string-append "^[ \t]*" "Evaluation" "[ \t]*")))

   (MemberLink . ,(make-regexp (string-append "^[ \t]*" "MemberLink" "[ \t]*"))) (Member . ,(make-regexp (string-append "^[ \t]*" "Member" "[ \t]*")))  

   (InheritanceLink . ,(make-regexp (string-append "^[ \t]*" "InheritanceLink" "[ \t]*"))) (Inheritance . ,(make-regexp (string-append "^[ \t]*" "Inheritance" "[ \t]*"))) 

   (OrLink . ,(make-regexp (string-append "^[ \t]*" "OrLink" "[ \t]*"))) (Or . ,(make-regexp (string-append "^[ \t]*" "Or" "[ \t]*"))) 

   (AndLink . ,(make-regexp (string-append "^[ \t]*" "AndLink" "[ \t]*"))) (And . ,(make-regexp (string-append "^[ \t]*" "And" "[ \t]*"))) 
   
   (stv . ,(make-regexp (string-append "^[ \t]*" "stv" "[ \t]*")))

   (num . ,(make-regexp (string-append "^[ \t]*" "[0-9]+[0-9.]*\\b" "[ \t]*")))

   (qoute . ,(make-regexp (string-append "^[ \t]*" "\"" "[ \t]*")))

    (name . ,(make-regexp (string-append "^[ \t]*" "[^\"]+" "[ \t]*")))

    (lparen . ,(make-regexp (string-append "^[ \t]*" "\\(" "[ \t]*")))

      (rparen . ,(make-regexp (string-append "^[ \t]*" "\\)" "[ \t]*")))
)))


(define (get-source-location port column)
    (make-source-location (port-filename port) (port-line port) column (false-if-exception (ftell port)) #f)
)

(define (tokenize str location)
    (let* (
        [current-match '()]
        [has-match? (lambda (pattern str) 
            (let ([match (regexp-exec pattern str)])
                (if match
                 (begin (set! current-match match) #t)
                    #f))

        )]

        [result:suffix (lambda (token location value) 
            (cons 
                (make-lexical-token token location value)
                (match:suffix current-match)
            )
        )]
    )
     (cond 
        [(has-match? (hash-ref hash-tb 'lparen) str) (result:suffix 'LPAREN location #f)]
        [(has-match? (hash-ref hash-tb 'rparen) str) (result:suffix 'RPAREN location #f)]
        [(string=? str "") (cons (make-lexical-token 'NEWLINE location #f) "")]
        [(or (has-match? (hash-ref hash-tb 'ListLink) str) (has-match? (hash-ref hash-tb 'List) str))
         (result:suffix 'LIST location #f)
        ]
        [(or (has-match? (hash-ref hash-tb 'ConceptNode) str)
            (has-match? (hash-ref hash-tb 'Concept) str)
        )
         (result:suffix 'CONCEPT location #f)
        ]
        [(or (has-match? (hash-ref hash-tb 'PredicateNode) str) (has-match? (hash-ref hash-tb 'Predicate) str))
            (result:suffix 'PREDICATE location #f)
        ]
        [(or (has-match? (hash-ref hash-tb 'EvaluationLink) str) (has-match? (hash-ref hash-tb 'Evaluation) str))
            (result:suffix 'EVALUATION location #f)
        ]
        [(or (has-match? (hash-ref hash-tb 'InheritanceLink) str) (has-match? (hash-ref hash-tb 'Inheritance) str))
            (result:suffix 'INHERITANCE location #f)
        ]
        [(or (has-match? (hash-ref hash-tb 'MemberLink) str) (has-match? (hash-ref hash-tb 'Member) str))
            (result:suffix 'MEMBER location #f)
        ]
        [(or (has-match? (hash-ref hash-tb 'OrLink) str) (has-match? (hash-ref hash-tb 'Or) str))
            (result:suffix 'OR location #f)
        ]
        [(or (has-match? (hash-ref hash-tb 'AndLink) str) (has-match? (hash-ref hash-tb 'And) str))
            (result:suffix 'AND location #f)
        ]
        [(or (has-match? (hash-ref hash-tb 'GeneNode) str) (has-match? (hash-ref hash-tb 'Gene) str))
            (result:suffix 'GENE location #f)
        ]
        [(or (has-match? (hash-ref hash-tb 'MoleculeNode) str) (has-match? (hash-ref hash-tb 'Molecule) str))
            (result:suffix 'MOLECULE location #f)
        ]
        [(has-match? (hash-ref hash-tb 'stv) str)
            (result:suffix 'TRUTHVALUE location #f)
        ]
        [(has-match? (hash-ref hash-tb 'num) str)
            (result:suffix 'NUM location (string-trim-both (match:substring current-match)))
        ]
        [(has-match? (hash-ref hash-tb 'qoute) str)
          (result:suffix 'DQUOTE location #f)
        ]
        [(has-match? (hash-ref hash-tb 'name) str)
          (result:suffix 'NAME location (string-trim-both (match:substring current-match)))
        ]

        ;;[(string=? "" str) (result:suffix 'NEWLINE location #f)]

        [else (cons (make-lexical-token 'NotDefined location str) "")]
     
     )
    
    )
)

(define (make-lexer port)
  (let ((cs-line "") (initial-line ""))
    (lambda ()
      (if (string=? "" cs-line)
        (begin
          (set! cs-line (read-line port))
          (set! initial-line cs-line)
        ))
      (let ((port-location (get-source-location port
              (if (eof-object? cs-line)
                0
                (string-contains initial-line cs-line)))))
        (if (eof-object? cs-line)
          '*eoi*
          (let ((result (tokenize cs-line port-location)))
            ; This is a sanity check for the tokenizer
            (if (pair? result)
              (begin
                (set! cs-line (cdr result))
                (car result))
              (error (format #f "Tokenizer issue => ~a," result))
            )))))
  )
)
; (define nodes '())
; (define edges '())
; (define atoms '())
(define (atomese-parser genes)
    (let (
          [annotation "biogrid"]
        )
    (define (handle-eval-ln predicate lns)
            (let* ([elms (flatten lns)])
                (cond ([or (string=? predicate "expresses")
                        (string=? predicate "interacts_with")]
                        (set! edges (append (list (create-edge (car elms) (cadr elms) predicate annotation "" predicate)) edges))
                    )
                    ((string=? predicate "has_name")
                        (if (not (member (car elms) atoms))
                            (begin 
                                (set! nodes (append (list (create-node genes (car elms) (cadr elms) "" "" annotation)) nodes))
                                (set! atoms (append (list (car elms)) atoms))
                            )
                        )
                    )
                    ((string=? predicate "has_definition")
                        (if (member (car elms) atoms)
                            (node-info-defn-set! (node-data (car nodes)) (cadr elms))
                        )
                    )

                    ((string=? predicate "GO_namespace")
                      (if (member (car elms) atoms)
                            (node-info-subgroup-set! (node-data (car nodes)) (cadr elms))
                        )
                    )

                    ((string=? predicate "has_pubmedId")
                        (edge-info-pubid-set! (edge-data (car edges)) (string-join (cdr elms) ","))
                    )
                    ((string=? predicate "has_location")
                        (let* ([info (node-data (car nodes))]
                               [loc (node-info-location info)]
                            )
                            (if (string=? loc "")
                                (node-info-location-set! info (cadr elms))
                                (node-info-location-set! info (string-append loc "," (cadr elms)))
                            )
                        
                        )
                    )
                    (else (error (format #f "Unrecognized predicate ~a" predicate)))
                    
                )
        )
    )

    (define (handle-ln node-a node-b link)
        (let ()
            (set! edges (append (list (create-edge node-a node-b link annotation "" link)) edges))
        )
    )

    (lalr-parser
        ;;Define the terminal symbols first
        (LIST EVALUATION PREDICATE CONCEPT GENE MOLECULE MEMBER INHERITANCE AND OR 
        LPAREN RPAREN NAME DQUOTE NEWLINE TRUTHVALUE NUM)

        ;;Parsing rules for nonterminal symbols
        (inputs 
            (links): #t
            (LPAREN links RPAREN): #t
        )

        (links
            (link): $1
            (links link): (list $1 $2)
        )

        (link 
            (list-ln): $1
            (eval-ln): $1
            (inheritance-ln): $1
            (member-ln): $1
            (and-ln): $1
            (or-ln): $1
            (enter): $1
        )

        (enter
            (an-enter): $1
            (enter an-enter): $1
        )

        (an-enter
            (NEWLINE): #f
        )

        (and-ln
            (LPAREN AND links RPAREN): $3
        )
        (or-ln
            (LPAREN OR links RPAREN): $3
        )

        (list-ln 
            (LPAREN LIST nodes RPAREN): (list $3)
            (LPAREN LIST enter nodes RPAREN): $4
            (LPAREN LIST links RPAREN): $3
            (LPAREN LIST links nodes RPAREN): (list $3 $4)
            (LPAREN LIST nodes links RPAREN): (list $4)
        )

        (eval-ln
            (LPAREN EVALUATION node list-ln RPAREN): (handle-eval-ln $3 $4)
            (LPAREN EVALUATION stv node list-ln RPAREN): (handle-eval-ln $4 $5)
        )

        (member-ln
            (LPAREN MEMBER node node RPAREN): (handle-ln $3 $4 "annotates")
            (LPAREN MEMBER stv node node RPAREN): (handle-ln $4 $5 "annotates")
        )

        (inheritance-ln 
            (LPAREN INHERITANCE node node RPAREN): (handle-ln $3 $4 "child_of")
            (LPAREN INHERITANCE stv node node RPAREN): (handle-ln $3 $4 "child_of")
        )

        (stv
            (LPAREN TRUTHVALUE NUM NUM RPAREN): #f
        )

        (nodes
          (node): $1
          (node enter): $1
          (nodes node): (cons $1 $2)
        )

        (node
            (predicate): $1
            (concept): $1
            (gene): $1
            (molecule): $1
        )
        (predicate
            (LPAREN PREDICATE name RPAREN): $3
        )

        (concept 
            (LPAREN CONCEPT name RPAREN): $3
        )
        (gene
            (LPAREN GENE name RPAREN): $3
        )
        (molecule
            (LPAREN MOLECULE name RPAREN): $3
        )
        (name 
            (DQUOTE NAME DQUOTE): $2
            (DQUOTE LPAREN NAME DQUOTE): (format #f "(~a" $3) ;for chemicals names that start with (
            (DQUOTE NUM NAME DQUOTE): (format #f "~a~a" $2 $3) ;for chemicals names that start with a number
            (DQUOTE LPAREN NUM NAME DQUOTE): (format #f "(~a~a" $3 $4) ;for chemicals names that start with ( and a number
            (DQUOTE DQUOTE): ""
        )
    )
))

(define-public (cs-parse genes port)
    (let* (
           [nodes '()]
           [edges '()]
           [atoms '()]
           [parser (atomese-parser genes)]
        )
        (parser (make-lexer port) error)
        (make-graph nodes edges)
    )
)