;;; MOZI-AI Annotation Scheme
;;; Copyright © 2019 Abdulrahman Semrie
;;; Copyright © 2019 Hedra Seid
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

(define-module (annotation string)
    #:use-module (opencog)
    #:use-module (opencog bioscience)
    #:use-module (annotation string-helpers)
    #:use-module (srfi srfi-1)
    #:export (string-annotation)
)

(define* (string-annotation genes chan #:key 
                                        (proteins #f) 
                                        (interactions #f)
                                        (namespace "")
                                        (parents 0)
                                        (coding #f)
                                        (noncoding #f)
                                    )
    (for-each (lambda (gene) 
        (find-interaction (GeneNode gene) chan proteins interactions namespace parents coding noncoding)
        (find-output-interactions gene chan proteins interactions namespace parents coding noncoding)
    ) genes)
)