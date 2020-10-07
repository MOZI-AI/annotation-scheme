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
    #:use-module (annotation util)
    #:use-module (annotation functions)
    #:use-module (annotation string-helpers)
    #:use-module (srfi srfi-1)
    #:use-module (ice-9 match)
    #:use-module (fibers channels)
    #:export (string-interaction-annotation)
)

(define* (string-interaction-annotation node chans #:key 
                                        (interactions #f)
                                        (gene-level? #f)
                                        (namespace "")
                                        (parents 0)
                                        (regulates #f) (part-of #f) (bi-dir #f)
                                        (coding #f)
                                        (noncoding #f)
                                    )
    
    (define namespaces (str->list namespace))

    (define interaction-lst (if interactions (str->list interactions) #f))

    (send-message (Concept "string-interaction-annotation") chans)
    (send-message (find-interaction node interaction-lst
        namespaces parents regulates part-of bi-dir coding noncoding) chans)
    (send-message (find-output-interactions node interaction-lst namespaces parents regulates part-of bi-dir coding noncoding) chans)
)