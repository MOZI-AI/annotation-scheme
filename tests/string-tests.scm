(define-module (tests string-tests)
    #:use-module (srfi srfi-64)
    #:use-module (opencog)
    #:use-module (opencog exec)
    #:use-module (opencog bioscience)
    #:use-module (annotation functions)
    #:use-module (annotation util)
)

(test-begin "string")

(primitive-load "tests/string_ggi_sample.scm")

(primitive-load "tests/string_ppi_sample.scm")

;;Fake expression to find ppi
(define expr-link (Evaluation 
                    (Predicate "expresses")
                    (List (Gene "ARF5") (MoleculeNode "Uniprot:P84085"))
            ))

(test-equal "find-ggi" 19 (length (find-ggi (Gene "ARF5"))))

(test-equal "find-ggi-filtered" 9 (length (find-ggi (Gene "ARF5") '("reaction"))))

(test-equal "find-ppi" 19 (length (find-ppi (Gene "ARF5"))))

(test-equal "find-ppi-filtered" 9 (length (find-ppi (Gene "ARF5") '("reaction"))))

(clear)

(test-end "string")