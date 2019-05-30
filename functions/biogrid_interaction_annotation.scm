
(define (biogrid-interaction-annotation gene_nodes interaction)
  (let ([result (list (ConceptNode "biogrid-interaction-annotation"))])
    
	(for-each (lambda (gene)
		(if (equal? interaction "proteins")
		     (set! result (append result (delete-duplicates (cog-outgoing-set (findProtInteractor gene))))))

		(if (equal? interaction "genes") 
	      (begin
				(set! result (append result (delete-duplicates (cog-outgoing-set (matchGeneInteractors gene)))))
	        ;; Add output genes interacting to each other
	        (set! result (append result (delete-duplicates (cog-outgoing-set (outputInteraction gene)))))
	      ))

    )(mapSymbol gene_nodes))

  (ListLink result)
))
