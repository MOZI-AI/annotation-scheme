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
(define find-GO-def
    (lambda (go)
     (get-name
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
    )
)

;;; Annotation's PM functions

;; Finds a GO term of specific namespace for a given gene g 
(define (findGoterm g namespace)
        (cog-execute! (GetLink
            (VariableNode "$a")
            (AndLink
              (MemberLink
                g
                (VariableNode "$a"))
              (EvaluationLink
               (PredicateNode "GO_namespace")
                 (ListLink
                   (VariableNode "$a")
                  (ConceptNode namespace)
                  )
                )
            )

            )
))

;; Finds parents of a GO term ( of given namespace type) 
(define (parent_finder go namespace)
   (cog-execute! (GetLink
            (VariableNode "$a")
            (AndLink
              (InheritanceLink
                go
                (VariableNode "$a"))
              (EvaluationLink
               (PredicateNode "GO_namespace")
                 (ListLink
                   (VariableNode "$a")
                  (ConceptNode namespace)
                  )
                )
            )

            )
))

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

;; Finds a concept where a gene is a member of
(define (findMember gene)
(cog-execute! (GetLink
    (VariableNode "$a")
    (MemberLink
       gene
       (VariableNode "$a"))
    ))
)

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
	     (EvaluationLink
	       (PredicateNode "interacts_with")
		      (ListLink
		        gene
		        (VariableNode "$a")))
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
            (EvaluationLink
               (PredicateNode "interacts_with")
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

		(EvaluationLink
		  (PredicateNode "interacts_with")
		   (ListLink
			   (VariableNode "$c")
			   (VariableNode "$b")
		))
	
	))
))

