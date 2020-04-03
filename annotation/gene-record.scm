;;; MOZI-AI Annotation Scheme
;;; Copyright © 2019 Abdulrahman Semrie
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

(define-module (annotation gene-record)
    #:use-module (rnrs records inspection)
    #:use-module (rnrs records syntactic)
    #:use-module (ice-9 match)
    #:export (make-gene
              make-gene-info 
              gene-record->scm
    )
)

(define-record-type gene
    (fields name 
            current
            similar
    )
)

(define-record-type gene-info
    (fields (mutable current)
            (mutable similar) 

    )
)

(define (gene-record->scm record)
    (define record->scm
        (match-lambda
            ((? gene? rec)
                `(("symbol" . ,(gene-name rec))
                  ("current" . ,(gene-current rec))
                  ("similar" . ,(list->vector (gene-similar rec)))
                )
            )
            (anything anything)
        )
    )
    (record->scm record)
)