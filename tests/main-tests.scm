(define-module (tests main)
    #:use-module (srfi srfi-64)
    #:use-module (ice-9 futures)
)

(test-begin "main")

;;Load modules and test atomspace
(primitive-load "opencog_deps")
(primitive-load "tests/sample_dataset.scm")

;;Mock the write-to-file function
(define-public (write-to-file result id name) #t)

(define req "[{\"function_name\": \"gene-pathway-annotation\", \"filters\": [{\"filter\": \"pathway\", \"value\": \"smpdb reactome\"}, {\"filter\": \"include_prot\", \"value\": \"True\"}, {\"filter\": \"include_sm\", \"value\": \"False\"}, {\"filter\": \"biogrid\", \"value\": \"0\"}]}, {\"function_name\": \"gene-go-annotation\", \"filters\": [{\"filter\": \"namespace\", \"value\": \"biological_process cellular_component molecular_function\"}, {\"filter\": \"parents\", \"value\": \"0\"}]}, {\"function_name\": \"biogrid-interaction-annotation\", \"filters\": [{\"filter\": \"interaction\", \"value\": \"Proteins\"}]}]")

(test-equal "parse-request" 4 (length (parse-request (list "IGF1") req)))

(test-assert "annotate-genes" (string? (annotate-genes (list "IGF1") "Dfaer" req)))

(clear)
(test-end "main")