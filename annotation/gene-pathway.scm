;;; MOZI-AI Annotation Scheme
;;; Copyright © 2019 Abdulrahman Semrie
;;; Copyright © 2019 Hedra Seid
;;; Copyright © 2020 Ricardo Wurmus
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

(define-module (annotation gene-pathway)
      #:use-module (annotation functions)
      #:use-module (annotation util)
      #:use-module (opencog)
      #:use-module (opencog exec)
      #:use-module (opencog bioscience)
      #:use-module (annotation parser)
      #:use-module (srfi srfi-1)
      #:use-module (ice-9 match)
      #:export (gene-pathway-annotation))

(include-from-path "annotation/instrumentation.scm")

(define-public gene-path-anno-ctr (accum-time "gene-path-anno"))
(define-public gene-path-write-ctr (accum-time "gene-path-write"))
(define-public reactome-ctr (accum-time "reactome"))
(define-public smpdb-ctr (accum-time "smpdb"))

;; TODO: would be better to use a list for the "pathway" argument
;; instead of splitting a string.
;; TODO: don't use the string "True" for include_prot and include_sm.
(define* (gene-pathway-annotation gene-nodes file-name
                                  #:key
                                  (pathway "reactome")
                                  (include_prot "True")
                                  (include_sm "True")
                                  (namespace "")
                                  (parents 0)
                                  (biogrid 1)
                                  coding
                                  noncoding)

(gene-path-anno-ctr #:enter? #t)
  (let* ([pwlst '()]
         [prot? (string=? include_prot "True")]
         [sm? (string=? include_sm "True")]
         [pathways (string-split pathway #\space)]
         [result
          (append-map (lambda (gene)
                        (append 
                         (node-info (GeneNode gene))
                         (append-map (match-lambda
                                       ("smpdb"
                                        (smpdb gene prot? sm? namespace parents biogrid coding noncoding))
                                       ("reactome"
                                        (match (reactome gene prot? sm? pwlst namespace parents biogrid coding noncoding)
                                          ((first . rest)
                                           (set! pwlst (append pwlst rest))
                                           first))))
                                     pathways)))
                      gene-nodes)]
         [res (ListLink (ConceptNode "gene-pathway-annotation")
                        (ListLink result))])
(gene-path-anno-ctr #:enter? #f)
(gene-path-write-ctr #:enter? #t)
    (write-to-file res file-name "gene-pathway")
(gene-path-write-ctr #:enter? #f)
    res))

(define (smpdb gene prot? sm? namespaces num-parents biogrid coding-rna non-coding-rna)
"
  From SMPDB
"
	(define namespace-list (string-split namespaces #\space))
(smpdb-ctr #:enter? #t)

  (let* ([pw (find-pathway-member (GeneNode gene) "SMP")]
         [ls (append-map (lambda (path)
                           (let ([node (cog-outgoing-atom (cog-outgoing-atom path 0) 1)])
                             (append
                              (if sm? (find-mol node "ChEBI") '())
                              (find-pathway-genes node namespace-list num-parents
                                      coding-rna non-coding-rna prot?)
                              (if prot?
                                  (let ([prots (find-mol node "Uniprot")])
                                    (if (null? prots)
                                        (node-info node)
                                        prots))
                                  '())
                              (if (= biogrid 1)
                                  (pathway-gene-interactors node)
                                  '()))))
                         pw)])
(smpdb-ctr #:enter? #f)
    (append pw
            ;; when proteins are selected, genes should only be linked to
            ;; proteins not to pathways
            (if prot? (find-protein (GeneNode gene) 0) '())
            ls)))

(define (reactome gene prot? sm? pwlst namespaces num-parents biogrid coding-rna non-coding-rna)
"
  From reactome
"
	(define namespace-list (string-split namespaces #\space))

(reactome-ctr #:enter? #t)
  (let* ([pw (find-pathway-member (GeneNode gene) "R-HSA")]
         [ls (append-map (lambda (path)
                           (let ([node (cog-outgoing-atom (cog-outgoing-atom path 0) 1)])
                             (set! pwlst (append pwlst (list node)))

                             (append
                              (find-pathway-genes node namespace-list num-parents
                                      coding-rna non-coding-rna prot?)
                              (if prot?
                                  (let ([prots (find-mol node "Uniprot")])
                                    (if (null? prots)
                                        (node-info node)
                                        prots)))
                              (if (= biogrid 1)
                                  (pathway-gene-interactors node)
                                  '())
                              (if sm? (find-mol node "ChEBI") '())
                              (list (pathway-hierarchy node pwlst)))))
                         pw)])
(reactome-ctr #:enter? #f)
    (list (append pw
                  (if prot? (find-protein (GeneNode gene) 1) '())
                  ls)
          pwlst)))
