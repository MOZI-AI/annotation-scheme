;; load modules

(use-modules (opencog))
(use-modules (opencog python))
(use-modules (opencog query))
(use-modules (opencog exec))
(use-modules (opencog bioscience))
(use-modules (ice-9 textual-ports)) 

;; load sample dataset

(primitive-load "sample_dataset.scm")

;; load the scheme functions 

(primitive-load "gene_go_annotation.scm")

(primitive-load "gene_pathway_annotation.scm")

(primitive-load "biogrid_interaction_annotation.scm")

;; Load the PM functions 

(primitive-load "pm_functions.scm")


;; Load request handler
 
(primitive-load "annotation_request_handler.scm")


;; Do some examples

(genes "MAP2K4 SPAG9")

;; 1
(define ex1 (do_annotation_scm 
 (list 
  (gene_go_annotation "biological_process cellular_component" 0) 
  (gene_pathway_annotation "smpdb reactome" "True" "True")
  (biogrid_interaction_annotation)
 )
))
;; - finds Go terms for a given gene of type biological process and cellular component, will not look for parents of the GO as it is 0
;; - finds the pathways of a given gene from SMPDB and reactome. The proteins and Small molecules of the pathways are included
;; - finds the PPI (protein protein interaction) from the biogrid data (in this demo you will notice that this result is empty as the 
;;   proteins expresses by the given gene are not included in the sample dataset)


;;; 2
(define ex2 (do_annotation_scm 
 (list 
  (gene_go_annotation "biological_process molecular_function" 1) 
  (biogrid_interaction_annotation)
 )
))
;; - finds Go terms for a given gene of type biological process and molecular funcction, will include the 1st level parents of the GO
;; - finds the Gene-Gene interaction (As the gene pathways annotation is not selected) from the biogrid data


;; 3
(define ex3 (do_annotation_scm 
 (list 
  (biogrid_interaction_annotation)
 )
))
;; - finds the Gene-Gene interaction (As the gene pathways annotation is not selected) from the biogrid data


  

