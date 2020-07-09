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
    #:use-module (annotation functions)
    #:use-module (opencog)
    #:use-module (opencog bioscience)
    #:export (go-annotation)
)

(define* (go-annotation go-terms chans #:key (biogrid #f) (protein #t))
  (send-message (Concept "go-annotation") chans)

  (for-each
    (lambda (go-term)
      (let ((go-node (Concept go-term)))
        (send-message (find-go-name go-node) chans)
        (send-message (find-go-namespace go-node) chans)
        (send-message (find-go-genes go-node) chans)
        (send-message (find-go-parents go-node) chans)
        (send-message (find-go-has-part go-node) chans)
        (send-message (find-go-regulates go-node) chans)
        (if protein (send-message (find-go-proteins go-node) chans))
      )
    )
    go-terms
  )
)
