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
(define-module (annotation biogrid)
	#:use-module (annotation functions)
	#:use-module (annotation util)
    #:use-module (opencog)
    #:use-module (opencog query)
    #:use-module (opencog exec)
    #:use-module (opencog bioscience)
	#:use-module (annotation parser)
	#:use-module (ice-9 threads)
		#:export (biogrid-interaction-annotation)
)
(define* (biogrid-interaction-annotation gene-nodes interaction #:optional (namespace "") (parents 0) #:key (id ""))
  (let ([result '()]
        [go (if (string=? namespace "") (ListLink) 
                (ListLink (ConceptNode namespace) (Number parents)))])
	
	(for-each (lambda (gene)
		(if (equal? interaction "Proteins")
			(set! result (append result (match-gene-interactors (GeneNode gene) 0 go) 
				(match-gene-interactors (GeneNode gene)  1 go) (find-output-interactors (GeneNode gene) 1 go)))
		)

		(if (equal? interaction "Genes") 
			(begin
				(set! result (append result  (match-gene-interactors (GeneNode gene) 0 go) (find-output-interactors (GeneNode gene) 0 go)))
			)
		)
	) gene-nodes)

	 (let (
    	[res (ListLink (ConceptNode "biogrid-interaction-annotation") (ListLink result))]
  		)
    	(write-to-file res id "biogrid")
		res
  	)
))
