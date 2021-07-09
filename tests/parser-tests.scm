(define-module (tests parser-test)
    #:use-module (srfi srfi-64)
    #:use-module (opencog)
    #:use-module (opencog exec)
    #:use-module (opencog bioscience)
    #:use-module (annotation gene-go)
    #:use-module (annotation gene-pathway)
    #:use-module (annotation graph)
    #:use-module (annotation biogrid)
    #:use-module (fibers conditions)
    #:use-module (annotation parser)
    #:use-module (json))

(test-begin "parser")

(define res  (list
         (EvaluationLink
            (PredicateNode "has_pubmedID")
            (ListLink
               (EvaluationLink
                  (PredicateNode "interacts_with")
                  (ListLink
                     (Uniprot "Uniprot:P05019")
                     (Uniprot "Uniprot:P17936")
                  )
               )
               (ListLink
                  (ConceptNode "https://www.ncbi.nlm.nih.gov/pubmed/?term=9497324")
                  (ConceptNode "https://www.ncbi.nlm.nih.gov/pubmed/?term=10823924")
                  (ConceptNode "https://www.ncbi.nlm.nih.gov/pubmed/?term=12735930")
               )
            )
         )
         (Member (Uniprot "Uniprot:P17936") (CellularComponent "membrane"))
         (EvaluationLink
            (PredicateNode "has_name")
            (ListLink
               (Uniprot "Uniprot:P17936")
               (GeneNode "IGFBP3")
            )
         )
         (EvaluationLink
            (PredicateNode "has_name")
            (ListLink
               (Uniprot "Uniprot:P05019")
               (GeneNode "IGF1")
            )
         )
         (EvaluationLink (stv 1 1)
            (PredicateNode "has_location")
            (ListLink
               (Uniprot "Uniprot:P17936")
               (ConceptNode "extracellular region")
            )
         )
         (EvaluationLink (stv 1 1)
            (PredicateNode "has_location")
            (ListLink
               (Uniprot "Uniprot:P17936")
               (ConceptNode "endoplasmic reticulum lumen")
            )
         )
))
(define n (length res))
(define i 0)
(define proc (let ()
   (lambda () (set! i (+ i 1)) (if (>= (- i 1) n) 'eof (list-ref res (- i 1))))
))

(define out (open-output-file "tests/test.json"))
(atomese-parser proc out (make-condition))
(define input (open-input-file "tests/test.json"))

(define json (json->scm input))


(test-assert "node-count" (= 2 (vector-length (assoc-ref json "nodes"))))

(test-assert "edge-count" (= 2 (vector-length (assoc-ref json "edges"))))


(close-port input)
;;remove the file
(system "rm test.json")

(test-end "parser")
