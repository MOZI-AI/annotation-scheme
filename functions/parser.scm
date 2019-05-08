
(define-public (parse result)
   (let*
      (
			 [go-annotations (get-annotations "gene_go_annotation" result)]
			 [pathway-annotations (get-annotations "gene_pathway_annotation" result)]
			 [biogrid-annotations (get-annotations "biogrid_interaction_annotation" result)]
			 [nodes '()]
			 [edges '()]
			 [atoms '()]
			 [graph '()]
			 [data '()]
			 [json '()]
      )
	 (set! data (create-gene-nodes result data))
	 (set! data (parse-go-annotations go-annotations data))
	 (set! data (parse-pathway-annotations pathway-annotations data))
	 (set! data (parse-biogrid-annotations biogrid-annotations data))
	 (set! nodes (list-ref data 0))
	 (set! atoms (list-ref data 1))
	 (set! edges (list-ref data 2))
	 (set! graph (make-graph nodes edges))
	 (set! json (scm->json-string graph))
	 json
   )
)

(define* (create-gene-nodes annotation-list data)
 (let*
  (
	  [gene ""]
	  [gene-name ""]
	  [gene-definition ""]
	  [nodes '()]
	  [atoms '()]
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
  (set! data (list nodes atoms))
  data
  )
)

(define* (parse-go-annotations go-annotations data)
 (let*
  (
	   [nodes (list-ref data 0)]
	   [atoms (list-ref data 1)]
	   [edges '()]
  )
  (map (lambda(main-annotation)
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
					[node (create-node node-id node-name node-definition annotation)]
					[gene-node (cog-name (cog-outgoing-atom annot 0))]
				)
				(if (not (node-exists? node-id atoms))
					(begin
						(set! nodes (append (list node) nodes))
						(set! atoms (cons node-id atoms))
					)
				)
				(set! edges (append (list (create-edge gene-node node-id  "annotates" annotation)) edges))
			   )
			)
		   )
		  )
	  )
   go-annotations)
  (set! data (list nodes atoms edges))
  data
 )
)

(define* (parse-pathway-annotations pathway-annotations data)
 (let*
  (
	  [nodes (list-ref data 0)]
	  [atoms (list-ref data 1)]
	  [edges (list-ref data 2)]
  )
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
							[node1-id (cog-name (cog-outgoing-atom annot 0))]
							[node2-id (cog-name (cog-outgoing-atom annot 1))]
;							TODO: Hedra should make sure either one of the atoms is not duplicate.
							[node-id (if (not (node-exists? node1-id atoms)) node1-id (if (not (node-exists? node2-id atoms)) node2-id))]
							[node-id (if (unspecified? node-id) node1-id node-id)] ;TODO Weird issue where a node becomes unspecified for no reason
							[node-name ""]
							[node-definition (get-node-info node-info "defn")]
							[node (create-node node-id node-name node-definition annotation)]
							[other-node-id (if (equal? node1-id node-id) node2-id node1-id)]
						)
						(if (not (node-exists? node-id atoms))
							 (begin
								(set! nodes (append (list node) nodes))
								(set! atoms (cons node-id atoms))
							 )
						)
;						(if (check-nodes node1 node2 node1-type node2-type)
						 (set! edges (append (list (create-edge other-node-id node-id "annotates" annotation)) edges))
;						)
					 )
				)
		   )
;		   (if (equal? main-atom-type 'EvaluationLink)
;				(let*
;				 (
;					 [predicate (cog-outgoing-atom annot 0)]
;					 [listlink (cog-outgoing-atom annot 1)]
;					 [node1-name (cog-name (cog-outgoing-atom listlink 0))]
;					 [node2-name (cog-name (cog-outgoing-atom listlink 1))]
;					 [node1-type (cog-type (cog-outgoing-atom listlink 0))]
;					 [node2-type (cog-type (cog-outgoing-atom listlink 1))]
;					 [node1 (create-node (cog-outgoing-atom listlink 0) annotation)]
;					 [node2 (create-node (cog-outgoing-atom listlink 1) annotation)]
;				 )

;				 (if (not (node-exists? node1-name atoms))
;					 (begin
;						(set! nodes (append (list node1) nodes))
;						(set! atoms (cons node1-name atoms))
;					 )
;				 )
;				 (if (not (node-exists? node2-name atoms))
;					(begin
;						(set! nodes (append (list node2) nodes))
;						(set! atoms (cons node2-name atoms))
;					)
;				 )
;				 (set! edges (append (list (create-edge-2 (cog-name (cog-outgoing-atom listlink 0)) (cog-name (cog-outgoing-atom listlink 1)) (cog-name predicate) annotation)) edges))
;				)
;		   )
		  )
	)
	pathway-annotations)
   (set! data (list nodes atoms edges))
    data
 )
)

(define* (parse-biogrid-annotations biogrid-annotations data)
 (let*
  (
	  [nodes (list-ref data 0)]
	  [atoms (list-ref data 1)]
	  [edges (list-ref data 2)]
  )
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
				 [node (create-node node-id node-name node-defn annotation)]
				 [other-node-id (if (equal? node1-id node-id) node2-id node1-id)]
			 )
			 (if (not (node-exists? node-id atoms))
					 (begin
						(set! nodes (append (list node) nodes))
						(set! atoms (append (list node-id) atoms))
					 )
			 )
			 (set! edges (append (list (create-edge other-node-id node-id predicate  annotation)) edges))
			)
		   )
		  )
	 )
	 biogrid-annotations)
     (set! data (list nodes atoms edges))
     data
 )
)

