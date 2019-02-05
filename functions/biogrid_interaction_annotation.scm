

(define (biogrid_interaction_annotation)
    	(define gen_int '())
    	(set! result (list (ConceptNode "biogrid_interaction_annotation")))
    
    (for-each (lambda (gene)
	(set! gen_int (cog-outgoing-set (findGeneInteractor gene)))

	(if (equal? interaction "proteins")
	(for-each (lambda(pro)
		(for-each (lambda (int)
			(for-each (lambda (int_prot)
				(set! result (append result 
				(list (EvaluationLink (PredicateNode "interacts_with") (ListLink pro int_prot)))))
			) (cog-outgoing-set (findprotein int)))
		) gen_int)
        )(cog-outgoing-set (findprotein gene))))


	(if (equal? interaction "genes")
        (for-each (lambda (g)
            (set! result (append result 
                    (list (EvaluationLink (PredicateNode "interacts_with") (ListLink gene g)))))
                    )gen_int))
	 
    )gene_nodes)

    ;; TODO: check for resulting genes if interacting to each other

  result
)   

