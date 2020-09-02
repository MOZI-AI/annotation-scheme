(define-module (tests string-tests)
    #:use-module (srfi srfi-64)
    #:use-module (opencog)
    #:use-module (opencog exec)
    #:use-module (opencog bioscience)
    #:use-module (annotation string-helpers)
    #:use-module (annotation util)
    #:use-module (annotation functions)
)

(test-begin "string")
(setenv "TEST_MODE" "TRUE")
(primitive-load-path "tests/string_ggi_sample.scm")

(primitive-load-path "tests/string_ppi_sample.scm")

;;Fake expression to find ppi
(define expr-link (Evaluation 
                    (Predicate "expresses")
                    (List (Gene "ARF5") (MoleculeNode "Uniprot:P84085"))))

(define atoms (map (lambda (i) (Concept i)) all-interactions))

(test-equal "find-ggi" 19 (length (do-find-ggi (Set (Gene "ARF5") (List atoms)))))

(test-equal "find-ggi-filtered" 9 (length (do-find-ggi (Set (Gene "ARF5") (List (Concept "reaction"))))))

(clear)
(setenv "TEST_MODE" #f) ;;remove the env variable
(test-end "string")