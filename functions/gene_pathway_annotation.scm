(define (gene-pathway-annotation gene_nodes pathway prot small_mol)
    (let ([result (list (ConceptNode "gene-pathway-annotation"))]
          [pwlst '()])

    (for-each (lambda (gene)
      (set! result (append result (node-info (GeneNode gene))))
      (for-each (lambda (pathw)
          (if (equal? pathw "smpdb")
              (set! result (append result (smpdb gene prot small_mol)))
              )
          (if (equal? pathw "reactome")
              (begin
              (let ([res (reactome gene prot small_mol pwlst)])
                (set! result (append result (car res)))
                (set! pwlst (append pwlst (cdr res)))
              )))
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
      (if (equal? prot "True")
        (let ([prots (cog-outgoing-set (findmol node "Uniprot"))])
          (if (not (null? prots))
            (set! tmp (append tmp prots))
            (set! tmp (append tmp (node-info node)))))
        (set! tmp (append tmp (pathway-gene-interactors node (GeneNode gene)))))
      )
        (if (null? tmp)
            '()
            tmp
          )
      ) pw)) )


  (if (equal? prot "True")
    (set! pw (findprotein (GeneNode gene) 0)) ;; when proteins are selected, genes should only be linked to proteins not to pathways
  )

  (append pw ls)
))

;; From reactome

(define (reactome gene prot sm pwlst)
    (let (
      [pw (findMember (GeneNode gene) "R-HSA")]
      [ls '()]
      )

      (set! ls (flatten (map (lambda (path)
        (let (
            [node (cog-outgoing-atom (cog-outgoing-atom path 0) 1)]
            [tmp '()]
        )
          (set! pwlst (append pwlst (list node)))
          (if (equal? prot "True")
            (let ([prots (cog-outgoing-set (findmol node "Uniprot"))])
              (if (not (null? prots))
                (set! tmp (append tmp prots))
                (set! tmp (append tmp (node-info node)))))
            (set! tmp (append tmp (pathway-gene-interactors node (GeneNode gene))))
            )
          (if (equal? sm "True")
            (set! tmp (append tmp (cog-outgoing-set (findmol node "ChEBI"))))
          )
          (set! tmp (append tmp (list (pathway-heirarchy node pwlst))))
          (if (null? tmp)
            '()
            tmp
          )
        )

      )    
      pw)))

    (if (equal? prot "True")
    (set! pw (findprotein (GeneNode gene) 1)) ;; when proteins are selected, genes should only be linked to proteins not to pathways
    )
      (list (append pw ls) pwlst) 
  ) 

)
