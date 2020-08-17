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
            (Get 
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
   ;Find genes that interact with each other and are members of the same pathway/GO category
   (append-map (lambda (intr)
      (if (member intr symmetric-interactions)
         (run-query 
            (Bind 
               (VariableList
                  (TypedVariable (Variable "$p1") (Type 'MoleculeNode))
                  (TypedVariable (Variable "$p2") (Type 'MoleculeNode)))

               (And 
                  (Member (Variable "$p1") node)
                  (Member (Variable "$p2") node)
                  (Evaluation (Predicate intr)
                     (Set (Variable "$p1") (Variable "$p2"))))
               (Evaluation (Predicate intr)
                     (Set  (Variable "$p1") (Variable "$p2")))))
         (run-query 
            (Get 
               (VariableList
                  (TypedVariable (Variable "$p1") (Type 'MoleculeNode))
                  (TypedVariable (Variable "$p2") (Type 'MoleculeNode)))

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
   (run-query (Bind
      (VariableList
         (TypedVariable (Variable "$p") (Type 'UniprotNode)))
      (Evaluation (Predicate "expresses") (List gene (Variable "$p")))
      (VariableNode "$p")))
)

(define-public find-proteins
   (memoize-function-call do-find-proteins)
)

;; ------------------------------------------------------
;; Finds coding and non coding RNA for a given gene

(define (do-get-rna atom)
	(run-query (Get
		(TypedVariable (Variable "$a") (gdr atom))
		(Evaluation (Predicate "transcribed_to") (List (gar atom) (Variable "$a"))))))

(define cache-get-rna
	(memoize-function-call do-get-rna))

(define-public (find-rna gene do-coding do-noncoding do-protein)
"
  find-rna GENE do-coding do-noncoding do-protein
  GENE should be a GeneNode
  do-coding do-noncoding do-protein should be #t or #f
"
   (define type (cond 
         ((and do-coding do-noncoding) (TypeInh "RnaNode"))
         (do-coding (Type "EnstNode"))
         (do-noncoding (Type "RefseqNode"))
         (else #f)))
   (if type 
      (append-map
         (lambda (rna)
            (add-rna-info gene rna do-protein))
		   (cache-get-rna (List gene type)))
      '()
   )
)

(define (add-rna-info gene rna do-prot)
      (match (cons (cog-type rna) do-prot)
         (('EnstNode . #t) 
            (list (Evaluation (Predicate "transcribed_to") (List gene rna)) (node-info rna)
            (Evaluation (Predicate "translated_to")
                (ListLink rna (find-translates rna))) 
            (node-info (car (find-translates rna)))))
         
         ((or ('EnstNode . #f) ('RefseqNode . _)) (list (Evaluation (Predicate "transcribed_to") (List gene rna)) (node-info rna)))))    

(define (do-find-translates rna)
	(run-query (Get
		(TypedVariable (Variable "$a") (Type 'UniprotNode))
		(Evaluation (Predicate "translated_to")
			(List rna (Variable "$a"))))))

(define-public find-translates
	(memoize-function-call do-find-translates))