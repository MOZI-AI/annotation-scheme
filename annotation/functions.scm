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
    #:use-module (annotation util)
    #:use-module (opencog)
    #:use-module (opencog exec)
    #:use-module (opencog bioscience)
;    #:use-module (rnrs base)
    #:use-module (srfi srfi-1)
    #:use-module (ice-9 match)
)

(include-from-path "annotation/instrumentation.scm")

(define-public find-pathway-genes-ctr (accum-time "find-pathway-genes"))
(define-public add-pathway-genes-ctr (accum-time "add-pathway-genes"))
(define-public find-go-term-ctr (accum-time "find-go-term"))
(define-public find-memberln-ctr (accum-time "find-memberln"))
(define-public add-go-info-ctr (accum-time "add-go-info"))
(define-public find-parent-ctr (accum-time "find-parent"))

(define-public match-gene-interactors-ctr (accum-time "match-gene-interactors"))
(define-public find-output-interactors-ctr (accum-time "find-output-interactors"))

(define-public find-pathway-member-ctr (accum-time "find-pathway-member"))
(define-public pathway-gene-interactors-ctr (accum-time "pathway-gene-interactors"))
(define-public generate-result-ctr (accum-time "generate-result"))
(define-public generate-interactors-ctr (accum-time "generate-interactors"))
(define-public build-interaction-ctr (accum-time "build-interaction"))
(define-public pathway-hierarchy-ctr (accum-time "pathway-hierarchy"))
(define-public find-protein-ctr (accum-time "find-protein"))
(define-public find-protein-form-ctr (accum-time "find-protein-form"))
(define-public find-mol-ctr (accum-time "find-mol"))
(define-public find-pubmed-id-ctr (accum-time "find-pubmed-id"))
(define-public find-rna-ctr (accum-time "find-rna"))

(define (find-parent a b)
  (find-parent-ctr #:enter? #t)
  (let ((rv (xfind-parent a b)))
  (find-parent-ctr #:enter? #f)
  rv))

(define (xfind-parent node namespaces)
  "Given an atom and list of namespaces find the parents of that atom
in the specified namespaces."
  (let ([atom (cog-outgoing-atom node 1)])
    (append-map (lambda (ns)
                  (run-query (BindLink
                              (TypedVariable (Variable "$a") (TypeNode 'ConceptNode))
                              (AndLink
                               (InheritanceLink
                                atom
                                (VariableNode "$a"))
                               (EvaluationLink
                                (PredicateNode "GO_namespace")
                                (ListLink
                                 (VariableNode "$a")
                                 (ConceptNode ns))))
                              (ExecutionOutputLink
                               (GroundedSchemaNode "scm: add-go-info")
                               (ListLink
                                atom
                                (VariableNode "$a"))))))
                namespaces)))


(define-public (find-memberln a b)
  (find-memberln-ctr #:enter? #t)
  (let ((rv (xfind-memberln a b)))
  (find-memberln-ctr #:enter? #f)
  rv))

(define (xfind-memberln gene namespaces)
  "Find GO terms of a gene."
  (append-map (lambda (ns)
                (run-query (BindLink
                            (TypedVariable (Variable "$a") (TypeNode 'ConceptNode))
                            (AndLink
                             (MemberLink
                              gene
                              (VariableNode "$a"))
                             (EvaluationLink
                              (PredicateNode "GO_namespace")
                              (ListLink
                               (VariableNode "$a")
                               (ConceptNode ns)))) 
                            (ExecutionOutputLink
                             (GroundedSchemaNode "scm: add-go-info")
                             (ListLink
                              gene
                              (VariableNode "$a"))))))
              namespaces))

(define-public (add-go-info a b)
  (add-go-info-ctr #:enter? #t)
  (let ((rv (xadd-go-info a b)))
  (add-go-info-ctr #:enter? #f)
  rv))

(define-public (xadd-go-info child-atom parent-atom)
  "Add information for GO nodes"
  (define parent-is-go?
    (match (string-split (cog-name parent-atom) #\:)
      (("GO" . rest) #t)
      (_ #f)))
  (if parent-is-go?
      (if (member (cog-type child-atom)
                  '(GeneNode MoleculeNode))
          (ListLink
           (MemberLink
            child-atom
            parent-atom)
           (go-info parent-atom))
          (ListLink
           (InheritanceLink
            child-atom
            parent-atom)
           (go-info parent-atom)))
      #f))

(define-public (find-go-term a b c)
  (find-go-term-ctr #:enter? #t)
  (let ((rv (xfind-go-term a b c)))
  (find-go-term-ctr #:enter? #f)
  rv))

;;the main function to find the go terms for a gene with a specification of the parents
(define-public xfind-go-term
  (lambda (g namespaces p)
      (let (
        [res (find-memberln g namespaces)]   
      )
      (define parents (flatten (let loop (
        [i p]
        [ls res]
        [acc '()]
      )
      (cond 
        [(= i 0) (append ls acc)]
        [(null? ls) acc]
        [else (cons (loop (- i 1)  (find-parent (car (cog-outgoing-set (car ls))) namespaces) (append ls acc)) (loop i (cdr ls) '()))
          ]
      )
      )))
       (cons (node-info g) parents)
    )
))

(define-public (find-proteins-goterm gene namespace parent)
  "Find GO terms for proteins coded by the given gene."
  (let* ([prot (find-protein-form gene)]
         [annotation
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
                (map (lambda (go)
                       (MemberLink (stv 0.0 0.0) prot go))
                     goterms))
              (find-go-term prot namespace parent))])
    (ListLink
     annotation
     (node-info prot)
     (EvaluationLink (PredicateNode "expresses")
                     (ListLink gene prot)))))

(define (go-info go)
  "Add details about the GO term."
  (define GO-ns (find-GO-ns go))
  (list
   (find-go-name go)
   (EvaluationLink 
    (PredicateNode "GO_namespace") 
    (ListLink 
     go
     (if (null? GO-ns) (ConceptNode "") GO-ns)))))

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

(define-public (find-pathway-member a b)
  (find-pathway-member-ctr #:enter? #t)
  (let ((rv (xfind-pathway-member a b)))
  (find-pathway-member-ctr #:enter? #f)
  rv))

(define-public (xfind-pathway-member gene db)
  (run-query (BindLink
      (TypedVariable (Variable "$a") (TypeNode 'ConceptNode))
      (AndLink
        (EvaluationLink
;; FIXME it would be faster to just use srfi-1 filter here... OK?
          (GroundedPredicateNode "scm: filter-atoms")
          (ListLink 
            (VariableNode "$a")
            (ConceptNode db)
          )
         )
        (MemberLink
          gene
          (VariableNode "$a"))
      )
      (ExecutionOutputLink
              (GroundedSchemaNode "scm: add-pathway-info")
                (ListLink
                  gene
                  (VariableNode "$a")
                ))
    ))
)

(define-public (add-pathway-info gene pathway)
  (if (or (string-contains (cog-name pathway) "R-HSA")
          (string-contains (cog-name pathway) "SMP"))
      (ListLink
       (MemberLink gene pathway)
       (node-info pathway))
      #f))

(define-public (find-pathway-genes a b c d)
  (find-pathway-genes-ctr #:enter? #t)
  (let ((rv (xfind-pathway-genes a b c d)))
  (find-pathway-genes-ctr #:enter? #f)
  rv))

(define-public (xfind-pathway-genes pathway go rna prot?)
  "Find genes which code the proteins in a given pathway.  Perform
cross-annotation: if go, annotate each member genes of a pathway for
its GO terms; if rna, annotate each member genes of a pathway for its
RNA transcribes; if prot?, include the proteins in which the RNA
translates to."
  (run-query
   (BindLink
    (VariableList 
     (TypedVariable (VariableNode "$p") (Type 'MoleculeNode))
     (TypedVariable (VariableNode "$g") (Type 'GeneNode)))
    (AndLink
     (MemberLink
      (VariableNode "$p")
      pathway)
     (EvaluationLink
      (PredicateNode "expresses")
      (ListLink
       (VariableNode "$g")
       (VariableNode "$p") )))
    (ExecutionOutputLink
     (GroundedSchemaNode "scm: add-pathway-genes")
     (ListLink
      pathway
      (VariableNode "$g")
      go
      rna
      (ConceptNode (if prot? "True" "False")))))))

(define-public (add-pathway-genes a b c d e)
  (add-pathway-genes-ctr #:enter? #t)
  (let ((rv (xadd-pathway-genes a b c d e)))
  (add-pathway-genes-ctr #:enter? #f)
  rv))

(define-public (xadd-pathway-genes pathway gene go rna prot)
  (let ((go-set (cog-outgoing-set go))
        (rna-set (cog-outgoing-set rna)))
    (if (and (null? go-set) (null? rna-set))
        (ListLink
         (MemberLink gene pathway)
         (node-info gene)
         (locate-node gene))
        (ListLink
         (MemberLink gene pathway)
         (node-info gene)
         (locate-node gene)
         (match go-set
           ((namespace parent . _)
            (ListLink (ConceptNode "gene-go-annotation")
                      (find-go-term gene
                                    (string-split (cog-name namespace) #\space)
                                    (string->number (cog-name parent)))
                      (ListLink (ConceptNode "gene-pathway-annotation"))))
           (_ '()))
         (match rna-set
           ((crna ncrna . _)
            (let* ([do-protein (string=? (cog-name prot) "True")]
                   [rnaresult (find-rna gene
                                        (cog-name crna)
                                        (cog-name ncrna)
                                        do-protein)])
              (if (null? rnaresult)
                  '()
                  (ListLink (ConceptNode "rna-annotation") rnaresult
                            (ListLink (ConceptNode "gene-pathway-annotation"))))))
           (_ '()))))))


(define-public (find-protein a b)
  (find-protein-ctr #:enter? #t)
  (let ((rv (xfind-protein a b)))
  (find-protein-ctr #:enter? #f)
  rv))

(define-public (xfind-protein gene option)
  "Find the proteins a gene expresses."
  (run-query
   (BindLink
    (VariableList
     (TypedVariable (Variable "$a") (TypeNode 'MoleculeNode))
     (TypedVariable (Variable "$pw") (TypeNode 'ConceptNode)))
    (AndLink
     (MemberLink
      gene
      (VariableNode "$pw"))
     (MemberLink
      (VariableNode "$a")
      (VariableNode "$pw"))
     (EvaluationLink
      (PredicateNode "expresses")
      (ListLink
       gene
       (VariableNode "$a"))))
    (ExecutionOutputLink
     (GroundedSchemaNode "scm: filter-pathway")
     (ListLink
      gene
      (VariableNode "$a")
      (VariableNode "$pw")
      (Number option))))))

(define-public filter-pathway (lambda (gene prot pathway option)
  (if (and (string=? (find-prefix prot) "Uniprot") )
    (cond ((and (string-contains (cog-name pathway) "SMP") (equal? option (Number "0")))
    (ListLink
      (EvaluationLink
        (PredicateNode "expresses")
          (ListLink
            gene
            prot ))
    (node-info pathway)
    ))
    ((and (equal? option (Number "1")) (string-contains (cog-name pathway) "R-HSA"))
    (ListLink
      (EvaluationLink
        (PredicateNode "expresses")
          (ListLink
            gene
            prot ))
      (node-info pathway)
      (ListLink 
        (add-loc (MemberLink gene pathway))
      )
    )))
)))

(define (find-prefix node)
  (match (string-split (cog-name node) #\:)
    ((name) name)
    ((name . rest) name)))

(define-public (pathway-hierarchy a b)
  (pathway-hierarchy-ctr #:enter? #t)
  (let ((rv (xpathway-hierarchy a b)))
  (pathway-hierarchy-ctr #:enter? #f)
  rv))

(define-public (xpathway-hierarchy pw lst)
" pathway-hierarchy -- Find hierarchy of the reactome pathway."

	(filter
		(lambda (inhlink)
			(and (member (gar inhlink) lst) (member (gdr inhlink) lst)))
		(cog-incoming-by-type pw 'InheritanceLink)))


(define-public (find-mol a b)
  (find-mol-ctr #:enter? #t)
  (let ((rv (xfind-mol a b)))
  (find-mol-ctr #:enter? #f)
  rv))

(define-public (xfind-mol path identifier)
" Finds molecules (proteins or chebi's) in a pathway"
  (run-query (BindLink
    (TypedVariable (Variable "$a") (TypeNode 'MoleculeNode))
    (AndLink
      (EvaluationLink
        (GroundedPredicateNode "scm: filter-atoms")
        (ListLink
          (VariableNode "$a")
          (ConceptNode identifier)
        )
      )
       (MemberLink
       (VariableNode "$a")
       path)
    )
    (ExecutionOutputLink
      (GroundedSchemaNode "scm: add-mol-info")
      (ListLink
        (VariableNode "$a")
        path
      )
    )))
)

;; Find coding Gene for a given protein
(define-public find-coding-gene
  (lambda (protein)
  (run-query (BindLink
    (TypedVariable (Variable "$g") (TypeNode 'GeneNode))
    (EvaluationLink
      (PredicateNode "expresses")
      (ListLink
        (VariableNode "$g")
        protein
      )
    )
    (EvaluationLink
      (PredicateNode "expresses")
      (ListLink
        (VariableNode "$g")
        protein
      )
    )
  )
)))

(define-public add-mol-info
  (lambda (mol path)
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
))

(define-public filter-atoms
  (lambda (atom identifier)
    (if (string-contains (cog-name atom) (cog-name identifier))
        (cog-new-stv 1 1)
        (cog-new-stv 0 0) 
    )
  )
) 

(define-public (match-gene-interactors a b c d)
  (match-gene-interactors-ctr #:enter? #t)
  (let ((rv (xmatch-gene-interactors a b c d)))
  (match-gene-interactors-ctr #:enter? #f)
  rv))

;; Finds genes interacting with a given gene
(define-public xmatch-gene-interactors
    (lambda (gene prot go rna)
        (run-query (BindLink
            (VariableList
            (TypedVariable (VariableNode "$a") (Type 'GeneNode)))
              (ChoiceLink 
                (EvaluationLink
                  (PredicateNode "interacts_with")
                  (ListLink
                  gene
                  (VariableNode "$a")
                  )
                )
                (EvaluationLink
                  (PredicateNode "interacts_with")
                  (ListLink
                   (VariableNode "$a")
                   gene
                  )
                )       
             )
            
            (ExecutionOutputLink
              (GroundedSchemaNode "scm: generate-result")
                (ListLink
                  gene
                  (VariableNode "$a")
                  (Number prot)
                  go
                  rna
                ))        
            )
        ))
)

(define-public (find-output-interactors a b c d)
  (find-output-interactors-ctr #:enter? #t)
  (let ((rv (xfind-output-interactors a b c d)))
  (find-output-interactors-ctr #:enter? #f)
  rv))

;;; Finds output genes interacting eachother 
(define-public xfind-output-interactors
    (lambda(gene prot go rna)
        (run-query (BindLink
          (VariableList
            (TypedVariable (VariableNode "$a") (Type 'GeneNode))
            (TypedVariable (VariableNode "$b") (Type 'GeneNode)))

          (And  
            (EvaluationLink
               (PredicateNode "interacts_with")
               (ListLink
               gene
               (VariableNode "$a")
              ))

            (EvaluationLink
               (PredicateNode "interacts_with")
               (ListLink
                (VariableNode "$a")
                (VariableNode "$b")
            ))

            (EvaluationLink
               (PredicateNode "interacts_with")
               (ListLink
                gene
               (VariableNode "$b")
              ))
          )
          (ExecutionOutputLink
            (GroundedSchemaNode "scm: generate-result")
              (ListLink
                (VariableNode "$a")
                (VariableNode "$b")
                (Number prot)
                go
                rna
              ))
        ))
))

(define (do-pathway-gene-interactors a)
  (pathway-gene-interactors-ctr #:enter? #t)
  (let ((rv (xdo-pathway-gene-interactors a)))
  (pathway-gene-interactors-ctr #:enter? #f)
  rv))

;; Gene interactors for genes in the pathway
(define xdo-pathway-gene-interactors
  (lambda (pw)
  (run-query (BindLink
    (VariableList
     (TypedVariable (VariableNode "$g1") (Type 'GeneNode))
     (TypedVariable (VariableNode "$g2") (Type 'GeneNode))
     (TypedVariable (VariableNode "$p1") (Type 'MoleculeNode))
     (TypedVariable (VariableNode "$p2") (Type 'MoleculeNode)))
   (AndLink
     (MemberLink (VariableNode "$p1") pw)
     (MemberLink (VariableNode "$p2") pw)
     (EvaluationLink (PredicateNode "expresses") (ListLink (VariableNode "$g1") (VariableNode "$p1")))
     (EvaluationLink (PredicateNode "expresses") (ListLink (VariableNode "$g2") (VariableNode "$p2")))
     (EvaluationLink (PredicateNode "interacts_with") (ListLink (VariableNode "$g1") (VariableNode "$g2")))
   )
  (ExecutionOutputLink
    (GroundedSchemaNode "scm: generate-interactors")
		  (ListLink
        pw
        (VariableNode "$g1")
		    (VariableNode "$g2")
		  ))
  ))
))

;; Cache previous results, so that they are not recomputed again,
;; if the results are already known. Note that this function accounts
;; for about 60% of the total execution time of `gene-pathway-annotation`,
;; so any caching at all is a win. In a test of 681 genes, this offers
;; a 3x speedup in run time.
(define-public pathway-gene-interactors
	(make-afunc-cache do-pathway-gene-interactors))

(define-public (find-protein-form a)
  (find-protein-form-ctr #:enter? #t)
  (let ((rv (xfind-protein-form a)))
  (find-protein-form-ctr #:enter? #f)
  rv))

(define-public xfind-protein-form
  (lambda (gene)
  (let ([prot
  (run-query (BindLink
    (VariableList
      (TypedVariable (VariableNode "$p") (Type 'MoleculeNode))
      (TypedVariable (VariableNode "$b") (Type 'ConceptNode)))
    (AndLink
      (EvaluationLink (PredicateNode "expresses") (ListLink gene (VariableNode "$p")))
      (EvaluationLink (PredicateNode "has_biogridID") (ListLink (VariableNode "$p") (VariableNode "$b")))
      (EvaluationLink (PredicateNode "has_biogridID") (ListLink gene (VariableNode "$b")))
    )
    (VariableNode "$p")
  ))])
  (if (not (null? prot))
    (car prot)
    (ListLink)
  )
  ))
)

(define-public (generate-result a b c d e)
  (generate-result-ctr #:enter? #t)
  (let ((rv (xgenerate-result a b c d e)))
  (generate-result-ctr #:enter? #f)
  rv))

(define-public (xgenerate-result gene-a gene-b prot go rna)
"
  generate-result -- add info about matched variable nodes

  `prot` is either (NumberNode 0) or (NumberNode 1)
      which is used to indicate whether or not protein interactions
      should be computed.

  `rna` may be either an empty ListLink, or may have one, or two
      ConceptNodes in it. If it has two, then first one is the coding RNA,
      and the second one is the non-coding RNA.

      XXX FIXME: these ConceptNodes are used to indicate whether or
      not the coding or non-coding interactions should be done.
      The are just set to (ConceptNode "True") to indicate this.
"
	(if
		(or (equal? (cog-type gene-a) 'VariableNode)
		    (equal? (cog-type gene-b) 'VariableNode))
		(ListLink)
		(let* (
            [do-prot-str  (cog-name prot)]
            [do-protein  (= 1 (string->number do-prot-str))]

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

            [namespace (gar go)]
            [parent    (gdr go)]

            [crna      (gar rna)]   ; coding RNA
            [ncrna     (gdr rna)]   ; non-coding RNA
            [crna-name  (if (null? crna)  "" (cog-name crna))]
            [ncrna-name (if (null? ncrna) "" (cog-name ncrna))]
          )

          ;; Neither gene has been done yet.
          (cond
              ((and (not already-done-a) (not already-done-b))
              (let (
                 [go-cross-annotation
                    (if (null? namespace) '()
                        (List
                           (Concept "gene-go-annotation")
                           (find-go-term gene-a
                              (string-split (cog-name namespace) #\ )
                              (string->number (cog-name parent)))
                           (find-go-term gene-b
                              (string-split (cog-name namespace) #\ )
                              (string->number (cog-name parent)))
                           (List (Concept "biogrid-interaction-annotation")))
                    )]
                 [rna-cross-annotation
                    (if (= 0 (cog-arity rna)) '()
                       (List
                          (Concept "rna-annotation")
                          (find-rna gene-a crna-name ncrna-name do-protein)
                          (find-rna gene-b crna-name ncrna-name do-protein)
                          (List (Concept "biogrid-interaction-annotation")))
                   )])
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
                     (if (null? namespace) '()
                        (List
                           (Concept "gene-go-annotation")
                           (find-go-term gene-x
                              (string-split (cog-name namespace) #\ )
                              (string->number (cog-name parent)))
                           (List (Concept "biogrid-interaction-annotation")))
                     )]
                  [rna-cross-annotation
                     (if (= 0 (cog-arity rna)) '()
                        (List
                           (Concept "rna-annotation")
                           (find-rna gene-x crna-name ncrna-name do-protein)
                           (List (Concept "biogrid-interaction-annotation")))
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

(define-public (build-interaction a b c d)
  (build-interaction-ctr #:enter? #t)
  (let ((rv (xbuild-interaction a b c d)))
  (build-interaction-ctr #:enter? #f)
  rv))

(define-public (xbuild-interaction interactor-1 interactor-2 pubmed interaction_pred)
  (if (or (equal? (cog-type interactor-1) 'ListLink) (equal? (cog-type interactor-2) 'ListLink))
    '()
    (if (null? pubmed) 
      (EvaluationLink 
        (PredicateNode interaction_pred) 
        (ListLink interactor-1 interactor-2))
      (EvaluationLink
        (PredicateNode "has_pubmedID")
        (ListLink (EvaluationLink 
                  (PredicateNode interaction_pred) 
                  (ListLink interactor-1 interactor-2))  
                pubmed))
    )
  )
)

(define-public (generate-interactors a b c)
  (generate-interactors-ctr #:enter? #t)
  (let ((rv (xgenerate-interactors a b c)))
  (generate-interactors-ctr #:enter? #f)
  rv))

(define-public (xgenerate-interactors path var1 var2)
	; (biogrid-reported-pathways) is a cache of the interactions that have
	; already been handled. Defined in util.scm and cleared in main.scm.
	(if (or (equal? var1 var2)
			((biogrid-reported-pathways) (Set var1 var2))) '()
		(let ([output (find-pubmed-id var1 var2)])
			(if (null? output)
				(EvaluationLink
					(PredicateNode "interacts_with")
					(ListLink var1 var2))
				(EvaluationLink
					(PredicateNode "has_pubmedID")
					(ListLink
						(EvaluationLink
							(PredicateNode "interacts_with")
							(ListLink var1 var2))
						output)))))
)

;; ------------------------------------------------------
(define (do-find-pubmed-id a)
  (find-pubmed-id-ctr #:enter? #t)
  (let ((rv (xdo-find-pubmed-id a)))
  (find-pubmed-id-ctr #:enter? #f)
  rv))

(define (xdo-find-pubmed-id gene-set)
"
  This is expecting a (SetLink (Gene \"a\") (Gene \"b\"))
  as the argument.
"
   (let* (
      [gene-a (gar gene-set)]
      [gene-b (gdr gene-set)]
      [pub (run-query
              (GetLink
               (VariableNode "$pub")
               (EvaluationLink
                (PredicateNode "has_pubmedID")
                (ListLink
                 (EvaluationLink 
                  (PredicateNode "interacts_with") 
                  (ListLink
                   gene-a
                   gene-b))
                 (VariableNode "$pub")))))])
    (if (null? pub)
        (run-query
         (GetLink
          (VariableNode "$pub")
          (EvaluationLink
           (PredicateNode "has_pubmedID")
           (ListLink
            (EvaluationLink 
             (PredicateNode "interacts_with") 
             (ListLink
              gene-b
              gene-a))
            (VariableNode "$pub")))))
        pub)))

(define cache-find-pubmed-id
	(make-afunc-cache do-find-pubmed-id))

; Memoized version of above, for performance.
(define-public (find-pubmed-id gene-a gene-b)
	(cache-find-pubmed-id (Set gene-a gene-b)))

;; ------------------------------------------------------
;; Finds coding and non coding RNA for a given gene
(define-public (find-rna a b c d)
  (find-parent-ctr #:enter? #t)
  (let ((rv (xfind-rna a b c d)))
  (find-parent-ctr #:enter? #f)
  rv))

(define (xfind-rna gene coding noncoding do-protein)
	(define do-coding (string=? coding "True"))
	(define do-noncoding (string=? noncoding "True"))
	(map
		(lambda (transcribe)
			(filterbytype gene transcribe do-coding do-noncoding do-protein))
		(run-query (Get
			(TypedVariable (Variable "$a") (Type 'MoleculeNode))
			(Evaluation (Predicate "transcribed_to") (List gene (Variable "$a"))))))
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

(define-public (find-translates rna)
  (run-query (GetLink
    (TypedVariable (VariableNode "$a") (TypeNode 'MoleculeNode))
      (EvaluationLink
        (PredicateNode "translated_to")
        (ListLink
          rna
          (VariableNode "$a")
        )
      )
))
)
