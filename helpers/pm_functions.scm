;; a set of helper methods

;; Parser PM functions

(define-syntax try
    (syntax-rules (catch)
      ((_ body (catch catcher))
       (call-with-current-continuation
        (lambda (exit)
          (with-exception-handler
           (lambda (condition)
             catcher
             (exit condition))
           (lambda () body)))))))

(define (get-params p)
 (if(equal? (cog-type p) 'ListLink)
    (map (lambda (t)
        (cog-name t)
        ) (cog-outgoing-set p))

    (list (cog-name p)))
)

(define (multi-word x)
    (string-join (get-params x))
)
(define (remove-set-ln ln)
    (if (cog-atom? ln)
        (cog-outgoing-set ln)
        '()
    )
)

(define (get-name atom)
 (if (> (length atom) 0)
  (cog-name (car  atom))
  ""
 )
)

;;finds go name for parser function
(define find-name
    (lambda (atom)
     (let*
        (
          [predicate (if (regexp-match? (string-match "GO:[0-9]+" (cog-name atom))) "GO_name" "has_name")]
        )
      (get-name
       (remove-set-ln
        (cog-execute!
         (GetLink
          (VariableNode "$name")

          (EvaluationLink
           (PredicateNode predicate)
           (ListLink
            atom
            (VariableNode "$name")
           )
          )
         )
        )
       )
      )
    )
    )
)

;;finds go definition for parser function
(define find-GO-def
    (lambda (go)
     (get-name
      (remove-set-ln
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
)

;;; Annotation's PM functions

;; Finds a GO term of specific namespace for a given gene g 
(define (findGoterm g namespace)
        (cog-execute! (GetLink
            (VariableNode "$a")
            (AndLink
              (MemberLink
                g
                (VariableNode "$a"))
              (EvaluationLink
               (PredicateNode "GO_namespace")
                 (ListLink
                   (VariableNode "$a")
                  (ConceptNode namespace)
                  )
                )
            )

            )
))

;; Finds parents of a GO term ( of given namespace type) 
(define (parent_finder go namespace)
   (cog-execute! (GetLink
            (VariableNode "$a")
            (AndLink
              (InheritanceLink
                go
                (VariableNode "$a"))
              (EvaluationLink
               (PredicateNode "GO_namespace")
                 (ListLink
                   (VariableNode "$a")
                  (ConceptNode namespace)
                  )
                )
            )

            )
))

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

;; Finds the namespace of a GO term
(define (find-GO-ns go)
(remove-set-ln
       (cog-execute!
        (GetLink
         (VariableNode "$ns")

         (EvaluationLink
          (PredicateNode "GO_namespace")
          (ListLink
           go
           (VariableNode "$ns")
          )
         )
        )
       )
      )
)

;; Finds the definition of a GO term
(define (find-godef go)
(remove-set-ln
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

;; Finds a concept where a gene is a member of
(define (findMember gene)
(cog-execute! (GetLink
    (VariableNode "$a")
    (MemberLink
       gene
       (VariableNode "$a"))
    ))
)

;; Finds entrez_id of a gene
(define (find_entrez gene)
 (get-name
   (remove-set-ln
    (cog-execute!
     (GetLink
       (VariableNode "$a")
       (EvaluationLink
        (PredicateNode "has_entrez_id")
        (ListLink
         gene
         (VariableNode "$a")
        )
       )
    )
   )
  )
 )
)

;; Finds proteins a gene expresses
(define findprotein
    (lambda(gene)
        (cog-execute! (GetLink
            (VariableNode "$a")
            (EvaluationLink
               (PredicateNode "expresses")
               (ListLink
               gene
               (VariableNode "$a")
              )
            )
    ))))

;;Finds a name of any node (Except GO which has different structure)
(define findpwname
    (lambda(pw)
        (cog-execute! (GetLink
            (VariableNode "$a")
            (EvaluationLink
               (PredicateNode "has_name")
               (ListLink
               pw
               (VariableNode "$a")
              )
            )
))))

;; Finds molecules (proteins or chebi's) in a pathway 
(define (findmol path)
  (cog-execute! (GetLink
    (VariableNode "$a")
    (MemberLink
       (VariableNode "$a")
       path))
  )
)

;; append a list into a list to collect the result in one List
(define (append . lsts)
  (cond
    ((null? lsts) '())
    ((null? (car lsts)) (apply append (cdr lsts)))
    (else (cons (caar lsts) (apply append (cdar lsts) (cdr lsts))))))

;; Collect Pair of nodes interacting eachother to avoid repeatation  
(define pairs '())

;; Finds genes interacting with a given gene
(define matchGeneInteractors
    (lambda(gene)
        (cog-execute! (BindLink
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
              (GroundedSchemaNode "scm: generate_result")
                (ListLink
                  gene
                  (VariableNode "$a")
                ))
    ))	
))

;;; Finds output genes interacting eachother 
(define outputInteraction
    (lambda(gene)
        (cog-execute! (BindLink
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
            (GroundedSchemaNode "scm: generate_result")
              (ListLink
                (VariableNode "$a")
                (VariableNode "$b")
              ))
    ))	
))

;; Finds Protein-protein equivalence of a gene-gene interaction 
(define findProtInteractor
  (lambda(gene)
     (cog-execute! (BindLink
 
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
    (GroundedSchemaNode "scm: generate_result")
		  (ListLink
		    (VariableNode "$c")
		    (VariableNode "$b")
		  ))
	
))
))

;; Grounded schema node to add info about matched variable nodes

(define (generate_result var1 var2)
  (if (and 
    (and (not (equal? (cog-type var1) 'VariableNode)) (not (equal? (cog-type var2) 'VariableNode))) 
    (and (not (member (list var1 var2) pairs)) (not (member (list var2 var1) pairs))))

    (begin
    (set! pairs (append pairs (list (list var1 var2))))
    (let ([output (ListLink
          (EvaluationLink (PredicateNode "Interacts_with") (ListLink var1 var2))
          (node-info var2)
          (node-info var1)
          )])
    output
    )
    )
))
;; build description URL of a node

(define (build-desc-url node)
 (let
	(
		[atom-type (cog-type node)]
		[description ""]
	)
 	(case atom-type
	 ('MoleculeNode
		(begin
		 (if (equal? (list-ref (string-split (cog-name node) #\:) 0) "ChEBI")
			(set! description (string-append "https://www.ebi.ac.uk/chebi/searchId.do?chebiId=CHEBI:" (cog-name node)))
	 		(set! description (string-append "https://www.uniprot.org/uniprot/" (list-ref (string-split (cog-name node) #\:) 1)))
		 )
		)
	 )
	 ('GeneNode (set! description (string-append "https://www.ncbi.nlm.nih.gov/gene/" (find_entrez node))))
	 ('ConceptNode
		(begin
		 (if (string-contains (cog-name node) "SMP")
		 	(set! description (string-append "http://smpdb.ca/view/" (cog-name node)))
		 )
		 (if (string-contains (cog-name node) "R-HSA")
		 	(set! description (string-append "http://www.reactome.org/content/detail/" (cog-name node)))
		 )
		)
	 )
	)
	description
 )

)

;; Find node name and description

(define (node-info node)
    (ListLink
      (EvaluationLink (PredicateNode "has_name") (ListLink node (node-name node)))
      (EvaluationLink (PredicateNode "has_definition") (ListLink node (Concept (build-desc-url node))))
    )
)

(define (node-name node)
(let
    ([lst (cog-outgoing-set (findpwname node))]
    [name ""])
    (if (>= (length lst) 1)
	(set! name (list-ref lst 0))
	(set! name (ConceptNode "")))
name
)

)

;; Add location of a gene/Molecule node in context of Reactome pathway

(define (add-loc node)
(let ([child (cog-outgoing-atom node 0)] 
      [parent (cog-outgoing-atom node 1) ])
(cog-outgoing-set (cog-execute!
  (BindLink
    (VariableNode "$loc")
    (AndLink
      (MemberLink (stv 1 1) 
        child
        parent)
      (EvaluationLink (stv 1 1)
        (PredicateNode "has_location")
        (ListLink
          child
          (VariableNode "$loc")))
    )

    (AndLink
      (MemberLink (stv 1 1) 
        child
        parent)
      (EvaluationLink (stv 1 1)
        (PredicateNode "has_location")
        (ListLink
          child
          (VariableNode "$loc")))
    )
  )))
))