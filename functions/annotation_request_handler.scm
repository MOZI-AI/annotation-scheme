(define output '())  ;; final output to be returned to the user

(define result '())  ;; result for each annotation

(define gene_nodes '())

;; Accept a Gene list and map to geneNodes

(define (genes gene_list)
(define val_msg "")
(define unknown '())
(set! gene_nodes '()) ;; to remove previously annotated gene lists

(for-each (lambda(g)
    (if (equal? (cog-node 'GeneNode g) '())  ;; validates if given gene symbols exist in the atomspace
      (set! unknown (append unknown (list g)) )
      (set! gene_nodes (append gene_nodes (list (GeneNode g))))
    )
  ) (string-split gene_list #\ ))

(if (equal? unknown '())
    (set! val_msg "0")
    (begin (set! val_msg (string-append "1:" (string-join unknown ",")))
	   (set! gene_nodes '()))
)

val_msg
)
;; The main function

(define (do_annotation annotation_list)
  (set! output '()) ;; to remove previous output
    
  (for-each (lambda (func)
     (set! output (append output (list func)))
  ) annotation_list)

 (parse output)
) 






