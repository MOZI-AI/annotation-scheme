(define (gene-pathway-annotation gene_nodes pathway prot small_mol)
    (let ([result (list (ConceptNode "gene-pathway-annotation"))])

    (for-each (lambda (gene)
    (for-each (lambda (pathw)
        (if (equal? pathw "smpdb")
            (set! result (append result (smpdb gene prot small_mol)))
            )
        (if (equal? pathw "reactome")
            (set! result (append result (reactome gene prot small_mol)))
            )
        )(string-split pathway #\ ))
    ) gene_nodes)
 
  (ListLink result)
))  


;; From SMPDB 

(define (smpdb gene prot sm)
  (let (
    [pw (findMember (GeneNode gene) "SMP")]
    [ls '()]
  )

  (set! ls (flatten (map (lambda (path)
      (let (
        [node (cog-outgoing-atom (cog-outgoing-atom path 0) 1)]
        [tmp '()]
      )
      (if (equal? sm "True")
          (set! tmp (append tmp (cog-outgoing-set (findmol node "ChEBI"))))
      )
        (if (null? tmp)
            '()
            tmp
          )
      )
  ) pw)) )


  (if (equal? prot "True")
    (set! pw (findprotein (GeneNode gene) 1)) ;; when proteins are selected, genes should only be linked to proteins not to pathways
    (set! pw (findMember (GeneNode gene) "SMP"))
  )

  (if (equal? prot "True")
   (append pw ls (findprotein (GeneNode gene) 0))
               
   (append pw ls))
  )
)

;; From reactome

(define (reactome gene prot sm)
    (let (
      [pw (findMember (GeneNode gene) "R-HSA")]
      [ls '()]
      )

      (set! ls (flatten (map (lambda (path)
        (let (
            [node (cog-outgoing-atom (cog-outgoing-atom path 0) 1)]
            [tmp '()]
        )
          (if (equal? prot "True")
            (set! tmp (append tmp (cog-outgoing-set (findmol node "Uniprot"))))
          )
          (if (equal? sm "True")
            (set! tmp (append tmp (cog-outgoing-set (findmol node "ChEBI"))))
          )

          (if (null? tmp)
            '()
            tmp
          )
        )

      )    
      pw)))

    (if (equal? prot "True")
    (set! pw (findprotein (GeneNode gene) 0)) ;; when proteins are selected, genes should only be linked to proteins not to pathways
    (set! pw (findMember (GeneNode gene) "R-HSA"))
    )
      (append pw ls) 
  ) 

)
