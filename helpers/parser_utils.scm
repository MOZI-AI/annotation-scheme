(define* (create-node genes id name defn location annotation)
 (if (is-gene-main? id genes)
 	(make-node (make-node-data id name defn location "main") "nodes")
    (make-node (make-node-data id name defn location annotation) "nodes")
 )
)

(define* (create-edge node1 node2 name annotation #:optional (pubmedId ""))
   (make-edge (make-edge-data node2 node1 name pubmedId annotation) "edges")
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

(define* (get-node-info-go node-info ref)
 (call/cc (lambda (k)
	(let*
  (
	  [response ""]
  )
  (for-each
  (lambda (info)
		(let ([link (cog-outgoing-atom info 0)])
			(if (not (null? link))
				(begin 
					(if (equal? ref "name")
				(begin
					(if (equal? (cog-name (cog-outgoing-atom info 0)) "has_name")
					(set! response (cog-name (cog-outgoing-atom (cog-outgoing-atom info 1) 1)))
					(if (not (string-null? response))
							(k response)
					)

					)
					)
			)
			(if (equal? ref "defn")
				(begin
					(if (equal? (cog-name (cog-outgoing-atom info 0)) "has_definition")
					(set! response (cog-name (cog-outgoing-atom (cog-outgoing-atom info 1) 1)) )
					(if (not (string-null? response))
							(k response)
					)
					)
				)
			)
				)
			)
		)		
		)
  node-info)
  response
 )
 
 ))
)

(define* (get-node-info node-info ref)
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
	   (if (equal? ref "name")
	   	(if (equal? (cog-name (cog-outgoing-atom loc 0)) "has_name")
		 (set! response (cog-name (cog-outgoing-atom (cog-outgoing-atom loc 1) 1)) )
	    )
	   )
	   (if (equal? ref "defn")
	   (if (equal? (cog-name (cog-outgoing-atom loc 0)) "has_definition")
		 (set! response (cog-name (cog-outgoing-atom (cog-outgoing-atom loc 1) 1)))
	    )
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
	 	   (set! response (cog-name (cog-outgoing-atom (cog-outgoing-atom info 1) 1)))
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
	[response '()]
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
		(set! response (cons (cog-name (cog-outgoing-atom (cog-outgoing-atom loc 1) 1)) response))
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

(define* (get-pubmedID node-info)
 (let*
  (
	 [response ""]
  )

 (for-each
 (lambda (info)
  (if (equal? 'PredicateNode (cog-type (cog-outgoing-atom info 0)))
   (if (equal? "has_pubmedID" (cog-name (cog-outgoing-atom info 0)))
	(set! response (build-pubmed-url (cog-name (cog-outgoing-atom (cog-outgoing-atom info 1) 1))))
   )
  )
 )
 node-info)
  response
 )
)


(define* (build-desc-url node)
 (let*
	(
		[atom-type (cog-type node)]
		[description ""]
	)
 	(case atom-type
	 ('MoleculeNode
		(begin
		 (if (equal? (list-ref (string-split (cog-name node) #\:) 0) "ChEBI")
			(set! description (string-append "https://www.ebi.ac.uk/chebi/searchId.do?chebiId=" (list-ref (string-split (cog-name node) #\:) 1)))
	 		(set! description (string-append "https://www.uniprot.org/uniprot/" (list-ref (string-split (cog-name node) #\:) 1)))
		 )
		)
	 )
	 ('GeneNode (set! description (string-append "https://www.ncbi.nlm.nih.gov/gene/"  (find_entrez node))))
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

(define* (build-pubmed-url nodename)
 (string-append "https://www.ncbi.nlm.nih.gov/pubmed/?term=" (list-ref (string-split nodename #\:) 1))
)

(define* (write-to-file result name)
 (let*
	(
		[file-name (string-append "scheme/result/" name ".scm")]
	)
	(call-with-output-file file-name
  	(lambda (p)
		(begin
			(write result p)
		)
	)
	)
 )
)