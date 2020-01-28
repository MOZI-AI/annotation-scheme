(define-module (tests parser-test)
    #:use-module (srfi srfi-64)
    #:use-module (opencog)
    #:use-module (opencog exec)
    #:use-module (opencog bioscience)
    #:use-module (annotation gene-go)
    #:use-module (annotation gene-pathway)
    #:use-module (annotation biogrid)
    #:use-module (annotation parser)
    #:use-module (json)

)

(test-begin "parser")

(define res  (ListLink
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

(test-assert "atomese-parser"  (graph? (atomese-parser (format #f "~a" res))))

(test-assert "node-count" (= (length (graph-nodes (atomese-parser (format #f "~a" res)))) 2))

(test-assert "edge-count" (= (length (graph-edges (atomese-parser (format #f "~a" res)))) 3))

(test-end "parser")
