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

(define-module (annotation gene-go)
    #:use-module (annotation functions)
    #:use-module (annotation go-helpers)
    #:use-module (annotation util)
    #:use-module (opencog)
    #:use-module (opencog exec)
    #:use-module (opencog bioscience)
    #:export (gene-go-annotation)
)

(define* (gene-go-annotation lst chans #:key 
                            (namespace "biological_process molecular_function cellular_component") 
                            (parents 0) 
                            (regulates #f) (bi-dir #f) (part-of #f))
    
    (send-message (Concept "gene-go-annotation") chans)
    (for-each (lambda (pair) 
        (for-each (lambda (prot) 
            (send-message (find-go-term prot (string-split namespace #\space) parents regulates part-of bi-dir) chans)  
            (send-message (find-drugs-protein prot (string-split namespace #\space)) chans)) (cdr pair))) lst))