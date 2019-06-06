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
            (make-node (make-node-data id name defn "main") "nodes")
            (make-node (make-node-data id name defn "GO") "nodes")
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
            (make-node (make-node-data id id "" "Gene") "nodes")
            (make-node (make-node-data id id "" "Gene") "nodes")
            )
    )

)

(define (create-member-link gene go)
   (make-edge (make-edge-data (node-data-id (node-data go)) (node-data-id (node-data gene)) "annotates" "memeberln") "edges")
)

(define (create-member-ln elm set)
    (map (lambda (t)
        (make-edge (make-edge-data (node-data-id (node-data t)) (node-data-id (node-data elm)) "annotates" "memeberln") "edges")
    )
    set)

)

(define (create-member-ln-rev elm set)
    (map (lambda (t)
    (make-edge (make-edge-data (node-data-id (node-data elm)) (node-data-id (node-data t)) "annotates" "memeberln") "edges")
    ) set)
)

(define (create-eval-ln pred x y class)
(map (lambda (e)
    (make-edge (make-edge-data (node-data-id (node-data e)) (node-data-id (node-data x)) pred class) "edges")
) y)

)

(define (create-is-ln elm set)
(map (lambda (t) 
    (make-edge (make-edge-data  (node-data-id (node-data elm)) (node-data-id (node-data t)) "is_a" "isln") "edges")
) set) 
)

(define (create-is-ln-rev elm set)
    (map (lambda (t) 
        (make-edge (make-edge-data  (node-data-id (node-data t)) (node-data-id (node-data elm)) "is_a" "isln") "edges")
    ) set)
)
(define (node-exists? node ls)
    (let(
        [ids (map (lambda (x) (if (node? x) (node-data-id (node-data x)))) ls)]
        [n-id (node-data-id (node-data node))]
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

(define (generate-result var1 var2)
  (if  
    (and (not (equal? (cog-type var1) 'VariableNode)) (not (equal? (cog-type var2) 'VariableNode))) 

    (begin
    (let ([output (ListLink
          (if (null? (findpubmed (EvaluationLink (PredicateNode "interacts_with") (ListLink var1 var2))))
            (EvaluationLink (PredicateNode "interacts_with") (ListLink var1 var2))
            (findpubmed (EvaluationLink (PredicateNode "interacts_with") (ListLink var1 var2))))
          (node-info var2)
          (node-info var1)
          )])
    output
    )
    )
))
