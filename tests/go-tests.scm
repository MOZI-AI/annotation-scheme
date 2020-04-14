(define-module (tests go-test)
    #:use-module (srfi srfi-64)
    #:use-module (opencog)
    #:use-module (opencog exec)
    #:use-module (opencog bioscience)
    #:use-module (annotation functions)
    #:use-module (annotation util)
)

(test-begin "GO")

;;Load test atomspace
(primitive-load-path "tests/go_plus_sample.scm")


(test-equal "go-regulates" 3 (length (find-go-regulates (ConceptNode "GO:1903896"))))

(clear)
(test-end "GO")