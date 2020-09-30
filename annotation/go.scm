;;; MOZI-AI Annotation Scheme
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

(define-module (annotation go)
    #:use-module (annotation go-helpers)
    #:use-module (annotation util)
    #:use-module (annotation functions)
    #:use-module (opencog)
    #:use-module (opencog bioscience)
    #:export (go-annotation)
)

(define* (go-annotation go-node chans #:key (string #t) (protein #t)
                (namespace "biological_process molecular_function cellular_component") 
                (parents 1))

  (define namespaces (str->list namespace))
  (send-message (Concept "go-annotation") chans)

  (let ()
    (send-message (find-go-name go-node) chans)
    (send-message (find-go-plus go-node) chans)
    (send-message (find-parent go-node namespaces parents) chans)
    (if protein 
        (send-message (find-go-proteins go-node string) chans))))
