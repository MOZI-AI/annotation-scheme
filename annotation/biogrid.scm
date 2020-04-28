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

(define-module (annotation biogrid)
	#:use-module (annotation functions)
	#:use-module (annotation util)
	#:use-module (opencog)
	#:use-module (opencog exec)
	#:use-module (opencog bioscience)
	#:use-module (annotation parser)
    #:use-module (ice-9 match)
    #:use-module (srfi srfi-1)
	#:export (biogrid-interaction-annotation))

(define* (biogrid-interaction-annotation gene-nodes file-name
                                         #:key
                                         (interaction "Proteins")
                                         (namespace "")
                                         (parents 0)
                                         coding
                                         noncoding)
	(define namespaces
		(if (null? namespace) '() (string-split namespace #\ )))

  (let* ([rna (list (if coding (ConceptNode "coding") '())
                              (if noncoding (ConceptNode "noncoding") '()))]
         [result
          (append-map (lambda (gene)
            (match interaction
              ("Proteins"
               (append (match-gene-interactors (GeneNode gene)
                            #t namespaces parents coding noncoding)
                       (find-output-interactors (GeneNode gene)
                            #t namespaces parents coding noncoding)))
              ("Genes"
               (append rna
                       (match-gene-interactors (GeneNode gene)
                            #f namespaces parents coding noncoding)
                       (find-output-interactors (GeneNode gene)
                            #f namespaces parents coding noncoding)))))
          gene-nodes)]
         [res (ListLink (ConceptNode "biogrid-interaction-annotation")
                        (ListLink result))])
    (write-to-file res file-name "biogrid")
	res))
