;; load modules

(use-modules (opencog))
(use-modules (opencog python))
(use-modules (opencog query))
(use-modules (opencog exec))
(use-modules (opencog bioscience))
(use-modules (ice-9 textual-ports)) 

;; load sample dataset

(primitive-load "sample_dataset.scm")

;; define global variables 

(define output '())  ;; final output to be returned to the user

(define result '())  ;; result for each annotation

(define gene_nodes '())

(define interaction "")

;; load the scheme functions 

(primitive-load "gene_go_annotation.scm")

(primitive-load "gene_pathway_annotation.scm")

(primitive-load "biogrid_interaction_annotation.scm")

;; Load the PM functions 

(primitive-load "pm_functions.scm")

;; load the parser
;;(primitive-load "parser.scm")

;; Load request handler
 
(primitive-load "annotation_request_handler.scm")


;; Do some examples
;; 1

(genes "MAP2K4 SPAG9")

(do_annotation 
 (list 
  (gene_go_annotation "biological_process cellular_component" 0) 
  (gene_pathway_annotation "smpdb reactome" "True" "True")
  (biogrid_interaction_annotation)
 )
)

;;; 2

(do_annotation 
 (list 
  (gene_go_annotation "biological_process cellular_component" 0) 
  (biogrid_interaction_annotation)
 )
)


;; 3

(do_annotation 
 (list 
  (biogrid_interaction_annotation)
 )
)
