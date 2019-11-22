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

(define req "[{\"function_name\": \"gene-pathway-annotation\", \"filters\": [{\"filter\": \"pathway\", \"value\": \"smpdb reactome\"},{\"filter\": \"include_prot\", \"value\": \"True\"}, {\"filter\": \"include_sm\", \"value\": \"False\"}, {\"filter\": \"biogrid\", \"value\": \"0\"}]}, {\"function_name\": \"gene-go-annotation\", \"filters\": [{\"filter\": \"namespace\", \"value\": \"biological_process cellular_component molecular_function\"}, {\"filter\": \"parents\", \"value\": \"0\"}, {\"filter\": \"protein\", \"value\": \"True\"}]}, {\"function_name\": \"biogrid-interaction-annotation\", \"filters\": [{\"filter\": \"interaction\", \"value\": \"Proteins\"}]}]")

(test-equal "parse-request" 4 (length (parse-request (list "IGF1") "Dfaer" req)))

(test-assert "annotate-genes" (string? (annotate-genes (list "IGF1") "Dfaer" req)))

(test-equal "find-genes" "1:" (substring (find-genes (list "IGF")) 0 2))

(define namespace (list "biological_process" "molecular_function" "cellular_component"))

(test-equal "protein-goterm" 86 (length (cog-outgoing-set (find-proteins-goterm (GeneNode "IGF1") namespace 0))))

(primitive-load "annotation/pln_rule.scm")

(test-equal "current_vs_prev_symbols" (ListLink) (find-protein-form (GeneNode "NOV")))

(test-equal "find-genes" "0" (find-genes (list "IGF1" "TF")))

(test-equal "delete-genes" #t (cog-delete-recursive (GeneNode "IGF")))

(clear)
(test-end "main")