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

;; validates if given gene symbols exist in the atomspace

(define (find-genes gene-list)
(let ((val-msg "")
     (unknown '()))

(for-each (lambda(g)
    (if (equal? (cog-node 'GeneNode g) '())  
      (set! unknown (append unknown (list g)) )
    )
  ) gene-list)

(if (null? unknown )
    (set! val-msg "0")
    (set! val-msg (string-append "1:" (string-join unknown ",")))
)
val-msg ))


;; Adds the name and description of gene_nodes

(define (gene-info genes)
    (let ([info '()])
         (for-each (lambda (g)
              (set! info (append info (list (ListLink (node-info (GeneNode g)) (ListLink (locate-node (GeneNode g)))))))
         ) genes)
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







