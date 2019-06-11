;; load modules

(use-modules (opencog))
(use-modules (opencog python))
(use-modules (opencog query))
(use-modules (opencog exec))
(use-modules (opencog bioscience))
(use-modules (ice-9 textual-ports))
(use-modules (srfi srfi-1))
(use-modules (json))

;; load sample dataset

(primitive-load "tests/sample_dataset.scm")

;; load the scheme functions 

(primitive-load "functions/gene_go_annotation.scm")

(primitive-load "functions/gene_pathway_annotation.scm")

(primitive-load "functions/biogrid_interaction_annotation.scm")

;; Load the PM functions 

(primitive-load "functions/pm_functions.scm")

(primitive-load "helpers/utils.scm")
(primitive-load "helpers/parser_utils.scm")

(primitive-load "functions/parser.scm")



;; Load request handler
 
(primitive-load "functions/annotation_request_handler.scm")

;; Do some examples

(define result (append
				(list (gene-info (mapSymbol (list "SPAG9" "MAP2K4" ))))
				(list
				 ( gene-go-annotation (list "SPAG9" "MAP2K4" )  "biological_process cellular_component molecular_function" 0)
				 ( gene-pathway-annotation (list "SPAG9" "MAP2K4" )  "smpdb reactome"  "True"  "True" )
				 ( biogrid-interaction-annotation (list "SPAG9" "MAP2K4" )  "Proteins" )
				)
			   )
)


(call-with-output-file "example-1.scm"
(lambda (output-port)
(display result output-port)))

;;(parse ex1 (list "MAP2K4" "SPAG9"))

  

