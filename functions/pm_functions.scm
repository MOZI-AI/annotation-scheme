;; a set of helper methods
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

;;

(define (findMember gene)
(cog-execute! (GetLink
    (VariableNode "$a")
    (MemberLink
       gene
       (VariableNode "$a"))
    )))


;;

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

;;


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
;;

;; can also be used to get any node name beside pathway, Except GO (which has different structure)

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

;;

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

;;



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

;;;

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
;;;


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
)
)