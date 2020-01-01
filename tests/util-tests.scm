#! /usr/bin/env guile
!#

(use-modules
	(srfi srfi-64)
	(opencog)
	(opencog exec)
	(opencog bioscience)
	(annotation util)
)

(test-begin "util")
(primitive-load-path "tests/sample_dataset.scm")
(define entrez-link (EvaluationLink
        (PredicateNode "has_entrez_id")
        (ListLink 
	(GeneNode "IGF1")
	(ConceptNode "entrez:3479"))))


(test-assert "build-desc-go"  (string=? "http://amigo.geneontology.org/amigo/term/GO:1902430" (build-desc-url "GO:1902430")))

(test-assert "build-desc-prot"  (string=? "https://www.uniprot.org/uniprot/P4354" (build-desc-url "Uniprot:P4354")))

(test-assert "build-desc-prot"  (string=? "https://www.uniprot.org/uniprot/P4354" (build-desc-url "Uniprot:P4354")))

(test-assert "build-desc-gene"  (string=? "https://www.ncbi.nlm.nih.gov/gene/3479" (build-desc-url "IGF1")))

(test-assert "similar-genes" (= 11 (length (find-similar-gene "IGF"))))

(clear)


(test-end "util")
