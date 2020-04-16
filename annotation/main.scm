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


(define-module (annotation main)
    #:use-module (annotation util)
    #:use-module (annotation gene-go)
    #:use-module (annotation gene-pathway)
    #:use-module (annotation graph)
    #:use-module (annotation gene-record)
    #:use-module (annotation biogrid)
    #:use-module (annotation parser)
    #:use-module (opencog)
    #:use-module (opencog exec)
    #:use-module (opencog bioscience)
    #:use-module (json)
    #:use-module (ice-9 match)
    #:use-module (ice-9 threads)
    #:use-module (srfi srfi-43)
    #:use-module (rnrs bytevectors)
    #:use-module (ice-9 futures)
    #:use-module (srfi srfi-1)
    #:use-module (annotation functions)
    #:use-module (annotation rna)
)

(define annotation-functions '("gene-go-annotation" "gene-pathway-annotation" "biogrid-interaction-annotation" "include-rna"))

(define-public (find-genes gene-list)
"
   find-genes GENE-LIST
   Validate if given gene strings in GENE-LIST exist in the atomspace.
"
  (let* ((records (filter-map (lambda (g)
                    (if (null? (cog-node 'GeneNode g))
                        (make-gene g  "" (find-similar-gene g))
                        (let* ([curr (find-current-symbol g)])
                          (if (null? curr)
                            #f
                            (make-gene g (car curr) '())
                          )
                        )
                    )
                ) gene-list))
        )
        (if (null? records)
          "[]"
          (scm->json-string (list->vector (map gene-record->scm records)))
        )  
      ))

(define-public (gene-info genes file-name)
  "Add the name and description of gene nodes to the given list of GENES."
  (let* ((info
         (map (lambda (gene)
                (list (ListLink (node-info (GeneNode gene))
                                (ListLink (locate-node (GeneNode gene))))))
              genes))
              
        (res (ListLink (ConceptNode "main") info))     
        )
        (write-to-file res file-name "main")
        res
  )
)

(define-public (mapSymbol gene-list)
  "Map gene symbols into GeneNodes."
  (map GeneNode gene-list))


(define-public (parse-request gene-list file-name req)
    (let (
        (table (if (string? req) (json-string->scm req) (json-string->scm (utf8->string (u8-list->bytevector req))) ))
    )
      (flatten (append (list (lambda () (gene-info gene-list file-name))) (vector->list (vector-map (lambda (i elm) 
        (if (member (assoc-ref elm "function_name") annotation-functions)
            (let* (
                (func-name (string->symbol (assoc-ref elm "function_name")))
                (func (variable-ref (module-variable (current-module) func-name)))
                (filters (assoc-ref elm "filters"))
                (args  (flatten (vector->list (vector-map (lambda (index f)
                (list (with-input-from-string (string-append "#:" (assoc-ref f "filter")) read) 
                    (if (string->number (assoc-ref f "value"))
                        (string->number (assoc-ref f "value"))
                        (assoc-ref f "value")
                    ))
                ) filters))))
                )
                (lambda () (apply func gene-list (append (list file-name) args)))
                
              )

            '()
        )
    ) table))))
))

(define-public (annotate-genes genes-list file-name request)
  (parameterize ((biogrid-genes (make-atom-set))
                 (biogrid-pairs (make-atom-set))
                 (biogrid-reported-pathways (make-atom-set)))
    (let* ([fns (parse-request genes-list file-name request)]
           [result (par-map (lambda (x) (x)) fns)] 
           [graphs (map (lambda (res) (atomese-parser res)) result)]
           [super-graph (make-graph (append-map (lambda (graph) (graph-nodes graph)) graphs)
                                    (append-map (lambda (graph) (graph-edges graph)) graphs)
                                )]
           )

          (call-with-output-file (get-file-path file-name file-name ".json")
                          (lambda (p) (scm->json (atomese-graph->scm super-graph) p))
                 ))))
