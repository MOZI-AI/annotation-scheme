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

(define-module (annotation gene-go)
    #:use-module (annotation functions)
    #:use-module (annotation util)
    #:use-module (opencog)
    #:use-module (opencog exec)
    #:use-module (opencog bioscience)
    #:use-module (annotation parser)
    #:export (gene-go-annotation)
)

(include-from-path "annotation/instrumentation.scm")

(define-public gene-go-anno-ctr (accum-time "gene-go-anno"))
(define-public gene-go-write-ctr (accum-time "gene-go-write"))

(define* (gene-go-annotation gene-nodes file-name #:key (namespace "biological_process molecular_function cellular_component") (parents 0) (protein "True"))
(gene-go-anno-ctr #:enter? #t)
    (let (
        [result (flatten (map (lambda (gene) 
          (if (equal? protein "True")
            (ListLink
              (find-go-term (GeneNode gene) (string-split namespace #\ ) parents)
              (find-proteins-goterm (GeneNode gene) (string-split namespace #\ ) parents)
            )
            (find-go-term (GeneNode gene) (string-split namespace #\ ) parents)
          )
          )gene-nodes))]
          )
(gene-go-anno-ctr #:enter? #f)
(gene-go-write-ctr #:enter? #t)
    (let (
    	[res (ListLink (ConceptNode "gene-go-annotation") (ListLink result))]
  		)
    	(write-to-file res file-name "gene-go")
(gene-go-write-ctr #:enter? #f)
      res
  	)
  )
)
