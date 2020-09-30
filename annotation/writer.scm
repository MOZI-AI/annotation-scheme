;;; MOZI-AI Annotation Scheme
;;; Copyright © 2020 Abdulrahman Semrie
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

(define-module (annotation writer)
    #:use-module (opencog)
    #:use-module (opencog exec)
    #:use-module (opencog bioscience)
    #:use-module (ice-9 suspendable-ports)
    #:use-module (ice-9 textual-ports)
    #:use-module (fibers channels)
    #:use-module (fibers conditions)
)

(install-suspendable-ports!)

(define-public (output-to-file proc port cond)
    (let loop (
      (msg (proc))
   )
    (if (equal? msg 'eof)
      (begin (force-output port)
          (close-port port)
          (signal-condition! cond)
      )
      (begin 
         (write msg port)
         (loop (proc))
      )
    )
))