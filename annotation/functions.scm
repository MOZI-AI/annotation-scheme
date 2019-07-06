(define-module (annotation functions)
    #:use-module (annotation util)
    #:use-module (opencog)
    #:use-module (opencog query)
    #:use-module (opencog exec)
    #:use-module (opencog bioscience)
    #:use-module (rnrs base)
    #:use-module (srfi srfi-1)
    
)

;;finds go definition for parser function
(define find-godef
    (lambda (go)

      (cog-outgoing-set
       (cog-execute!
        (GetLink
         (VariableNode "$def")

         (EvaluationLink
          (PredicateNode "GO_definition")
          (ListLink
           go
           (VariableNode "$def")
          )
         )
        )
      )
     )
    )
)

;;Given an atom and list of namespaces finds the parents of that atom in the specified namespaces
(define find-parent

  (lambda (node namespaces)
        (let (
          [atom (cog-outgoing-atom node 1)]
          [parents '()]
        )
        (for-each (lambda (ns)
          (set! parents (append parents (cog-outgoing-set (cog-execute! (BindLink
            (VariableNode "$a")
            (AndLink
              (InheritanceLink
                atom
                (VariableNode "$a"))
              (EvaluationLink
                (PredicateNode "GO_namespace")
                (ListLink
                  (VariableNode "$a")
                  (ConceptNode ns)
                )
              )
            )
          (ExecutionOutputLink
              (GroundedSchemaNode "scm: add-go-info")
                (ListLink
                  atom
                  (VariableNode "$a")
                ))
        ))))) 
        ) namespaces
      )
    parents  
  )
))

;;Finds Go terms of a gene
(define find-memberln 
  (lambda (gene namespaces)
    (let ([go-atoms '()])

      (for-each (lambda (ns)
      
        (set! go-atoms (append go-atoms (cog-outgoing-set (cog-execute! (BindLink
            (VariableNode "$a")
            (AndLink
              (MemberLink
                gene
                (VariableNode "$a"))
                (EvaluationLink
                (PredicateNode "GO_namespace")
                (ListLink
                  (VariableNode "$a")
                  (ConceptNode ns)
                )
              )
            ) 
           (ExecutionOutputLink
              (GroundedSchemaNode "scm: add-go-info")
                (ListLink
                  gene
                  (VariableNode "$a")
                ))
          )))))
      ) namespaces)
          go-atoms
          ))
)

;;
(define (add-go-info child-atom parent-atom)
  (if (and (equal? (cog-type child-atom) 'GeneNode)
      (equal? (list-ref (string-split (cog-name parent-atom) #\:) 0) "GO"))
    (ListLink  
      (MemberLink
          child-atom
          parent-atom
      )
      (go-info parent-atom)
    )
    (begin
      (if (equal? (list-ref (string-split (cog-name parent-atom) #\:) 0) "GO")
        (ListLink 
            (InheritanceLink
              child-atom
              parent-atom
          )
          (go-info parent-atom)
        )
    ))
  )
)

;;the main function to find the go terms for a gene with a specification of the parents
(define-public find-go-term 
  (lambda (g namespaces p)
      (let (
        [res  (find-memberln (GeneNode g) namespaces)]      
      )
      (define parents (flatten (let loop (
        [i p]
        [ls res]
        [acc '()]
      )
      (cond 
        [(= i 0) (append ls acc)]
        [(null? ls) acc]
        [else (cons (loop (- i 1)  (find-parent (car (cog-outgoing-set (car ls))) namespaces) (append ls acc)) (loop i (cdr ls) '()))
          ]
      )
      )))
       (delete-duplicates parents)
    )
  ))

;; Add details about the GO term
(define (go-info go)
(list
  (EvaluationLink (PredicateNode "has_name") 
    (ListLink 
      go 
      (if (equal? (cog-outgoing-set (findGoname go)) '() ) (ConceptNode "") (cog-outgoing-set (findGoname go)))))
    (EvaluationLink 
      (PredicateNode "has_definition") 
      (ListLink 
        go 
        (if (equal? (find-godef go) '()) (ConceptNode "") (find-godef go))))
    (EvaluationLink 
      (PredicateNode "GO_namespace") 
      (ListLink 
        go 
        (if (equal? (find-GO-ns go) '()) (ConceptNode "") (find-GO-ns go))))
))

;; Finds parents of a GO term ( of given namespace type) 
(define find-GO-ns 
  (lambda (go)
    (cog-outgoing-set (cog-execute!
            (GetLink
                (VariableNode "$v")
                (EvaluationLink 
                    (PredicateNode "GO_namespace")
                    (ListLink 
                      go
                      (VariableNode "$v")
                    )
                 )
                )
    ))
  
  )
)

;; Finds the name of a GO term
(define findGoname
    (lambda(go)
        (cog-execute! (GetLink
            (VariableNode "$a")
            (EvaluationLink
               (PredicateNode "GO_name")
               (ListLink
               go
               (VariableNode "$a")
              )
            )
           )
        )
    )
)

(define-public (find-pathway-member gene db)
  (cog-outgoing-set (cog-execute! (BindLink
      (VariableNode "$a")
      (AndLink
        (EvaluationLink
          (GroundedPredicateNode "scm: filter-atoms")
          (ListLink 
            (VariableNode "$a")
            (ConceptNode db)
          )
         )
        (MemberLink
          gene
          (VariableNode "$a"))
      )
      (ExecutionOutputLink
              (GroundedSchemaNode "scm: add-pathway-info")
                (ListLink
                  gene
                  (VariableNode "$a")
                ))
    )))
)

(define add-pathway-info 
  (lambda (gene pathway)
     (let ([res '()])
      (if  (string-contains (cog-name pathway) "R-HSA")
        (set! res (ListLink 
            (MemberLink gene pathway)
            (node-info pathway)
        ))
     )
     (if (string-contains (cog-name pathway) "SMP")
        (set! res (ListLink 
            (MemberLink gene pathway)
            (node-info pathway)
        ))
     )
     res
     )
))

;; Finds proteins a gene expresses
(define-public find-protein
    (lambda (gene option)
        (cog-outgoing-set (cog-execute! (BindLink
          (VariableList
            (VariableNode "$a")
            (VariableNode "$pw"))
           (AndLink
            (MemberLink
             gene
             (VariableNode "$pw"))
            (MemberLink
            (VariableNode "$a")
            (VariableNode "$pw"))
            (EvaluationLink
            (PredicateNode "expresses")
              (ListLink
                gene
                (VariableNode "$a") ))
           )
        (ExecutionOutputLink
          (GroundedSchemaNode "scm: filter-pathway")
            (ListLink
              gene
              (VariableNode "$a")
              (VariableNode "$pw")
              (Number option)
            )
        )
        )))))

(define filter-pathway (lambda (gene prot pathway option)
(if (and (string=? (find-prefix prot) "Uniprot") )
  (cond ((and (string-contains (cog-name pathway) "SMP") (equal? option (Number "0")))
    (ListLink
      (EvaluationLink
        (PredicateNode "expresses")
          (ListLink
            gene
            prot ))
    (node-info pathway)
    ))
    ((and (equal? option (Number "1")) (string-contains (cog-name pathway) "R-HSA"))
    (ListLink
      (EvaluationLink
        (PredicateNode "expresses")
          (ListLink
            gene
            prot ))
      (node-info pathway)
      (ListLink 
        (add-loc (MemberLink gene pathway))
      )
    )))
)))

(define (find-prefix node)
(if (equal? (length (string-split (cog-name node) #\:)) 1)
       (cog-name node)
       (car  (string-split (cog-name node) #\:))
   )
)
;; Find heirarchy of the reactome pathway
(define-public pathway-heirarchy
  (lambda (pw lst)
    (let ([res-parent
      (cog-outgoing-set (cog-execute! (BindLink
        (VariableNode "$parentpw")
          (InheritanceLink
            pw
          (VariableNode "$parentpw"))
        (ExecutionOutputLink
          (GroundedSchemaNode "scm: check-pw")
          (ListLink
            pw
            (VariableNode "$parentpw")
            (ListLink lst)
          )
        ))
      ))
    ]
    [res-child (cog-outgoing-set (cog-execute! (BindLink
      (VariableNode "$parentpw")
      (InheritanceLink
        (VariableNode "$parentpw")
        pw)
      (ExecutionOutputLink
        (GroundedSchemaNode "scm: check-pw")
        (ListLink
         (VariableNode "$parentpw")
         pw
         (ListLink lst)
        )
      ))
    ))]
  )
  (append res-parent res-child)
)))

(define check-pw
  (lambda (pw parent-pw lst)
    (if (and (member parent-pw (cog-outgoing-set lst)) (member pw (cog-outgoing-set lst)))
    (ListLink
      (InheritanceLink
      pw
      parent-pw)
    ))
))

;; Finds molecules (proteins or chebi's) in a pathway 
(define-public (find-mol path identifier)
  (cog-execute! (BindLink
    (VariableNode "$a")
    (AndLink
      (EvaluationLink
        (GroundedPredicateNode "scm: filter-atoms")
        (ListLink
          (VariableNode "$a")
          (ConceptNode identifier)
        )
      )
       (MemberLink
       (VariableNode "$a")
       path)
    )
    (ExecutionOutputLink
      (GroundedSchemaNode "scm: add-mol-info")
      (ListLink
        (VariableNode "$a")
        path
      )
    )))
)

(define add-mol-info
  (lambda (mol path)
  (if (string-contains (cog-name path) "R-HSA")
    (ListLink
      (MemberLink mol path)
      (node-info mol)
      (ListLink 
        (add-loc (MemberLink mol path))
      )
    )
    (ListLink
      (MemberLink mol path)
      (node-info mol)
      (ListLink (locate-node mol))
    )
  )
))

(define filter-atoms
  (lambda (atom identifier)
    (if (string-contains (cog-name atom) (cog-name identifier))
        (cog-new-stv 1 1)
        (cog-new-stv 0 0) 
    )
  )
) 



;; append a list into a list to collect the result in one List
(define (append . lsts)
  (cond
    ((null? lsts) '())
    ((null? (car lsts)) (apply append (cdr lsts)))
    (else (cons (caar lsts) (apply append (cdar lsts) (cdr lsts))))))


;; Finds genes interacting with a given gene
(define-public match-gene-interactors
    (lambda(gene)
        (cog-outgoing-set (cog-execute! (BindLink
            (VariableList
            (TypedVariable (VariableNode "$a") (Type 'GeneNode)))

            (EvaluationLink
               (PredicateNode "interacts_with")
               (ListLink
               gene
               (VariableNode "$a")
              )
            )
            (ExecutionOutputLink
              (GroundedSchemaNode "scm: generate-result")
                (ListLink
                  gene
                  (VariableNode "$a")
                ))
    )))	
))

;;; Finds output genes interacting eachother 
(define-public output-interaction
    (lambda(gene)
        (cog-outgoing-set (cog-execute! (BindLink
          (VariableList
            (TypedVariable (VariableNode "$a") (Type 'GeneNode))
            (TypedVariable (VariableNode "$b") (Type 'GeneNode)))

          (And  
            (EvaluationLink
               (PredicateNode "interacts_with")
               (ListLink
               gene
               (VariableNode "$a")
              ))

            (EvaluationLink
               (PredicateNode "interacts_with")
               (ListLink
               (VariableNode "$a")
               (VariableNode "$b")
              ))

            (EvaluationLink
               (PredicateNode "interacts_with")
               (ListLink
                gene
               (VariableNode "$b")
              ))
          )
          (ExecutionOutputLink
            (GroundedSchemaNode "scm: generate-result")
              (ListLink
                (VariableNode "$a")
                (VariableNode "$b")
              ))
    )))	
))

;; Finds Protein-protein equivalence of a gene-gene interaction 
(define-public find-prot-interactor
  (lambda(gene)
     (cog-outgoing-set (cog-execute! (BindLink
 
      (VariableList
        (TypedVariable (VariableNode "$a") (Type 'GeneNode))
        (TypedVariable (VariableNode "$b") (Type 'MoleculeNode))
        (TypedVariable (VariableNode "$c") (Type 'MoleculeNode)))
	  
      (And 
          (EvaluationLink
            (PredicateNode "expresses")
              (ListLink
                gene
                (VariableNode "$c")
          ))

          (EvaluationLink
          (PredicateNode "interacts_with")
            (ListLink
              gene
              (VariableNode "$a")
          ))

          (EvaluationLink
          (PredicateNode "expresses")
            (ListLink
              (VariableNode "$a")
              (VariableNode "$b")
        ))
      )

    ;; This will be executed if the above pattern is found.
    (ExecutionOutputLink
      (GroundedSchemaNode "scm: generate-ppi-result")
        (ListLink
          gene
          (VariableNode "$c")
          (VariableNode "$a")
          (VariableNode "$b")
        ))
	
  )))
))

;; Grounded schema node to add info about matched variable nodes

(define (generate-result gene-a gene-b)
  (if  
    (and (not (equal? (cog-type gene-a) 'VariableNode)) (not (equal? (cog-type gene-b) 'VariableNode))
    (not (member (cons gene-a gene-b) (pairs)))
     (not (member (cons gene-b gene-a) (pairs)))
    ) 

        (begin
            (let ([output (find-pubmed-id gene-a gene-b)])
                (pairs (append (list (cons gene-a gene-b)) (pairs)))
                (if (null? output)
                    (ListLink 
                        (EvaluationLink 
                            (PredicateNode "interacts_with") 
                            (ListLink gene-a gene-b))
                        (node-info gene-b)
                        (node-info gene-a)
                    )
                    (ListLink 
                        (EvaluationLink
                            (PredicateNode "has_pubmedID")
                            (ListLink 
                                (EvaluationLink (PredicateNode "interacts_with") (ListLink gene-a gene-b))
                                output
                            )
                        )
                        (node-info gene-a)
                        (ListLink (locate-node gene-a))
                        (node-info gene-b)
                        (ListLink (locate-node gene-b))
                        )
                    )
                )
        )
    
))

(define (generate-ppi-result gene-a prot-a gene-b prot-b)
    (if (and (not (member (cons gene-a prot-a) (pairs)))
            (not (member (cons gene-b prot-b) (pairs)))
        )
        (begin
            (pairs (append (list (cons gene-a prot-a)  (cons gene-b prot-b)) (pairs)))
            (ListLink
                    (EvaluationLink (PredicateNode "expresses") (ListLink gene-a prot-a))
                    (EvaluationLink (PredicateNode "expresses") (ListLink gene-b prot-b))
                    (node-info prot-a)
                    (node-info prot-b)
            )
        )
    )
)
;;                           
(define (find-pubmed-id gene-a gene-b)
 (let ([pub (cog-outgoing-set (cog-execute!
     (GetLink
       (VariableNode "$pub")
       (EvaluationLink
           (PredicateNode "has_pubmedID")
           (ListLink
            (EvaluationLink 
                (PredicateNode "interacts_with") 
                  (ListLink
                    gene-a
                    gene-b
                  ))
            (VariableNode "$pub")
           )
         )

   )))])
   (if (null? pub)
     (set! pub (cog-outgoing-set (cog-execute!
     (GetLink
       (VariableNode "$pub")
       (EvaluationLink
           (PredicateNode "has_pubmedID")
           (ListLink
             (EvaluationLink 
                (PredicateNode "interacts_with") 
                  (ListLink
                    gene-b
                    gene-a
                  ))
             (VariableNode "$pub")
           )
         )
   )))
   ))
   pub
))

(define( generate-pubmedID interaction ids)
    (EvaluationLink
        (PredicateNode "has_pubmedID")
        (ListLink
          interaction
          ids))
)
