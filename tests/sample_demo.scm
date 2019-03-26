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

(primitive-load "functions/pm_functions.scm")


;; Load request handler
 
(primitive-load "functions/annotation_request_handler.scm")


;; Do some examples

(genes "SPAG9")

;; 1
;; - finds Go terms for a given genes (of type biological process and cellular component), will traverse 1st level of parents of GO
;; - finds the pathways from SMPDB and reactome. The proteins and Small molecules of the pathways are included
;; - finds the PPI (protein protein interaction) from the biogrid data. 

(do_annotation_scm
 (list
  (gene_pathway_annotation "smpdb reactome" "True" "True")
 )
)




  

