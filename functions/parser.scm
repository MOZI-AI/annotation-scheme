
(define-public (parse result genes)
   (let*
      (
			 [go-annotations (get-annotations "gene-go-annotation" (cdr result))]
			 [pathway-annotations (get-annotations "gene-pathway-annotation" (cdr result))]
			 [biogrid-annotations (get-annotations "gene-pathway-annotation" (cdr result))]
			 [nodes '()]
			 [edges '()]
			 [graph '()]
			 [data '()]
			 [json '()]
      )
	 (set! data (create-gene-nodes (car result) data genes))
	 (set! data (parse-go-annotations go-annotations data genes))
	 (set! data (parse-pathway-annotations pathway-annotations data genes))
	 (set! data (parse-biogrid-annotations biogrid-annotations data genes))
	 (set! nodes (list-ref data 0))
	 (set! edges (list-ref data 2))
	 (set! graph (make-graph nodes edges))
	 (set! json (scm->json-string graph))
	 json
   )
)

(define* (create-gene-nodes annotation-list data genes)
 (let*
  (
	  [gene ""]
	  [gene-name ""]
	  [gene-definition ""]
	  [nodes '()]
	  [atoms '()]
  )
  (for-each
    (lambda (annotation-atoms)
	 (let*
	  (
		  [annotations (cog-outgoing-set annotation-atoms)]
	  )
	  (if (equal? 2 (length annotations)) ;;there should be a better way to 
	   (begin
		(for-each
		 (lambda (gene-info)
		  (begin (if (equal? (cog-name (cog-outgoing-atom gene-info 0)) "has_name")
			(begin
			 (set! gene (cog-name (car (cog-outgoing-set (cog-outgoing-atom gene-info 1)))))
			 (set! gene-name (cog-name (cadr (cog-outgoing-set (cog-outgoing-atom gene-info 1)))))
			)
		   )
		   (if (equal? (cog-name (cog-outgoing-atom gene-info 1)) "has_definition")
			(set! gene-definition (cog-name (cadr (cog-outgoing-set (cog-outgoing-atom gene-info 1)))))
		   )
		   (if (not (node-exists? gene atoms))
			(begin
			 (set! nodes (append (list (create-node genes gene gene-name gene-definition "" "")) nodes))
			 (set! atoms (cons gene atoms))
			)
		   )
		  )
		 )
		 annotations)
	   )
	  )
	 )
   )
   annotation-list)
  (set! data (list nodes atoms))
  data
  )
)

(define* (parse-go-annotations go-annotations data genes)
 (let*
  (
	   [nodes (list-ref data 0)]
	   [atoms (list-ref data 1)]
	   [edges '()]
  )
  (map (lambda(main-annotation)
		(let*
		   (
			   [annot (list-ref (cog-outgoing-set main-annotation) 0)]
			   [node-info (cog-outgoing-set main-annotation)]
			   [annotation "gene-go-annotation"]
			   [main-atom-type (cog-type annot)]
			   [inner-atom (cog-outgoing-atom annot 0)]
		   )
		   (if (equal? main-atom-type 'MemberLink)
			(begin
			   (let*
				(
					[node-id (cog-name (cog-outgoing-atom annot 1))]
					[node-name (get-node-info-go node-info "name")]
					[node-definition (get-node-info-go node-info "defn")]
					[node-location (get-node-loc node-info)]
					[node (create-node genes node-id node-name node-definition node-location annotation)]
					[gene-node (cog-name (cog-outgoing-atom annot 0))]
				)
				(if (not (node-exists? node-id atoms))
					(begin
					 	(set! atoms (cons node-id atoms))
					 	(set! nodes (append (list node) nodes))
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

(define* (parse-pathway-annotations pathway-annotations data genes)
 (let*
  (
	  [nodes (list-ref data 0)]
	  [atoms (list-ref data 1)]
	  [edges (list-ref data 2)]
  )
  (map (lambda(main-annotation)
		  (let*
		   (

			   [annot (list-ref (cog-outgoing-set main-annotation) 2)]
			   [node-info (cog-outgoing-set main-annotation)]
			   [annotation "gene-pathway-annotation"]
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
							[node-name (get-node-info node-info "name")]
							[node-definition (get-node-info node-info "defn")]
							[node-locations (get-node-loc-pathway node-info)]
							[other-node-id (if (equal? node1-id node-id) node2-id node1-id)]
						)
						(if (not (node-exists? node-id atoms))
							 (begin
							  	(set! atoms (cons node-id atoms))
									(if (null? node-locations)
										(set! nodes (append (list (create-node genes node-id node-name node-definition "" annotation)) nodes))
										(map (lambda (location)
							  			(set! nodes (append (list (create-node genes node-id node-name node-definition location 	annotation)) nodes))
											)
					 						node-locations)
									)

							 )
						)
					    (set! edges (append (list (create-edge other-node-id node-id "annotates" annotation)) edges))
					 )
				)
		   )
		   (if (equal? main-atom-type 'EvaluationLink)
				(let*
				 (
					 [predicate (cog-outgoing-atom annot 0)]
					 [listlink (cog-outgoing-atom annot 1)]
					 [node1-id (cog-name (cog-outgoing-atom listlink 0))]
					 [node2-id (cog-name (cog-outgoing-atom listlink 1))]
					 [node-id (if (not (node-exists? node1-id atoms)) node1-id (if (not (node-exists? node2-id atoms)) node2-id))]
					 [node-id (if (unspecified? node-id) node1-id node-id)]
					 [node-name (get-node-info node-info "name")]
					 [node-definition (get-node-info node-info "defn")]
					 [node-locations (get-node-loc-pathway node-info)]
					 [other-node-id (if (equal? node1-id node-id) node2-id node1-id)]
				 )
				 (if (not (node-exists? node-id atoms))
					 (begin
						(set! atoms (cons node-id atoms))
						(if (null? node-locations)
										(set! nodes (append (list (create-node genes node-id node-name node-definition "" 	annotation)) nodes))
										(map (lambda (location)
							  			(set! nodes (append (list (create-node genes node-id node-name node-definition location 	annotation)) nodes))
											)
					 						node-locations)
									)
					 )
				 )
				 (set! edges (append (list (create-edge other-node-id node-id "annotates" annotation)) edges))
				)
		   )
		  )
	)
	pathway-annotations)
   (set! data (list nodes atoms edges))
    data
 )
)

(define* (parse-biogrid-annotations biogrid-annotations data genes)
 (let*
  (
	  [nodes (list-ref data 0)]
	  [atoms (list-ref data 1)]
	  [edges (list-ref data 2)]
  )
  (map (lambda(main-annotation)
		(let*
		   (
			   [annotation "biogrid-interaction-annotation"]
			   [annot (cog-outgoing-atom  main-annotation 0)]
			   [main-atom-type (cog-type annot)]
			   [node-info (cog-outgoing-set main-annotation)]

		   )
		   (if (equal? main-atom-type 'EvaluationLink)
			(let*
			 (
				 [predicate (cog-name (cog-outgoing-atom annot 0))]
				 [listlink (cog-outgoing-atom annot 1)]
			 )
			 (if (equal? 'MemberLink (cog-type (cog-outgoing-atom listlink 0)))
			  (let*
			   (
				   [node1-id (cog-name (cog-outgoing-atom listlink 0))]
				   [node2-id (cog-name (cog-outgoing-atom listlink 1))]
				   [node-id (if (not (node-exists? node1-id atoms)) node1-id (if (not (node-exists? node2-id atoms)) node2-id))]
				   [node-id (if (unspecified? node-id) node1-id node-id)] ;TODO Weird issue where a node becomes unspecified for no reason
				   [node-name (get-node-info  node-info "name")]
				   [node-defn (get-node-info  node-info "defn")]
				   [node (create-node genes node-id node-name node-defn "" annotation)]
				   [other-node-id (if (equal? node1-id node-id) node2-id node1-id)]
				   [edge-pubmed-id (get-pubmedID node-info)]
			   )
			    (if (not (node-exists? node-id atoms))
					 (begin
						(set! nodes (append (list node) nodes))
						(set! atoms (append (list node-id) atoms))
					 )
			    )
			   	(set! edges (append (list (create-edge other-node-id node-id predicate edge-pubmed-id annotation)) edges))
			  )
			 )
			 (if (equal? 'EvaluationLink (cog-type (cog-outgoing-atom listlink 0)))
			  (let*
			   (
				   [node1-id (cog-name (cog-outgoing-atom (cog-outgoing-atom (cog-outgoing-atom listlink 0) 1) 0))]
				   [node2-id (cog-name (cog-outgoing-atom (cog-outgoing-atom (cog-outgoing-atom listlink 0) 1) 1))]
				   [node-id (if (not (node-exists? node1-id atoms)) node1-id (if (not (node-exists? node2-id atoms)) node2-id))]
				   [node-id (if (unspecified? node-id) node1-id node-id)] ;TODO Weird issue where a node becomes unspecified for no reason
				   [node-name (get-node-info  node-info "name")]
				   [node-defn (get-node-info  node-info "defn")]
				   [node (create-node genes node-id node-name node-defn "" annotation)]
				   [other-node-id (if (equal? node1-id node-id) node2-id node1-id)]
				   [edge-pubmed-id (get-pubmedID node-info)]
			   )
			   (if (not (node-exists? node-id atoms))
					(begin
						(set! nodes (append (list node) nodes))
						(set! atoms (append (list node-id) atoms))
					)
			   )
			   (set! edges (append (list (create-edge other-node-id node-id predicate edge-pubmed-id annotation)) edges))
			  )
			 )
			)
		   )
		  )
	 )
	 biogrid-annotations)
     (set! data (list nodes atoms edges))
     data
 )
)

