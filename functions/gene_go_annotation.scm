(define* (gene-go-annotation gene_nodes namespace #:optional (parents 0))
    (let (
    )
  (ListLink (ConceptNode "gene-go-annotation")
    (flatten (map (lambda (gene) 
      (find-go-term gene namespace parents)
  
  ) gene_nodes)))
  )
)
