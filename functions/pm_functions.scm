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
    ))
)

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
            (VariableNode "$a")
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
    )	
)))

;;;

(define findGeneInteractor
    (lambda(gene)
        (cog-execute! (GetLink
            (VariableNode "$a")
            (EvaluationLink
               (PredicateNode "interacts_with")
               (ListLink
               gene
               (VariableNode "$a")
              ))
    )	
)))
;;;


(define findProtInteractor
  (lambda(gene)
     (cog-execute! (BindLink
	(VariableList
	 (VariableNode "$a")
	 (VariableNode "$b")
	 (VariableNode "$c"))
	 (And 
	    (EvaluationLink
	       (PredicateNode "interacts_with")
		  (ListLink
		      gene
		      (VariableNode "$a")
		  ))
	    (EvaluationLink
	       (PredicateNode "expresses")
		  (ListLink
		    gene
		    (VariableNode "$c")
		 ))
	    (EvaluationLink
	       (PredicateNode "expresses")
		  (ListLink
		    (VariableNode "$a")
		    (VariableNode "$b")
		 ))
	 )
	(if (and (equal? (cog-type (VariableNode "$c")) 'MoleculeNode) (equal? (cog-type (VariableNode "$c") 'MoleculeNode)))
		(EvaluationLink
		   (PredicateNode "interacts_with")
		       (ListLink
			(VariableNode "$c")
			(VariableNode "$b")
		))
		'()
	)))
))

