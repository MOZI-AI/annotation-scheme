;; load modules

(use-modules (opencog))
(use-modules (opencog python))
(use-modules (opencog query))
(use-modules (opencog exec))
(use-modules (opencog bioscience))
(use-modules (ice-9 textual-ports)) 

;; load sample dataset

(primitive-load "tests/sample_dataset.scm")

;; load the scheme functions 

(primitive-load "functions/gene_go_annotation.scm")

(primitive-load "functions/gene_pathway_annotation.scm")

(primitive-load "functions/biogrid_interaction_annotation.scm")

;; Load the PM functions 

(primitive-load "helpers/pm_functions.scm")
(primitive-load "functions/parser.scm")


;; Load request handler
 
(primitive-load "annotation_request_handler.scm")

;; Do some examples

(genes "MAP2K4 SPAG9")

;; 1
;; - finds Go terms for a given genes (of type biological process and cellular component), will traverse 1st level of parents of GO
;; - finds the pathways from SMPDB and reactome. The proteins and Small molecules of the pathways are included
;; - finds the PPI (protein protein interaction) from the biogrid data. 

(define ex1 (do_annotation_scm 
 (list 
 ;; (gene_go_annotation "biological_process cellular_component" 1) 
;  (gene_pathway_annotation "smpdb reactome" "True" "True")
  (biogrid_interaction_annotation)
 )
))

(call-with-output-file "example-1.scm"
(lambda (output-port)
(display ex1 output-port)))


;;; 2
;; - finds Go terms for a given genes (of type biological process, molecular funcction and cellular component), will include the 1st level parents of the GO
;; - finds the Gene-Gene interaction (As the gene pathways annotation is not selected) from the biogrid data
(define ex2 (do_annotation_scm 
 (list 
  (gene_go_annotation "biological_process molecular_function cellular_component" 1) 
  ;;(biogrid_interaction_annotation)
 )
))

(call-with-output-file "example-2.scm"
(lambda (output-port)
(display ex2 output-port)))


;; 3
;; - finds the Gene-Gene interaction (As the gene pathways annotation is not selected) from the biogrid data
(define ex3 (do_annotation_scm 
 (list 
  (biogrid_interaction_annotation)
 )
))


(call-with-output-file "example-3.scm"
(lambda (output-port)
(display ex3 output-port)))



  

