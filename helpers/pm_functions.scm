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

(define findGene    
    (lambda(go)
        (cog-execute! 
            (GetLink
                (VariableNode "$g")
                (MemberLink
                    (VariableNode "$g")
                    go
                    )
                )
            )
     
        )
    )
(define findAboutGene
    (lambda(go)
        (cog-execute! (GetLink
            (VariableNode "$a")
            ;; The pattern to be searched for
            (MemberLink
                go
                (VariableNode "$a"))
        ;        The value to be returned.
            )
            
            )
    )
    
    
)

(define (findCommonGenes x y)
    (remove-set-ln (cog-execute!
        (GetLink
            (VariableNode "$g")

            (AndLink
                (MemberLink
                    (VariableNode "$g")
                        x
                )	
                (MemberLink
                    (VariableNode "$g")
                    y
                )
            )
        
        )
        
    ))

)

(define (findCommonCategories x y)
    (cog-execute!
        (GetLink
            ; The variable to be searched for
            (VariableNode "$go")
            ; The pattern to be searched for
            (AndLink
                (MemberLink
                    x
                    (VariableNode "$go")    
                )    
                (MemberLink
                    y
                    (VariableNode "$go")    
                )    
            )
        )
    )
)
(define findGO
    (lambda (go)
    (cog-execute! 
        (GetLink
            (VariableNode "$g")
            (MemberLink
                go
                (VariableNode "$g")
                )
            )
        )
 
    )
    
    )

(define findSynonym
    (lambda (go)
        (cog-execute!
            (GetLink
                (VariableNode "$go")
                (EvaluationLink 
                    (PredicateNode "GO_synonym_EXACT")
                    (ListLink 
                        go
                        (VariableNode "$go")
                    )
                    )

                
                )
            )
    
    )
    
    )

(define findSynonymNarraow
    (lambda (go)
        (cog-execute!
            (GetLink
                (VariableNode "$var")
                (EvaluationLink 
                    (PredicateNode "GO_synonym_NARROW")
                    (ListLink 
                        go
                        (VariableNode "$var")
                    )
                    )
                
                )
            
            )

    )
    
    )

(define findRelatedSynonym
    (lambda (go)
        (cog-execute!
            (GetLink
                (VariableNode "$var")
                (EvaluationLink 
                    (PredicateNode "GO_synonym_RELATED")
                    (ListLink 
                        go
                        (VariableNode "$var")
                    )
                    )
                
                )
            
            )
    
    )
        
        )

(define find-GO 
    (lambda (x)
        (let* 
            (
                [term (multi-word x)]
                [go (string-match "GO:[0-9]+" term)]

            )
            (if (regexp-match? go)
                (set! go (ConceptNode (match:substring go)))
                (try 
                    (set! go (car (find-GO-term (ConceptNode term))))
                    (catch 
                        (set! go #f)
                    )
                    ))
                
             go    
            )
       
    )
    
)   

(define find-GO-name
    (lambda (go)
        (try
            (cog-name (car (remove-set-ln (cog-execute! 
                (GetLink
                    (VariableNode "$name")
    
                    (EvaluationLink 
                        (PredicateNode "GO_name")
                        (ListLink 
                            go
                            (VariableNode "$name")
                        )
                        )
                    
                    )
                
                ))))
            (catch 
                (cog-name go)
                )
            )
    
    )
    
)

(define find-GO-def
    (lambda (go)
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
(define find-GO-term
        (lambda (name)
            (remove-set-ln (cog-execute! 
                (GetLink
                    (VariableNode "$go")
    
                    (EvaluationLink 
                        (PredicateNode "GO_name")
                        (ListLink 
                            (VariableNode "$go")
                            name
                        )
                        )
                    
                    )
                
                ))
        
        )
        
)
(define findNamespace
    (lambda (go)    
        (car (map find-GO-term (remove-set-ln (cog-execute!
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
            ))))
    
    )
    
    )

(define part-of-1
    (lambda (go)
        (cog-execute!
            (GetLink
                (VariableNode "$var")
                (EvaluationLink 
                    (PredicateNode "GO_part_of")
                    (ListLink 
                      (VariableNode "$var")
                       go
                    )
                 )
                
                )
            
            )
    
    )
    
    )

(define part-of-2
    (lambda (go)
        (cog-execute!
            (GetLink
                (VariableNode "$a")
                (EvaluationLink 
                    (PredicateNode "GO_part_of")
                    (ListLink 
                       go
                       (VariableNode "$a")
                    )
                 )
                )
            
            )
    
    )
    
    
    )



(define positive-regulates
    (lambda (go)
        (cog-execute! 
            (GetLink
                (VariableNode "$var")
                (EvaluationLink 
                    (PredicateNode "GO_positively_regulates")
                    (ListLink 
                        (VariableNode "$var")
                        go
                    )
                 )
                
                
                )
            
            )
    
    )
    
    )
    
(define negativelty-regulates
    (lambda (go)
        (cog-execute!
            (GetLink
                (VariableNode "$var")
                (EvaluationLink 
                    (PredicateNode "GO_negatively_regulates")
                    (ListLink 
                        (VariableNode "$var")
                        go
                    )
                 )
                
                )
            
            )
    
    )
    
)

(define regulates
    (lambda (go)
        (cog-execute! 
            (GetLink
                (VariableNode "$var")
                (EvaluationLink 
                    (PredicateNode "GO_regulates")
                    (ListLink 
                      (VariableNode "$var")
                      go
                    )
                 )
                
                )
            )
    )
    
    )

(define findAncestor
    (lambda (go)
        (let*
            (
                [ls '()]
            )
            (set! ls (remove-set-ln (cog-execute! 
                    (GetLink
                        (VariableNode "$a")
                        (InheritanceLink
                            go
                            (VariableNode "$a")
                            )
                        
                        )
                
                )))
            ;;Since we have InheritanceLink between the Concept "GO_term" and GO terms
            (set! ls (filter (lambda (x) (regexp-match? (string-match "GO:[0-9]+" (cog-name x)))) ls))
            ls
            )
    )
    
)

(define findChildren
    (lambda (go)
        (remove-set-ln (cog-execute! 
            (GetLink
                (VariableNode "$a")
                (InheritanceLink
                    (VariableNode "$a")
                    go
                    )
                
                )
        
        ))
    )
    
)

(define (findGONS gox goy)
        (cog-execute!
            
            (GetLink
                (VariableNode "$g")
                (AndLink
                    (EvaluationLink 
                        (PredicateNode "GO_namespace")
                        (ListLink
                            (VariableNode "$g")
                            gox
                        )
                    )
                    (MemberLink
                        goy
                        (VariableNode "$g")
                        
                        )
                    
                    )
                
                )
            )
)

(define (findGeneFunc gene)
    (cog-execute! (GetLink
        (VariableNode "$m")
        (AndLink
            (MemberLink
                gene
                (VariableNode "$m")
            )
            (EvaluationLink
                (PredicateNode "GO_namespace")
                (ListLink
                    (VariableNode "$m")
                    (ConceptNode "molecular_function")
                    )
                )
            
            
            )

    ))
)

(define (findGORel relType go)
    (let* (
        [ls '()]
        
    )
         ;;change po_reg and neg_reg to GO_pos_reg and GO_neg_reg respectively
        (if (string=? "is_a")
            (let ()
              (set! ls (append (findAncestor go) (findChildren go)))
            )
            (let (
                [is-reg (string-match "(positively|negatively)?.?regulates" relType)]
                [pred ""]
            ) 
            (if is-reg
                (let*
                    (
                        [charset (char-set #\sp #\-)]
                        [str-ls (string-split (match:substring is-reg) charset)]
                    )
                    (if (string=? (match:substring is-reg) "regulates") (set! relType (string-append "GO_" (match:substring is-reg)))   
                        (set! relType (string-append "GO_" (car str-ls) "_" (cadr str-ls)))
                    )
                    )
                (set! relType (string-append "GO_" relType))) 

            (set! pred (PredicateNode relType))
            (set! ls (remove-set-ln (cog-execute! 
                (GetLink
                    (VariableNode "$var")
                    (EvaluationLink
                        pred
                        (ListLink
                            go
                            (VariableNode "$var")
                            )
                        
                        )
                    )
                
                
                )))
            
            )
        ) 
        ls        
    )
)

(define (findCellComp go)
    (gdar (cog-execute! (GetLink
        (VariableList
            (VariableNode "$g")
            (VariableNode "$c")
            )
        (AndLink
            (MemberLink
                (VariableNode "$g")
                go
                )

            (MemberLink
                (VariableNode "$g")
                (VariableNode "$c")
                )
            (EvaluationLink
                (PredicateNode "GO_namespace")
                (ListLink
                    (VariableNode "$c")
                    (ConceptNode "cellular_component")
                    )
                )
            
            )
        )))

)

(define (findBioProcess go)
    (remove-set-ln (cog-execute! (GetLink
        (VariableList
            (VariableNode "$g")
            (VariableNode "$c")
            )
        (AndLink
            (MemberLink
                (VariableNode "$g")
                go
                )

            (MemberLink
                (VariableNode "$g")
                (VariableNode "$c")
                )
            (EvaluationLink
                (PredicateNode "GO_namespace")
                (ListLink
                    (VariableNode "$c")
                    (ConceptNode "biological_process")
                    )
                )
            
            )
        )))

)

(define (findRel gox goy)
    (remove-set-ln (cog-execute! 
        (GetLink
            (VariableList
                (VariableNode "$rel")
                (VariableNode "$g")
            )
            (AndLink
                (MemberLink
                    (VariableNode "$g")
                    gox
                )
                (MemberLink
                    (VariableNode "$g")
                    goy
                )
                
                (OrLink
                    (EvaluationLink
                    (VariableNode "$rel")
                    (ListLink
                        gox
                        goy
                    ))
                    (EvaluationLink
                        (VariableNode "$rel")
                        (ListLink
                            goy
                            gox
                        ))
                )
                ))
        
    ))

)

(define (findMolFunc go)
    (remove-set-ln (cog-execute! (GetLink
        (VariableList
            (VariableNode "$g")
            (VariableNode "$c")
            )
        (AndLink
            (MemberLink
                (VariableNode "$g")
                go
                )

            (MemberLink
                (VariableNode "$g")
                (VariableNode "$c")
                )
            (EvaluationLink
                (PredicateNode "GO_namespace")
                (ListLink
                    (VariableNode "$c")
                    (ConceptNode "molecular_function")
                    )
                )
            
            )
        )))
)

(define (findSubProc go)
   (remove-set-ln (cog-execute! (GetLink
        (VariableNode "$p")
        (AndLink
            ;;this is not necessary to check, but let it be here anyway
            (EvaluationLink
                (PredicateNode "GO_namespace")
                (ListLink 
                    (VariableNode "$p")
                    (ConceptNode "biological_process")
                )
                
                )
            (EvaluationLink
                (PredicateNode "GO_part_of")
                (ListLink
                    (VariableNode "$p")
                    go
                    )
                
                )
            
            )
        
        )))

)

;; patterns extracted from go-plus dataset

(define (defineGO go)   
  (remove-set-ln 
	(cog-execute! 
	(GetLink
	        
            (VariableNode "$g")
            
        
	   (EvaluationLink
	   (PredicateNode "has definition")
	   (ListLink 
	     go
	     (VariableNode "$g")
	   ))
		
        )
        )
    )
 )

(define GOAlternativeID    
    (lambda(go)
        (cog-execute! 
            (GetLink
                (VariableNode "$g")

		(EvaluationLink
		(PredicateNode "hasAlternativeId")
		(ListLink 
		go
        (VariableNode "$g")
        )
    )
        )
      )
    )
 )

(define GOReferenceLink    
    (lambda(go)
        (cog-execute! 
            (GetLink
                (VariableNode "$g")

		(EvaluationLink
		(PredicateNode "hasReferenceLink")
		(ListLink 
		go
		(VariableNode "$g")
		))
        )
      )
    )
 )
