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
  #:use-module (fibers channels)
	#:use-module (ice-9 optargs)
	#:use-module (rnrs exceptions)
	#:use-module (ice-9 textual-ports)
	#:use-module (ice-9 regex)
	#:use-module (srfi srfi-1)
  #:use-module (ice-9 threads)
	#:use-module (ice-9 match)
  #:use-module (ice-9 threads)
  #:use-module (json)
  #:use-module (ice-9 iconv)
  #:use-module (web socket client)
  #:use-module (web client)
	#:export (create-node
	          create-edge
            write-to-file
            get-file-path)
)

; ----------------------------------------------------
;Define Parameters
(define-public biogrid-genes (make-parameter (make-atom-set)))
(define-public biogrid-pairs (make-parameter (make-atom-set)))
(define-public biogrid-reported-pathways (make-parameter (make-atom-set)))
(define-public ws '())
; ----------------------------------------------------
;;Use a global cache list. Using a local cache cause segfault error when clearing the current atomspace and re-running another annotation. We have to also clear the cache
(define-public cache-list '())

(define (atom-hash ATOM SZ)
	(catch #t
		(lambda() (modulo (cog-handle ATOM) SZ))
		(lambda (key . args) 0)))

(define (atom-assoc ATOM ALIST)
	(find (lambda (pr) (equal? ATOM (car pr))) ALIST))

(define-public (make-afunc-cache AFUNC)
"
  make-afunc-cache AFUNC -- Return a caching version of AFUNC.
  Here, AFUNC is a function that takes a single atom as an argument,
  and returns some scheme object associated with that atom.
  This returns a function that returns the same values that AFUNC would
  return, for the same argument; but if a cached value is available,
  then that is returned, instead of calling AFUNC a second time.  This
  is useful whenever AFUNC is cpu-intensive, taking a long time to
  compute.  In order for the cache to be valid, the value of AFUNC must
  not depend on side-effects, because it will be called at most once.
"
  (define cache (make-hash-table))
  (set! cache-list (append (list cache) cache-list))
	(lambda (ITEM)
		(define val (hashx-ref atom-hash atom-assoc cache ITEM))
		(if val val
			(let ((fv (AFUNC ITEM)))
				(hashx-set! atom-hash atom-assoc cache ITEM fv)
				fv)))
)

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
	(define cache (make-afunc-cache FUNC))
	(lambda (ATOM) (cache ATOM))
)

; ----------------------------------------------------

(define sock-url (format #f "ws://~a:9001/~a" (getenv "ATOM_SERVER") (getenv "ATOM_ID")))
(define req-url (format #f "http://~a:9001/atomspaces/~a" (getenv "ATOM_SERVER") (getenv "ATOM_ID")))

(define (receive websock) 
    (let loop (
        (msg (websocket-receive websock))
        (res '())
    )
        (if (string=? msg "eof")
            res
            (loop  (websocket-receive websock) (append res (list (eval-string msg))))
        )
))

(define-public (run-query QUERY)
"
 Execute the pattern on a remote AtomSpace and return the result
"
  (let (
    [websock (if (and (websocket? ws) (websocket-open? ws)) 
                  ws 
                  (begin 
                    (set! ws (make-websocket sock-url))
                    ws
                  ))]
  )
    ; Send the query to AtomSpace server
    (websocket-send websock (format #f "~a" QUERY))

    ;;Receive result
    (receive websock)
  )
)

; --------------------------------------------------------



;; Define the parameters needed for GGI
(define-public biogrid-genes (make-parameter (make-atom-set)))
(define-public biogrid-pairs (make-parameter (make-atom-set)))
(define-public biogrid-reported-pathways (make-parameter (make-atom-set)))
(define-public ws (make-parameter '()))

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
(define-public (do-get-node-info node)
	(define (node-name node)
		(let ([lst (find-pathway-name node)])
				(if (null? lst) (ConceptNode "N/A") (car lst))))

	(if (cog-node? node)
    (append
      (find-organism node)
		  (list (EvaluationLink (PredicateNode "has_name") (ListLink node (node-name node))))
    )
		(ListLink))
)

; Cache results of do-get-node-info for performance.
(define memoize-node-info (memoize-function-call do-get-node-info))

(define-public (node-info ENTITY)
"
  node-info ENTITY -- Find the name,description and organism of an entity.

  An entity can be any kind of conceptual object, such as a gene, protein,
  small molecule, RNA, GeneOntology (GO) term, cellular location, etc.
  Here, ENTITY is an AtomSpace Atom that encodes such an object.
"
	(list (memoize-node-info ENTITY)))


;;Finds a name of any node (Except GO which has different structure)
(define-public (do-find-pathway-name pw)
	(define is-enst (string-prefix? "ENST" (cog-name pw)))
   (if (or is-enst (string-contains (cog-name pw) "Uniprot:"))
      (let ([predicate (if is-enst "transcribed_to" "expresses")])
        (run-query (Get
           (VariableList
           (TypedVariable (Variable "$a") (Type 'GeneNode)))
           (Evaluation (Predicate predicate)
              (List (Variable "$a") pw)))))
      '()
    )
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
                    (Get
                      (EvaluationLink (PredicateNode "has_entrez_id")
                      (ListLink
                          gene
                          (VariableNode "$a"))))
                    )
                  )
          )
    )
    (match (string-split entrez #\:)
      ((single) single)
      ((first second . rest) second))
      
  )
      
)

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
     (Get
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
   (define-values (_ bv) (http-get (string-append req-url "/similar" "?type=GeneNode&name=" gene-name)))

   (assoc-ref (json-string->scm (bytevector->string bv "utf-8")) "similar")  
)

; --------------------------------------------------------

(define-public (find-current-symbol gene)
   (map (lambda (g) (cog-name g)) (run-query (Bind
            (TypedVariable (Variable "$g") (Type 'GeneNode))
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
        (Bind
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

(define (do-find-organism gene)
"
  finds the organism(from human or virus etc ..) of a node
  node can be GeneNode or MoleculeNode
"
  (run-query 
    (Bind
      (VariableList
				(TypedVariable (Variable "$org") (Type 'ConceptNode))
				(TypedVariable (Variable "$name") (Type 'ConceptNode)))
      (AndLink
        (Evaluation (Predicate "from_organism") (List gene (Variable "$org")))
        (Evaluation (Predicate "has_name") (List (Variable "$org") (VariableNode "$name")))
      )
      (list
        (Evaluation (Predicate "from_organism") (List gene (Variable "$org")))
        (Evaluation (Predicate "has_name") (List (Variable "$org") (VariableNode "$name"))))
  ))
)
; Cache results of do-find-organism for performance.
(define cache-find-organism (memoize-function-call do-find-organism)) 

(define-public (find-organism gene)
   (list (cache-find-organism gene)))


(define-public (str->tv s)
  (if (string=? "True" s)
      #t
      #f
  )
)

(define-public (find-module name modules)
  "
  Return the reference to an object in the list of modules with the specified name
  "
    (let (
        [var  (any (lambda (mod) (module-variable (resolve-module mod) (string->symbol name))) modules)]
    )
        (if var 
            (variable-ref var)
            #f
        )
    )
)

(define-public (send-message message channels)
  (if (list? message)
    (for-each (lambda (msg) (send-message msg channels)) message)
    (for-each (lambda (chan) (put-message chan message))  channels)
  )
)

(define-public (clear-atomspace) 
      (clear)
      (for-each hash-clear! cache-list)
      (set! cache-list '())
)