;;; MOZI-AI Annotation Scheme
;;; Copyright © 2019 Abdulrahman Semrie
;;; Copyright © 2019 Hedra Seid
;;; Copyright © 2019 Enkusellasie Wondesen
;;; Copyright © 2020 Ricardo Wurmus
;;;
;;; This file is part of MOZI-AI Annotation Scheme
;;;
;;; MOZI-AI Annotation Scheme is free software; you can redistribute
;;; it and/or modify it under the terms of the GNU General Public
;;; License as published by the Free Software Foundation; either
;;; version 3 of the License, or (at your option) any later version.
;;;
;;; This software is distributed in the hope that it will be useful,
;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;;; General Public License for more details.
;;;
;;; You should have received a copy of the GNU General Public License
;;; along with this software.  If not, see
;;; <http://www.gnu.org/licenses/>.

(define-module (annotation util)
	#:use-module (opencog)
	#:use-module (opencog exec)
	#:use-module (opencog bioscience)
	#:use-module (annotation graph)
	#:use-module (ice-9 optargs)
;	#:use-module (rnrs base)
	#:use-module (rnrs exceptions)
	#:use-module (ice-9 textual-ports)
	#:use-module (ice-9 regex)
	#:use-module (srfi srfi-1)
	#:use-module (ice-9 match)
	#:use-module (ice-9 threads)
	#:export (create-node
	          create-edge
            write-to-file
            get-file-path)
)

; ----------------------------------------------------

(define-public (memoize-function-call FUNC)
"
  memoize-function-call - Thread-safe function caching.

  This defines a cache for the function FUNC, assumed to be a function
  taking a single Stom as input, and returning any output. The cache
  records (memoizes) the return value returned by FUNC, and if it is
  called a secnd time, or more, the cached value is returned. This can
  save large amounts of time if FUNC is expensive.

  This differs from ordinary caching/memoizing utilities as it provides
  special handling for Atom arguments.
"
	(define mtx (make-mutex))
	(define cache (make-afunc-cache FUNC))
	(lambda (ATOM) (with-mutex mtx (cache ATOM)))
)

; ----------------------------------------------------

;; Define the parameters needed for GGI
(define-public biogrid-genes (make-parameter (make-atom-set)))
(define-public biogrid-pairs (make-parameter (make-atom-set)))
(define-public biogrid-reported-pathways (make-parameter (make-atom-set)))

(define (get-name atom)
 (if (> (length atom) 0)
  (cog-name (car  atom))
  ""
 )
)


(define* (create-node id name defn location annotation #:optional (subgroup ""))
    (make-node (make-node-info id name defn location subgroup annotation) "nodes")
)

(define* (create-edge node1 node2 name annotation #:optional (pubmedId "") (subgroup ""))
   (make-edge (make-edge-info node2 node1 name pubmedId subgroup annotation) "edges")
)

;; Find node name and description. See `node-info` below for documentation.
(define (do-get-node-info node)
	(define (node-name node)
		(let ([lst (find-pathway-name node)])
				(if (null? lst) (ConceptNode "N/A") (car lst))))

	(if (cog-node? node)
		(EvaluationLink (PredicateNode "has_name") (ListLink node (node-name node)))
		(ListLink))
)

; Cache results of do-get-node-info for performance.
(define memoize-node-info (memoize-function-call do-get-node-info))

(define-public (node-info ENTITY)
"
  node-info ENTITY -- Find the name and description of an entity.

  An entity can be any kind of conceptual object, such as a gene, protein,
  small molecule, RNA, GeneOntology (GO) term, cellular location, etc.
  Here, ENTITY is an AtomSpace Atom that encodes such an object.
"
	(list (memoize-node-info ENTITY)))


;;Finds a name of any node (Except GO which has different structure)
(define (do-find-pathway-name pw)
	(define is-enst (string-prefix? "ENST" (cog-name pw)))
   (if (or is-enst (string-contains (cog-name pw) "Uniprot:"))
      (let ([predicate (if is-enst "transcribed_to" "expresses")])
        (run-query (Get
           (VariableList
           (TypedVariable (Variable "$a") (Type 'GeneNode)))
           (Evaluation (Predicate predicate)
              (List (Variable "$a") pw)))))
      (run-query (Get
         (VariableList
         (TypedVariable (Variable "$a") (Type 'ConceptNode)))
         (Evaluation (Predicate "has_name")
            (List pw (Variable "$a"))))))
)

(define find-pathway-name
	(memoize-function-call do-find-pathway-name))

(define-public (is-cellular-component? ATOM-LIST)
"
  is-cellular-component? ATOM-LIST

  Return #t if any of the atoms in ATOM-LIST have the form

     (Evaluation
         (Predicate \"GO_namespace\")
         (List
            (Concept \"foo\")
            (Concept \"cellular_component\")))

  where (Concept \"foo\") could be anything. Otherwise, return #f.
"
	(any
		(lambda (info)
			(and
				(equal? (cog-name (gar info)) "GO_namespace")
				(equal? "cellular_component" (cog-name (gddr info)))))
		ATOM-LIST)

	; XXX TODO:
	; The code below might run faster, because it does a hash
	; compare instead of a string compare.
	;
	; (define pnas (Predicate "GO_namespace"))
	; (define celc (Concept "cellular_component"))
	; (any (lambda (info) (and
	;     (equal? pnas (gar info)) (equal? celc (gddr info)))) ATOM-LIST)
)

(define-public (build-desc-url node)
    (cond 
        ((string-prefix? "ChEBI" node) (string-append "https://www.ebi.ac.uk/chebi/searchId.do?chebiId=" (cadr (string-split node #\:))))
        ((string-prefix? "Uniprot" node) (string-append "https://www.uniprot.org/uniprot/" (cadr (string-split node #\:))))
        ((string-prefix? "GO" node) (string-append "http://amigo.geneontology.org/amigo/term/" node))
        ((string-prefix? "SMP" node) (string-append "http://smpdb.ca/view/" node))
        ((string-prefix? "R-HSA" node)
          (string-append "http://www.reactome.org/content/detail/" node)
        )
        ((string-prefix? "ENST" node) (string-append "http://useast.ensembl.org/Homo_sapiens/Gene/Summary?g=" node))
        ((or (string-prefix? "NM_" node) (string-prefix? "NR_" node) (string-prefix? "NP_" node) (string-prefix? "YP_" node))
          (string-append "https://www.ncbi.nlm.nih.gov/nuccore/" node))
        (else (string-append "https://www.ncbi.nlm.nih.gov/gene/"  (find-entrez (GeneNode node))))
    )
)

(define (find-entrez gene)
  "Find the entrez_id of a gene."
  (let ((entrez (get-name
                  (run-query
                   (GetLink
                    (VariableNode "$a")
                    (EvaluationLink
                     (PredicateNode "has_entrez_id")
                     (ListLink
                      gene
                      (VariableNode "$a"))))))))
    (match (string-split entrez #\:)
      ((single) single)
      ((first second . rest) second))))

; ----------------------------------------------------

(define run-query-mtx (make-mutex))
(define-public (run-query QUERY)
"
  Call (cog-execute! QUERY), return results, delete the SetLink.
  This avoids a memory leak of SetLinks
"
	; Run the query
	(define set-link (cog-execute! QUERY))

	(lock-mutex run-query-mtx)
	(if (cog-atom? set-link)
		; Get the query results
		(let ((results (cog-outgoing-set set-link)))
			; Delete the SetLink
			(cog-delete set-link)
			(unlock-mutex run-query-mtx)
			; Return the results.
			results)
		; Try again
		(begin
			(unlock-mutex run-query-mtx)
			(run-query QUERY))
	)
)

; --------------------------------------------------------

(define (do-find-name GO-ATOM)
"
	find-name GO-ATOM

	Find the name of GO-ATOM. This assumes a structure of the following
   form, holding the name in the second spot:

         (Evaluation
             (Predicate \"GO_name\")  ; or (Predicate \"has_name\")
             (List
                 GO-ATOM
                 (Concept \"some name\")))
   and then this returns the string \"some name\" if such a structure
   exists. Otherwise, it returns the empty string.
   The predicate (Predicate \"GO_name\") is used whenever GO-ATOM
   has the form (Concept \"GO:nnnnn\") where \"nnnnn\" is a number.
   Otherwise, (Predicate \"has_name\") is used.
"
  (define pname
     (if (regexp-match?  (string-match "GO:[0-9]+" (cog-name GO-ATOM)))
       "GO_name" "has_name"))

  (get-name
    (run-query
     (GetLink
      (Variable "$name")
      (Evaluation
        (Predicate pname)
        (List GO-ATOM (Variable "$name"))))))
)

; A memoized version of `do-find-name`, improves performance considerably
; on repeated searches.
(define find-name (memoize-function-call do-find-name))

; --------------------------------------------------------

(define-public (find-similar-gene gene-name)
   (define pattern (string-append gene-name ".+$"))
   (let ([res (filter-map
      (lambda (some-gene)
        (if (regexp-match? (string-match pattern (cog-name some-gene)))
            (cog-name some-gene)
            #f
        ))
      ; cog-get-atoms gets ALL of the GeneNodes in the atomspace...
      (cog-get-atoms 'GeneNode))])
      
      (if (> (length res) 5) 
        (take res 5)
        res
  )))

; --------------------------------------------------------

(define-public (find-current-symbol gene)
   (map (lambda (g) (cog-name g)) (run-query (BindLink
            (TypedVariable (Variable "$g") (Type "GeneNode"))
            (Evaluation
               (Predicate "has_current_symbol")
               (ListLink (Gene gene) (Variable "$g")))
            (VariableNode "$g"))))
)

(define-public (build-pubmed-url nodename)
 (string-append "https://www.ncbi.nlm.nih.gov/pubmed/?term=" (cadr (string-split nodename #\:)))
)

(define* (write-to-file result id name #:optional (ext ".scm"))
    (let*
        (
          [file-name (get-file-path id name ext)]
        )
        (call-with-output-file file-name
            (lambda (p)
              (write result p)
            )
          )
  ))

(define* (get-file-path id name #:optional (ext ".scm"))
    (catch #t (lambda ()
    (let*
        (
          [env-path (getenv "RESULT_DIR")]
          [path (if (not env-path) 
            (begin 
              (if (not (file-exists? "/tmp/result"))
                (mkdir "/tmp/result")
              )
              (string-append "/tmp/result/" id)
            )
            (string-append env-path "/" id))]
          [file-name (string-append path "/" name ext)]
        )
        (if (not (file-exists? path))
            (mkdir path)
        )
        file-name
  ))  
  (lambda (key . parameters)
      (format (current-error-port) "Cannot write scheme result files. ~a: ~a\n" key parameters)
      #f
    ))

)

(define (is-compartment loc)
	(any
		(lambda (comp) (string-contains loc comp))
		(list "vesicle" "photoreceptor" "plasma" "centriole"
			"cytoplasm" "endosome" "golgi" "vacuole" "granule"
			"endoplasmic" "mitochondri" "cytosol" "peroxisome"
			"ribosomes" "lysosome" "nucle"))
)

(define (filter-loc node go)
"
  filter only Cell membrane and compartments

  Return either the location or #f
"
  (define loc (string-downcase (find-name go)))

  (if (or (and (not (string-contains loc "complex"))
      (or (string-suffix? "ome" loc) (string-suffix? "ome membrane" loc)))
          (is-compartment loc))
      (Evaluation
        (Predicate "has_location")
        (ListLink node (Concept loc)))
      #f)
)

(define (do-locate-node node)
  (define go-list (run-query
    (Get
       (Variable "$go")
       (And
         (Member node (Variable "$go"))
         (Evaluation
           (Predicate "GO_namespace")
           (List (Variable "$go") (Concept "cellular_component")))
        ))))

  (define loc-list
    (filter-map (lambda (go) (filter-loc node go)) go-list))

  (if (not (null? loc-list)) loc-list
    (run-query
      (Bind
        (Variable "$loc")
        (Evaluation
          (Predicate "has_location")
          (List node (Variable "$loc")))
        (Evaluation
          (Predicate "has_location")
          (List node (Variable "$loc"))))))
)

(define-public locate-node (make-afunc-cache do-locate-node))

(define-public (add-loc node)
"
  Add location of a gene/Molecule node in context of Reactome pathway
"
  (let ([child (cog-outgoing-atom node 0)] 
        [parent (cog-outgoing-atom node 1) ])
      (run-query
        (BindLink
          (VariableNode "$loc")
          (ContextLink
            (MemberLink 
              child
              parent)
            (EvaluationLink
              (PredicateNode "has_location")
              (ListLink
                child
                (VariableNode "$loc")))
          )
            (EvaluationLink
              (PredicateNode "has_location")
              (ListLink
                child
                (VariableNode "$loc")))
          )
        )
    )
)

(define-public (find-subgroup name) 
    (let ((initial (string-split name #\:)))
        (match initial
            ((a b) a )
            ((a)
                (cond 
                    ((string-prefix? "R-HSA" a) "Reactome")
                    ((string-prefix? "SMP" a) "SMPDB")
                    (else "Genes")
                )
            )
        )
    )

)
;;a helper function to flatten a list, i.e convert a list of lists into a single list
(define-public (flatten x)
  (cond ((null? x) '())
        ((and (cog-link? x) (null? (cog-outgoing-set x))) '())
        ((pair? x) (append (flatten (car x)) (flatten (cdr x))))
        (else (list x))))
