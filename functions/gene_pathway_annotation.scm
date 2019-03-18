;; 


(define (gene_pathway_annotation pathway prot small_mol)
    (set! result (list (ConceptNode "gene_pathway_annotation")))
    (set! interaction "proteins")

    (for-each (lambda (gene)
    (for-each (lambda(pathw)
        (if (equal? pathw "smpdb")
            (smpdb gene prot small_mol))
        (if (equal? pathw "reactome")
            (reactome gene prot small_mol))
                
                )(string-split pathway #\ ))
    )gene_nodes)
 
  result
)  


;; From SMPDB 

(define (smpdb gene prot sm)
  (define pw '())
  (set! pw (identify_pw gene pw "SMP"))
  (for-each (lambda(path)
        (set! result (append result (list (list (MemberLink gene path) (node-info path)))))
        (if (equal? sm "True")
            (filter_by (cog-outgoing-set (findmol path)) "ChEBI:" path))
      )pw)
  (if (equal? prot "True")
      (for-each (lambda(pro)
            (set! result (append result
                    (list (list (EvaluationLink (PredicateNode "expresses") (ListLink gene pro)) (node-info pro)))))
                  )(cog-outgoing-set (findprotein gene))))
)


;;

(define (filter_by res str path)
(for-each (lambda (m)
  (if (string-contains (cog-name m) str)
      (set! result (append result (list (list (MemberLink m path) (node-info m))))
              )res)
  ) res))


;; From reactome

(define (reactome gene prot small_mol)
    (define pw '())
    (set! pw (identify_pw gene pw "R-HSA"))
  
      (for-each (lambda(path)
        (set! result (append result (list (list (MemberLink gene path) (node-info path)))))

        (if (equal? prot "True")
            (for-each (lambda (mol)
                (if (string-contains (cog-name mol) "Uniprot:") 
                (set! result (append result
                    (list (list (MemberLink mol path) (node-info mol))))))) (cog-outgoing-set (findmol path))))
            
        (if (equal? small_mol "True")
            (for-each (lambda (smol)
            (if (string-contains (cog-name smol) "ChEBI:") 
            (set! result (append result
                    (list (list (MemberLink smol path) (node-info smol))))))) (cog-outgoing-set (findmol path))))
      )pw)
  
)

;; Identify Pathway based on given str (SMPDB or Reactome)

(define (identify_pw gene pw str)
  (define mem (cog-outgoing-set (findMember gene)))
  (for-each (lambda (m)
  (if (string-contains (cog-name m) str)
      (set! pw (append pw (list m))))
              )mem)
  pw
)

