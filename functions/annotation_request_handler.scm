;; validates if given gene symbols exist in the atomspace

(define (find-genes gene-list)
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
              (set! info (append info (list (ListLink (node-info (GeneNode g)) (ListLink (locate-node (GeneNode g)))))))
         ) genes)
(ListLink info)))

;; Map gene symbols into GeneNodes

(define (mapSymbol gene-list)
(let ([gene-nodes '()])
(for-each (lambda (g)
(set! gene-nodes (append gene-nodes (list (GeneNode g))))
) gene-list )
gene-nodes
))

(define nodes (make-parameter '()))
(define edges (make-parameter '()))
(define atoms (make-parameter '()))
(define genes (make-parameter '()))
(define pairs (make-parameter '()))
(define annotation (make-parameter '()))

(define (annotate-genes gene-list file-name annts-fns)
  (parameterize ( (nodes '()) 
                  (edges '()) 
                  (atoms '()) 
                  (genes gene-list)
                  (pairs '())
                  (annotation '())
              ) 
      (let* ([result (ListLink (force annts-fns))])
      (write-to-file result file-name)
      (scm->json-string (atomese-parser (format #f "~a" result)))
    )
  )

)







