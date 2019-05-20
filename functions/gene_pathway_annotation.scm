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

(define (smpdb gene prot sm result)
  (let ([pw (identify-pw gene "SMP")])
  (for-each (lambda(path)
        (set! result (append result (list (ListLink (MemberLink gene path) (node-info path)))))
        (if (equal? sm "True")
            (filter-by (cog-outgoing-set (findmol path)) "ChEBI:" path result))
      )pw)
  (if (equal? prot "True")
      (for-each (lambda(pro)
            (set! result (append result
                    (list (ListLink (EvaluationLink (PredicateNode "expresses") (ListLink gene pro)) (node-info pro)))))
                  )(cog-outgoing-set (findprotein gene))))
result
))

;;

(define (filter-by res str path result)
(for-each (lambda (m)
  (if (string-contains (cog-name m) str)
      (set! result (append result (list (ListLink (MemberLink m path) (node-info m))))
              )res)
  ) res))

;; From reactome

(define (reactome gene prot small_mol result)
    (let ([pw (identify-pw gene "R-HSA")])
  
      (for-each (lambda(path)
        (set! result (append result (list (ListLink (add-loc (MemberLink gene path)) (node-info path)))))

        (if (equal? prot "True")
            (for-each (lambda (mol)
                (if (string-contains (cog-name mol) "Uniprot:") 
                (set! result (append result
                    (list (ListLink (add-loc (MemberLink mol path)) (node-info mol))))))) (cog-outgoing-set (findmol path))))
            
        (if (equal? small_mol "True")
            (for-each (lambda (smol)
            (if (string-contains (cog-name smol) "ChEBI:") 
            (set! result (append result
                    (list (ListLink (add-loc (MemberLink smol path)) (node-info smol))))))) (cog-outgoing-set (findmol path))))
      )pw)
) result)

;; Identify Pathway based on given str (SMPDB or Reactome)

(define (identify-pw gene str)
  (let ([pw '()] 
       [mem (cog-outgoing-set (findMember gene))])
  (for-each (lambda (m)
  (if (string-contains (cog-name m) str)
      (set! pw (append pw (list m))))
              )mem)
  pw
))

