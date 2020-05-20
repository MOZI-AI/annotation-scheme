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


(define-public (find-interaction gene chans interactions proteins namespace parents 
               coding non-coding)
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
         (for-each (lambda (res)
            (send-message res chans)
            (do-cross-annotation res chans proteins namespace parents coding non-coding)
         )        
            (append-map (lambda (prot) (cache-find-ggi (Set prot (List atoms)))) proteins))
        )
        (for-each (lambda (res)
         (send-message res chans)
         (do-cross-annotation res chans proteins namespace parents coding non-coding)
        ) (cache-find-ggi (Set gene (List atoms))))
      )  
   )
)

(define-public (find-output-interactions gene chans interactions proteins namespace parents coding non-coding)

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
      (for-each (lambda (res)
         (send-message res chans)
         (do-cross-annotation res chans proteins namespace parents coding non-coding)) output-interactors)
   )
)

(define (do-cross-annotation link out-chans protein namespace num-parent coding non-coding)
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
        [already-done-a ((biogrid-genes) gene-a)]
        [already-done-b ((biogrid-genes) gene-b)]
    )
        
        (if (not already-done-a)
            (send-message (node-info gene-a) out-chans)
        )

        (if (not already-done-b)
            (send-message (node-info gene-b) out-chans)
        )
        
        
        ;;go-cross annotation
        (if namespace
            (begin 
               (send-message (Concept "gene-go-annotation") out-chans)
               (send-message (find-go-term gene-a namespace num-parent) out-chans)
               (send-message (find-go-term gene-b namespace num-parent) out-chans)
               (send-message (Concept "string-annotation") out-chans)
            )

        )

        (if (or coding non-coding)
            (begin 
               (send-message (Concept "rna-annotation") out-chans)
               (send-message (find-rna gene-a coding non-coding protein) out-chans)
               (send-message (Concept "string-annotation") out-chans)
            )
        )
   ))



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