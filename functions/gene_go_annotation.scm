(define* (gene-go-annotation gene_nodes namespace #:optional (parents 0))
    (let (
    )
  (ListLink (flatten (map (lambda (gene) 
      (find-go-term gene namespace parents)
  
  ) gene_nodes)))
  )
)