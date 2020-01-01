#! /usr/bin/env guile
!#

(use-modules
	(srfi srfi-64)
	(ice-9 futures)
	(opencog)
	(opencog bioscience)
	(annotation main)
	(annotation functions)
	(annotation util)
)

(test-begin "main")

;; Load test atomspace
(primitive-load-path "tests/sample_dataset.scm")

;;Mock the write-to-file function
(define-public (write-to-file result id name) #t)

(define req "[{\"function_name\": \"gene-pathway-annotation\", \"filters\": [{\"filter\": \"pathway\", \"value\": \"smpdb reactome\"},{\"filter\": \"include_prot\", \"value\": \"True\"}, {\"filter\": \"include_sm\", \"value\": \"False\"}, {\"filter\": \"biogrid\", \"value\": \"0\"}]}, {\"function_name\": \"gene-go-annotation\", \"filters\": [{\"filter\": \"namespace\", \"value\": \"biological_process cellular_component molecular_function\"}, {\"filter\": \"parents\", \"value\": \"0\"}, {\"filter\": \"protein\", \"value\": \"True\"}]}, {\"function_name\": \"include-rna\", \"filters\": [{\"filter\": \"coding\", \"value\": \"True\"},{\"filter\": \"noncoding\", \"value\": \"True\"},{\"filter\": \"protein\", \"value\": \"1\"}]},{\"function_name\": \"biogrid-interaction-annotation\", \"filters\": [{\"filter\": \"interaction\", \"value\": \"Proteins\"}]}]")

(test-equal "parse-request" 5 (length (parse-request (list "IGF1") "Dfaer" req)))

(test-assert "annotate-genes" (string? (annotate-genes (list "IGF1") "Dfaer" req)))

(test-equal "find-genes" "1:" (substring (find-genes (list "IGF")) 0 2))

(define namespace (list "biological_process" "molecular_function" "cellular_component"))

(test-equal "protein-goterm" 86 (length (cog-outgoing-set (find-proteins-goterm (GeneNode "IGF1") namespace 0))))

(primitive-load-path "annotation/pln_rule.scm")

(test-equal "current_vs_prev_symbols" (ListLink) (find-protein-form (GeneNode "NOV")))

(test-equal "find-genes" "0" (find-genes (list "IGF1" "TF")))

(test-equal "delete-genes" #t (cog-delete-recursive (GeneNode "IGF")))

(clear)
(test-end "main")
