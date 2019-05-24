;; load modules

(use-modules (opencog))
(use-modules (opencog python))
(use-modules (opencog query))
(use-modules (opencog exec))
(use-modules (opencog bioscience))
(use-modules (ice-9 textual-ports))
(use-modules (srfi srfi-1))

;; load sample dataset

(primitive-load "tests/sample_dataset.scm")

;; load the scheme functions 

(primitive-load "functions/gene_go_annotation.scm")

(primitive-load "functions/gene_pathway_annotation.scm")

(primitive-load "functions/biogrid_interaction_annotation.scm")

;; Load the PM functions 

(primitive-load "helpers/pm_functions.scm")
(primitive-load "helpers/parser_utils.scm")
(primitive-load "functions/parser.scm")
(primitive-load "helpers/utils.scm")


;; Load request handler
 
(primitive-load "functions/annotation_request_handler.scm")

;; Do some examples

(define ex1 '())

(if (equal? (genes (list "MAP2K4" "SPAG9")) "0") 
(begin
(set! ex1 
 (append (gene-info (mapSymbol (list "MAP2K4" "SPAG9")))
 (list 
  (gene-go-annotation (list "MAP2K4" "SPAG9") (list "biological_process" "cellular_component"))
  (gene-pathway-annotation (list "MAP2K4" "SPAG9") "smpdb reactome" "True" "True")
  (biogrid-interaction-annotation (list "MAP2K4" "SPAG9") "proteins" )
 ))
)
))


(call-with-output-file "example-1.scm"
(lambda (output-port)
(display ex1 output-port)))


  

