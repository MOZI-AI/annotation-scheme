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
  (let* ([pwlst '()]
         [pathways (string-split pathway #\space)]
         [go (if (string-null? namespace)
                 (ListLink)
                 (ListLink (ConceptNode namespace) (Number parents)))]
         [rna (ListLink (list (if coding (ConceptNode coding) '())
                              (if noncoding (ConceptNode noncoding) '())))]
         [result
          (append-map (lambda (gene)
                        (append 
                         (node-info (GeneNode gene))
                         (append-map (match-lambda
                                       ("smpdb"
                                        (smpdb gene include_prot include_sm go biogrid rna))
                                       ("reactome"
                                        (match (reactome gene include_prot include_sm pwlst go biogrid rna)
                                          ((first . rest)
                                           (set! pwlst (append pwlst rest))
                                           first))))
                                     pathways)))
                      gene-nodes)]
         [res (ListLink (ConceptNode "gene-pathway-annotation")
                        (ListLink result))])
    (write-to-file res file-name "gene-pathway")
    res))

;; From SMPDB
(define (smpdb gene prot sm go biogrid rna)
  (let* ([prot? (string=? prot "True")]
         [sm? (string=? sm "True")]
         [pw (find-pathway-member (GeneNode gene) "SMP")]
         [ls (append-map (lambda (path)
                           (let ([node (cog-outgoing-atom (cog-outgoing-atom path 0) 1)])
                             (append
                              (if sm? (find-mol node "ChEBI") '())
                              (find-pathway-genes node go rna prot)
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
    (append pw
            ;; when proteins are selected, genes should only be linked to
            ;; proteins not to pathways
            (if prot? (find-protein (GeneNode gene) 0) '())
            ls)))

;; From reactome

(define (reactome gene prot sm pwlst go biogrid rna)
    (let (
      [pw (find-pathway-member (GeneNode gene) "R-HSA")]
      [ls '()]
      )

      (set! ls (flatten (map (lambda (path)
        (let (
            [node (cog-outgoing-atom (cog-outgoing-atom path 0) 1)]
            [tmp '()]
        )
          (set! pwlst (append pwlst (list node)))
          (set! tmp (append tmp (find-pathway-genes node go rna prot)))
          (if (equal? prot "True")
            (let ([prots (find-mol node "Uniprot")])
              (if (not (null? prots))
                (set! tmp (append tmp prots))
                (set! tmp (append tmp (node-info node)))))
            )
          (if (= biogrid 1)
            (set! tmp (append tmp (pathway-gene-interactors node))))
          (if (equal? sm "True")
            (set! tmp (append tmp (find-mol node "ChEBI")))
          )
          (set! tmp (append tmp (list (pathway-hierarchy node pwlst))))
          (if (null? tmp)
            '()
            tmp
          )
        )
      )
      pw)))

    (if (equal? prot "True")
    (set! pw (append pw (find-protein (GeneNode gene) 1)))
    )
      (list (append pw ls) pwlst)
  ))
