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
 
(primitive-load "functions/annotation_request_handler.scm")

;; Do some examples

(define ex1 '())
(define ex2 '())

(if (equal? (genes "MAP2K4 SPAG9") "0") 
(begin
(set! ex1 
 (append (gene_info (map_symbol "MAP2K4 SPAG9"))
 (list 
  (gene_go_annotation (list "biological_process" "cellular_component") 1 (map_symbol "MAP2K4 SPAG9"))
  (gene_pathway_annotation "smpdb reactome" "True" "True" (map_symbol "MAP2K4 SPAG9"))
  (biogrid_interaction_annotation "proteins" (map_symbol "MAP2K4 SPAG9"))
 ))
)

; (set! ex2  
;  (append (gene_info (map_symbol "MAP2K4 SPAG9"))
;  (list 
;   (gene_go_annotation (list "biological_process" "molecular_function" "cellular_component") 1 (map_symbol "MAP2K4 SPAG9")) 
;   (biogrid_interaction_annotation "genes" (map_symbol "MAP2K4 SPAG9"))
;  )))
))


(call-with-output-file "example-1.scm"
(lambda (output-port)
(display ex1 output-port)))

; (call-with-output-file "example-2.scm"
; (lambda (output-port)
; (display ex2 output-port)))

  

