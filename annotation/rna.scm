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

(define-module (annotation rna)
	#:use-module (annotation functions)
	#:use-module (annotation util)
    #:use-module (opencog)
    #:use-module (opencog query)
    #:use-module (opencog exec)
    #:use-module (opencog bioscience)
	#:use-module (annotation parser)
    #:export (include-rna)
)
 
(define* (include-rna gene-list file-name #:key (coding "True") (noncoding "True") (protein "True"))
;;; 
;;; The include-rna function finds coding and non-coding RNA forms of the gene-list. needs 4 arguments to do so.
;;; file-name -> where to write the output file
;;; coding -> when True, includes the coding RNA's
;;; coding -> when True with protein True, includes the coding RNA's and crosponding coding proteins 
;;; non-coding -> when True includes the non-coding RNA's 

  (let* ((rna
    (map (lambda (gene)
    (ListLink
      (if (equal? coding "True")
        (list (cog-outgoing-set (find-crna (GeneNode gene) protein)))
        '())
      (if (equal? noncoding "True")
        (list (cog-outgoing-set (find-ncrna (GeneNode gene))))
        '()))
    )gene-list)
    ))
    (let (
    	[res (ListLink (ConceptNode "rna-annotation") (ListLink rna))]
  		)
    	(write-to-file res file-name "mainRNA")
		res
  	)
  )
)