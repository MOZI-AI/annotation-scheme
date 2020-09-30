;;; MOZI-AI Annotation Scheme
;;; Copyright © 2019 Abdulrahman Semrie
;;; Copyright © 2019 Hedra Seid
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
(define-module (annotation pathway-helpers)
    #:use-module (annotation util)
    #:use-module (annotation functions)
    #:use-module (annotation go-helpers)
    #:use-module (opencog)
    #:use-module (opencog exec)
    #:use-module (opencog bioscience)
    #:use-module (annotation util)
    #:use-module (srfi srfi-1)
    #:use-module (ice-9 match)
)

; --------------------------------------------------------

(define-public (find-pathway-member gene pathway-type)
"
  Find the pathways a protein belongs to 
"
   (run-query (Get
         (TypedVariable (Variable "$pway") (Type pathway-type))
         (Member gene (Variable "$pway"))))
)

; --------------------------------------------------------

(define (add-pathway-node pathway node namespace-list num-parents regulates part-of bi-dir
                do-coding-rna do-non-coding-rna)

	(define no-rna (not (or do-coding-rna do-non-coding-rna)))
	(define no-ns (and (null? namespace-list) (= 0 num-parents)))

	(append
		(list 
         (Member node pathway)
         (node-info node)
         (locate-node node))
		(if no-ns '()
			(list
				(Concept "gene-go-annotation")
				(find-go-term node namespace-list num-parents regulates part-of bi-dir)
				(Concept "gene-pathway-annotation")))
		(if no-rna '()
			(let* ([rnaresult
						(find-rna node do-coding-rna do-non-coding-rna)])
				(if (null? rnaresult) '()
					(list (Concept "rna-annotation") rnaresult
						(Concept "gene-pathway-annotation"))))))
)

(define (do-get-pathway-nodes atom)
	(run-query
		(Get
			(VariableList
				(TypedVariable (Variable "$p") (gdr atom)))
			(Member (Variable "$p") (gar atom)))))

(define get-pathway-nodes (memoize-function-call do-get-pathway-nodes))

(define-public (find-pathway-proteins pathway namespace-list 
                  num-parents regulates part-of bi-dir
                  coding-rna non-coding-rna)
"
  Find proteins in a given pathway.  Perform
  cross-annotation. If there is a list of namespaces, then annotate
  each member proteins of a pathway for its GO terms. If both
  rna flags are true, annotate each member proteins of a pathway for its
  RNA transcribes. 

  'namespace-list' should be a list of string names of namespaces.
  'num-parents' should be a non-negative integer.
  'coding-rna' should be either #f or #t.
  'non-coding-rna' should be either #f or #t.
"
	(map
		(lambda (prot)
			(add-pathway-node pathway prot namespace-list num-parents 
            regulates part-of bi-dir coding-rna non-coding-rna))
		(get-pathway-nodes (List pathway (Type "UniprotNode"))))
)

(define-public (find-pathway-genes pathway namespace-list
                  num-parents regulates part-of bi-dir
                  coding-rna non-coding-rna)
  "
  Find genes in a given pathway.  Perform
  cross-annotation. If there is a list of namespaces, then annotate
  each member genes of a pathway for its GO terms. If both
  rna flags are true

  'namespace-list' should be a list of string names of namespaces.
  'num-parents' should be a non-negative integer.
  'coding-rna' should be either #f or #t.
  'non-coding-rna' should be either #f or #t.
"           
	(map
		(lambda (gene)
			(add-pathway-node pathway gene namespace-list num-parents 
            regulates part-of bi-dir coding-rna non-coding-rna))
		(get-pathway-nodes (List pathway (Type "GeneNode"))))
)

; --------------------------------------------------------

(define (filter-pathway gene prot pathway)
    (match (cog-type pathway)
     ('ReactomeNode (list (Evaluation (Predicate "expresses") (List gene prot))
         (node-info pathway)
         (add-loc (Member gene pathway))))
     ('SmpNode (list (Evaluation (Predicate "expresses") (List gene prot))
         (node-info pathway))))
)

(define-public (find-protein gene option)
"
  Find the proteins a gene expresses, where both the gene and
  the protein are on the same pathway. These from a triangle:

    gene <--is-in-- pathway
    prot <--is-in-- pathway
    prot <--expresses-- gene
"
   (append-map (lambda (prot-path) 
        (filter-pathway gene (gar prot-path) (gdr prot-path)))  (run-query (Get
         (VariableList
            (TypedVariable (Variable "$prot") (Type 'Uniprot))
            (TypedVariable (Variable "$pway") (Type (if (= option 0) 'SmpNode 'ReactomeNode))))
         (And
            (Member gene (Variable "$pway"))
            (Member (Variable "$prot") (Variable "$pway"))
            (Evaluation
               (Predicate "expresses")
               (List gene (Variable "$prot")))))))
)

(define-public (pathway-hierarchy pw lst)
"
  pathway-hierarchy -- Find hierarchy of the reactome pathway.
"
	(filter
		(lambda (inhlink)
			(and (member (gar inhlink) lst) (member (gdr inhlink) lst)))
		(cog-incoming-by-type pw 'InheritanceLink)))


(define (add-mol-info mol path)

  (match (cons (cog-type path) (cog-type mol))
    (('ReactomeNode . 'UniprotNode)
      (list (Member mol path) (find-coding-gene mol) (node-info mol) (add-loc (Member mol path))))
    (('ReactomeNode . 'ChebiNode)
      (list (Member mol path) (find-mol-go-plus mol) (node-info mol) (add-loc (Member mol path))))
    (('SmpNode . 'UniprotNode)
      (list (Member mol path) (find-coding-gene mol) (node-info mol) (locate-node mol)))
    (('SmpNode . 'ChebiNode)
      (list (Member mol path) (find-mol-go-plus mol) (node-info mol) (locate-node mol)))
    (_ (throw 'unknown-type mol path)))
)

(define (do-get-mol atom)
	(run-query (Get
		(TypedVariable (Variable "$a") (gdr atom))
		(Member (Variable "$a") (gar atom)))))

(define cache-get-mol
	(memoize-function-call do-get-mol))

(define-public (find-mol path type)
" Finds molecules (proteins or chebi's) in a pathway"

  (flatten (append-map (lambda (mol) (add-mol-info mol path))  (cache-get-mol (List path (TypeNode type)))))
)