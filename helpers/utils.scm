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

;; build description URL of a node

(define (build-desc-url node)
 (let
	(
		[atom-type (cog-type node)]
		[description ""]
	)
 	(case atom-type
	 ('MoleculeNode
		(begin
		 (if (equal? (list-ref (string-split (cog-name node) #\:) 0) "ChEBI")
			(set! description (string-append "https://www.ebi.ac.uk/chebi/searchId.do?chebiId=CHEBI:" (cog-name node)))
	 		(set! description (string-append "https://www.uniprot.org/uniprot/" (list-ref (string-split (cog-name node) #\:) 1)))
		 )
		)
	 )
	 ('GeneNode (set! description (string-append "https://www.ncbi.nlm.nih.gov/gene/" (find_entrez node))))
	 ('ConceptNode
		(begin
		 (if (string-contains (cog-name node) "SMP")
		 	(set! description (string-append "http://smpdb.ca/view/" (cog-name node)))
		 )
		 (if (string-contains (cog-name node) "R-HSA")
		 	(set! description (string-append "http://www.reactome.org/content/detail/" (cog-name node)))
		 )
		)
	 )
	)
	description
 )

)

;; Grounded schema node to add info about matched variable nodes

(define (generate-result var1 var2)
  (if  
    (and (not (equal? (cog-type var1) 'VariableNode)) (not (equal? (cog-type var2) 'VariableNode))) 

    (begin
    (let ([output (ListLink
          (EvaluationLink (PredicateNode "Interacts_with") (ListLink var1 var2))
          (node-info var2)
          (node-info var1)
          )])
    output
    )
    )
))


;; Parser Utils

(define* (create-node genes id name defn location annotation)
 (if (is-gene-main? id genes)
 	(make-node (make-node-data id name defn location "main") "nodes")
    (make-node (make-node-data id name defn location annotation) "nodes")
 )
)

(define (create-edge node1 node2 name annotation)
   (make-edge (make-edge-data node2 node1 name annotation) "edges")
)

(define* (node-exists? node node-list)
 (if (null? node-list) #f
  (if (equal? node (car node-list) ) #t
   (node-exists? node (cdr node-list))
  )
 )
)

(define* (is-gene-main? gene gene_list)
 (if (null? gene_list) #f
	(if (equal? gene (car gene_list)) #t
	    (is-gene-main? gene (cdr gene_list))
	)
 )
)

(define* (get-annotations annotation annotation-list)
 (let*
  (
    [annotation_list '()]
  )
  (for-each
    (lambda(annotations)
     (if (equal? annotation (cog-name (car (cog-outgoing-set annotations) )))
      (set! annotation_list (cdr (cog-outgoing-set annotations)))
     )
    )
   annotation-list)
   annotation_list
 )
)

(define* (check-nodes node1 node2 n1type n2type)
 (if (or
	  (equal? (node-data-id (node-data node1)) (node-data-id (node-data node2)))
	  (or (equal? n1type 'VariableNode) (equal? n2type 'VariableNode))
	  (or
	   (string= "" (node-data-id (node-data node1)))
	   (string= "" (node-data-id (node-data node2)))
	  )
 	)
  #f
  #t
 )
)

(define* (get-node-info node-info ref)
 (let*
  (
	  [response ""]
  )
  (for-each
  (lambda(info)
   (if (equal? ref "name")
	(begin
		(if (equal? (cog-name (cog-outgoing-atom info 0)) "has_name")
		 (set! response (cog-name (cog-outgoing-atom (cog-outgoing-atom info 1) 1)) )
		)
	)
   )
   (if (equal? ref "defn")
	(begin
	 	(if (equal? (cog-name (cog-outgoing-atom info 0)) "has_definition")
		 (set! response (cog-name (cog-outgoing-atom (cog-outgoing-atom info 1) 1)) )
		)
	)
   )
  )
  node-info)
  response
 )
)

(define* (get-node-info-from-biogrid node-info ref id)
 (let*
  (
	  [response ""]
  )
  (if (equal? ref "name")
   (begin
	(if (equal? (cog-name (cog-outgoing-atom (cog-outgoing-atom (cog-outgoing-atom (cog-outgoing-atom node-info 1) 0) 1) 0)) id)
	 (set! response (cog-name (cog-outgoing-atom (cog-outgoing-atom (cog-outgoing-atom (cog-outgoing-atom node-info 1) 0) 1) 1)))
	 (set! response (cog-name (cog-outgoing-atom (cog-outgoing-atom (cog-outgoing-atom (cog-outgoing-atom node-info 2) 0) 1) 1)))
	)
   )
  )
  (if (equal? ref "defn")
   (begin
	(if (equal? (cog-name (cog-outgoing-atom (cog-outgoing-atom (cog-outgoing-atom (cog-outgoing-atom node-info 1) 0) 1) 0)) id)
	 (set! response (cog-name (cog-outgoing-atom (cog-outgoing-atom (cog-outgoing-atom (cog-outgoing-atom node-info 1) 1) 1) 1)))
	 (set! response (cog-name (cog-outgoing-atom (cog-outgoing-atom (cog-outgoing-atom (cog-outgoing-atom node-info 2) 1) 1) 1)))
	)
   )
  )
  response
 )
)

(define* (is-cellular_component? node-info)
 (let*
  (
	 [response #f]
  )
  (for-each
   (lambda (info)
    (if (equal? (cog-name (cog-outgoing-atom info 0)) "GO_namespace")
	 (set! response (if (equal? "cellular_component" (cog-name (cog-outgoing-atom (cog-outgoing-atom info 1) 1))) #t #f))
    )
   )
  node-info)
  response
 )
)

(define* (get-node-loc node-info)
 (let*
  (
	  [response ""]
  )
  (if (is-cellular_component? node-info)
   (for-each
	(lambda (info)
	   (if (equal? (cog-name (cog-outgoing-atom info 0)) "has_name")
	 	   (set! response (cog-name (cog-outgoing-atom (cog-outgoing-atom info 1) 1)) )
	   )
	)
	node-info)
  )
  response
 )
)

(define* (get-node-loc-pathway node-info)
 (let*
  (
	[response ""]
  )
 (for-each
  (lambda (info)
   (if (equal? 'ListLink (cog-type info))
	(let*
	 (
		 [location-list (cog-outgoing-set info)]
	 )
	 (for-each
	  (lambda (loc)
	   (if (equal? (cog-name (cog-outgoing-atom loc 0)) "has_location")
		(set! response (string-append (cog-name (cog-outgoing-atom (cog-outgoing-atom loc 1) 1)) " , "response))
	   )
	  )
	 location-list)
	)
   )
  )
  node-info)
  response
 )
)

(define* (write-to-file)
 (let*
	(
		[file-name (generate-filename)]
	)
	(call-with-output-file file-name
  	(lambda (p)
			(if (not (null? output))
					(begin
						(write result p)
					)
			)
		)
	)
	file-name
 )
)

(define* (generate-filename)
 (string-append "scheme/result/"(number->string (current-time)) ".scm")
)
