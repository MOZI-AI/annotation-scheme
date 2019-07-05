;;; MOZI-AI Annotation Scheme
;;; Copyright © 2019 Abdulrahman Semrie
;;; Copyright © 2019 tanksha
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

(use-modules (srfi srfi-1)
             (ice-9 match))

(define (find-genes gene-list)
  "Validate if given gene strings in GENE-LIST exist in the
atomspace."
  (let ((unknown (filter (lambda (gene)
                           (null? (cog-node 'GeneNode gene)))
                         gene-list)))
    (match unknown
      (() "0")
      (_ (string-append "1:" (string-join unknown ","))))))

(define (gene-info genes)
  "Add the name and description of gene nodes to the given list of GENES."
  (let ((info
         (map (lambda (gene)
                (list (ListLink (node-info (GeneNode gene))
                                (ListLink (locate-node (GeneNode gene))))))
              genes)))
    (ListLink info)))

;; Map gene symbols into GeneNodes

(define (mapSymbol gene-list)
(let ([gene-nodes '()])
(for-each (lambda (g)
(set! gene-nodes (append gene-nodes (list (GeneNode g))))
) gene-list )
gene-nodes
))

(define nodes (make-parameter '()))
(define edges (make-parameter '()))
(define atoms (make-parameter '()))
(define genes (make-parameter '()))
(define pairs (make-parameter '()))
(define annotation (make-parameter '()))

(define (annotate-genes gene-list file-name annts-fns)
  (parameterize ( (nodes '()) 
                  (edges '()) 
                  (atoms '()) 
                  (genes gene-list)
                  (pairs '())
                  (annotation '())
              ) 
      (let* ([result (ListLink (force annts-fns))])
      (write-to-file result file-name)
      (scm->json-string (atomese-parser (format #f "~a" result)))
    )
  )

)







