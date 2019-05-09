(use-modules (srfi srfi-1))

(define (gene_go_annotation namespace P gene_nodes)
  (let ([Goterms '()]      
        [result (list (ConceptNode "gene_go_annotation"))]
        [ns namespace]
        [trav_result '()])

  (for-each (lambda (gene)
  (set! result (append result (find-go-term (cog-name gene) namespace P)))
  )gene_nodes)

 result
))

;;Returns a namespace EvaluationLink of namespaces
(define namespace-eval (lambda (nsp)
    (map (lambda (n)
          (EvaluationLink
               (PredicateNode "GO_namespace")
                 (ListLink
                   (VariableNode "$a")
                  (ConceptNode n)
                  )
                )
    )
        
    nsp
    )
))

;;Given an atom and list of namespaces finds the parents of that atom in the specified namespaces
(define find-parent
  (lambda (node namespaces)
        (let ([atom (cog-outgoing-atom node 1)])
          (cog-outgoing-set (cog-execute! (BindLink
            (VariableNode "$a")
            (AndLink
              (InheritanceLink
                atom
                (VariableNode "$a"))
              (OrLink (namespace-eval namespaces))
            )
          (ExecutionOutputLink
              (GroundedSchemaNode "scm: add-go-info")
                (ListLink
                  atom
                  (VariableNode "$a")
                ))
        )
      )
        
    )    
  )
      
))

;;Finds Go terms of a gene
(define find-memberln 
  (lambda (gene namespaces)
     (cog-outgoing-set (cog-execute! (BindLink
            (VariableNode "$a")
            (AndLink
              (MemberLink
                gene
                (VariableNode "$a"))
                (OrLink (namespace-eval namespaces))
            ) 
           (ExecutionOutputLink
              (GroundedSchemaNode "scm: add-go-info")
                (ListLink
                  gene
                  (VariableNode "$a")
                ))
          )
  )
))
)

;;
(define (add-go-info child-atom parent-atom)
(if (and (equal? (cog-type child-atom) 'GeneNode)
    (equal? (list-ref (string-split (cog-name parent-atom) #\:) 0) "GO"))
  (ListLink  
    (MemberLink
        child-atom
        parent-atom
    )
    (go_info parent-atom)
  )
  (begin
    (if (equal? (list-ref (string-split (cog-name parent-atom) #\:) 0) "GO")
      (ListLink 
          (InheritanceLink
       child-atom
       parent-atom
        )
    (go_info parent-atom)
    )
  ))
))

;;a helper function to flatten a list, i.e convert a list of lists into a single list
(define (flatten x)
  (cond ((null? x) '())
        ((pair? x) (append (flatten (car x)) (flatten (cdr x))))
        (else (list x))))

;;the main function to find the go terms for a gene with a specification of the parents
(define find-go-term 
  (lambda (g namespaces p)
      (let (
        [res  (find-memberln (GeneNode g) namespaces)]
        
      
      )
      (define parents (flatten (let loop (
        [i p]
        [ls res]
        [acc '()]
      )
      (cond 
        [(= i 0) (append ls acc)]
        [(null? ls) acc]
        [else (cons (loop (- i 1)  (find-parent (car (cog-outgoing-set (car ls))) namespaces) (append ls acc)) (loop i (cdr ls) '()))
          ]
      )
      )))
       (delete-duplicates parents)

    )
  ))

;; Add details about the GO term
(define (go_info go)
(list
(EvaluationLink (PredicateNode "GO_namespace") (ListLink go (if (equal? (find-GO-ns go) '()) (ConceptNode "") (find-GO-ns go))))
(EvaluationLink (PredicateNode "has_name") (ListLink go (if (equal? (cog-outgoing-set (findGoname go)) '() ) (ConceptNode "") (cog-outgoing-set (findGoname go)))))
(EvaluationLink (PredicateNode "has_definition") (ListLink go (if (equal? (find-godef go) '()) (ConceptNode "") (find-godef go)))) 
))


