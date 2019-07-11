(define (get-member-link g s)
(map (lambda (t) (MemberLink g t)) (cog-outgoing-set s))
)

(define* (create-go-node term #:optional (main #f))
    (let*   
        (
            [id (cog-name term)]
            [name ""]
            [defn ""]

        )
        
        (set! name (find-GO-name (ConceptNode id)))
        (try
            (set! defn (cog-name (car (remove-set-ln (find-GO-def term))))) 
            (catch 
                (set! defn "")
                )
            )  
        

        (if main 
            (make-node (make-node-info id name defn "main") "nodes")
            (make-node (make-node-info id name defn "GO") "nodes")
            )
        
        
        
    )
    
)

(define* (create-gene-node term #:optional (main #f))
    (let*
        (
            [id (cog-name term)]
            [node '()]
        )
        (if main 
            (make-node (make-node-info id id "" "Gene") "nodes")
            (make-node (make-node-info id id "" "Gene") "nodes")
            )
    )

)

(define (create-member-link gene go)
   (make-edge (make-edge-info (node-info-id (node-info go)) (node-info-id (node-info gene)) "annotates" "memeberln") "edges")
)

(define (create-member-ln elm set)
    (map (lambda (t)
        (make-edge (make-edge-info (node-info-id (node-info t)) (node-info-id (node-info elm)) "annotates" "memeberln") "edges")info
    )
    set)
info
)

(define (create-member-ln-rev elm set)
    (map (lambda (t)
    (make-edge (make-edge-info (node-info-id (node-info elm)) (node-info-id (node-info t)) "annotates" "memeberln") "edges")
    ) set)
)

(define (create-eval-ln pred x y class)
(map (lambda (e)
    (make-edge (make-edge-data (node-data-id (node-data e)) (node-data-id (node-data x)) pred class) "edges")
) y)

)

(define (create-is-ln elm set)
(map (lambda (t) 
    (make-edge (make-edge-info  (node-info-id (node-info elm)) (node-info-id (node-info t)) "is_a" "isln") "edges")
) set) 
)

(define (create-is-ln-rev elm set)
    (map (lambda (t) 
        (make-edge (make-edge-info  (node-info-id (node-info t)) (node-info-id (node-info elm)) "is_a" "isln") "edges")
    ) set)
)
(define (node-exists? node ls)
    (let(
        [ids (map (lambda (x) (if (node? x) (node-info-id (node-data x)))) ls)]
        [n-id (node-info-id (node-data node))]
    )
        (member n-id ids)    
    )
)
(define (build-hierarchy go temp)
    (if (null? go) temp
        (let*
            (
                [current-pars (findAncestor go)]
                [parent-nodes (map create-go-node current-pars)]
                [current-node (create-go-node go)]
                [nodes '()]
                [edges (create-is-ln current-node parent-nodes)]
            )
            (if (node-exists? current-node (graph-nodes temp))
                (set! nodes parent-nodes)
                (set! nodes (append (list current-node) parent-nodes))
            )
            (if (not (null? current-pars))
                (car (map (lambda (x) (build-hierarchy x (append-graph (make-graph nodes edges) temp))) current-pars))
                (build-hierarchy current-pars (append-graph (make-graph nodes edges) temp))
            )
            
        )
        )
)

(define (append-graph g1 g2)
    (let* (
        (n1 (graph-nodes g1))
        (e1 (graph-edges g1))
        (n2 (graph-nodes g2))
        (e2 (graph-edges g2))
    )
    (make-graph (append n1 n2) (append e1 e2))
        
        )
)

(define (to-ls-link res)
    (ListLink
        (map (lambda (x) x) res)
    )
)

;;a helper function to flatten a list, i.e convert a list of lists into a single list
(define (flatten x)
  (cond ((null? x) '())
        ((pair? x) (append (flatten (car x)) (flatten (cdr x))))
        (else (list x))))

;; Grounded schema node to add info about matched variable nodes

(define (generate-result gene-a gene-b)
  (if  
    (and (not (equal? (cog-type gene-a) 'VariableNode)) (not (equal? (cog-type gene-b) 'VariableNode))
    (not (member (cons gene-a gene-b) (pairs)))
     (not (member (cons gene-b gene-a) (pairs)))
    ) 

        (begin
            (let* ([output (findpubmed gene-a gene-b)]
                  [res (flatten (map (lambda (x) 
                                    (if (not (member (cog-name x) (biogrid-genes)))
                                        (cog-name x)
                                        '()
                                    ) 
                    )  (list gene-a gene-b))) ]
                  [interaction (if (null? output) (EvaluationLink 
                                        (PredicateNode "interacts_with") 
                                        (ListLink gene-a gene-b))
                                        (EvaluationLink
                                            (PredicateNode "has_pubmedID")
                                            (ListLink (EvaluationLink 
                                                     (PredicateNode "interacts_with") 
                                                     (ListLink gene-a gene-b))  
                                                    output)
                                        ))]   
                )
                (pairs (append (list (cons gene-a gene-b)) (pairs)))
                (match res
                    ((a b)
                        (begin 
                            (biogrid-genes (append (list a b) (biogrid-genes)))
                            (ListLink
                                interaction
                                (node-info (GeneNode a))
                                (node-info (GeneNode b))
                            )
                        )
                    )
                    ((a)
                        (begin 
                            (biogrid-genes (append (list a) (biogrid-genes)))
                            (ListLink
                                interaction
                            (node-info (GeneNode a))
                        ))
                    )
                    (()
                            (ListLink
                                interaction
                            )
                    )
                )
            )
        )
        (ListLink)
))

(define (generate-ppi-result gene-a prot-a )
        (begin
            (ListLink
                    (EvaluationLink (PredicateNode "expresses") (ListLink gene-a prot-a))
                    (node-info prot-a)
            )
        )
)

(define (generate-interactors path gene var1 var2)
  (if (and (not (string=? (cog-name var1) (cog-name var2)))
          (not (or (string=? (cog-name gene) (cog-name var1))(string=? (cog-name gene) (cog-name var2))))
      )
      (ListLink
        (MemberLink var1 path) 
        (MemberLink var2 path)
        (generate-result var1 var2)
      )
      (ListLink)
  )
)