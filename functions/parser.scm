(define nodes '())
(define edges '())
(define atoms '())
(define graph '())
(define json '())

(define-public (parse result)
   (let*
      (
			 [go-annotations (get-annotations "gene_go_annotation" result)]
			 [pathway-annotations (get-annotations "gene_pathway_annotation" result)]
			 [biogrid-annotations (get-annotations "biogrid_interaction_annotation" result)]
      )
		 (reset)
     (parse-go-annotations go-annotations)
     (parse-pathway-annotations pathway-annotations)
  	 (parse-biogrid-annotations biogrid-annotations)
     (set! graph (make-graph nodes edges))
     (set! json (scm->json-string graph))
     json
   )
)

(define* (parse-go-annotations go-annotations)

  (map (lambda(annot)
		(let*
		   (
			   [annotation "gene_go_annotation"]
			   [main-atom-type (cog-type annot)]
			   [inner-atom (cog-outgoing-atom annot 0)]
		   )
		   (if (equal? main-atom-type 'InheritanceLink)
			(begin
			   (let*
				(
					[node1-name (cog-name (cog-outgoing-atom annot 0))]
					[node2-name (cog-name (cog-outgoing-atom annot 1))]
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
				(set! edges (append (list (create-edge node1 node2 "annotates" annotation)) edges))
			   )
			)
		   )
		  )
	  )
   go-annotations)
)

(define* (parse-pathway-annotations pathway-annotations)
	(map (lambda(annot)
		  (let*
		   (
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
					(set! edges (append (list (create-edge node1 node2 "annotates" annotation)) edges))
					 )
				)
		   )
		   (if (equal? main-atom-type 'EvaluationLink)
				(let*
				 (
					 [predicate (cog-outgoing-atom annot 0)]
					 [listlink (cog-outgoing-atom annot 1)]
				 )
				 (set! edges (append (list (create-edge-2 (cog-name (cog-outgoing-atom listlink 0)) (cog-name (cog-outgoing-atom listlink 1)) (cog-name predicate) annotation)) edges))
				)
		   )
		  )
	)
	pathway-annotations)
)

(define* (parse-biogrid-annotations biogrid-annotations)
	 (map (lambda(annot)
		(let*
		   (
			   [annotation "biogrid_interaction_annotation"]
			   [main-atom-type (cog-type annot)]
			   [inner-atom (cog-outgoing-atom annot 0)]
		   )
		   (if (equal? main-atom-type 'EvaluationLink)
			(let*
			 (
				 [predicate (cog-outgoing-atom annot 0)]
				 [listlink (cog-outgoing-atom annot 1)]
				 [node (cog-outgoing-atom listlink 0)]
			 )
			 (if (not (node-exists? (cog-name node) atoms))
					 (begin
						(set! nodes (append (list (create-node node annotation)) nodes))
						(set! atoms (cons (cog-name node) atoms))
					 )
			 )
			 (set! node (cog-outgoing-atom listlink 1))
			 (if (not (node-exists? node atoms))
					 (begin
						(set! nodes (append (list (create-node node annotation)) nodes))
						(set! atoms (cons (cog-name node) atoms))
					 )
			 )
			 (set! edges (append (list (create-edge-2 (cog-name (cog-outgoing-atom listlink 0)) (cog-name (cog-outgoing-atom listlink 1)) (cog-name predicate) annotation)) edges))
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
