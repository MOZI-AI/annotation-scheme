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

(define-module (annotation string-helpers)
    #:use-module (opencog)
    #:use-module (opencog exec)
    #:use-module (opencog bioscience)
    #:use-module (annotation functions)
    #:use-module (annotation util)
    #:use-module (srfi srfi-1)
    #:use-module (ice-9 match)
    #:use-module (fibers channels)
)


;;Different modes of interactions

(define all-interactions '("binding" "reaction" "inhibition" "activation" "expression" "catalysis" "ptmod"))

(define symmetric-interactions '("binding" "reaction"))

(define-public (do-find-ggi input-set)
   (append-map (lambda (interaction)
      (if (member (cog-name interaction) symmetric-interactions)
         ;;symmetric - Use SetLink
         (run-query (Bind 
            (Evaluation 
               (Predicate (cog-name interaction))
               (Set
                  (gar input-set)
                  (Variable "$x")
               )
            )
            (Evaluation
               (Predicate (cog-name interaction))
               (Set (gar input-set) (Variable "$x"))
            )
         ))
         ;;not symmetric - Use ListLink
         (run-query (Bind 
            (Evaluation 
               (Predicate (cog-name interaction))
               (List
                  (gar input-set)
                  (Variable "$x")
               ))
            (Evaluation
               (Predicate (cog-name interaction))
               (List (gar input-set) (Variable "$x"))
            )
         ))
      )
   ) (cog-outgoing-set (gdr input-set)))

)

(define-public cache-find-ggi
   (memoize-function-call do-find-ggi)
)


(define-public (find-interaction gene interactions proteins
                  namespace parents regulates part-of bi-dir coding non-coding)
   ;;Find Genes that interact with the input gene. Optionally specify a filter list of the interactions
   ;;If proteins option is true do a Protein-Protein interaction
   (let (
      [atoms (if interactions (map (lambda (e) (Concept e)) interactions) 
               (map (lambda (e) (Concept e)) all-interactions))]
   )
      (if proteins
        (let (
            [proteins (find-proteins gene)]
        )
         (append-map (lambda (res)
            (do-cross-annotation res proteins namespace parents regulates part-of bi-dir coding non-coding)
         )        
            (append-map (lambda (prot) (cache-find-ggi (Set prot (List atoms)))) proteins))
        )
        (append-map (lambda (res)
         (do-cross-annotation res proteins 
               namespace parents regulates part-of bi-dir coding non-coding)
        ) (cache-find-ggi (Set gene (List atoms))))
      )  
   )
)

(define-public (find-output-interactions gene interactions proteins
    namespace parents regulates part-of bi-dir coding non-coding)

   (define (get-output-interactors intrs)
      (append-map (lambda (intr)
         (run-query (Bind
			(VariableList
				(TypedVariable (Variable "$a") (Type 'GeneNode))
				(TypedVariable (Variable "$b") (Type 'GeneNode)))

			(And
				(Evaluation (Predicate intr)
					(Set gene (Variable "$a")))

				(Evaluation (Predicate intr)
					(Set (Variable "$a") (Variable "$b")))

				(Evaluation (Predicate intr)
					(Set gene (Variable "$b")))
			)          
            (Evaluation (Predicate intr)
                (Set (Variable "$a") (Variable "$b")     
            )))
      )) intrs)
   )

   (let ([output-interactors (if interactions (get-output-interactors interactions) (get-output-interactors all-interactions))])
      (append-map (lambda (res)
         (do-cross-annotation res proteins 
               namespace parents regulates part-of bi-dir coding non-coding)) output-interactors)
   )
)

(define (do-cross-annotation link do-protein
             namespaces num-parents regulates part-of bi-dir coding-rna non-coding-rna)
    "
     do-cross-annotation -- add info about matched variable nodes
    `namespaces` should be a scheme list of strings (possibly an empty list),
     each string a namespace name.

    `num-parents` should be a number.

    `coding-rna` should be either #f or #t.
    `non-coding-rna` should be either #f or #t.
    "
    (let* (
        [gene-a (gadr link)]
        [gene-b (gddr link)]
        [already-done-a ((intr-genes) gene-a)]
        [already-done-b ((intr-genes) gene-b)]
        [already-done-pair ((gene-pairs) (List gene-a gene-b))])
        
        (cond 
          ((and (not already-done-a) (not already-done-b))
            (let ([go-cross-annotation
                    (if (null? namespaces) '()
                        (list
                           (Concept "gene-go-annotation")
                           (find-go-term gene-a namespaces num-parents regulates part-of bi-dir)
                           (find-go-term gene-b namespaces num-parents regulates part-of bi-dir)
                           (Concept "biogrid-interaction-annotation"))
                    )]
                    [rna-cross-annotation
                      (if (or coding-rna non-coding-rna)
                        (list
                            (Concept "rna-annotation")
                            (find-rna gene-a coding-rna non-coding-rna do-protein)
                            (find-rna gene-b coding-rna non-coding-rna do-protein)
                            (Concept "biogrid-interaction-annotation"))
                          '()     
                      )])
                    (append (list link (node-info gene-a) (node-info gene-b))
                      go-cross-annotation rna-cross-annotation)))
            ((or (not already-done-a) (not already-done-b)
              (let* ([gene-x (if already-done-a gene-b gene-a)]
                    [go-cross-annotation
                     (if (null? namespaces) '()
                        (list
                           (Concept "gene-go-annotation")
                           (find-go-term gene-x namespaces num-parents regulates part-of bi-dir)
                           (Concept "biogrid-interaction-annotation"))
                     )]
                    [rna-cross-annotation
                     (if (or coding-rna non-coding-rna)
                        (list
                           (Concept "rna-annotation")
                           (find-rna gene-x coding-rna non-coding-rna do-protein)
                           (Concept "biogrid-interaction-annotation"))
                        '()
                    )])
                    (append (list link (node-info gene-x)) go-cross-annotation rna-cross-annotation))))
            (else (if (not already-done-pair) (list link))))))



(define (do-find-pathway-gene-interactors pathway)
   (append-map (lambda (intr)
      (if (member intr symmetric-interactions)
         (run-query 
            (Bind 
               (VariableList
                  (TypedVariable (Variable "$g1") (Type 'GeneNode))
                  (TypedVariable (Variable "$g2") (Type 'GeneNode)))

               (And 
                  (Member (Variable "$g1") pathway)
                  (Member (Variable "$g2") pathway)
                  (Evaluation (Predicate intr)
                     (Set 
                        (Variable "$g1")
                        (Variable "$g2")
                     )
                  )
               )

               (Evaluation (Predicate intr)
                     (Set 
                        (Variable "$g1")
                        (Variable "$g2")
                     )
                  )
            )
         )
         (run-query 
            (Get 
               (VariableList
                  (TypedVariable (Variable "$g1") (Type 'GeneNode))
                  (TypedVariable (Variable "$g2") (Type 'GeneNode)))

               (And 
                  (Member (Variable "$g1") pathway)
                  (Member (Variable "$g2") pathway)
                  (Evaluation (Predicate intr)
                     (List 
                        (Variable "$g1")
                        (Variable "$g2")
                     )
                  )
               )

               (Evaluation (Predicate intr)
                     (List 
                        (Variable "$g1")
                        (Variable "$g2")
                     )
               )
            )
         )
      )
   
   ) all-interactions)
)

(define cache-pathway-gene-interactors (memoize-function-call do-find-pathway-gene-interactors))

(define-public (find-pathway-gene-interactors pathway) (cache-pathway-gene-interactors pathway))

(define (do-find-pathway-protein-interactors pathway)
   (append-map (lambda (intr)
      (if (member intr symmetric-interactions)
         (run-query 
            (Bind 
               (VariableList
                  (TypedVariable (Variable "$p1") (Type 'MoleculeNode))
                  (TypedVariable (Variable "$p2") (Type 'MoleculeNode)))

               (And 
                  (Member (Variable "$p1") pathway)
                  (Member (Variable "$p2") pathway)
                  (Evaluation (Predicate intr)
                     (Set 
                        (Variable "$p1")
                        (Variable "$p2")
                     )
                  )
               )
               (Evaluation (Predicate intr)
                     (Set 
                        (Variable "$p1")
                        (Variable "$p2")
                     )
                  )
            )
         )
         (run-query 
            (Get 
               (VariableList
                  (TypedVariable (Variable "$p1") (Type 'MoleculeNode))
                  (TypedVariable (Variable "$p2") (Type 'MoleculeNode)))

               (And 
                  (Member (Variable "$p1") pathway)
                  (Member (Variable "$p2") pathway)
                  
                  (Evaluation (Predicate intr)
                     (List 
                        (Variable "$p1")
                        (Variable "$p2")
                     )
                  )      
               )
               (Evaluation (Predicate intr)
                  (List 
                     (Variable "$p1")
                     (Variable "$p2")
                  )
               )
            )
         )
      )
   
   ) all-interactions)
)

(define cache-pathway-protein-interactors (memoize-function-call do-find-pathway-protein-interactors))

(define-public (find-pathway-protein-interactors pathway) (cache-pathway-protein-interactors pathway))