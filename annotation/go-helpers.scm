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
    #:export (find-go-plus)
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

(define-public (find-drugs-protein prot namespace)
"
  find-drugs-protein Protein NAMESPACE

  Find the drugs associated with the proteins expressed by Protein in GO terms under NAMESPACE.
"
  
   (append-map
        (lambda (ns)
          (run-query
            (Bind
              (VariableSet
                (TypedVariable (Variable "$go-term") (ns->type ns))
                (TypedVariable (Variable "$drug-action") (Type "PredicateNode"))
                (TypedVariable (Variable "$drug") (Type "MoleculeNode"))
                (TypedVariable (Variable "$drug-group") (Type "ConceptNode")))
              (And
                (Member prot (Variable "$go-term"))
                (Evaluation (Variable "$drug-action") (List (Variable "$drug") prot))
                (Inheritance (Variable "$drug") (Variable "$drug-group"))
                (Inheritance
                  (Variable "$drug-group")
                  (Concept "drug")))
              (Evaluation
                (Variable "$drug-action")
                (List (Variable "$drug") prot))))) namespace))

; --------------------------------------------------
(define-public (find-go-genes go-term string?)
"
  find-go-gene GO-TERM STRING?

  Find the genes associate with GO-TERM via a MemberLink.
  If STRING? is true, the gene-gene interaction from
  the STRING database will also be included.
"
   (define genes (append-map (lambda (ln)
      (list ln (node-info (gar ln)))) 
      (run-query
         (Bind
            (TypedVariable (Variable "$gene") (Type "GeneNode"))
            (Member (Variable "$gene") go-term)
            (Member (Variable "$gene") go-term)))))
   (if string? 
      (append genes (find-pathway/go-gene-interactors go-term))
      genes))

(define-public (find-go-proteins go-term string?)
"
  find-go-protein GO-TERM

  Find the proteins associate with GO-TERM via a MemberLink.
"

  (define proteins (append-map (lambda (ln)
      (list ln (node-info (gar ln)))) 
      (run-query
         (Bind
            (TypedVariable (Variable "$prot") (Type 'UniprotNode))
            (Member (Variable "$prot") go-term)
            (Member (Variable "$prot") go-term)))))
   (if string? 
      (append proteins (find-pathway/go-protein-interactors go-term))
      proteins))

(define-public (find-go-parents go-term)
"
  find-go-parents GO-TERM

  Find the parent GO terms of GO-TERM via an InheritanceLink.
"
  (append-map (lambda (ln) 
    (list ln (find-go-name (gdr ln)))) (run-query (Bind 
         (Inheritance go-term (Variable "$par"))
         (Inheritance go-term (Variable "$par"))))))

;; =========================== GO Plus Chebi ==============================
(define chebi-rlns '("has_part" "has_role"))

(define (do-find-mol-go-plus mol)
   (let* (
      [chebis (append-map (lambda (rln)
         (run-query (Bind 
                        (Evaluation
                           (Predicate rln)
                           (ListLink mol (Variable "$mol")))
                        (Evaluation
                           (Predicate rln)
                           (ListLink mol (Variable "$mol"))))))  chebi-rlns)]

      [parents (run-query (Bind 
             ;; FIXME Add a specific type to GOCHEs instead of ConceptNode
             (VariableList (TypedVariable (Variable "$par") (TypeChoice (Type 'ConceptNode) (Type 'ChebiOntologyNode))))
             (Inheritance mol (Variable "$par"))
             (Inheritance mol (Variable "$par"))))]) 

      (append chebis parents))
)

(define-public find-mol-go-plus
   (memoize-function-call do-find-mol-go-plus)
)