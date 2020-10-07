;;; MOZI-AI Annotation Scheme
;;; Copyright © 2019 Abdulrahman Semrie
;;; Copyright © 2019 Hedra Seid
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

(define-module (annotation biogrid-helpers)
    #:use-module (opencog)
    #:use-module (opencog exec)
    #:use-module (opencog bioscience)
    #:use-module (annotation util)
    #:use-module (annotation functions)
    #:use-module (annotation go-helpers)
    #:use-module (srfi srfi-1)
    #:use-module (ice-9 match)
)


(define-public (match-gene-interactors gene exclude-orgs)
"
  match-gene-interactors - Finds genes interacting with a given gene

"
	(append-map
		(lambda (act-gene)
			(generate-result gene act-gene))

		(run-query (Get
      (And 
        (Evaluation 
          (Predicate "interacts_with")
          (SetLink gene (Variable "$a")))
        (map (lambda (org)
          (Absent 
            (Evaluation (Predicate "from_organism")
              (List  (Variable "$a")
                  (NcbiTaxonomy (string-append "taxid:" org)))))) exclude-orgs))))))

(define-public (find-output-interactors gene exclude-orgs)
"
  find-output-interactors -- Finds output genes interacting with each-other

  This finds a triangular relationship, between the given gene, and
  two others, such that all three interact with one-another.
"
	(append-map
		(lambda (gene-pair)
			(generate-result (gar gene-pair) (gdr gene-pair)))

		(run-query (Get
      (VariableList
          (TypedVariable (Variable "$a") (Type 'GeneNode))
          (TypedVariable (Variable "$b") (Type 'GeneNode)))
          (And 
            (Evaluation (Predicate "interacts_with")
            (SetLink gene (Variable "$a")))

            (Evaluation (Predicate "interacts_with")
              (SetLink (Variable "$a") (Variable "$b")))

            (Evaluation (Predicate "interacts_with")
                (SetLink gene (Variable "$b")))
            (map (lambda (org)
                (Absent 
                  (Evaluation (Predicate "from_organism")
                    (List 
                      (Variable "$b")
                      (NcbiTaxonomy (string-append "taxid:" org)))))) exclude-orgs))))))
;; ------------------------------------------------------

(define (generate-interactors path var1 var2)
	; (biogrid-reported-pathways) is a cache of the interactions that have
	; already been handled. Defined in util.scm and cleared in main.scm.
	(if (or (equal? var1 var2)
			((biogrid-reported-pathways) (Set var1 var2))) #f
		(let ([output (find-pubmed-id var1 var2)])
			(if (null? output)
				(EvaluationLink
					(PredicateNode "interacts_with")
					(SetLink var1 var2))
				(EvaluationLink
					(PredicateNode "has_pubmedID")
					(ListLink
						(EvaluationLink
							(PredicateNode "interacts_with")
							(SetLink var1 var2))
						output)))))
)

(define (do-pathway-gene-interactors pw)
"
  Gene interactors for genes in the pathway.

  This finds all pentagons, where two proteins appear on the same
  pathway, the genes expressing those proteins are known, and the
  two genes are interacting. That is,

    pathway <--is-in-- protein-1 <--expresses-- gene-1
    pathway <--is-in-- protein-2 <--expresses-- gene-2
    gene-1 <--interacts--> gene-2
"
   ; Find all interaction
   (define gene-pentagons
      (run-query (Get
         (VariableList
            (TypedVariable (Variable "$g1") (Type 'GeneNode))
            (TypedVariable (Variable "$g2") (Type 'GeneNode))
            (TypedVariable (Variable "$p1") (Type 'UniprotNode))
            (TypedVariable (Variable "$p2") (Type 'UniprotNode)))
         (And
            (Member (Variable "$p1") pw)
            (Member (Variable "$p2") pw)
            (Evaluation (Predicate "expresses")
               (List (Variable "$g1") (Variable "$p1")))
            (Evaluation (Predicate "expresses")
               (List (Variable "$g2") (Variable "$p2")))
            (Evaluation (Predicate "interacts_with")
               (SetLink (Variable "$g1") (Variable "$g2")))))))

   (filter-map
      (lambda (gene-path)
         (define g1 (gar gene-path))
         (define g2 (gdr gene-path))
         (cog-delete gene-path) ; get rid of unused ListLink
         (generate-interactors pw g1 g2))
      gene-pentagons)
)

;; Cache previous results, so that they are not recomputed again,
;; if the results are already known. Note that this function accounts
;; for about 60% of the total execution time of `gene-pathway-annotation`,
;; so any caching at all is a win. In a test of 681 genes, this offers
;; a 3x speedup in run time.
(define-public pathway-gene-interactors
	(memoize-function-call do-pathway-gene-interactors))

;; ---------------------------------

(define (do-find-protein-form gene)
	(let ([prot
		(run-query (Bind
			(VariableList
				(TypedVariable (Variable "$p") (Type 'UniprotNode))
				(TypedVariable (Variable "$b") (Type 'ConceptNode)))
			(And
				(Evaluation (Predicate "expresses") (List gene (Variable "$p")))
				(Evaluation (Predicate "has_biogridID") (List (Variable "$p") (Variable "$b")))
				(Evaluation (Predicate "has_biogridID") (List gene (Variable "$b"))))
			(VariableNode "$p")))])
		(if (not (null? prot)) (car prot) (ListLink)))
)


;; ---------------------------------

(define-public (generate-result gene-a gene-b)
"
  generate-result -- add info about matched variable nodes
"
	(if
		(or (equal? (cog-type gene-a) 'VariableNode)
		    (equal? (cog-type gene-b) 'VariableNode))
		   '()
		(let* (
				[already-done-a ((intr-genes) gene-a)]
				[already-done-b ((intr-genes) gene-b)]
        [already-done-pair ((gene-pairs) (List gene-a gene-b))]
				[output (find-pubmed-id gene-a gene-b)]
        [interaction (build-interaction gene-a gene-b output "interacts_with")])

          ;; Neither gene has been done yet.
          (cond
              ((and (not already-done-a) (not already-done-b))
                (list interaction (node-info gene-a) (locate-node gene-a)
                  (node-info gene-b) (locate-node gene-b)))

              ;; One of the two genes is done already. Do the other one.
              ((or (not already-done-a) (not already-done-b))
                (let ([gene-x (if already-done-a gene-b gene-a)])
                 (list interaction (node-info gene-x) (locate-node  gene-x))))

              ;;; Both of the genes have been done.
              (else (if (not already-done-pair)  (list interaction) '()))))))

;; ------------------------------------------------------

(define-public (build-interaction interactor-1 interactor-2 pubmed interaction_pred)
  (if (or (equal? (cog-type interactor-1) 'ListLink) (equal? (cog-type interactor-2) 'ListLink))
    '()
    (if (null? pubmed) 
      (EvaluationLink 
        (PredicateNode interaction_pred) 
        (SetLink interactor-1 interactor-2))
      (EvaluationLink
        (PredicateNode "has_pubmedID")
        (ListLink (EvaluationLink 
                  (PredicateNode interaction_pred) 
                  (SetLink interactor-1 interactor-2))  
                pubmed))))
)

;; ------------------------------------------------------
(define (do-find-pubmed-id gene-set)
  ;;This is expecting a (SetLink (Gene \"a\") (Gene \"b\")) as the argument.
   (let* (
      [gene-a (gar gene-set)]
      [gene-b (gdr gene-set)])
      (run-query
         (Get
          (VariableNode "$pub")
            (EvaluationLink (PredicateNode "has_pubmedID")
            (ListLink
              (EvaluationLink  (PredicateNode "interacts_with") 
              (SetLink gene-a gene-b))
              (VariableNode "$pub")))))))

(define cache-find-pubmed-id
	(memoize-function-call do-find-pubmed-id))

; Memoized version of above, for performance.
(define-public (find-pubmed-id gene-a gene-b)
	(cache-find-pubmed-id (Set gene-a gene-b)))