
(define (gene_go_annotation namespace P gene_nodes)
  (let ([Goterms '()]      
        [result (list (ConceptNode "gene_go_annotation"))]
        [ns namespace]
        [trav_result '()])

  (for-each (lambda (gene)
    (set! Goterms '())
              
        (for-each (lambda (n)
        (set! Goterms (append  Goterms (cog-outgoing-set (findGoterm gene n))))
        )(string-split ns #\ ))

        (for-each (lambda (go)
           (set! result (append result (list (list (MemberLink gene go) (go_info go))))) ;; find go-terms of selected namespace for a given gene
           (set! trav_result '())
           (if (> P 0) (set! result (append result (traverse_parent go P ns trav_result)))) ;; traverse for parents of the Go P times, of selected namespace
              
        )Goterms)

  )gene_nodes)

 result
))

;; traverse for parents of Go term g for p times

(define (traverse_parent go p ns trav_result) 
  (define parents '())
  (let ([loop 0])
  (for-each (lambda (g)
    (for-each (lambda(n)
      (relationship g (cog-outgoing-set (parent_finder g n)) trav_result)
      (set! parents (append parents (cog-outgoing-set (parent_finder g n))))
    )(string-split ns #\ ))
  (set! loop (+ loop 1))
  (if (> p loop) 
  (traverse_parent parents (- p loop)))
  ) (list go) ))
    
  trav_result
  )

;; links g and its parents with InheritanceLink

(define (relationship g parents trav_result)
  (for-each (lambda (l) 
  (if (not (equal? (cog-name l) "GO_term"))
  (set! trav_result (append trav_result (list (list (InheritanceLink g l) (go_info l) ))))
  )) parents)
trav_result
)


;; Add namespace of the GO term
(define (go_info go)
(list
(EvaluationLink (PredicateNode "GO_namespace") (ListLink go (if (equal? (find-GO-ns go) '()) (ConceptNode "") (find-GO-ns go))))
(EvaluationLink (PredicateNode "has_name") (ListLink go (if (equal? (cog-outgoing-set (findGoname go)) '() ) (ConceptNode "") (cog-outgoing-set (findGoname go)))))
(EvaluationLink (PredicateNode "has_definition") (ListLink go (if (equal? (find-godef go) '()) (ConceptNode "") (find-godef go)))) 
))


