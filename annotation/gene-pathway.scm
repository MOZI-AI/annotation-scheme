;;; MOZI-AI Annotation Scheme
;;; Copyright © 2019 Abdulrahman Semrie
;;; Copyright © 2019 Hedra Seid
;;;
;;; This file is part of MOZI-AI Annotation Scheme
;;;
;;; MOZI-AI Annotation Scheme is free software; you can redistribute
;;; it and/or modify it under the terms of the GNU General Public
;;; License as published by the Free Software Foundation; either
;;; version 3 of the License, or (at your option) any later version.
;;;
;;; This software is distributed in the hope that it will be useful,
;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;;; General Public License for more details.
;;;
;;; You should have received a copy of the GNU General Public License
;;; along with this software.  If not, see
;;; <http://www.gnu.org/licenses/>.

(define-module (annotation gene-pathway)
      #:use-module (annotation functions)
      #:use-module (annotation util)
      #:use-module (opencog)
      #:use-module (opencog query)
      #:use-module (opencog exec)
      #:use-module (opencog bioscience)
)

(define-public (gene-pathway-annotation gene_nodes pathway prot small_mol)
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
    [pw (find-pathway-member (GeneNode gene) "SMP")]
    [ls '()]
  )

  (set! ls (flatten (map (lambda (path)
      (let (
        [node (cog-outgoing-atom (cog-outgoing-atom path 0) 1)]
        [tmp '()]
      )
      (if (equal? sm "True")
          (set! tmp (append tmp (cog-outgoing-set (find-mol node "ChEBI"))))
      )
      (set! tmp (append tmp (find-pathway-genes node)))
      (if (equal? prot "True")
        (let ([prots (cog-outgoing-set (find-mol node "Uniprot"))])
          (if (not (null? prots))
            (set! tmp (append tmp prots))
            (set! tmp (append tmp (node-info node))))))
        (set! tmp (append tmp (pathway-gene-interactors node (GeneNode gene))))
        (if (null? tmp)
          '()
          tmp
        )
      )
      ) pw)) )


  (if (equal? prot "True")
    (set! pw (append pw (find-protein (GeneNode gene) 0))) ;; when proteins are selected, genes should only be linked to proteins not to pathways
  )

  (append pw ls)
))

;; From reactome

(define (reactome gene prot sm pwlst)
    (let (
      [pw (find-pathway-member (GeneNode gene) "R-HSA")]
      [ls '()]
      )

      (set! ls (flatten (map (lambda (path)
        (let (
            [node (cog-outgoing-atom (cog-outgoing-atom path 0) 1)]
            [tmp '()]
        )
          (set! pwlst (append pwlst (list node)))
          (set! tmp (append tmp (find-pathway-genes node)))
          (if (equal? prot "True")
            (let ([prots (cog-outgoing-set (find-mol node "Uniprot"))])
              (if (not (null? prots))
                (set! tmp (append tmp prots))
                (set! tmp (append tmp (node-info node)))))
            )
          (set! tmp (append tmp (pathway-gene-interactors node (GeneNode gene))))
          (if (equal? sm "True")
            (set! tmp (append tmp (cog-outgoing-set (find-mol node "ChEBI"))))
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
    (set! pw (append pw (find-protein (GeneNode gene) 1))) 
    )
      (list (append pw ls) pwlst) 
  )) 