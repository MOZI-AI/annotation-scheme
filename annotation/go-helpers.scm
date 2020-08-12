;;; MOZI-AI Annotation Scheme
;;; Copyright © 2019 Abdulrahman Semrie
;;; Copyright © 2019 Hedra Seid
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

(define-module (annotation go-helpers)
    #:use-module (annotation functions)
    #:use-module (annotation string-helpers)
    #:use-module (annotation util)
    #:use-module (opencog)
    #:use-module (opencog exec)
    #:use-module (opencog bioscience)
    #:use-module (annotation util)
    #:use-module (srfi srfi-1)
    #:use-module (ice-9 match)
)

(define-public (find-go-name go)
  "Find the name of a GO term."
  (run-query (Bind
              (TypedVariable (Variable "$a") (TypeNode 'ConceptNode))
              (EvaluationLink
               (PredicateNode "has_name")
               (ListLink go (VariableNode "$a")))
              (EvaluationLink
               (PredicateNode "has_name")
               (ListLink go (VariableNode "$a"))))))


(define (add-go-info child-atom parent-atom)
"
   Add information for GO nodes
"
   (define parent-is-go?
      (member (cog-type parent-atom) (list 'BiologicalProcessNode 'CellularComponentNode 'MolecularFunctionNode)))

   (if parent-is-go?
      (if (member (cog-type child-atom) '(GeneNode MoleculeNode))
         (list
            (Member child-atom parent-atom)
            (find-go-name parent-atom))
         (list
           (Inheritance child-atom parent-atom)
           (find-go-name parent-atom)))
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
            (TypedVariable (Variable "$a") (ns->type ns-name))
            (And
               (Inheritance atom (Variable "$a"))))))

      (filter-map
         (lambda (thing) (add-go-info atom thing))
         go-list))

   (append-map add-go-for-ns namespaces)
)

(define-public (find-memberln gene namespaces)
"
  Find GO terms of a gene.  `gene` must be a GeneNode and `namespaces`
  must be a list of strings.
"
   (define (add-go-member-ns ns-name)

      ;;list of go atoms that this gene is a member of
      (define go-list
         (run-query (Get
            (TypedVariable (Variable "$a") (ns->type ns-name))
            (And
               (Member gene (Variable "$a"))))))

      (filter-map
         (lambda (thing) (add-go-info gene thing))
         go-list))

   (append-map add-go-member-ns namespaces)
)

(define-public (find-go-term g namespaces num-parents regulates part-of bi-dir)
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
            (if item (find-parent (car (flatten item)) namespaces) '()))
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
   (define go-regulates (append-map (lambda (go) (find-go-plus go regulates part-of bi-dir)) res))
   (define all-parents (loop num-parents res '()))

   (append (node-info g) all-parents go-regulates)
)

;; ======================= GO Plus =============================

(define regulates-rln (List (Concept "GO_regulates") (Concept "GO_positively_regulates") (Concept "GO_negatively_regulates")))

(define (do-find-regulates input-atom)
      (if (stv->scm (cog-tv input-atom))
         (append (append-map (lambda (reg) (run-query (Bind 
            (Evaluation
               (Predicate (cog-name reg))
               (ListLink (gar input-atom) (Variable "$go")))

            (Evaluation
               (Predicate (cog-name reg))
               (ListLink (gar input-atom) (Variable "$go")))))) (cog-outgoing-set regulates-rln))

         (append-map (lambda (reg) (run-query (Bind 
            (Evaluation
               (Predicate (cog-name reg))
               (ListLink (Variable "$go") (gar input-atom)))

            (Evaluation
               (Predicate (cog-name reg))
               (ListLink (Variable "$go") (gar input-atom)))))) (cog-outgoing-set regulates-rln)))

         (append-map (lambda (reg) (run-query (Bind 
            (Evaluation
               (Predicate (cog-name reg))
               (ListLink (gar input-atom) (Variable "$go")))

            (Evaluation
               (Predicate (cog-name reg))
               (ListLink (gar input-atom) (Variable "$go")))))) (cog-outgoing-set regulates-rln))))

(define find-go-regulates (memoize-function-call do-find-regulates))

(define (do-find-part-of input-atom)
   (if (stv->scm (cog-tv input-atom))
      (append
         (run-query (Bind
            (Evaluation
               (Predicate "has_part")
               (List (gar input-atom) (Variable "$go")))
            (Evaluation
               (Predicate "has_part")
               (List (gar input-atom) (Variable "$go")))))

         (run-query
            (Bind
               (Evaluation (Predicate "has_part")
                  (List (Variable "$go") (gar input-atom)))
               (Evaluation (Predicate "has_part")
                  (List (Variable "$go") (gar input-atom))))))

      (run-query (Bind
            (Evaluation (Predicate "has_part")
               (List (gar input-atom) (Variable "$go")))
            (Evaluation (Predicate "has_part")
               (List (gar input-atom) (Variable "$go")))))))

(define find-part-of (memoize-function-call do-find-part-of))

(define* (find-go-plus go-term #:optional (regulates #t) (part_of #t) (bi-direction #t))
   (define (find-go-plus-info ln)
      (if (equal? go-term (gadr ln))
           (find-go-name (gddr ln))
           (find-go-name (gadr ln))))
   (let (
      [go-reg-terms (if regulates (find-go-regulates (Set go-term (scm->stv bi-direction))) '())]
      [go-part-terms (if part_of (find-part-of (Set go-term (scm->stv bi-direction))) '())]) 
      (append go-reg-terms go-part-terms (append-map find-go-plus-info go-reg-terms) 
         (append-map find-go-plus-info go-part-terms))))


;; ======================== GO-Proteins ==============================
(define-public (find-proteins-goterm gene namespace parent regulates part-of bi-dir)
  "Find GO terms for proteins coded by the given gene."
  (let* ([prots (find-proteins gene)])
    
    (if (null? prots)
      '()
      (let ([annotations (append-map (lambda (prot) 
            (if (null? (find-memberln prot namespace))
              (let ([goterms
                     (append-map
                      (lambda (ns)
                        (run-query (Get
                                    (TypedVariable (VariableNode "$g")
                                                   (ns->type ns))
                                    (AndLink (MemberLink gene (VariableNode "$g"))))))
                      namespace)])
                (list
                  (map (lambda (go)
                       (MemberLink prot go)) goterms)
                  (node-info prot)
                  (EvaluationLink (PredicateNode "expresses")
                     (ListLink gene prot))))

               (list
                  (find-go-term prot namespace parent regulates part-of bi-dir)
                  (EvaluationLink (PredicateNode "expresses")
                     (ListLink gene prot))))) prots)])
          
          annotations))))

(define-public (find-drugs-protein gene namespace)
"
  find-drugs-protein GENE NAMESPACE

  Find the drugs associated with the proteins expressed by GENE in GO terms under NAMESPACE.
"
  (define var-go-term (Variable "$go-term"))
  (define var-drug-action (Variable "$drug-action"))
  (define var-drug (Variable "$drug"))
  (define var-drug-group (Variable "$drug-group"))

  (append-map
    (lambda (prot)
      (append-map
        (lambda (ns)
          (run-query
            (Bind
              (VariableSet
                (TypedVariable var-go-term (ns->type ns))
                (TypedVariable var-drug-action (Type "PredicateNode"))
                (TypedVariable var-drug (Type "MoleculeNode"))
                (TypedVariable var-drug-group (Type "ConceptNode")))
              (And
                (Evaluation
                  (Predicate "expresses")
                  (List gene prot))
                (Member gene var-go-term)

                (Evaluation var-drug-action (List var-drug prot))
                (Inheritance var-drug var-drug-group)
                (Inheritance
                  var-drug-group
                  (Concept "drug")))
              (Evaluation
                var-drug-action
                (List var-drug prot))))) namespace))
    (find-proteins gene)))

; --------------------------------------------------
(define-public (find-go-genes go-term string?)
"
  find-go-gene GO-TERM STRING?

  Find the genes associate with GO-TERM via a MemberLink.
  If STRING? is true, the gene-gene interaction from
  the STRING database will also be included.
"
  (define var-gene-1 (Variable "$gene-1"))
  (define var-gene-2 (Variable "$gene-2"))

  (if string?
    (run-query
      (Bind
        (VariableSet
          (TypedVariable var-gene-1 (Type "GeneNode"))
          (TypedVariable var-gene-2 (Type "GeneNode")))
        (Present
          (Member var-gene-1 go-term)
          (Evaluation
            (Predicate "interacts_with")
            (Set var-gene-1 var-gene-2)))
        (Member var-gene-1 go-term)
        (Evaluation (Predicate "interacts_with") (Set var-gene-1 var-gene-2))))
    (filter
      (lambda (memblink)
        (and (equal? (gdr memblink) go-term)
             (equal? (cog-type (gar memblink)) 'GeneNode)))
      (cog-incoming-by-type go-term 'MemberLink)))
   
   (if string?
      (append (run-query (Bind 
                (TypedVariable var-gene-1 (Type "GeneNode"))
                (Member var-gene-1 go-term)
                (Member var-gene-1 go-term)))
              (find-pathway/go-gene-interactors go-term))
      (run-query (Bind 
        (TypedVariable var-gene-1 (Type "GeneNode"))
        (Member var-gene-1 go-term)
      (Member var-gene-1 go-term)))))

(define-public (find-go-proteins go-term string?)
"
  find-go-protein GO-TERM

  Find the proteins associate with GO-TERM via a MemberLink.
"
  (define var-protein (Variable "$prot"))

  (run-query
    (Bind
        (TypedVariable var-protein (Type "Uniprot"))
        (Member var-protein go-term)
        (Member var-protein go-term))))

(define-public (find-go-parents go-term)
"
  find-go-parents GO-TERM

  Find the parent GO terms of GO-TERM via an InheritanceLink.
"
  (run-query (Bind 
         (Inheritance go-term (Variable "$par"))
         (Inheritance go-term (Variable "$par")))))