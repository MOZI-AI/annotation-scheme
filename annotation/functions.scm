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
    #:use-module (srfi srfi-1)
    #:use-module (ice-9 match)
)

;;Different modes of interactions

(define-public all-interactions '("binding" "reaction" "inhibition" "activation" "expression" "catalysis" "ptmod"))

(define-public symmetric-interactions '("binding" "reaction"))

(define (do-find-pathway/go-gene-interactors node)
   ;Find genes that interact with each other and are members of the same pathway/GO category

   (append-map (lambda (intr)
      (if (member intr symmetric-interactions)
         (run-query 
            (Bind 
               (VariableList
                  (TypedVariable (Variable "$g1") (Type 'GeneNode))
                  (TypedVariable (Variable "$g2") (Type 'GeneNode)))

               (And 
                  (Member (Variable "$g1") node)
                  (Member (Variable "$g2") node)
                  (Evaluation (Predicate intr)
                     (Set (Variable "$g1") (Variable "$g2"))))

               (Evaluation (Predicate intr)
                  (Set  (Variable "$g1") (Variable "$g2")))))
         (run-query 
            (Bind 
               (VariableList
                  (TypedVariable (Variable "$g1") (Type 'GeneNode))
                  (TypedVariable (Variable "$g2") (Type 'GeneNode)))

               (And 
                  (Member (Variable "$g1") node)
                  (Member (Variable "$g2") node)
                  (Evaluation (Predicate intr)
                     (List (Variable "$g1") (Variable "$g2"))))

               (Evaluation (Predicate intr)
                     (List (Variable "$g1") (Variable "$g2"))))))) all-interactions))

(define cache-pathway/go-gene-interactors (memoize-function-call do-find-pathway/go-gene-interactors))

(define-public (find-pathway/go-gene-interactors node) (cache-pathway/go-gene-interactors node))

(define (do-find-pathway/go-protein-interactors node)
   ;Find proteins that interact with each other and are members of the same pathway/GO category
   (append-map (lambda (intr)
      (if (member intr symmetric-interactions)
         (run-query 
            (Bind 
               (VariableList
                  (TypedVariable (Variable "$p1") (Type 'UniprotNode))
                  (TypedVariable (Variable "$p2") (Type 'UniprotNode)))

               (And 
                  (Member (Variable "$p1") node)
                  (Member (Variable "$p2") node)
                  (Evaluation (Predicate intr)
                     (Set (Variable "$p1") (Variable "$p2"))))
               (Evaluation (Predicate intr)
                     (Set  (Variable "$p1") (Variable "$p2")))))
         (run-query 
            (Bind 
               (VariableList
                  (TypedVariable (Variable "$p1") (Type 'UniprotNode))
                  (TypedVariable (Variable "$p2") (Type 'UniprotNode)))

               (And 
                  (Member (Variable "$p1") node)
                  (Member (Variable "$p2") node)
                  
                  (Evaluation (Predicate intr)
                     (List (Variable "$p1") (Variable "$p2"))))
               (Evaluation (Predicate intr)
                  (List (Variable "$p1") (Variable "$p2"))))))) all-interactions))

(define cache-pathway/go-protein-interactors (memoize-function-call do-find-pathway/go-protein-interactors))

(define-public (find-pathway/go-protein-interactors node) (cache-pathway/go-protein-interactors node))

;; ----------------------------------------------

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

;;Return all proteins expressed by a gene
(define (do-find-proteins gene)
   (run-query (Get
      (VariableList
         (TypedVariable (Variable "$p") (Type 'UniprotNode)))
      (Evaluation (Predicate "expresses") (List gene (Variable "$p")))))
)

(define-public find-proteins
   (memoize-function-call do-find-proteins)
)

;---------------------------------------------
;Given a protein find the gene that codes for that protein
(define (do-get-coding-gene prot)
   (run-query (Get (TypedVariable (Variable "$a") (Type "GeneNode"))
      (Evaluation (Predicate "expresses")
         (List (Variable "$a") prot))))
)

(define-public find-coding-gene (memoize-function-call do-get-coding-gene))

;; ------------------------------------------------------
;; Finds coding and non coding RNA for a given gene or protein

(define (do-get-crna gene)
   (run-query (Get
         (TypedVariable (Variable "$a") (TypeNode "EnstNode"))
         (Evaluation (Predicate "transcribed_to") (List gene (Variable "$a"))))))

(define (do-get-nc-rna gene)
   (run-query (Get
         (TypedVariable (Variable "$a") (TypeNode "RefseqNode"))
         (Evaluation (Predicate "translated_to") (List gene (Variable "$a"))))))

(define (do-get-crna-proteins prot)
	(run-query (Get
		(TypedVariable (Variable "$a") (TypeNode "EnstNode"))
		(Evaluation (Predicate "translated_to") (List (Variable "$a") prot)))))

(define (do-get-nc-rna-proteins prot)
   (run-query (Bind 
      (VariableList
       (TypedVariable (Variable "$a") (TypeNode "RefseqNode"))
       (TypedVariable (Variable "$g") (TypeNode "GeneNode")))
      (And 
         (Evaluation (Predicate "expresses")
            (List (Variable "$g") prot))
         (Evaluation (Predicate "translated_to") 
            (List (Variable "$g") (Variable "$a"))))
      (Evaluation (Predicate "translated_to") 
            (List (Variable "$g") (Variable "$a"))))))

(define cache-get-crna (memoize-function-call do-get-crna))

(define cache-get-nc-rna (memoize-function-call do-get-nc-rna))

(define cache-get-crna-proteins
	(memoize-function-call do-get-crna-proteins))

(define cache-get-nc-rna-proteins
	(memoize-function-call do-get-nc-rna-proteins))

(define-public (find-rna node do-coding do-noncoding)
"
  find-rna node do-coding do-noncoding do-protein
  node should be a UniprotNode
  do-coding do-noncoding should be #t or #f
"
   (define is-gene? (equal? (cog-type node) 'GeneNode))
   (let ((rnas (cond 
      ((and do-coding do-noncoding)
         (append (if is-gene? (cache-get-crna node) (cache-get-crna-proteins node)) (if is-gene? (cache-get-nc-rna node) (cache-get-nc-rna node))))
      (do-coding (if is-gene? (cache-get-crna node) (cache-get-crna-proteins node)))
      (do-noncoding (if is-gene? (cache-get-nc-rna node) (cache-get-nc-rna node)))
      (else '()))))
   
   (append-map (lambda (rna) (add-rna-info node rna)) rnas)))

(define (add-rna-info node rna)
      (match (cons (cog-type node) (cog-type rna))
         (('UniprotNode . 'EnstNode)
            (list (node-info rna)
               (Evaluation (Predicate "translated_to") (ListLink rna node))))
         (('GeneNode . 'EnstNode)
            (list (node-info rna)
               (Evaluation (Predicate "transcribed_to") (ListLink node rna node rna))))        
         (('UniprotNode . 'RefseqNode) (list rna (node-info (gddr rna))))
         (('GeneNode . 'RefseqNode) (list (node-info rna) 
               (Evaluation (Predicate "translated_to") (ListLink node rna))))))

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

(define* (add-go-info child-atom #:optional (parent-atom #f))
"
   Add information for GO nodes
"

   (if parent-atom
      (list
         (Inheritance child-atom parent-atom)
         (find-go-name parent-atom))
      (find-go-name child-atom)))

(define-public (find-parent node namespaces parents)
"
  Given an atom and list of namespaces, find the parents of that atom
  in the specified namespaces. The namespaces must be a list of strings.
"

   (define (find-parent-helper atom)

      ;; list of go-atoms that are parent of this go atom and are in the namespce specified by namespaces parameter
      (define go-list
         (append-map (lambda (ns-name) (run-query (Get
            (TypedVariable (Variable "$a") (ns->type ns-name))
            (And
               (Inheritance atom (Variable "$a")))))) namespaces))

      (flatten (filter-map
         (lambda (thing) (add-go-info atom thing))
         go-list)))

   
   ;; Return a list of the parents of things in `lst`.
   (define (find-parents lst)
      (append-map
         (lambda (item)
            ; Something is sending us a stray #f for soe reason...
            (if item (find-parent-helper (gdr (car (flatten item)))) '()))
         lst))

   ;; breadth-first, depth-recursive loop. This gets all parents
   ;; at depth `i` (thus, it's breadth-first) and then recurses
   ;; to the next depth.
   (let loop ((i parents)
               (lst (find-parent-helper node))
               (acc '()))
      (if (= i 0) acc
         (loop (- i 1) (find-parents lst) (append lst acc)))))

(define-public (find-memberln protein namespaces)
"
  Find GO terms of a protein.  `protein` must be a GeneNode and `namespaces`
  must be a list of strings.
"
   
   ;;list of go atoms that this protein is a member of
   (define go-list
      (append-map (lambda (ns-name) (run-query (Get
         (TypedVariable (Variable "$a") (ns->type ns-name))
         (And
            (Member protein (Variable "$a")))))) namespaces))

   (map (lambda (go) (list (Member protein go) (add-go-info go))) go-list)
)

(define-public (find-go-term prot namespaces num-parents regulates part-of bi-dir)
"
  The main function to find the go terms for a protein with a
  specification of the parents.
  `namespaces` should be a list of strings.
  `num-parents` should be a number, the number of parents to look up.
"
   

   ; res is list of the GO terms directly related to 
   ; the input protein (prot) that are members of the input namespaces
   (define res (find-memberln prot namespaces))
   (define all-parents (append-map (lambda (ls) (find-parent (gdr (car ls)) namespaces num-parents))  res))

   (append res all-parents))

(define-public (gene->protein gene chans)
  "Get proteins for each gene"
    (let ((prots (find-proteins gene)))
      (for-each (lambda (prot)
         (send-message (node-info prot) chans) 
        (send-message (Evaluation (Predicate "expresses") (List gene prot)) chans))  prots)
      prots))