(define biogrid_interaction_rule
    (BindLink
        (VariableList
            (TypedVariable (Variable "$g") (Type "GeneNode"))
            (TypedVariable (Variable "$gg") (Type "GeneNode"))
            (TypedVariable (Variable "$ggg") (Type "GeneNode"))
        ) 
        (And
            (EvaluationLink
                (PredicateNode "has_current_symbol")
                (ListLink
                    (Variable "$g")
                    (Variable "$gg")))
            (EvaluationLink
                (PredicateNode "interacts_with")
                (ListLink
                    (Variable "$g")
                    (Variable "$ggg")
                )
            )
	    )
        (ListLink
            (EvaluationLink
                (PredicateNode "has_pubmedID")
                (ListLink
                (EvaluationLink
                    (PredicateNode "interacts_with")
                    (ListLink
                        (Variable "$gg")
                        (Variable "$ggg")
                    )
                )
                (find-pubmed-id (Variable "$g") (Variable "$ggg"))
                )
            )
            (DeleteLink
                (EvaluationLink
                  (PredicateNode "interacts_with")
                  (ListLink
                     (Variable "$g")
                     (Variable "$ggg")
                  )
               )
            )
        )
    )
)
(define member_rule
    (BindLink
        (VariableList
            (TypedVariable (Variable "$g") (Type "GeneNode"))
            (TypedVariable (Variable "$gg") (Type "GeneNode"))
            (TypedVariable (Variable "$c") (Type "ConceptNode"))
        ) 
        (And
            (EvaluationLink
                (PredicateNode "has_current_symbol")
                (ListLink
                    (Variable "$g")
                    (Variable "$gg")))
            (MemberLink
                (Variable "$g")
                (Variable "$c"))
	    )
        (ListLink
            (MemberLink
                (Variable "$gg")
                (Variable "$c"))
            (DeleteLink
                (MemberLink
                    (Variable "$g")
                    (Variable "$c"))
            )
        )
    )
)
(define expresses_rule
    (BindLink
        (VariableList
            (TypedVariable (Variable "$g") (Type "GeneNode"))
            (TypedVariable (Variable "$gg") (Type "GeneNode"))
            (TypedVariable (Variable "$m") (Type "MoleculeNode"))
        ) 
        (And
            (EvaluationLink
                (PredicateNode "has_current_symbol")
                (ListLink
                    (Variable "$g")
                    (Variable "$gg")))
            (EvaluationLink
                (PredicateNode "expresses")
                (ListLink
                    (Variable "$g")
                    (Variable "$m")))
	    )
        (ListLink
            (EvaluationLink
                (PredicateNode "expresses")
                (ListLink
                    (Variable "$gg")
                    (Variable "$m")))
            (DeleteLink
                (EvaluationLink
                    (PredicateNode "expresses")
                    (ListLink
                        (Variable "$g")
                        (Variable "$m")))
            )
        )
    )
)
(define location_rule
    (BindLink
        (VariableList
            (TypedVariable (Variable "$g") (Type "GeneNode"))
            (TypedVariable (Variable "$gg") (Type "GeneNode"))
            (TypedVariable (Variable "$l") (Type "ConceptNode"))
        ) 
        (And
            (EvaluationLink
                (PredicateNode "has_current_symbol")
                (ListLink
                    (Variable "$g")
                    (Variable "$gg")))
            (EvaluationLink (stv 1 1)
                (PredicateNode "has_location")
                (ListLink
                    (Variable "$g")
                    (Variable "$l")))
        )
        (ListLink
            (EvaluationLink (stv 1 1)
                (PredicateNode "has_location")
                (ListLink
                (Variable "$gg")
                (Variable "$l")
                ))
            (DeleteLink
                (EvaluationLink (stv 1 1)
                    (PredicateNode "has_location")
                    (ListLink
                        (Variable "$g")
                        (Variable "$l")))
            )
        )
    )
)
(define name_rule
    (BindLink
        (VariableList
            (TypedVariable (Variable "$g") (Type "GeneNode"))
            (TypedVariable (Variable "$gg") (Type "GeneNode"))
            (TypedVariable (Variable "$n") (Type "ConceptNode"))
        ) 
        (And
            (EvaluationLink
                (PredicateNode "has_current_symbol")
                (ListLink
                    (Variable "$g")
                    (Variable "$gg")))
            (EvaluationLink (stv 1 1)
                (PredicateNode "has_name")
                (ListLink
                    (Variable "$g")
                    (Variable "$n")))
        )
        (ListLink
            (EvaluationLink (stv 1 1)
                (PredicateNode "has_name")
                (ListLink
                (Variable "$gg")
                (Variable "$n")
                ))
            (DeleteLink
                (EvaluationLink (stv 1 1)
                    (PredicateNode "has_name")
                    (ListLink
                        (Variable "$g")
                        (Variable "$n")))
            )
        )
    )
)
(define biogird_id_rule
    (BindLink
        (VariableList
            (TypedVariable (Variable "$g") (Type "GeneNode"))
            (TypedVariable (Variable "$gg") (Type "GeneNode"))
            (TypedVariable (Variable "$b") (Type "ConceptNode"))
        ) 
        (And
            (EvaluationLink
                (PredicateNode "has_current_symbol")
                (ListLink
                    (Variable "$g")
                    (Variable "$gg")))
            (EvaluationLink (stv 1 1)
                (PredicateNode "has_biogridID")
                (ListLink
                    (Variable "$g")
                    (Variable "$b")))
        )
        (ListLink        
            (EvaluationLink (stv 1 1)
                (PredicateNode "has_biogridID")
                (ListLink
                (Variable "$gg")
                (Variable "$b")
                ))
            (DeleteLink
                (EvaluationLink (stv 1 1)
                    (PredicateNode "has_biogridID")
                    (ListLink
                        (Variable "$g")
                        (Variable "$b")))
            )
        )
    )
)
(define entrez_id_rule
    (BindLink
        (VariableList
            (TypedVariable (Variable "$g") (Type "GeneNode"))
            (TypedVariable (Variable "$gg") (Type "GeneNode"))
            (TypedVariable (Variable "$e") (Type "ConceptNode"))
        ) 
        (And
            (EvaluationLink
                (PredicateNode "has_current_symbol")
                (ListLink
                    (Variable "$g")
                    (Variable "$gg")))
            (EvaluationLink (stv 1 1)
                (PredicateNode "has_entrez_id")
                (ListLink
                    (Variable "$g")
                    (Variable "$e")))
        )
        (ListLink        
            (EvaluationLink (stv 1 1)
                (PredicateNode "has_entrez_id")
                (ListLink
                (Variable "$gg")
                (Variable "$e")
                ))
            (DeleteLink
                (EvaluationLink (stv 1 1)
                    (PredicateNode "has_entrez_id")
                    (ListLink
                        (Variable "$g")
                        (Variable "$e")))
            )
        )
    )
)

(cog-execute! biogrid_interaction_rule)
(cog-execute! member_rule)
(cog-execute! expresses_rule)
(cog-execute! name_rule)
(cog-execute! location_rule)
(cog-execute! biogird_id_rule)
(cog-execute! entrez_id_rule)
