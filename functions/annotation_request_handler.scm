;; validates if given gene symbols exist in the atomspace

(define (genes gene_list)
(let ((val_msg "")
     (unknown '()))

(for-each (lambda(g)
    (if (equal? (cog-node 'GeneNode g) '())  
      (set! unknown (append unknown (list g)) )
    )
  ) (string-split gene_list #\ ))

(if (equal? unknown '())
    (set! val_msg "0")
    (set! val_msg (string-append "1:" (string-join unknown ",")))
)
val_msg ))


;; Adds the name and description of gene_nodes

(define (gene_info genes)
    (let ([info '()])
         (for-each (lambda (g)
              (set! info (append info (list (node-info g))))
         ) genes)
info))

;; Map gene symbols into GeneNodes

(define (map_symbol gene_list)
(let ([gene_nodes '()])
(for-each (lambda (g)
(set! gene_nodes (append gene_nodes (list (GeneNode g))))
) (string-split gene_list #\ ))
gene_nodes
))









