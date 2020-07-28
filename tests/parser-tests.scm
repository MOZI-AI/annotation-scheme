(define-module (tests parser-test)
    #:use-module (srfi srfi-64)
    #:use-module (opencog)
    #:use-module (opencog exec)
    #:use-module (opencog bioscience)
    #:use-module (annotation gene-go)
    #:use-module (annotation gene-pathway)
    #:use-module (annotation graph)
    #:use-module (annotation biogrid)
    #:use-module (annotation parser))

(test-begin "parser")

(define res  (list
         (EvaluationLink
            (PredicateNode "has_pubmedID")
            (ListLink
               (EvaluationLink
                  (PredicateNode "interacts_with")
                  (ListLink
                     (MoleculeNode "Uniprot:P05019")
                     (MoleculeNode "Uniprot:P17936")
                  )
               )
               (ListLink
                  (ConceptNode "https://www.ncbi.nlm.nih.gov/pubmed/?term=9497324")
                  (ConceptNode "https://www.ncbi.nlm.nih.gov/pubmed/?term=10823924")
                  (ConceptNode "https://www.ncbi.nlm.nih.gov/pubmed/?term=12735930")
               )
            )
         )
         (EvaluationLink
            (PredicateNode "has_name")
            (ListLink
               (MoleculeNode "Uniprot:P17936")
               (GeneNode "IGFBP3")
            )
         )
         (EvaluationLink
            (PredicateNode "has_name")
            (ListLink
               (MoleculeNode "Uniprot:P05019")
               (GeneNode "IGF1")
            )
         )
         (EvaluationLink (stv 1 1)
            (PredicateNode "has_location")
            (ListLink
               (MoleculeNode "Uniprot:P17936")
               (ConceptNode "extracellular region")
            )
         )
         (EvaluationLink (stv 1 1)
            (PredicateNode "has_location")
            (ListLink
               (MoleculeNode "Uniprot:P17936")
               (ConceptNode "endoplasmic reticulum lumen")
            )
         )
))
(define n (length res))
(define i 0)
(define proc (let ()
   (lambda () (set! i (+ i 1)) (if (>= i n) 'eof (list-ref res (- i 1))))
))

(test-assert "node-count" (= (vector-length (cdar (atomese-parser proc))) 2))

(define i 0) ;; reset the list index
(test-assert "edge-count" (= (vector-length (cdadr (atomese-parser proc))) 1))

(test-end "parser")
