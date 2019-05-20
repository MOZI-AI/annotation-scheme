(define nodes '())
(define edges '())
(define atoms '())
(define graph '())
(define json '())
(define output '())

(define-public (parse result)
   (let*
      (
			 [go-annotations (get-annotations "gene_go_annotation" result)]
			 [pathway-annotations (get-annotations "gene_pathway_annotation" result)]
			 [biogrid-annotations (get-annotations "biogrid_interaction_annotation" result)]
      )
	 (reset)
	 (set! output result)
     (parse-go-annotations go-annotations)
     (parse-pathway-annotations pathway-annotations)
  	 (parse-biogrid-annotations biogrid-annotations)
     (set! graph (make-graph nodes edges))
     (set! json (scm->json-string graph))
     json
   )
)

(define* (create-gene-nodes annotation-list)
 (let*
  (
	  [gene ""]
	  [gene-name ""]
	  [gene-definition ""]
  )
  (for-each
    (lambda(annotations)
	 (if (equal? 2 (length annotations))
	  (begin
	   (for-each
		(lambda (gene-info)
		 (begin
		  (if (equal? (cog-name (cog-outgoing-atom gene-info 0)) "has_name")
			   (begin
				   (set! gene (cog-name (cog-outgoing-atom (cog-outgoing-atom gene-info 1) 0)))
				   (set! gene-name (cog-name (cog-outgoing-atom (cog-outgoing-atom gene-info 1) 1)))
			   )
		  )
		  (if (equal? (cog-name (cog-outgoing-atom gene-info 0)) "has_definition")
		      (set! gene-definition (cog-name (cog-outgoing-atom (cog-outgoing-atom gene-info 1) 1)))
		  )

		  (if (not (node-exists? gene atoms))
			  (begin
				(set! nodes (append (list (create-node-2 gene gene-name gene-definition "")) nodes))
				(set! atoms (cons gene atoms))
			  )
		  )
		 )
		)
	   annotations)
	  )
	 )
   )
   annotation-list)
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
	(if (equal? (cog-name (cog-outgoing-atom (cog-outgoing-atom (cog-outgoing-atom node-info 1) 1) 0)) id)
	 (set! response (cog-name (cog-outgoing-atom (cog-outgoing-atom (cog-outgoing-atom node-info 1) 1) 1)))
	 (set! response (cog-name (cog-outgoing-atom (cog-outgoing-atom (cog-outgoing-atom node-info 3) 1) 1)))
	)
   )
  )
  (if (equal? ref "defn")
   (begin
	(if (equal? (cog-name (cog-outgoing-atom (cog-outgoing-atom (cog-outgoing-atom node-info 2) 1) 0)) id)
	 (set! response (cog-name (cog-outgoing-atom (cog-outgoing-atom (cog-outgoing-atom node-info 2) 1) 1)))
	 (set! response (cog-name (cog-outgoing-atom (cog-outgoing-atom (cog-outgoing-atom node-info 4) 1) 1)))
	)
   )
  )
  response
 )
)

(define* (parse-go-annotations go-annotations)

  (map (lambda (annot)
		(let*
		   (
			   [annot (list-ref main-annotation 0)]
			   [node-info (list-ref main-annotation 1)]
			   [annotation "gene_go_annotation"]
			   [main-atom-type (cog-type annot)]
			   [inner-atom (cog-outgoing-atom annot 0)]
		   )
		   (if (equal? main-atom-type 'InheritanceLink)
			(begin
			   (let*
				(
					[node-id (cog-name (cog-outgoing-atom annot 1))]
					[node-name (get-node-info node-info "name")]
					[node-definition (get-node-info node-info "defn")]
					[node (create-node-2 node-id node-name node-definition annotation)]
					[gene-node (cog-name (cog-outgoing-atom annot 0))]
				)
				(if (not (node-exists? node-id atoms))
					(begin
						(set! nodes (append (list node) nodes))
						(set! atoms (cons node-id atoms))
					)
				)
				(set! edges (append (list (create-edge-2 gene-node node-id  "annotates" annotation)) edges))
			   )
			)
		   )
		  )
	  )
   go-annotations)
)

(define* (parse-pathway-annotations pathway-annotations)
	(map (lambda(main-annotation)
		  (let*
		   (
			   [annot (list-ref main-annotation 0)]
			   [node-info (list-ref main-annotation 1)]
			   [annotation "gene_pathway_annotation"]
			   [main-atom-type (cog-type annot)]
			   [inner-atom (cog-outgoing-atom annot 0)]
		   )
		   (if (equal? main-atom-type 'MemberLink)
				(begin
					 (let*
						(
							[node1-name (cog-name (cog-outgoing-atom annot 0))]
							[node2-name (cog-name (cog-outgoing-atom annot 1))]
							[node1-type (cog-type (cog-outgoing-atom annot 0))]
							[node2-type (cog-type (cog-outgoing-atom annot 1))]
							[node1 (create-node (cog-outgoing-atom annot 0) annotation)]
							[node2 (create-node (cog-outgoing-atom annot 1) annotation)]
						)
						(if (not (node-exists? node1-name atoms))
							 (begin
								(set! nodes (append (list node1) nodes))
								(set! atoms (cons node1-name atoms))
							 )
						)
						(if (not (node-exists? node2-name atoms))
							(begin
								(set! nodes (append (list node2) nodes))
								(set! atoms (cons node2-name atoms))
							)
						)
						(if (check-nodes node1 node2 node1-type node2-type)
						 (set! edges (append (list (create-edge node1 node2 "annotates" annotation)) edges))
						)
					 )
				)
		   )
		   (if (equal? main-atom-type 'EvaluationLink)
				(let*
				 (
					 [predicate (cog-outgoing-atom annot 0)]
					 [listlink (cog-outgoing-atom annot 1)]
					 [node1-name (cog-name (cog-outgoing-atom listlink 0))]
					 [node2-name (cog-name (cog-outgoing-atom listlink 1))]
					 [node1-type (cog-type (cog-outgoing-atom listlink 0))]
					 [node2-type (cog-type (cog-outgoing-atom listlink 1))]
					 [node1 (create-node (cog-outgoing-atom listlink 0) annotation)]
					 [node2 (create-node (cog-outgoing-atom listlink 1) annotation)]
				 )
				 (if (not (node-exists? node1-name atoms))
					 (begin
						(set! nodes (append (list node1) nodes))
						(set! atoms (cons node1-name atoms))
					 )
				 )
				 (if (not (node-exists? node2-name atoms))
					(begin
						(set! nodes (append (list node2) nodes))
						(set! atoms (cons node2-name atoms))
					)
				 )
				 (set! edges (append (list (create-edge-2 (cog-name (cog-outgoing-atom listlink 0)) (cog-name (cog-outgoing-atom listlink 1)) (cog-name predicate) annotation)) edges))
				)
		   )
		  )
	)
	pathway-annotations)
)

(define* (parse-biogrid-annotations biogrid-annotations)
	 (map (lambda(main-annotation)
		(let*
		   (
			   [annotation "biogrid_interaction_annotation"]
			   [annot (cog-outgoing-atom main-annotation 0)]
			   [main-atom-type (cog-type annot)]
		   )
		   (if (equal? main-atom-type 'EvaluationLink)
			(let*
			 (
				 [predicate (cog-name (cog-outgoing-atom annot 0))]
				 [listlink (cog-outgoing-atom annot 1)]
				 [node1-id (cog-name (cog-outgoing-atom listlink 0))]
				 [node2-id (cog-name (cog-outgoing-atom listlink 1))]
				 [node-id (if (not (node-exists? node1-id atoms)) node1-id (if (not (node-exists? node2-id atoms)) node2-id))]
				 [node-id (if (unspecified? node-id) node1-id node-id)] ;TODO Weird issue where a node becomes unspecified for no reason
;				 [node-name (get-node-info-from-biogrid main-annotation "name" node-id)]
				 [node-name ""]
				 [node-defn (get-node-info-from-biogrid main-annotation "defn" node-id)]
				 [node (create-node-2 node-id node-name node-defn annotation)]
				 [other-node-id (if (equal? node1-id node-id) node2-id node1-id)]
			 )
			 (if (not (node-exists? node-id atoms))
					 (begin
						(set! nodes (append (list node) nodes))
						(set! atoms (append (list node-id) atoms))
					 )
			 )
			 (set! edges (append (list (create-edge-2 other-node-id node-id predicate  annotation)) edges))
			)
		   )
		  )
	 )
	 biogrid-annotations)
)

(define* (create-node term annotation #:optional (main #f))
    (let*
        (
            [id (cog-name term)]
            [name ""]
            [defn ""]
			[is-go (regexp-match? (string-match "GO:[0-9]+" id))]
        )

			 (set! name (find-name term))
			 (if is-go
				(set! defn (find-GO-def term))
				(set! defn (build-desc-url term))
			 )

			(if (is-gene-main? (cog-name term) gene_nodes)
					(make-node (make-node-data id name defn "main") "nodes")
					(make-node (make-node-data id name defn annotation) "nodes")
			)
    )
)

(define* (create-node-2 id name defn annotation)
 (if (is-gene-main? id gene_nodes)
 	(make-node (make-node-data id name defn "main") "nodes")
    (make-node (make-node-data id name defn annotation) "nodes")
 )
)

(define (create-edge node1 node2 name annotation)
   (make-edge (make-edge-data (node-data-id (node-data node2)) (node-data-id (node-data node1)) name annotation) "edges")
)

(define (create-edge-2 node1 node2 name annotation)
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
	(if (equal? gene (cog-name (car gene_list))) #t
	    (is-gene-main? gene (cdr gene_list))
	)
 )
)

(define* (reset)
 	(set! nodes '())
	(set! edges '())
	(set! atoms '())
	(set! graph '())
	(set! json '())
)

(define* (get-annotations annotation annotation-list)
 (let*
  (
    [annotation_list '()]
  )
  (for-each
    (lambda(annotations)
     (if (equal? annotation (cog-name (car annotations)))
      (set! annotation_list (cdr annotations))
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


(define* (build-desc-url node)
 (let*
	(
		[atom-type (cog-type node)]
		[description ""]
	)
 	(case atom-type
	 ('MoleculeNode
		(begin
		 (if (equal? (list-ref (string-split (cog-name node) #\:) 0) "CHEBI")
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

