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

(define-module (annotation functions)
    #:use-module (annotation util)
    #:use-module (opencog)
    #:use-module (opencog exec)
    #:use-module (opencog bioscience)
;    #:use-module (rnrs base)
    #:use-module (srfi srfi-1)
    #:use-module (ice-9 match)
)

;;Given an atom and list of namespaces finds the parents of that atom in the specified namespaces
(define find-parent

  (lambda (node namespaces)
        (let (
          [atom (cog-outgoing-atom node 1)]
          [parents '()]
        )
        (for-each (lambda (ns)
          (set! parents (append parents (run-query (BindLink
            (TypedVariable (Variable "$a") (TypeNode 'ConceptNode))
            (AndLink
              (InheritanceLink
                atom
                (VariableNode "$a"))
              (EvaluationLink
                (PredicateNode "GO_namespace")
                (ListLink
                  (VariableNode "$a")
                  (ConceptNode ns)
                )
              )
            )
          (ExecutionOutputLink
              (GroundedSchemaNode "scm: add-go-info")
                (ListLink
                  atom
                  (VariableNode "$a")
                ))
        )))) 
        ) namespaces
      )
    parents  
  )
))

;;Finds Go terms of a gene
(define find-memberln 
  (lambda (gene namespaces)
    (let ([go-atoms '()])

      (for-each (lambda (ns)
      
        (set! go-atoms (append go-atoms (run-query (BindLink
            (TypedVariable (Variable "$a") (TypeNode 'ConceptNode))
            (AndLink
              (MemberLink
                gene
                (VariableNode "$a"))
                (EvaluationLink
                (PredicateNode "GO_namespace")
                (ListLink
                  (VariableNode "$a")
                  (ConceptNode ns)
                )
              )
            ) 
           (ExecutionOutputLink
              (GroundedSchemaNode "scm: add-go-info")
                (ListLink
                  gene
                  (VariableNode "$a")
                ))
          ))))
      ) namespaces)
          go-atoms
          ))
)

;;Add information for GO nodes
(define-public (add-go-info child-atom parent-atom)
  (if (and (or (equal? (cog-type child-atom) 'GeneNode) (equal? (cog-type child-atom) 'MoleculeNode))
      (equal? (list-ref (string-split (cog-name parent-atom) #\:) 0) "GO"))
    (ListLink  
      (MemberLink
          child-atom
          parent-atom
      )
      (go-info parent-atom)
    )
    (begin
      (if (equal? (list-ref (string-split (cog-name parent-atom) #\:) 0) "GO")
        (ListLink 
            (InheritanceLink
              child-atom
              parent-atom
          )
          (go-info parent-atom)
        )
    ))
  )
)

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

;; Finds go terms for a proteins coded by the given gene
(define-public find-proteins-goterm
  (lambda (gene namespace parent)
  (let ([prot (find-protein-form gene)]
       [annotation '()])
  (if (equal? (find-memberln prot namespace) '())
    (begin
      (let ([goterms (flatten (map (lambda (ns)
        (run-query (BindLink
        (TypedVariable (VariableNode "$g") (Type 'ConceptNode))
        (AndLink (MemberLink gene (VariableNode "$g"))
          (EvaluationLink (PredicateNode "GO_namespace") (ListLink (VariableNode "$g") (ConceptNode ns)))
        )
        (VariableNode "$g")))
      ) namespace))])
      (set! annotation (map (lambda (go)
            (MemberLink (stv 0.0 0.0) prot go)
      )goterms))
    ))
    (set! annotation (find-go-term prot namespace parent))
  )
  (ListLink
    annotation
    (node-info prot)
    (EvaluationLink (PredicateNode "expresses") (ListLink gene prot))
  )
  )
))
;; Add details about the GO term
(define (go-info go)
  (list
      (find-go-name go)
      (EvaluationLink 
        (PredicateNode "GO_namespace") 
        (ListLink 
          go 
          (if (equal? (find-GO-ns go) '()) (ConceptNode "") (find-GO-ns go))))
  )
)

;; Finds parents of a GO term ( of given namespace type) 
(define find-GO-ns 
  (lambda (go)
    (run-query
            (GetLink
                (TypedVariable (Variable "$v") (TypeNode 'ConceptNode))
                (EvaluationLink 
                    (PredicateNode "GO_namespace")
                    (ListLink 
                      go
                      (VariableNode "$v")
                    )
                 )
                )
    )
  
  )
)

;; Finds the name of a GO term
(define find-go-name
    (lambda(go)
        (run-query (BindLink
           (TypedVariable (Variable "$a") (TypeNode 'ConceptNode))
            (EvaluationLink
               (PredicateNode "GO_name")
               (ListLink
               go
               (VariableNode "$a")
              )
            )
              (EvaluationLink
               (PredicateNode "GO_name")
               (ListLink
               go
               (VariableNode "$a")
              )
            )
           )
        )
    )
)

;;finds go definition for parser function
(define find-godef
    (lambda (go)
       (run-query
        (BindLink
         (VariableNode "$def")

         (EvaluationLink
          (PredicateNode "GO_definition")
          (ListLink
           go
           (VariableNode "$def")
          )
         )
          (EvaluationLink
          (PredicateNode "GO_definition")
          (ListLink
           go
           (VariableNode "$def")
          )
         )
        )       
      )
     )
)

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

(define-public add-pathway-info 
  (lambda (gene pathway)
     (let ([res '()])
      (if  (string-contains (cog-name pathway) "R-HSA")
        (set! res (ListLink 
            (MemberLink gene pathway)
            (node-info pathway)
        ))
     )
     (if (string-contains (cog-name pathway) "SMP")
        (set! res (ListLink 
            (MemberLink gene pathway)
            (node-info pathway)
        ))
     )
     res
     )
  )
)
;; finds genes which codes the proteins in a given pathway and does cross annotation:
;; if go, annotate each member genes of a pathway for its GO terms
;; if rna, annotate each member genes of a pathway for its RNA transcribes
;; if prot, include the proteins inwhich the RNA translates to
(define-public find-pathway-genes
  (lambda (pathway go rna prot)
    (run-query (BindLink
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
          (ConceptNode prot)
        ))
  ))
))
(define-public (add-pathway-genes pathway gene go rna prot)
(if (and (null? (cog-outgoing-set go)) (null? (cog-outgoing-set rna)))
  (ListLink
        (MemberLink gene pathway)
        (node-info gene)
        (locate-node gene)
  )
  (ListLink
    (MemberLink gene pathway)
      (node-info gene)
      (locate-node gene)
  (if (not (null? (cog-outgoing-set go)))
    (let ([namespace (car (cog-outgoing-set go))]
          [parent (cadr (cog-outgoing-set go))])
      (ListLink (ConceptNode "gene-go-annotation") (find-go-term gene  (string-split (cog-name namespace) #\ ) (string->number (cog-name parent)))
      (ListLink (ConceptNode "gene-pathway-annotation")))
    )
    '()
  )
  (if (not (null? (cog-outgoing-set rna)))
    (let ([crna (car (cog-outgoing-set rna))]
          [ncrna (cadr (cog-outgoing-set rna))]
          [protein (if (equal? (cog-name prot) "True") 1 0)])
      (let ([rnaresult  (find-rna gene (cog-name crna) (cog-name ncrna) protein)])
      (if (not (null? rnaresult))
        (ListLink (ConceptNode "rna-annotation") rnaresult
        (ListLink (ConceptNode "gene-pathway-annotation")))
        '()
      ))
    )
    '()
  )
  )
))
;; Finds proteins a gene expresses
(define-public find-protein
    (lambda (gene option)
        (run-query (BindLink
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
                (VariableNode "$a") ))
            )
        (ExecutionOutputLink
          (GroundedSchemaNode "scm: filter-pathway")
            (ListLink
              gene
              (VariableNode "$a")
              (VariableNode "$pw")
              (Number option)
            )
        )
      )
  )
))

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
  (if (equal? (length (string-split (cog-name node) #\:)) 1)
        (cog-name node)
        (car  (string-split (cog-name node) #\:))
    )
)
;; Find heirarchy of the reactome pathway
(define-public pathway-hierarchy
  (lambda (pw lst)
    (let ([res-parent
      (run-query (BindLink
        (VariableNode "$parentpw")
          (InheritanceLink
            pw
          (VariableNode "$parentpw"))
        (ExecutionOutputLink
          (GroundedSchemaNode "scm: check-pathway")
          (ListLink
            pw
            (VariableNode "$parentpw")
            (ListLink lst)
          )
        ))
      )
    ]
    [res-child (run-query (BindLink
      (VariableNode "$parentpw")
      (InheritanceLink
        (VariableNode "$parentpw")
        pw)
      (ExecutionOutputLink
        (GroundedSchemaNode "scm: check-pathway")
        (ListLink
         (VariableNode "$parentpw")
         pw
         (ListLink lst)
        )
      ))
    )]
  )
  (append res-parent res-child)
)))

(define-public check-pathway
  (lambda (pw parent-pw lst)
    (if (and (member parent-pw (cog-outgoing-set lst)) (member pw (cog-outgoing-set lst)))
    (ListLink
      (InheritanceLink
      pw
      parent-pw)
    ))
))

;; Finds molecules (proteins or chebi's) in a pathway 
(define-public (find-mol path identifier)
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
    (lambda (gene prot go)
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
                ))        
            )
        ))
)

;;; Finds output genes interacting eachother 
(define-public find-output-interactors
    (lambda(gene prot go)
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
              ))
        ))
))

;; Gene interactors for genes in the pathway
(define-public pathway-gene-interactors 
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

(define-public (generate-result gene-a gene-b prot go)
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
                            (locate-node coding-prot-a))
                        ))
                      (ListLink
                          interaction
                          (node-info (GeneNode a))
                          (locate-node  (GeneNode a))
                          (node-info (GeneNode b))
                          (locate-node  (GeneNode b))
                          (if (not (null? namespace))
                          (ListLink
                            (ConceptNode "gene-go-annotation")
                            (find-go-term (GeneNode a) (string-split (cog-name namespace) #\ ) (string->number (cog-name parent)))
                            (find-go-term (GeneNode b) (string-split (cog-name namespace) #\ ) (string->number (cog-name parent)))
                            (ListLink (ConceptNode "biogrid-interaction-annotation"))
                            )
                            '() )
                      )
                  ))
              )
              ((a)
                  (begin 
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
                            (locate-node coding-prot))
                        ))
                      (ListLink
                          interaction
                          (node-info (GeneNode a))
                          (locate-node  (GeneNode a))
                          (if (not (null? namespace))
                          (ListLink (ConceptNode "gene-go-annotation") (find-go-term (GeneNode a) (string-split (cog-name namespace) #\ ) (string->number (cog-name parent)))
                          (ListLink (ConceptNode "biogrid-interaction-annotation"))
                          )
                          '()
                          ))
                  ))
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
                    gene-b
                  ))
            (VariableNode "$pub")
           )
         )

   ))])
   (if (null? pub)
     (set! pub (run-query
     (GetLink
       (VariableNode "$pub")
       (EvaluationLink
           (PredicateNode "has_pubmedID")
           (ListLink
             (EvaluationLink 
                (PredicateNode "interacts_with") 
                  (ListLink
                    gene-b
                    gene-a
                  ))
             (VariableNode "$pub")
           )
         )
   ))
   ))
   pub
))
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
  (if (and (equal? (cog-name cod) "True") (string-prefix? "ENST" (cog-name rna)))
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
          '()
      )
    )
    '()
  )
  (if (and (equal? (cog-name ncod) "True") (not (string-prefix? "ENST" (cog-name rna))))
    (list
      (EvaluationLink
        (PredicateNode "transcribed_to")
          (ListLink
              gene
              rna))
      (node-info rna)
    )
    '()
  )
)
)

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
