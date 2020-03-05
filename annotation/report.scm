
(define-public (report)
" Print profile report... "

	; Pathway stuff.
	(format #t "\nPathway functions\n")
	(gene-path-anno-ctr #:report? #t)
	(gene-path-write-ctr #:report? #t)

	(smpdb-ctr #:report? #t)
	(reactome-ctr #:report? #t)

	(find-pathway-genes-ctr #:report? #t)
	(add-pathway-genes-ctr #:report? #t)
	(find-pathway-member-ctr #:report? #t)
	(pathway-gene-interactors-ctr #:report? #t)
	(generate-interactors-ctr #:report? #t)
	(pathway-hierarchy-ctr #:report? #t)
	(find-protein-ctr #:report? #t)
	
	; go stuff
	(format #t "\nGO functions\n")
	(gene-go-anno-ctr #:report? #t)
	(gene-go-write-ctr #:report? #t)
	(find-go-term-ctr #:report? #t)
	(add-go-info-ctr #:report? #t)

	; grid stuff
	(format #t "\nBiogrid functions\n")
	(biogrid-ctr #:report? #t)
	(biowrite-ctr #:report? #t)
	(match-gene-interactors-ctr #:report? #t)
	(find-output-interactors-ctr #:report? #t)
	(generate-result-ctr #:report? #t)
	(build-interaction-ctr #:report? #t)
	(find-memberln-ctr #:report? #t)
	(find-protein-form-ctr #:report? #t)
	(find-pubmed-id-ctr #:report? #t)
	(find-rna-ctr #:report? #t)
	
	; common to grid and path
	(format #t "\nCommon functions\n")
	(find-mol-ctr #:report? #t)
	(find-name-ctr #:report? #t)
	(locate-node-ctr #:report? #t)
	(add-loc-ctr #:report? #t)
	(find-parent-ctr #:report? #t)
)
