#! /usr/bin/env guile
!#

(use-modules
	(srfi srfi-64)
	(opencog)
	(opencog exec)
	(opencog bioscience)
	(annotation gene-go)
	(annotation gene-pathway)
	(annotation biogrid)
	(annotation parser)
	(json)
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

(test-end "parser")
