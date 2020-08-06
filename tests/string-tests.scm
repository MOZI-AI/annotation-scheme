(define-module (tests string-tests)
    #:use-module (srfi srfi-64)
    #:use-module (opencog)
    #:use-module (opencog exec)
    #:use-module (opencog bioscience)
    #:use-module (annotation string-helpers)
    #:use-module (annotation util)
)

(test-begin "string")

(primitive-load "tests/string_ggi_sample.scm")

(primitive-load "tests/string_ppi_sample.scm")

;;Fake expression to find ppi
(define expr-link (Evaluation 
                    (Predicate "expresses")
                    (List (Gene "ARF5") (MoleculeNode "Uniprot:P84085"))))

(define atoms (map (lambda (i) (Concept i)) all-interactions))

(test-equal "find-ggi" 19 (length (do-find-ggi (Set (Gene "ARF5") (List atoms)))))

(test-equal "find-ggi-filtered" 9 (length (do-find-ggi (Set (Gene "ARF5") (List (Concept "reaction"))))))

(clear)

(test-end "string")