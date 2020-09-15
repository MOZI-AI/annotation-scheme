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

(primitive-load-path "tests/string_ppi_sample.scm")


(define atoms (map (lambda (i) (Concept i)) all-interactions))
(define lst (do-find-ppi (Set (UniprotNode "P84085") (List atoms))))
(test-equal "find-ppi" 19 (length lst))

(map (lambda (l) (display (gddr l))) lst)

(test-equal "find-ppi-filtered" 2 (length (do-find-ppi (Set (UniprotNode "Q9Y587") (List (Concept "binding") (Concept "reaction"))))))

(clear)
(setenv "TEST_MODE" #f) ;;remove the env variable
(test-end "string")