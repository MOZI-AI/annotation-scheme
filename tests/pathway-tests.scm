(define-module (tests pathway-test)
    #:use-module (srfi srfi-64)
    #:use-module (opencog)
    #:use-module (opencog query)
    #:use-module (opencog exec)
    #:use-module (opencog bioscience)
    #:use-module (annotation gene-go)
    #:use-module (annotation gene-pathway)
    #:use-module (annotation biogrid)
    #:use-module (annotation functions)
    #:use-module (annotation util)
)


(test-begin "pathway")
;; Load test atomspace
(primitive-load-path "tests/sample_dataset.scm")

(test-equal "pathway-interactors" 3 (length (pathway-gene-interactors  (ConceptNode "R-HSA-114608"))))

(clear)
(test-end "pathway")
