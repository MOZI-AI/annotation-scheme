#! /usr/bin/env guile
!#

(use-modules
	(srfi srfi-64)
	(opencog)
	(opencog exec)
	(opencog bioscience)
	(annotation gene-go)
	(annotation gene-pathway)
	(annotation biogrid)
	(annotation functions)
	(annotation util)
)


(test-begin "pathway")
;; Load test atomspace
(primitive-load "tests/sample_dataset.scm")

(test-equal "pathway-interactors" 3 (length (pathway-gene-interactors  (ConceptNode "R-HSA-114608"))))

(clear)
(test-end "pathway")
