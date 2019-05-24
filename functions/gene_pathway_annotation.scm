(define (gene-pathway-annotation gene_nodes pathway prot small_mol)
    (let ([result (list (ConceptNode "gene_pathway_annotation"))])

    (for-each (lambda (gene)
    (for-each (lambda(pathw)
        (if (equal? pathw "smpdb")
            (set! result (smpdb gene prot small_mol result))
            )
        (if (equal? pathw "reactome")
            (set! result (reactome gene prot small_mol result))
            )
                )(string-split pathway #\ ))
    )(mapSymbol gene_nodes))
 
  (ListLink result)
))  


;; From SMPDB 

(define (smpdb gene prot sm)
  (let (
    [pw (findMember (GeneNode gene) "SMP")]
  
  )

  (define ls (flatten (map (lambda (path)
      (let (
        [node (cog-outgoing-atom (cog-outgoing-atom path 1) 1)]
      )
        (set! result (append result (list (ListLink (MemberLink gene path) (node-info path)))))
      (if (equal? sm "True")
        (ListLink (cog-outgoing-set (findmol node "ChEBI")))
        '()
        )

      )
  ) pw)) )

  (if (equal? prot "True")
   (append pw ls (findprotein (GeneNode gene)))
                    (list (ListLink (EvaluationLink (PredicateNode "expresses") (ListLink gene pro)) (node-info pro)))))
   (append pw ls)
  )
result
))

;; From reactome

(define (reactome gene prot sm)
    (let (
      [pw (findMember (GeneNode gene) "R-HSA")]
      [ls '()]
      )

      (set! ls (flatten (map (lambda (path)
        (let (
            [node (cog-outgoing-atom (cog-outgoing-atom path 1) 1)]
            [tmp '()]
        )
          (if (equal? prot "True")
            (set! tmp (append tmp (cog-outgoing-set (findmol node "UniProt"))))
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
) result)

      (append pw ls) 
))
