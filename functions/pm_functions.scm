;; a set of helper methods

;; Parser PM functions

(define-syntax try
    (syntax-rules (catch)
      ((_ body (catch catcher))
       (call-with-current-continuation
        (lambda (exit)
          (with-exception-handler
           (lambda (condition)
             catcher
             (exit condition))
           (lambda () body)))))))

(define (get-params p)
 (if(equal? (cog-type p) 'ListLink)
    (map (lambda (t)
        (cog-name t)
        ) (cog-outgoing-set p))

    (list (cog-name p)))
)

(define (multi-word x)
    (string-join (get-params x))
)
(define (remove-set-ln ln)
    (if (cog-atom? ln)
        (cog-outgoing-set ln)
        '()
    )
)

(define (get-name atom)
 (if (> (length atom) 0)
  (cog-name (car  atom))
  ""
 )
)

;;finds go name for parser function
(define find-name
    (lambda (atom)
     (let*
        (
          [predicate (if (regexp-match? (string-match "GO:[0-9]+" (cog-name atom))) "GO_name" "has_name")]
        )
      (get-name
       (remove-set-ln
        (cog-execute!
         (GetLink
          (VariableNode "$name")

          (EvaluationLink
           (PredicateNode predicate)
           (ListLink
            atom
            (VariableNode "$name")
           )
          )
         )
        )
       )
      )
    )
    )
)

;;finds go definition for parser function
(define find-godef
    (lambda (go)

      (cog-outgoing-set
       (cog-execute!
        (GetLink
         (VariableNode "$def")

         (EvaluationLink
          (PredicateNode "GO_definition")
          (ListLink
           go
           (VariableNode "$def")
          )
         )
        )
      )
     )
    )
)

;;Given an atom and list of namespaces finds the parents of that atom in the specified namespaces
(define find-parent

  (lambda (node namespaces)
        (let (
          [atom (cog-outgoing-atom node 1)]
          [parents '()]
        )
        (for-each (lambda (ns)
          (set! parents (append parents (cog-outgoing-set (cog-execute! (BindLink
            (VariableNode "$a")
            (AndLink
              (InheritanceLink
                atom
                (VariableNode "$a"))
              (EvaluationLink
                (PredicateNode "GO_namespace")
                (ListLink
                  (VariableNode "$a")
                  (ConceptNode ns)
                )
              )
            )
          (ExecutionOutputLink
              (GroundedSchemaNode "scm: add-go-info")
                (ListLink
                  atom
                  (VariableNode "$a")
                ))
        ))))) 
        )
      )
    parents  
  )
))

;;Finds Go terms of a gene
(define find-memberln 
  (lambda (gene namespaces)
    (let ([go-atoms '()])

      (for-each (lambda (ns)
      
        (set! go-atoms (append go-atoms (cog-outgoing-set (cog-execute! (BindLink
            (VariableNode "$a")
            (AndLink
              (MemberLink
                gene
                (VariableNode "$a"))
                (EvaluationLink
                (PredicateNode "GO_namespace")
                (ListLink
                  (VariableNode "$a")
                  (ConceptNode ns)
                )
              )
            ) 
           (ExecutionOutputLink
              (GroundedSchemaNode "scm: add-go-info")
                (ListLink
                  gene
                  (VariableNode "$a")
                ))
          )))))
      ) namespaces)
          go-atoms
          ))
)

;;
(define (add-go-info child-atom parent-atom)
  (if (and (equal? (cog-type child-atom) 'GeneNode)
      (equal? (list-ref (string-split (cog-name parent-atom) #\:) 0) "GO"))
    (ListLink  
      (MemberLink
          child-atom
          parent-atom
      )
      (go-info parent-atom)
    )
    (begin
      (if (equal? (list-ref (string-split (cog-name parent-atom) #\:) 0) "GO")
        (ListLink 
            (InheritanceLink
        child-atom
        parent-atom
          )
      (go-info parent-atom)
      )
    ))
  )
)

;;the main function to find the go terms for a gene with a specification of the parents
(define find-go-term 
  (lambda (g namespaces p)
      (let (
        [res  (find-memberln (GeneNode g) namespaces)]      
      )
      (define parents (flatten (let loop (
        [i p]
        [ls res]
        [acc '()]
      )
      (cond 
        [(= i 0) (append ls acc)]
        [(null? ls) acc]
        [else (cons (loop (- i 1)  (find-parent (car (cog-outgoing-set (car ls))) namespaces) (append ls acc)) (loop i (cdr ls) '()))
          ]
      )
      )))
       (delete-duplicates parents)
    )
  ))

;; Add details about the GO term
(define (go-info go)
(list
(EvaluationLink (PredicateNode "GO_namespace") (ListLink go (if (equal? (find-GO-ns go) '()) (ConceptNode "") (find-GO-ns go))))
(EvaluationLink (PredicateNode "has_name") (ListLink go (if (equal? (cog-outgoing-set (findGoname go)) '() ) (ConceptNode "") (cog-outgoing-set (findGoname go)))))
(EvaluationLink (PredicateNode "has_definition") (ListLink go (if (equal? (find-godef go) '()) (ConceptNode "") (find-godef go)))) 
))

;; Finds parents of a GO term ( of given namespace type) 
(define find-GO-ns 
  (lambda (go)
    (cog-outgoing-set (cog-execute!
            (GetLink
                (VariableNode "$v")
                (EvaluationLink 
                    (PredicateNode "GO_namespace")
                    (ListLink 
                      go
                      (VariableNode "$v")
                    )
                 )
                )
    ))
  
  )
)

;; Finds the name of a GO term
(define findGoname
    (lambda(go)
        (cog-execute! (GetLink
            (VariableNode "$a")
            (EvaluationLink
               (PredicateNode "GO_name")
               (ListLink
               go
               (VariableNode "$a")
              )
            )
           )
        )
    )
)

;; Finds the namespace of a GO term
(define (find-GO-ns go)
(remove-set-ln
       (cog-execute!
        (GetLink
         (VariableNode "$ns")

         (EvaluationLink
          (PredicateNode "GO_namespace")
          (ListLink
           go
           (VariableNode "$ns")
          )
         )
        )
       )
      )
)

;; Finds the definition of a GO term
(define (find-godef go)
(remove-set-ln
       (cog-execute!
        (GetLink
         (VariableNode "$def")

         (EvaluationLink
          (PredicateNode "GO_definition")
          (ListLink
           go
           (VariableNode "$def")
          )
         )
        )
       )
      )
)

;; Finds a concept where a gene is a member of
(define (findMember gene)
(cog-execute! (GetLink
    (VariableNode "$a")
    (MemberLink
       gene
       (VariableNode "$a"))
    )))


;; Finds entrez_id of a gene
(define (find_entrez gene)
 (get-name
   (remove-set-ln
    (cog-execute!
     (GetLink
       (VariableNode "$a")
       (EvaluationLink
        (PredicateNode "has_entrez_id")
        (ListLink
         gene
         (VariableNode "$a")
        )
       )
    )
   )
  )
 )
)

;; Finds proteins a gene expresses
(define findprotein
    (lambda(gene)
        (cog-execute! (GetLink
            (VariableNode "$a")
            (EvaluationLink
               (PredicateNode "expresses")
               (ListLink
               gene
               (VariableNode "$a")
              )
            )
    ))))

;;Finds a name of any node (Except GO which has different structure)
(define findpwname
    (lambda(pw)
        (cog-execute! (GetLink
            (VariableNode "$a")
            (EvaluationLink
               (PredicateNode "has_name")
               (ListLink
               pw
               (VariableNode "$a")
              )
            )
))))

;; Finds molecules (proteins or chebi's) in a pathway 
(define (findmol path)
  (cog-execute! (GetLink
    (VariableNode "$a")
    (MemberLink
       (VariableNode "$a")
       path))
  )
)

;; append a list into a list to collect the result in one List
(define (append . lsts)
  (cond
    ((null? lsts) '())
    ((null? (car lsts)) (apply append (cdr lsts)))
    (else (cons (caar lsts) (apply append (cdar lsts) (cdr lsts))))))


;; Finds genes interacting with a given gene
(define matchGeneInteractors
    (lambda(gene)
        (cog-execute! (BindLink
            (VariableList
            (TypedVariable (VariableNode "$a") (Type 'GeneNode)))

            (EvaluationLink
               (PredicateNode "interacts_with")
               (ListLink
               gene
               (VariableNode "$a")
              )
            )
            (ExecutionOutputLink
              (GroundedSchemaNode "scm: generate-result")
                (ListLink
                  gene
                  (VariableNode "$a")
                ))
    ))	
))

;;; Finds output genes interacting eachother 
(define outputInteraction
    (lambda(gene)
        (cog-execute! (BindLink
          (VariableList
            (TypedVariable (VariableNode "$a") (Type 'GeneNode))
            (TypedVariable (VariableNode "$b") (Type 'GeneNode)))

          (And  
            (EvaluationLink
               (PredicateNode "interacts_with")
               (ListLink
               gene
               (VariableNode "$a")
              ))

            (EvaluationLink
               (PredicateNode "interacts_with")
               (ListLink
               (VariableNode "$a")
               (VariableNode "$b")
              ))

            (EvaluationLink
               (PredicateNode "interacts_with")
               (ListLink
                gene
               (VariableNode "$b")
              ))
          )
          (ExecutionOutputLink
            (GroundedSchemaNode "scm: generate-result")
              (ListLink
                (VariableNode "$a")
                (VariableNode "$b")
              ))
    ))	
))

;; Finds Protein-protein equivalence of a gene-gene interaction 
(define findProtInteractor
  (lambda(gene)
     (cog-execute! (BindLink
 
 	  (VariableList
      (TypedVariable (VariableNode "$a") (Type 'GeneNode))
      (TypedVariable (VariableNode "$b") (Type 'MoleculeNode))
	    (TypedVariable (VariableNode "$c") (Type 'MoleculeNode)))
	  
	 (And 
      (EvaluationLink
        (PredicateNode "expresses")
          (ListLink
            gene
            (VariableNode "$c")
      ))

	    (EvaluationLink
	     (PredicateNode "interacts_with")
		    (ListLink
		      gene
		      (VariableNode "$a")
		  ))

	    (EvaluationLink
	     (PredicateNode "expresses")
		    (ListLink
		      (VariableNode "$a")
		      (VariableNode "$b")
		 ))
	 )

  ;; This will be executed if the above pattern is found.
  (ExecutionOutputLink
    (GroundedSchemaNode "scm: generate-result")
		  (ListLink
		    (VariableNode "$c")
		    (VariableNode "$b")
		  ))
	
))
))

;; Find node name and description

(define (node-info node)
    (ListLink
      (EvaluationLink (PredicateNode "has_name") (ListLink node (node-name node)))
      (EvaluationLink (PredicateNode "has_definition") (ListLink node (Concept (build-desc-url node))))
    )
)

(define (node-name node)
(let
    ([lst (cog-outgoing-set (findpwname node))]
    [name ""])
    (if (>= (length lst) 1)
	(set! name (list-ref lst 0))
	(set! name (ConceptNode "")))
name
)

)

;; Add location of a gene/Molecule node in context of Reactome pathway

(define (add-loc node)
(let ([child (cog-outgoing-atom node 0)] 
      [parent (cog-outgoing-atom node 1) ])
(cog-outgoing-set (cog-execute!
  (BindLink
    (VariableNode "$loc")
    (AndLink
      (MemberLink (stv 1 1) 
        child
        parent)
      (EvaluationLink (stv 1 1)
        (PredicateNode "has_location")
        (ListLink
          child
          (VariableNode "$loc")))
    )
      (EvaluationLink (stv 1 1)
        (PredicateNode "has_location")
        (ListLink
          child
          (VariableNode "$loc")))
    )
  )))
)