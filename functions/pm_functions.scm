
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
(cog-execute! (GetLink
            (VariableNode "$a")
            (EvaluationLink
               (PredicateNode "has_entrez_id")
               (ListLink
               gene
               (VariableNode "$a")
              )
            )
    ))
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

;;

(define findGeneInteractor
    (lambda(gene)
        (cog-execute! (GetLink
            (VariableNode "$a")
            (EvaluationLink
               (PredicateNode "interacts_with")
               (ListLink
               gene
               (VariableNode "$a")
              )
            )
    ))))

;; append a list into a list to collect the result in one List
(define (append . lsts)
  (cond
    ((null? lsts) '())
    ((null? (car lsts)) (apply append (cdr lsts)))
    (else (cons (caar lsts) (apply append (cdar lsts) (cdr lsts))))))
