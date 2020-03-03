;;; MOZI-AI Annotation Scheme
;;; Copyright © 2019 Habush
;;; Copyright © 2019 enku-io
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

(define-module (annotation graph)
  #:use-module (rnrs records inspection)
  #:use-module (rnrs records syntactic)
  #:use-module (ice-9 match)
  #:use-module (srfi srfi-1)
  #:export (make-node-info
            node-info?
            node-info-id
            node-info-name
            node-info-name-set!
            node-info-defn
            node-info-defn-set!
            node-info-location
            node-info-location-set!
            node-info-subgroup
            node-info-subgroup-set!
            node-info-group
            node-info-group-set!

            make-node
            node-data
            node-data-set!
            node?

            make-edge-info
            edge-info?
            edge-info-id
            edge-info-pubid
            edge-info-pubid-set!
            edge-info-subgroup-set!
            edge-info-group-set!

            make-edge
            edge-data
            edge?

            make-graph
            graph?
            graph-nodes
            graph-edges

            make-result
            result-text
            result-graph

            atomese-graph->scm))

;;
;; Graph builder helpers
;;

;;Record Definitions
(define-record-type node-info
  (fields id
          (mutable name)
          (mutable defn)
          (mutable location)
          (mutable subgroup)
          (mutable group)))

(define-record-type node
  (fields (mutable data) group))

(define-record-type edge-info
  (fields source
          target
          name
          (mutable pubid)
          (mutable subgroup)
          (mutable group)))

(define-record-type edge
  (fields (mutable data) group))

(define-record-type graph
  (fields nodes edges))

(define-record-type result
  (fields text graph))

;;
;; Graph builder
;;
(define (atomese-graph->scm graph)
  (define thing->scm
    (match-lambda
      ((? graph? thing)
       `(("nodes" . ,(map thing->scm (graph-nodes thing)))
         ("edges" . ,(map thing->scm (graph-edges thing)))))
      ((? result? thing)
       `(("text"  . ,(thing->scm (result-text thing)))
         ("graph" . ,(thing->scm (result-graph thing)))))
      ((? edge? thing)
       `(("data"  . ,(thing->scm (edge-data thing)))
         ("group" . ,(thing->scm (edge-group thing)))))
      ((? edge-info? thing)
       `(("source"   . ,(thing->scm (edge-info-source thing)))
         ("target"   . ,(thing->scm (edge-info-target thing)))
         ("name"     . ,(thing->scm (edge-info-name thing)))
         ("pubmedId" . ,(thing->scm (edge-info-pubid thing)))
         ("subgroup" . ,(thing->scm (edge-info-subgroup thing)))
         ("group"    . ,(thing->scm (edge-info-group thing)))))
      ((? node? thing)
       `(("data"  . ,(thing->scm (node-data thing)))
         ("group" . ,(thing->scm (node-group thing)))))
      ((? node-info? thing)
       `(("id"         . ,(thing->scm (node-info-id thing)))
         ("name"       . ,(thing->scm (node-info-name thing)))
         ("definition" . ,(thing->scm (node-info-defn thing)))
         ("location"   . ,(thing->scm (node-info-location thing)))
         ("subgroup"   . ,(thing->scm (node-info-subgroup thing)))
         ("group"      . ,(thing->scm (node-info-group thing)))))
      (anything anything)))
  (thing->scm graph))
