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

(define (find-parent node namespaces)
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

(define (find-memberln gene namespaces)
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

(define-public (add-go-info child-atom parent-atom)
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

;;the main function to find the go terms for a gene with a specification of the parents
(define-public find-go-term 
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
       (append (node-info g) parents)
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
                        (run-query (BindLink
                                    (TypedVariable (VariableNode "$g")
                                                   (Type 'ConceptNode))
                                    (AndLink (MemberLink gene (VariableNode "$g"))
                                             (EvaluationLink
                                              (PredicateNode "GO_namespace")
                                              (ListLink
                                               (VariableNode "$g")
                                               (ConceptNode ns))))
                                    (VariableNode "$g"))))
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

(define-public (find-pathway-member gene db)
  (run-query (BindLink
      (TypedVariable (Variable "$a") (TypeNode 'ConceptNode))
      (AndLink
        (EvaluationLink
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

(define-public (find-pathway-genes pathway go rna prot?)
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

(define-public (add-pathway-genes pathway gene go rna prot)
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
            (let* ([protein (if (string=? (cog-name prot) "True") 1 0)]
                   [rnaresult (find-rna gene
                                        (cog-name crna)
                                        (cog-name ncrna)
                                        protein)])
              (if (null? rnaresult)
                  '()
                  (ListLink (ConceptNode "rna-annotation") rnaresult
                            (ListLink (ConceptNode "gene-pathway-annotation"))))))
           (_ '()))))))

(define-public (find-protein gene option)
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

(define-public (pathway-hierarchy pw lst)
" pathway-hierarchy -- Find hierarchy of the reactome pathway."

	(filter
		(lambda (inhlink)
			(and (member (gar inhlink) lst) (member (gdr inhlink) lst)))
		(get-incoming-by-type pw 'InheritanceLink)))


(define-public (find-mol path identifier)
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


;; Finds genes interacting with a given gene
(define-public match-gene-interactors
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

;;; Finds output genes interacting eachother 
(define-public find-output-interactors
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

;; Gene interactors for genes in the pathway
(define do-pathway-gene-interactors
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
;; if the results are already known. Note that this functin accounts
;; for about 60% of the total execution time of `gene-pathway-annotation`
;; so any caching at all is a win. In a test of 681 genes, this offers
;; a 3x speedup in run time.
(define-public pathway-gene-interactors
	(make-afunc-cache do-pathway-gene-interactors))

(define-public find-protein-form
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

;; Grounded schema node to add info about matched variable nodes

(define-public (generate-result gene-a gene-b prot go rna) 
    (if  
      (and (not (equal? (cog-type gene-a) 'VariableNode)) (not (equal? (cog-type gene-b) 'VariableNode))
        )  
      (let* (
            [output (find-pubmed-id gene-a gene-b)]
            [res (flatten (map (lambda (x) 
                              (if (not (member (cog-name x) (biogrid-genes)))
                                  (cog-name x)
                                  '()
                              ) 
              )  (list gene-a gene-b))) ]
            [interaction (if (= 1 (string->number (cog-name prot))) 
                (ListLink
                  (build-interaction gene-a gene-b output "interacts_with")
                  (build-interaction (find-protein-form gene-a) (find-protein-form gene-b) output "inferred_interaction"))
                (build-interaction gene-a gene-b output "interacts_with"))]
            [namespace (if (null? (cog-outgoing-set go)) '() (car (cog-outgoing-set go)))]
            [parent (if (null? (cog-outgoing-set go)) '() (cadr (cog-outgoing-set go)))]
            [pairs (find (lambda (x) (equal? x (cons (cog-name gene-a) (cog-name gene-b)))) (biogrid-pairs))]
            [crna (if (not (null? (cog-outgoing-set rna))) (car (cog-outgoing-set rna)))]
            [ncrna (if (not (null? (cog-outgoing-set rna))) (cadr (cog-outgoing-set rna)))]
          )
          (if (null? interaction)
            (ListLink)
          )
          (if (not pairs)
            (biogrid-pairs (append (biogrid-pairs) (list (cons (cog-name gene-a) (cog-name gene-b)))))
          )
          (match res
              ((a b)
                  (begin 
                  (let ([go-cross-annotation (if (null? namespace) '() 
                        (ListLink (ConceptNode "gene-go-annotation")
                        (map (lambda (gene) (find-go-term (GeneNode gene) (string-split (cog-name namespace) #\ ) (string->number (cog-name parent))))(list a b))
                        (ListLink (ConceptNode "biogrid-interaction-annotation")))
                        )]
                        [rna-cross-annotation (if (null? (cog-outgoing-set rna)) '() 
                        (ListLink (ConceptNode "rna-annotation") 
                        (map (lambda (gene) (find-rna (GeneNode gene) (cog-name crna) (cog-name ncrna) (cog-name prot))) (list a b))
                        (ListLink (ConceptNode "biogrid-interaction-annotation")))
                        )])
                      (biogrid-genes (append (list a b) (biogrid-genes)))
                      (if (= 1 (string->number (cog-name prot)))
                        (let ([coding-prot-a (find-protein-form (GeneNode a))]
                              [coding-prot-b (find-protein-form (GeneNode b))])
                        (if (or (equal? coding-prot-a (ListLink)) (equal? coding-prot-b (ListLink)))
                          (ListLink)
                          (ListLink
                            interaction
                            (EvaluationLink (PredicateNode "expresses") (ListLink (GeneNode a) coding-prot-a))
                            (node-info (GeneNode a))
                            (node-info coding-prot-a)
                            (locate-node coding-prot-a)
                            (EvaluationLink (PredicateNode "expresses") (ListLink (GeneNode b) coding-prot-b))
                            (node-info (GeneNode b))
                            (node-info coding-prot-b)
                            (locate-node coding-prot-a)
                            go-cross-annotation
                            rna-cross-annotation
                          )
                        ))
                      (ListLink
                          interaction
                          (node-info (GeneNode a))
                          (locate-node  (GeneNode a))
                          (node-info (GeneNode b))
                          (locate-node  (GeneNode b))
                          go-cross-annotation
                          rna-cross-annotation 
                      )
                    )
                  )
                  )
              )
              ((a)
                  (begin 
                  (let ([go-cross-annotation (if (null? namespace) '() 
                        (ListLink (ConceptNode "gene-go-annotation") 
                        (find-go-term (GeneNode a) (string-split (cog-name namespace) #\ ) (string->number (cog-name parent))) 
                        (ListLink (ConceptNode "biogrid-interaction-annotation")))
                        )]
                        [rna-cross-annotation (if (null? (cog-outgoing-set rna)) '() 
                        (ListLink (ConceptNode "rna-annotation")
                        (find-rna (GeneNode a) (cog-name crna) (cog-name ncrna) (cog-name prot))
                        (ListLink (ConceptNode "biogrid-interaction-annotation")))
                        )])
                      (biogrid-genes (append (list a) (biogrid-genes)))
                      (if (= 1 (string->number (cog-name prot)))
                        (let ([coding-prot (find-protein-form (GeneNode a))])
                        (if (equal? coding-prot (ListLink))
                          (ListLink)
                          (ListLink
                            interaction
                            (EvaluationLink (PredicateNode "expresses") (ListLink (GeneNode a) coding-prot))
                            (node-info (GeneNode a))
                            (node-info coding-prot)
                            (locate-node coding-prot)
                            go-cross-annotation
                            rna-cross-annotation 
                            )
                        ))
                      (ListLink
                          interaction
                          (node-info (GeneNode a))
                          (locate-node  (GeneNode a))
                          go-cross-annotation
                          rna-cross-annotation
                      )
                      )
                  )
                )
              )
              (()
                  (if pairs
                    (ListLink)
                    (ListLink
                          interaction
                      )
                  )
              )
          )
      )
  (ListLink)
)
    
)

(define-public (build-interaction interactor-1 interactor-2 pubmed interaction_pred)
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

(define-public (generate-interactors path var1 var2)
      (if (not (string=? (cog-name var1) (cog-name var2)))
      
      (let ([pairs (find (lambda (x) (or (equal? (cons (cog-name var1) (cog-name var2)) x)
                                          (equal? (cons (cog-name var2) (cog-name var1)) x)
                                      )
        
                  ) (biogrid-pairs-pathway))]
          )
          (if pairs
            '()
            (let (
              [output (find-pubmed-id var1 var2)]
              )
                (biogrid-pairs-pathway (append (biogrid-pairs-pathway) (list (cons (cog-name var1) (cog-name var2)))))
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
                          output)
                        )
                )
              )
            )
          )
        '()
    )

)

;;                           
(define-public (find-pubmed-id gene-a gene-b)
  (let ([pub (run-query
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

;; Finds coding and non coding RNA for a given gene
(define-public (find-rna gene coding noncoding protein)
  (run-query (BindLink
    (TypedVariable (Variable "$a") (TypeNode 'MoleculeNode))
      (EvaluationLink
        (PredicateNode "transcribed_to")
        (ListLink
          gene
          (VariableNode "$a")
        )
      )
    (ExecutionOutputLink
      (GroundedSchemaNode "scm: filterbytype")
        (ListLink 
          gene
          (VariableNode "$a")
          (Concept coding)
          (Concept noncoding)
          (Number protein))
    )
))
)

(define-public (filterbytype gene rna cod ncod prot)
  (ListLink 
   (if (and (string=? (cog-name cod) "True")
            (string-prefix? "ENST" (cog-name rna)))
       (list
        (EvaluationLink
         (PredicateNode "transcribed_to")
         (ListLink
          gene
          rna))
        (node-info rna)
        (if (= (string->number (cog-name prot)) 1)
            (list
             (EvaluationLink
              (PredicateNode "translated_to")
              (ListLink
               rna
               (find-translates rna)))
             (node-info (car (find-translates rna))))
            '()))
       '())
   (if (and (string=? (cog-name ncod) "True")
            (not (string-prefix? "ENST" (cog-name rna))))
       (list
        (EvaluationLink
         (PredicateNode "transcribed_to")
         (ListLink
          gene
          rna))
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
