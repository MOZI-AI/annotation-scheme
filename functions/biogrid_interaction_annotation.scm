(define (biogrid_interaction_annotation)
    (set! result (list (ConceptNode "biogrid_interaction_annotation")))
    
    (for-each (lambda (gene)
        (for-each (lambda (g)
            (set! result (append result 
                    (list (EvaluationLink (PredicateNode "interacts_with") (ListLink gene g)))))
                    )(cog-outgoing-set (findGeneInteractor gene)))
    ) gene_nodes)
 
  result
)   

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
