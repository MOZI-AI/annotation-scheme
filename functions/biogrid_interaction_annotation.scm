
(define (biogrid-interaction-annotation gene_nodes interaction)
  (let ([result (list (ConceptNode "biogrid-interaction-annotation"))])
    
	(for-each (lambda (gene)
		(if (equal? interaction "Proteins")
		     (set! result (append result  (match-gene-interactors gene  1) (find-protein-interactor gene (Number 1))  (find-output-interactors gene)))
		)

		(if (equal? interaction "Genes") 
			(set! result (append result  (match-gene-interactors gene 0)
				 (find-output-interactors gene)
			))
		)
	) (mapSymbol gene_nodes))

  (ListLink result)
  )
)
