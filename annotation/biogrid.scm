(define-module (annotation biogrid)
	#:use-module (annotation functions)
	#:use-module (annotation util)
    #:use-module (opencog)
    #:use-module (opencog query)
    #:use-module (opencog exec)
    #:use-module (opencog bioscience)
)
(define-public (biogrid-interaction-annotation gene_nodes interaction)
  (let ([result (list (ConceptNode "biogrid-interaction-annotation"))])
    
	(for-each (lambda (gene)
		(if (equal? interaction "Proteins")
		     (set! result (append result(match-gene-interactors (GeneNode gene))(find-prot-interactor (GeneNode gene))
			 (output-interaction (GeneNode gene))
			 ))
			 
		) 

		(if (equal? interaction "Genes") 
	      (begin
				(set! result (append result  (match-gene-interactors (GeneNode gene))))
	        ;; Add output genes interacting to each other
	        	(set! result (append result  (output-interaction (GeneNode gene))))
	      ))

    ) gene_nodes)

  (ListLink result)
  )
)
