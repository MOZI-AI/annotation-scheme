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
(define* (gene-pathway-annotation gene-nodes 
                                  chans
                                  #:key
                                  (pathway "reactome")
                                  (include_prot #t)
                                  (include_sm #t)
                                  (namespace "")
                                  (parents 0)
                                  (biogrid #f)
                                  (coding #f)
                                  (noncoding #f))

  (define namespaces (if (string-null? namespace) 
                            '()
                            (string-split namespace #\space)))

  (let* (
         [pathways (string-split pathway #\space)])

        (if (not (null? pathways))
          (send-message (ConceptNode "gene-pathway-annotation") chans)

          (for-each (lambda (gene)
                          (for-each (lambda (pathway) 
                          
                            (if (string=? pathway "smpdb")
                              (smpdb gene chans include_prot include_sm namespaces parents biogrid coding noncoding)
                            )
                            (if (string=? pathway "reactome")
                                (reactome gene chans include_prot include_sm namespaces parents biogrid coding noncoding)
                            )) pathways))
                      gene-nodes)
        )              
    
  ))

(define (smpdb gene chans prot? sm? namespaces num-parents biogrid coding-rna non-coding-rna)
"
  From SMPDB
"

  (let* ([pw (find-pathway-member (GeneNode gene) "SMP")])


         (for-each (lambda (path)

                  (send-message (list (Member (Gene gene) path) (node-info path)) chans)

                  (if sm? 
                    (send-message (find-mol path "ChEBI") chans))

                  (send-message (find-pathway-genes path namespaces num-parents coding-rna non-coding-rna prot?) chans)
                  (if prot?
                      (let ([prots (find-mol path "Uniprot")])
                        (if (null? prots)
                            (send-message prots chans))))
                  
                  (if biogrid
                      (send-message (pathway-gene-interactors path) chans)))  pw)

          (if prot? 
            (send-message (find-protein (GeneNode gene) 0) chans))      

    )
)

(define (reactome gene chans prot? sm? namespaces num-parents biogrid coding-rna non-coding-rna)
"
  From reactome
"

  (let* ([pw (find-pathway-member (GeneNode gene) "R-HSA")]
         [pwlst '()]
        )
      
      (for-each  (lambda (path)
                  
                        (send-message (list (Member (Gene gene) path) (node-info path)) chans)

                        (set! pwlst (append pwlst (list path)))

                      (send-message
                        (find-pathway-genes path namespaces num-parents
                              coding-rna non-coding-rna prot?) chans)
                      (if prot?
                          (let ([prots (find-mol path"Uniprot")])
                            (if (null? prots)
                                (send-message prots chans)))
                      )
                      (if biogrid
                          (send-message (pathway-gene-interactors path) chans )
                      )

                      (if sm? (send-message (find-mol path"ChEBI") chans))

                      (send-message (pathway-hierarchy path pwlst) chans)) pw)


      (if prot? 
          (send-message (find-protein (GeneNode gene) 1) chans))
))