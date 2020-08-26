(define-module (tests go-test)
    #:use-module (srfi srfi-64)
    #:use-module (opencog)
    #:use-module (opencog exec)
    #:use-module (opencog bioscience)
    #:use-module (annotation functions)
    #:use-module (annotation util)
    #:use-module (annotation go-helpers)
)

(test-begin "GO")
(setenv "TEST_MODE" "TRUE")
;;Load test atomspace
(primitive-load-path "tests/go_plus_sample.scm")
(primitive-load-path "tests/go_plus_chebi_sample.scm")

(test-equal "go-regulates" 1 (length (find-go-plus (BiologicalProcessNode "GO:1903896"))))

(test-equal "chebi-go-plus" 2 (length (find-mol-go-plus (ChebiNode "ChEBI:15776"))))

(clear)

(setenv "TEST_MODE" #f) ;;remove the env variable
(test-end "GO")