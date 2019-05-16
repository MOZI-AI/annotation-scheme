
(define (biogrid_interaction_annotation interaction gene_nodes )
  (let ([result (list (ConceptNode "biogrid_interaction_annotation"))])
    
	(for-each (lambda (gene)
		(if (equal? interaction "proteins")
		     (set! result (append result (delete-duplicates (cog-outgoing-set (findProtInteractor gene))))))

		(if (equal? interaction "genes") 
	      (begin
				(set! result (append result (delete-duplicates (cog-outgoing-set (matchGeneInteractors gene)))))
	        ;; Add output genes interacting to each other
	        (set! result (append result (delete-duplicates (cog-outgoing-set (outputInteraction gene)))))
	      ))

    )gene_nodes)

  (ListLink result)
))
