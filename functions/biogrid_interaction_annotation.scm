
(define (biogrid_interaction_annotation)
    	(define gen_int '())
	(define prot_int '())
    	(set! result (list (ConceptNode "biogrid_interaction_annotation")))
    
    (for-each (lambda (gene)

	(if (equal? interaction "proteins")
	     (set! result (append result (cog-outgoing-set (findProtInteractor gene)))))

	(if (equal? interaction "genes") 
           (begin
		(set! result (append result (cog-outgoing-set (matchGeneInteractors gene))))
                ;; check for output genes if interacting to each other
		(set! gen_int (cog-outgoing-set (findGeneInteractor gene)))
	        (for-each (lambda (g)
	            (set! gen_int (cdr gen_int))
		    (for-each (lambda (r)
    			(if (member g (cog-outgoing-set (findGeneInteractor r)))
    				(set! result (append result 
				(list (EvaluationLink (PredicateNode "interacts_with") (ListLink g r))))))
   		    ) gen_int)
		)(cog-outgoing-set (findGeneInteractor gene)))))

    )gene_nodes)

  result
)
