(define-module (tests main)
    #:use-module (srfi srfi-64)
    #:use-module (ice-9 futures)
)

(test-begin "main")

;;Load modules and test atomspace
(primitive-load "opencog_deps")
(primitive-load "tests/sample_dataset.scm")

;;Mock the write-to-file function
(define (write-to-file result id name) #t)

(test-assert "annotate-genes" (string=? (annotate-genes '("IGF1") "Dfaer" (delay (parallel (gene-go-annotation '("IGF1") "biological_process molecular_function cellular_component" 0 #:id "Dfaer")  (biogrid-interaction-annotation (list "IGF1" )  "Proteins" #:id "Dfaer")(gene-pathway-annotation (list "IGF1" )  "reactome"  "False"  "False" #:biogrid 1 #:id "Dfaer"))))))

(clear)
(test-end "main")