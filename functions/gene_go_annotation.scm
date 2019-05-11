(define* (gene-go-annotation gene_nodes namespace #:optional (parents 0))
    (let (
      [hs (make-hash-table)]
    )
  (for-each (lambda (gene) 
      (hash-set! hs gene (find-go-term gene namespace parents))
  
  ) gene_nodes)
  hs
  )
) 