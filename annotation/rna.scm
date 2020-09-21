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
	#:use-module (opencog exec)
	#:use-module (opencog bioscience)
	#:use-module (annotation parser)
	#:export (include-rna)
)

(define* (include-rna node chans #:key (coding #t) (noncoding #t))
"
  The include-rna function finds coding and non-coding RNA forms of
  the node. Needs 3 arguments:
  coding -> when True, includes the coding RNA's
  coding -> when True with protein True, includes the coding RNA's
            and corresponding coding proteins.
  non-coding -> when True includes the non-coding RNA's
"
	(send-message (Concept "rna-annotation") chans)
	(send-message (find-rna node coding noncoding) chans)
)
