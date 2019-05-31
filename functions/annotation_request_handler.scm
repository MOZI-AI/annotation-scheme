;; validates if given gene symbols exist in the atomspace

(define (genes gene-list)
(let ((val-msg "")
     (unknown '()))

(for-each (lambda(g)
    (if (equal? (cog-node 'GeneNode g) '())  
      (set! unknown (append unknown (list g)) )
    )
  ) gene-list)

(if (null? unknown )
    (set! val-msg "0")
    (set! val-msg (string-append "1:" (string-join unknown ",")))
)
val-msg ))


;; Adds the name and description of gene_nodes

(define (gene-info genes)
    (let ([info '()])
         (for-each (lambda (g)
              (set! info (append info (list (ListLink (node-info g)))))
         ) genes)
info))

;; Map gene symbols into GeneNodes

(define (mapSymbol gene-list)
(let ([gene-nodes '()])
(for-each (lambda (g)
(set! gene-nodes (append gene-nodes (list (GeneNode g))))
) gene-list )
gene-nodes
))









