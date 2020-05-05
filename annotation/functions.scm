;;; MOZI-AI Annotation Scheme
;;; Copyright © 2019 Abdulrahman Semrie
;;; Copyright © 2019 Hedra Seid
;;; Copyright © 2020 Ricardo Wurmus
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

(define-module (annotation functions)
    #:use-module (opencog)
    #:use-module (opencog exec)
    #:use-module (opencog bioscience)
    #:use-module (annotation util)
;    #:use-module (rnrs base)
    #:use-module (srfi srfi-1)
    #:use-module (ice-9 match)
)

(define (add-go-info child-atom parent-atom)
"
   Add information for GO nodes
"
   (define parent-is-go?
      (match (string-split (cog-name parent-atom) #\:)
         (("GO" . rest) #t)
         (_ #f)))
   (if parent-is-go?
      (if (member (cog-type child-atom) '(GeneNode MoleculeNode))
         (ListLink
            (Member child-atom parent-atom)
            (go-info parent-atom))
         (ListLink
           (Inheritance child-atom parent-atom)
           (go-info parent-atom)))
      #f))

(define (find-parent node namespaces)
"
  Given an atom and list of namespaces, find the parents of that atom
  in the specified namespaces. The namespaces must be a list of strings.
"
   (define atom (gdr node))

   (define (add-go-for-ns ns-name)

      ;; list of go-atoms that are parent of this go atom and are in the namespce specified by namespaces parameter
      (define go-list
         (run-query (Get
            (TypedVariable (Variable "$a") (Type 'ConceptNode))
            (And
               (Inheritance atom (Variable "$a"))
               (Evaluation (Predicate "GO_namespace")
                   (List (Variable "$a") (Concept ns-name)))))))

      (filter-map
         (lambda (thing) (add-go-info atom thing))
         go-list))

   (append-map add-go-for-ns namespaces)
)

(define (find-memberln gene namespaces)
"
  Find GO terms of a gene.  `gene` must be a GeneNode and `namespaces`
  must be a list of strings.
"
   (define (add-go-member-ns ns-name)

      ;;list of go atoms that this gene is a member of
      (define go-list
         (run-query (Get
            (TypedVariable (Variable "$a") (Type 'ConceptNode))
            (And
               (Member gene (Variable "$a"))
               (Evaluation (Predicate "GO_namespace")
                   (List (Variable "$a") (Concept ns-name)))))))

      (filter-map
         (lambda (thing) (add-go-info gene thing))
         go-list))

   (append-map add-go-member-ns namespaces)
)

(define-public (find-go-term g namespaces num-parents)
"
  The main function to find the go terms for a gene with a
  specification of the parents.
  `namespaces` should be a list of strings.
  `num-parents` should be a number, the number of parents to look up.
"

   ;; Return a list of the parents of things in `lst`.
   (define (find-parents lst)
      (append-map
         (lambda (item)
            ; Something is sending us a stray #f for soe reason...
            (if item (find-parent (gar item) namespaces) '()))
         lst))

   ;; breadth-first, depth-recursive loop. This gets all parents
   ;; at depth `i` (thus, it's breadth-first) and then recurses
   ;; to the next depth.
   (define (loop i lis acc)
      (define next-acc (append lis acc))
      (if (= i 0) next-acc
         (loop (- i 1) (find-parents lis) next-acc)))

   ; res is list of the GO terms directly related to 
   ; the input gene (g) that are members of the input namespaces
   (define res (find-memberln g namespaces))

   (define all-parents (loop num-parents res '()))

   (cons (node-info g) all-parents)
)

(define-public (find-proteins-goterm gene namespace parent)
  "Find GO terms for proteins coded by the given gene."
  (let* ([prots (find-proteins gene)])
    
    (if (null? prots)
      '()
      (let (
         [annotations
          (append-map (lambda (prot) 
            (if (null? (find-memberln prot namespace))
              (let ([goterms
                     (append-map
                      (lambda (ns)
                        (run-query (Get
                                    (TypedVariable (VariableNode "$g")
                                                   (Type 'ConceptNode))
                                    (AndLink (MemberLink gene (VariableNode "$g"))
                                             (EvaluationLink
                                              (PredicateNode "GO_namespace")
                                              (ListLink
                                               (VariableNode "$g")
                                               (Concept ns)))))))
                      namespace)])
                (list
                  (map (lambda (go)
                       (MemberLink prot go))
                     goterms)
                  (node-info prot)
                  (EvaluationLink (PredicateNode "expresses")
                     (ListLink gene prot))
                ))

               (list
                  (find-go-term prot namespace parent)
                  (EvaluationLink (PredicateNode "expresses")
                     (ListLink gene prot))
               ))) prots)
          ])
          
          annotations
          )
    
    )))

(define (do-go-info go)
  "Add details about the GO term."
  (define GO-ns (find-GO-ns go))
  (list
   (find-go-name go)
   (EvaluationLink 
    (PredicateNode "GO_namespace") 
    (ListLink 
     go
     (if (null? GO-ns) (ConceptNode "") GO-ns)))))

; Cache the results; this includes the caching of two distinct
; BindLinks/GetLinks: one in `find-GO-ns` and one in `find-go-name`.
(define go-info (memoize-function-call do-go-info))

(define (find-GO-ns go)
  "Find parents of a GO term (of given namespace type)."
  (run-query
   (GetLink
    (TypedVariable (Variable "$v") (TypeNode 'ConceptNode))
    (EvaluationLink
     (PredicateNode "GO_namespace")
     (ListLink
      go
      (VariableNode "$v"))))))

(define (find-go-name go)
  "Find the name of a GO term."
  (run-query (BindLink
              (TypedVariable (Variable "$a") (TypeNode 'ConceptNode))
              (EvaluationLink
               (PredicateNode "GO_name")
               (ListLink
                go
                (VariableNode "$a")))
              (EvaluationLink
               (PredicateNode "GO_name")
               (ListLink
                go
                (VariableNode "$a"))))))

(define (find-godef go)
  "Find go definition for parser function."
  (run-query
   (BindLink
    (VariableNode "$def")
    (EvaluationLink
     (PredicateNode "GO_definition")
     (ListLink
      go
      (VariableNode "$def")))
    (EvaluationLink
     (PredicateNode "GO_definition")
     (ListLink
      go
      (VariableNode "$def"))))))

; --------------------------------------------------------

(define-public (find-pathway-member gene identifier)
"
  Do something fun and entertaining.
"
   (define (add-pathway-info gene pathway)
      (define pathway-name (cog-name pathway))

      (if (or (string-contains pathway-name "R-HSA")
              (string-contains pathway-name "SMP"))
         (List
            (Member gene pathway)
            (node-info pathway))
         #f))

   (define pathway-list
      (run-query (Get
         (TypedVariable (Variable "$pway") (Type 'ConceptNode))
         (Member gene (Variable "$pway")))))

   (filter-map
      (lambda (pathway)
         (if (string-contains (cog-name pathway) identifier)
            (add-pathway-info gene pathway)
            #f))
      pathway-list)
)

; --------------------------------------------------------

(define (add-pathway-genes pathway gene namespace-list num-parents
                do-coding-rna do-non-coding-rna do-protein)

	(define no-rna (not (or do-coding-rna do-non-coding-rna)))
	(define no-ns (and (null? namespace-list) (= 0 num-parents)))

	(List
		(Member gene pathway)
		(node-info gene)
		(locate-node gene)
		(if no-ns '()
			(List
				(Concept "gene-go-annotation")
				(find-go-term gene namespace-list num-parents)
				(List (Concept "gene-pathway-annotation"))))
		(if no-rna '()
			(let* ([rnaresult
						(find-rna gene do-coding-rna do-non-coding-rna do-protein)])
				(if (null? rnaresult) '()
					(List (Concept "rna-annotation") rnaresult
						(List (Concept "gene-pathway-annotation")))))))
)

(define (do-get-pathway-genes pathway)
	(run-query
		(Bind
			(VariableList
				(TypedVariable (Variable "$p") (Type 'MoleculeNode))
				(TypedVariable (Variable "$g") (Type 'GeneNode)))
			(And
				(Member (Variable "$p") pathway)
				(Evaluation (Predicate "expresses")
					(List (Variable "$g") (Variable "$p"))))
			(Variable "$g"))))

(define get-pathway-genes (memoize-function-call do-get-pathway-genes))

(define-public (find-pathway-genes pathway namespace-list num-parents
                  coding-rna non-coding-rna do-protein)
"
  Find genes which code the proteins in a given pathway.  Perform
  cross-annotation. If there is a list of namespaces, then annotate
  each member genes of a pathway for its GO terms. If both
  rna flags are true, annotate each member genes of a pathway for its
  RNA transcribes. If do-protein is true, include the proteins in which the
  RNA translates to.

  'namespace-list' should be a list of string names of namespaces.
  'num-parents' should be a non-negative integer.
  'coding-rna' should be either #f or #t.
  'non-coding-rna' should be either #f or #t.
  'do-protein' should be either #f or #t.
"
	(map
		(lambda (gene)
			(add-pathway-genes pathway gene namespace-list num-parents
				coding-rna non-coding-rna do-protein))
		(get-pathway-genes pathway))
)

; --------------------------------------------------------

(define (filter-pathway gene prot pathway option)

   (define (find-prefix node)
      (match (string-split (cog-name node) #\:)
         ((name) name)
         ((name . rest) name)))

   (define pathway-name (cog-name pathway))

   (if (not (and (string=? (find-prefix prot) "Uniprot"))) #f
      (cond
         ((and
            (equal? option 0)
            (string-contains pathway-name "SMP"))
            (List
               (Evaluation (Predicate "expresses") (List gene prot))
               (node-info pathway)))
         ((and
            (equal? option 1)
            (string-contains pathway-name "R-HSA"))
            (List
               (Evaluation (Predicate "expresses") (List gene prot))
               (node-info pathway)
               (List (add-loc (Member gene pathway)))))
         (else #f)
      ))
)

(define-public (find-protein gene option)
"
  Find the proteins a gene expresses, where both the gene and
  the protein are on the same pathway. These from a triangle:

    gene <--is-in-- pathway
    prot <--is-in-- pathway
    prot <--expresses-- gene
"
   (define prot-path-list
      (run-query (Get
         (VariableList
            (TypedVariable (Variable "$prot") (Type 'MoleculeNode))
            (TypedVariable (Variable "$pway") (Type 'ConceptNode)))
         (And
            (Member gene (Variable "$pway"))
            (Member (Variable "$prot") (Variable "$pway"))
            (Evaluation
               (Predicate "expresses")
               (List gene (Variable "$prot")))))))
   (filter-map
      (lambda (prot-path)
         (define prot (gar prot-path))
         (define path (gdr prot-path))
         (cog-delete prot-path) ; delete excess pointless ListLink
         (filter-pathway gene prot path option))
      prot-path-list)
)

; --------------------------------------------------------

(define-public (pathway-hierarchy pw lst)
"
  pathway-hierarchy -- Find hierarchy of the reactome pathway.
"
	(filter
		(lambda (inhlink)
			(and (member (gar inhlink) lst) (member (gdr inhlink) lst)))
		(cog-incoming-by-type pw 'InheritanceLink)))


(define (add-mol-info mol path)
  (if (string-contains (cog-name path) "R-HSA")
    (ListLink
      (MemberLink mol path)
      (if (string-contains (cog-name mol) "Uniprot")
        (find-coding-gene mol)
        '()
        )
      (node-info mol)
      (ListLink
        (add-loc (MemberLink mol path))
      )
    )
    (ListLink
      (MemberLink mol path)
      (if (string-contains (cog-name mol) "Uniprot")
        (find-coding-gene mol)
        '()
      )
      (node-info mol)
      (ListLink (locate-node mol))
    )
  )
)

(define (do-get-mol path)
	(run-query (Get
		(TypedVariable (Variable "$a") (Type 'MoleculeNode))
		(Member (Variable "$a") path))))

(define cache-get-mol
	(memoize-function-call do-get-mol))

(define-public (find-mol path identifier)
" Finds molecules (proteins or chebi's) in a pathway"
	(filter-map
		(lambda (mol)
			(if (string-contains (cog-name mol) identifier)
				(add-mol-info mol path) #f))
		(cache-get-mol path))
)

; ------------------------------------

(define (do-find-coding-gene protein)
"
  Find coding Gene for a given protein
"
	(define evlnk
		(Evaluation (Predicate "expresses")
			(List (Variable "$g") protein)))

	(run-query (Bind
		(TypedVariable (Variable "$g") (Type 'GeneNode))
		evlnk evlnk))
)

(define-public find-coding-gene
	(memoize-function-call do-find-coding-gene))

; ------------------------------------


(define-public (match-gene-interactors gene do-protein namespace parents coding non-coding orgs)
"
  match-gene-interactors - Finds genes interacting with a given gene

  If do-protein is #t then protein interactions are included.
"
      (map
         (lambda (act-gene)
            (generate-result gene act-gene do-protein namespace parents coding non-coding))

         (run-query (Get
                  (And 
                     (Evaluation 
                     (Predicate "interacts_with")
                     (SetLink gene (Variable "$a")))
                     (map (lambda (org)
                        (Absent 
                           (Evaluation (Predicate "from_organism")
                              (List 
                                 (Variable "$a")
                                 (ConceptNode (string-append "TaxonomyID:" org))
                              )
                           )
                        )
                     ) orgs))
               ))
            )
)

(define-public (find-output-interactors gene do-protein namespace parents coding non-coding orgs)
"
  find-output-interactors -- Finds output genes interacting with each-other

  This finds a triangular relationship, between the given gene, and
  two others, such that all three interact with one-another.

  If do-protein is #t then protein interactions are included.
"
      (map
         (lambda (gene-pair)
            (generate-result (gar gene-pair) (gdr gene-pair) do-protein namespace parents coding non-coding))

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
                                 (Variable "$a")
                                 (ConceptNode (string-append "TaxonomyID:" org))
                              )
                           )
                        )
                     ) orgs)
               
               )
         )))  
)

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
            (TypedVariable (Variable "$p1") (Type 'MoleculeNode))
            (TypedVariable (Variable "$p2") (Type 'MoleculeNode)))
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
				(TypedVariable (Variable "$p") (Type 'MoleculeNode))
				(TypedVariable (Variable "$b") (Type 'ConceptNode)))
			(And
				(Evaluation (Predicate "expresses") (List gene (Variable "$p")))
				(Evaluation (Predicate "has_biogridID") (List (Variable "$p") (Variable "$b")))
				(Evaluation (Predicate "has_biogridID") (List gene (Variable "$b"))))
			(VariableNode "$p")))])
		(if (not (null? prot)) (car prot) (ListLink)))
)

;; Cache previous results, so that they are not recomputed again,
;; if the results are already known. Note that this function accounts
;; for about 85% of the total execution time of `biogrid-interaction-annotation`,
;; so any caching at all is a win. In a test of 681 genes, there is a
;; cache hit 99 out of 100 times (that is, 100 times fewer calls to
;; do-find-protein-form) resulting in a 400x speedup for this function(!)
;; and a grand-total 9x speedup for `biogrid-interaction-annotation`.
;; Wow.
(define-public find-protein-form
	(memoize-function-call do-find-protein-form))

;; ---------------------------------

;;Return all proteins expressed by a gene
(define (do-find-proteins gene)
   (run-query (Bind
      (VariableList
         (TypedVariable (Variable "$p") (Type 'MoleculeNode)))
      (Evaluation (Predicate "expresses") (List gene (Variable "$p")))
      (VariableNode "$p")))
)

(define-public find-proteins
   (memoize-function-call do-find-proteins)
)


(define-public (generate-result gene-a gene-b do-protein namespaces num-parents
                                coding-rna non-coding-rna)
"
  generate-result -- add info about matched variable nodes

  `prot` should be #t  for protein interactions to be computed.

  `namespaces` should be a scheme list of strings (possibly an empty list),
     each string a namespace name.

  `num-parents` should be a number.

  `coding-rna` should be either #f or #t.
  `non-coding-rna` should be either #f or #t.
"
	(if
		(or (equal? (cog-type gene-a) 'VariableNode)
		    (equal? (cog-type gene-b) 'VariableNode))
		(ListLink)
		(let* (
				[already-done-a ((biogrid-genes) gene-a)]
				[already-done-b ((biogrid-genes) gene-b)]
            [already-done-pair ((biogrid-pairs) (List gene-a gene-b))]

				[output (find-pubmed-id gene-a gene-b)]
            [interaction (if do-protein
                (ListLink
                  (build-interaction gene-a gene-b output "interacts_with")
                  (build-interaction
                     (find-protein-form gene-a)
                     (find-protein-form gene-b)
                     output "inferred_interaction"))
                (build-interaction gene-a gene-b output "interacts_with"))]
          )

          ;; Neither gene has been done yet.
          (cond
              ((and (not already-done-a) (not already-done-b))
              (let (
                 [go-cross-annotation
                    (if (null? namespaces) '()
                        (List
                           (Concept "gene-go-annotation")
                           (find-go-term gene-a namespaces num-parents)
                           (find-go-term gene-b namespaces num-parents)
                           (List (Concept "biogrid-interaction-annotation")))
                    )]
                 [rna-cross-annotation
                    (if (or coding-rna non-coding-rna)
                       (List
                          (Concept "rna-annotation")
                          (find-rna gene-a coding-rna non-coding-rna do-protein)
                          (find-rna gene-b coding-rna non-coding-rna do-protein)
                          (List (Concept "biogrid-interaction-annotation")))
                        '()     
                     )
                          
                     ])
                      (if do-protein
                        (let ([coding-prot-a (find-protein-form gene-a)]
                              [coding-prot-b (find-protein-form gene-b)])
                        (if (or (equal? coding-prot-a (ListLink))
                                (equal? coding-prot-b (ListLink)))
                          (ListLink)
                          (ListLink
                            interaction
                            (Evaluation (Predicate "expresses") (List gene-a coding-prot-a))
                            (node-info gene-a)
                            (node-info coding-prot-a)
                            (locate-node coding-prot-a)
                            (Evaluation (Predicate "expresses") (List gene-b coding-prot-b))
                            (node-info gene-b)
                            (node-info coding-prot-b)
                            (locate-node coding-prot-b)
                            go-cross-annotation
                            rna-cross-annotation
                          )
                        ))
                      (ListLink
                          interaction
                          (node-info gene-a)
                          (locate-node gene-a)
                          (node-info gene-b)
                          (locate-node gene-b)
                          go-cross-annotation
                          rna-cross-annotation
                      )
                    )
                  ))

              ;; One of the two genes is done already. Do the other one.
              ((or (not already-done-a) (not already-done-b))
              (let* (
                  [gene-x (if already-done-a gene-b gene-a)]
                  [go-cross-annotation
                     (if (null? namespaces) '()
                        (List
                           (Concept "gene-go-annotation")
                           (find-go-term gene-x namespaces num-parents)
                           (List (Concept "biogrid-interaction-annotation")))
                     )]
                  [rna-cross-annotation
                     (if (or coding-rna non-coding-rna)
                        (List
                           (Concept "rna-annotation")
                           (find-rna gene-x coding-rna non-coding-rna do-protein)
                           (List (Concept "biogrid-interaction-annotation")))
                        '()
                    )])
                 (if do-protein
                    (let ([coding-prot (find-protein-form gene-x)])
                       (if (equal? coding-prot (ListLink))
                          (ListLink)
                          (ListLink
                            interaction
                            (Evaluation (Predicate "expresses") (List gene-x coding-prot))
                            (node-info gene-x)
                            (node-info coding-prot)
                            (locate-node coding-prot)
                            go-cross-annotation
                            rna-cross-annotation)
                    ))
                    (ListLink
                       interaction
                       (node-info gene-x)
                       (locate-node  gene-x)
                       go-cross-annotation
                       rna-cross-annotation)
                )))

              ;;; Both of the genes have been done.
              (else (if already-done-pair (ListLink) (ListLink interaction)))
          )
      )
   )
)

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
                pubmed))
    )
  )
)

;; ------------------------------------------------------
(define (do-find-pubmed-id gene-set)
"
  This is expecting a (SetLink (Gene \"a\") (Gene \"b\"))
  as the argument.
"
   (let* (
      [gene-a (gar gene-set)]
      [gene-b (gdr gene-set)])
      (run-query
         (GetLink
            (VariableNode "$pub")
               (EvaluationLink
                (PredicateNode "has_pubmedID")
                (ListLink
                 (EvaluationLink 
                  (PredicateNode "interacts_with") 
                  (SetLink
                   gene-a
                   gene-b))
                 (VariableNode "$pub")))))
   ))

(define cache-find-pubmed-id
	(memoize-function-call do-find-pubmed-id))

; Memoized version of above, for performance.
(define-public (find-pubmed-id gene-a gene-b)
	(cache-find-pubmed-id (Set gene-a gene-b)))

;; ------------------------------------------------------
;; Finds coding and non coding RNA for a given gene

(define (do-get-rna gene)
	(run-query (Get
		(TypedVariable (Variable "$a") (Type 'MoleculeNode))
		(Evaluation (Predicate "transcribed_to") (List gene (Variable "$a"))))))

(define cache-get-rna
	(memoize-function-call do-get-rna))

(define-public (find-rna gene do-coding do-noncoding do-protein)
"
  find-rna GENE do-coding do-noncoding do-protein
  GENE should be a GeneNode
  do-coding do-noncoding do-protein should be #t or #f
"
	(map
		(lambda (transcribe)
			(filterbytype gene transcribe do-coding do-noncoding do-protein))
		(cache-get-rna gene))
)

(define (filterbytype gene rna cod ncod do-prot)
  (ListLink
   (if (and cod (string-prefix? "ENST" (cog-name rna)))
       (list
        (Evaluation (Predicate "transcribed_to") (List gene rna))
        (node-info rna)
        (if do-prot
            (list
             (Evaluation (Predicate "translated_to")
                (ListLink rna (find-translates rna)))
             (node-info (car (find-translates rna))))
            '()))
       '())
   (if (and ncod (not (string-prefix? "ENST" (cog-name rna))))
       (list
        (Evaluation (Predicate "transcribed_to") (List gene rna))
        (node-info rna))
       '())))

(define (do-find-translates rna)
	(run-query (Get
		(TypedVariable (Variable "$a") (Type 'MoleculeNode))
		(Evaluation (Predicate "translated_to")
			(List rna (Variable "$a"))))))

(define-public find-translates
	(memoize-function-call do-find-translates))
