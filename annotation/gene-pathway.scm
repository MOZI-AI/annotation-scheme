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
      #:use-module (annotation util)
      #:use-module (annotation functions)
      #:use-module (annotation string-helpers)
      #:use-module (annotation pathway-helpers)
      #:use-module (annotation biogrid-helpers)
      #:use-module (opencog)
      #:use-module (opencog exec)
      #:use-module (opencog bioscience)
      #:use-module (srfi srfi-1)
      #:use-module (ice-9 match)
      #:export (gene-pathway-annotation))

;; TODO: would be better to use a list for the "pathway" argument
;; instead of splitting a string.
(define* (gene-pathway-annotation node 
                                  chans
                                  #:key
                                  (pathway "reactome")
                                  (include_sm #t) (gene-level? #f)
                                  (namespace "") (parents 0)
                                  (biogrid #f) (string #f)
                                  (regulates #f) (part-of #f) (bi-dir #f)
                                  (coding #f) (noncoding #f))

  (define namespaces (str->list namespace))

  (let* ([pathways (str->list pathway)])

    (if (not (null? pathways))
      (begin 
        (send-message (ConceptNode "gene-pathway-annotation") chans)
        (for-each (lambda (pathway)
          (let ((pathway-type (if (string=? pathway "reactome") 'ReactomeNode 'SmpNode)))
            (match (cons (cog-type node) gene-level?)
            (('GeneNode . #f)
                (let ((prots (gene->protein node chans)))
                    (for-each (lambda (prot) 
                      (annotate-pathways prot chans pathway-type include_sm #f namespaces parents regulates part-of bi-dir string coding noncoding)) prots)))
            (('GeneNode . #t)
                (annotate-pathways node chans pathway-type include_sm #t namespaces parents regulates part-of bi-dir string coding noncoding))
            (('UniprotNode . _)
                (annotate-pathways node chans pathway-type include_sm #f namespaces parents regulates part-of bi-dir string coding noncoding))))) pathways)))))


(define (annotate-pathways node chans pathway-type sm? gene-level? namespaces num-parents regulates part-of bi-dir biogrid coding-rna non-coding-rna)

  (let* ([pw (find-pathway-member node pathway-type)])

    (for-each (lambda (path)

      (send-message (list (Member node path) (node-info path)) chans)

      (if sm? 
        (send-message (find-mol path 'ChebiNode) chans))

      (if gene-level?
        (send-message (find-pathway-genes path namespaces num-parents regulates  
          part-of bi-dir coding-rna non-coding-rna) chans)
         (send-message (find-pathway-proteins path namespaces num-parents regulates  
           part-of bi-dir coding-rna non-coding-rna) chans)
      )
     
      (if string 
        (if gene-level?
          (send-message (find-pathway/go-gene-interactors path) chans)
          (send-message (find-pathway/go-protein-interactors path) chans)))) pw))
)