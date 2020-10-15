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
(define* (gene-pathway-annotation lst 
                                  chans
                                  #:key
                                  (pathway "reactome")
                                  (include_sm #t)
                                  (namespace "") (parents 0)
                                  (biogrid 0) (string #f)
                                  (regulates #f) (part-of #f) (bi-dir #f)
                                  (coding #f) (noncoding #f))

  (define namespaces (if (string-null? namespace) 
                          '()
                          (string-split namespace #\space)))

  (let* ([pathways (string-split pathway #\space)])

    (if (not (null? pathways))
      (begin 
        (send-message (ConceptNode "gene-pathway-annotation") chans)
        (for-each (lambda (pathway)
          (if (string=? pathway "smpdb")
            (smpdb lst chans include_sm namespaces parents regulates part-of bi-dir string coding noncoding))
          (if (string=? pathway "reactome")
            (reactome lst chans include_sm namespaces parents regulates part-of bi-dir string coding noncoding))) pathways)))))

(define (smpdb lst chans sm? namespaces num-parents regulates part-of bi-dir string coding-rna non-coding-rna)
"
  From SMPDB
"
  (for-each (lambda (pair) (for-each (lambda (prot) 
    (let* ([pw (find-pathway-member prot 'SmpNode)])

    (for-each (lambda (path)

      (send-message (list (Member prot path) (node-info path)) chans)

      (if sm? 
        (send-message (find-mol path 'ChebiNode) chans))

      (send-message (find-pathway-proteins path namespaces num-parents regulates  
         part-of bi-dir coding-rna non-coding-rna) chans)
          
      (if string 
        (send-message (find-pathway/go-protein-interactors path) chans))) pw))) (cdr pair)))  lst))

(define (reactome lst chans sm? namespaces num-parents regulates part-of bi-dir biogrid coding-rna non-coding-rna)
"
  From reactome
"
  (for-each (lambda (pair) (for-each (lambda (prot)
    (let* ([pw (find-pathway-member prot 'ReactomeNode)]
         [pwlst '()])
      
      (for-each  (lambda (path)
                  
        (send-message (list (Member prot path) (node-info path)) chans)

        (set! pwlst (append pwlst (list path)))

        (send-message
          (find-pathway-proteins path namespaces num-parents
                regulates part-of bi-dir coding-rna non-coding-rna) chans)
        
        (if string 
          (send-message (find-pathway/go-protein-interactors path) chans))

        (if sm? (send-message (find-mol path 'ChebiNode) chans))

        (send-message (pathway-hierarchy path pwlst) chans)) pw))) (cdr pair))) lst))
