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
    #:use-module (annotation util)
    #:use-module (annotation functions)
    #:use-module (annotation go-helpers)
    #:use-module (srfi srfi-1)
    #:use-module (ice-9 match)
)

(define-public (do-find-ppi input-set)
   (append-map (lambda (interaction)
      (if (member (cog-name interaction) symmetric-interactions)
         ;;symmetric - Use SetLink
         (run-query (Bind 
            (VariableList 
               (TypedVariable (Variable "$x") (Type (cog-type (car input-set)))))
            (Evaluation 
               (Predicate (cog-name interaction))
               (Set (gar input-set) (Variable "$x")))
            (Evaluation
               (Predicate (cog-name interaction))
               (Set (gar input-set) (Variable "$x")))))
         ;;not symmetric - Use ListLink
         (run-query (Bind 
            (VariableList 
               (TypedVariable (Variable "$x") (Type (cog-type (car input-set)))))
            (Evaluation 
               (Predicate (cog-name interaction))
               (List (gar input-set) (Variable "$x")))
            (Evaluation
               (Predicate (cog-name interaction))
               (List (gar input-set) (Variable "$x"))))))) (cog-outgoing-set (gdr input-set)))

)

(define-public cache-find-ppi
   (memoize-function-call do-find-ppi)
)

(define (do-get-output-interactors input-set)
   (append-map (lambda (intr)
      (if (member (cog-name intr) symmetric-interactions)
         (run-query (Bind
            (VariableList 
               (TypedVariable (Variable "$a") (Type (cog-type (car input-set))))
               (TypedVariable (Variable "$b") (Type (cog-type (car input-set)))))
            (And
               (Evaluation (Predicate intr)
                  (Set (gar input-set) (Variable "$a")))

               (Evaluation (Predicate intr)
                  (Set (Variable "$a") (Variable "$b")))

               (Evaluation (Predicate intr)
                  (Set (gar input-set) (Variable "$b"))))          
               (Evaluation (Predicate intr)
                  (Set (Variable "$a") (Variable "$b")))))
         (run-query (Bind
            (VariableList 
               (TypedVariable (Variable "$a") (Type (cog-type (car input-set))))
               (TypedVariable (Variable "$b") (Type (cog-type (car input-set)))))
            (And
               (Evaluation (Predicate intr)
                  (List (gar input-set) (Variable "$a")))

               (Evaluation (Predicate intr)
                  (List (Variable "$a") (Variable "$b")))

               (Evaluation (Predicate intr)
                  (List (gar input-set) (Variable "$b"))))          
               (Evaluation (Predicate intr)
                  (List (Variable "$a") (Variable "$b"))))))) (gdr input-set)))


(define-public (find-interaction prot interactions namespace parents regulates part-of bi-dir coding non-coding)
   ;;Find proteins that interact with the input protein. Optionally specify a filter list of the interactions
   (let (
      [atoms (if interactions (map (lambda (e) (Concept e)) interactions) 
               (map (lambda (e) (Concept e)) all-interactions))])
      
        (append-map (lambda (res) 
         (do-cross-annotation res namespace parents regulates part-of bi-dir coding non-coding)) (cache-find-ppi (List prot (List atoms))))))

(define-public (find-output-interactions prot interactions
    namespace parents regulates part-of bi-dir coding non-coding)



   (let ([output-interactors (if interactions (get-output-interactors interactions) (get-output-interactors all-interactions))])
      (append-map (lambda (res)
         (do-cross-annotation res namespace parents regulates part-of bi-dir coding non-coding)) output-interactors))
)

(define-public (do-cross-annotation link namespaces num-parents regulates part-of bi-dir coding-rna non-coding-rna)
    "
     do-cross-annotation -- add info about matched variable nodes
    `namespaces` should be a scheme list of strings (possibly an empty list),
     each string a namespace name.

    `num-parents` should be a number.

    `coding-rna` should be either #f or #t.
    `non-coding-rna` should be either #f or #t.
    "
    (let* (
        [prot-a (gadr link)]
        [prot-b (gddr link)]
        [already-done-a ((intr-genes) prot-a)]
        [already-done-b ((intr-genes) prot-b)]
        [already-done-pair ((gene-pairs) (List prot-a prot-b))])
        
        (cond 
          ((and (not already-done-a) (not already-done-b))
            (let ([go-cross-annotation
                    (if (null? namespaces) '()
                        (list
                           (Concept "gene-go-annotation")
                           (find-go-term prot-a namespaces num-parents regulates part-of bi-dir)
                           (find-go-term prot-b namespaces num-parents regulates part-of bi-dir)
                           (Concept "string-interaction-annotation")))]
                    [rna-cross-annotation
                      (if (or coding-rna non-coding-rna)
                        (list
                            (Concept "rna-annotation")
                            (find-rna prot-a coding-rna non-coding-rna)
                            (find-rna prot-b coding-rna non-coding-rna)
                            (Concept "string-interaction-annotation"))
                          '())])
                  (append (list link (node-info prot-a) (node-info prot-b))
                     go-cross-annotation rna-cross-annotation)))
            
            ((or (not already-done-a) (not already-done-b))
              (let* ([prot-x (if already-done-a prot-b prot-a)]
                    [go-cross-annotation
                     (if (null? namespaces) '()
                        (list
                           (Concept "gene-go-annotation")
                           (find-go-term prot-x namespaces num-parents regulates part-of bi-dir)
                           (Concept "string-interaction-annotation")))]
                    [rna-cross-annotation
                     (if (or coding-rna non-coding-rna)
                        (list
                           (Concept "rna-annotation")
                           (find-rna prot-x coding-rna non-coding-rna)
                           (Concept "string-interaction-annotation"))
                        '())])
                  (append (list link (node-info prot-x)) go-cross-annotation rna-cross-annotation)))
            (else (if (not already-done-pair) (list link) '())))))