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
      #:use-module (annotation biogrid-helpers)
	#:use-module (opencog)
	#:use-module (opencog exec)
	#:use-module (opencog bioscience)
	#:use-module (annotation parser)
      #:use-module (ice-9 match)
      #:use-module (srfi srfi-1)
	#:export (biogrid-interaction-annotation))

(define* (biogrid-interaction-annotation node
                                         chans
                                         #:key
                                         (namespace "")
                                         (parents 0)
                                         (regulates #f) (part-of #f) (bi-dir #f)
                                         (coding #f)
                                         (noncoding #f)
                                         (exclude-orgs ""))
	(define namespaces (str->list namespace))

    (define exclude-taxonomies 
          (if (number? exclude-orgs) (list (number->string exclude-orgs)) '()))

     (send-message (Concept "biogrid-interaction-annotation") chans)

        (send-message (match-gene-interactors node exclude-taxonomies) chans)
        (send-message (find-output-interactors node exclude-taxonomies) chans))
