;; sample data_set for testing the annotation service,
;; The data is all about genes MAP2K4 and SPAG9

;; GO term parenting example

(MemberLink 
 	(GeneNode "SPAG9")
	(ConceptNode "GO:0001669"))

(EvaluationLink 
	 (PredicateNode "GO_namespace")
	 (ListLink 
		 (ConceptNode "GO:0001669")
		 (ConceptNode "cellular_component")
	 )
)

(MemberLink 
 	(GeneNode "SPAG9")
	(ConceptNode "GO:0030335"))

(EvaluationLink 
	 (PredicateNode "GO_namespace")
	 (ListLink 
		 (ConceptNode "GO:0030335")
		 (ConceptNode "biological_process")
	 )
)

(InheritanceLink 
 	(ConceptNode "GO:0001669")
	(ConceptNode "GO:0001666"))

(EvaluationLink 
	 (PredicateNode "GO_namespace")
	 (ListLink 
		 (ConceptNode "GO:0001666")
		 (ConceptNode "cellular_component")
	 )
)


(InheritanceLink 
 	(ConceptNode "GO:0001666")
	(ConceptNode "GO:0001667"))

(EvaluationLink 
	 (PredicateNode "GO_namespace")
	 (ListLink 
		 (ConceptNode "GO:0001667")
		 (ConceptNode "cellular_component")
	 )
)



(InheritanceLink 
 	(ConceptNode "GO:0001667")
	(ConceptNode "GO:0001668"))

(EvaluationLink 
	 (PredicateNode "GO_namespace")
	 (ListLink 
		 (ConceptNode "GO:0001668")
		 (ConceptNode "cellular_component")
	 )
)

(InheritanceLink 
 	(ConceptNode "GO:0030335")
	(ConceptNode "GO:0001666"))


(InheritanceLink 
 	(ConceptNode "GO:0001668")
	(ConceptNode "GO:0001670"))

(EvaluationLink 
	 (PredicateNode "GO_namespace")
	 (ListLink 
		 (ConceptNode "GO:0001670")
		 (ConceptNode "cellular_component")
	 )
)



;; Gene expresses protein

(EvaluationLink
(PredicateNode "expresses")
(ListLink 
(GeneNode "MAP2K4")
(MoleculeNode "Uniprot:Q5U0B8")))
(EvaluationLink
(PredicateNode "expresses")
(ListLink 
(GeneNode "MAP2K4")
(MoleculeNode "Uniprot:Q6PIE6")))


(EvaluationLink
(PredicateNode "expresses")
(ListLink 
(GeneNode "FLNC")
(MoleculeNode "Uniprot:Q9Y503")))
(EvaluationLink
(PredicateNode "expresses")
(ListLink 
(GeneNode "FLNC")
(MoleculeNode "Uniprot:Q9NYE5")))
(EvaluationLink
(PredicateNode "expresses")
(ListLink 
(GeneNode "FLNC")
(MoleculeNode "Uniprot:Q9NS12")))


(EvaluationLink
(PredicateNode "expresses")
(ListLink 
(GeneNode "MAPK8")
(MoleculeNode "Uniprot:D3DX92")))
(EvaluationLink
(PredicateNode "expresses")
(ListLink 
(GeneNode "MAPK8")
(MoleculeNode "Uniprot:B7ZLV4")))


;;;;; Biogrid

(EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "MAP2K4")
            (GeneNode "FLNC")
         )
      )
      (ConceptNode "pubmed:9006895")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "MAP2K4")
            (GeneNode "MAPK8")
         )
      )
      (ConceptNode "pubmed:13130464")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "MAP2K4")
            (GeneNode "MAPK8")
         )
      )
      (ConceptNode "pubmed:16533805")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "MAP2K4")
            (GeneNode "MAPK8")
         )
      )
      (ConceptNode "pubmed:10713157")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "MAP2K4")
            (GeneNode "MAPK8")
         )
      )
      (ConceptNode "pubmed:15998799")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "MAP2K4")
            (GeneNode "MAPK8")
         )
      )
      (ConceptNode "pubmed:12391307")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "MAP2K4")
            (GeneNode "MAPK8")
         )
      )
      (ConceptNode "pubmed:11707464")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "MAP2K4")
            (GeneNode "MAPK8")
         )
      )
      (ConceptNode "pubmed:9808624")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "MAP2K4")
            (GeneNode "MAPK8")
         )
      )
      (ConceptNode "pubmed:12788955")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "MAP2K4")
            (GeneNode "MAPK8")
         )
      )
      (ConceptNode "pubmed:9207092")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "MAP2K4")
            (GeneNode "MAPK8")
         )
      )
      (ConceptNode "pubmed:11279118")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "MAP2K4")
            (GeneNode "MAPK8")
         )
      )
      (ConceptNode "pubmed:9162092")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "MAP2K4")
            (GeneNode "MAP2K7")
         )
      )
      (ConceptNode "pubmed:13130464")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "MAP2K4")
            (GeneNode "MAP2K7")
         )
      )
      (ConceptNode "pubmed:11062067")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "MAP2K4")
            (GeneNode "AKT1")
         )
      )
      (ConceptNode "pubmed:15998799")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "MAP2K4")
            (GeneNode "AKT1")
         )
      )
      (ConceptNode "pubmed:11707464")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "MAP2K4")
            (GeneNode "ITCH")
         )
      )
      (ConceptNode "pubmed:19737936")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "MAP2K4")
            (GeneNode "MAPK9")
         )
      )
      (ConceptNode "pubmed:12788955")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "MAP2K4")
            (GeneNode "MAPK9")
         )
      )
      (ConceptNode "pubmed:21900206")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "MAP2K4")
            (GeneNode "MAPK9")
         )
      )
      (ConceptNode "pubmed:22366412")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "MAP2K4")
            (GeneNode "PML")
         )
      )
      (ConceptNode "pubmed:10620019")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "MAP2K4")
            (GeneNode "MAPK10")
         )
      )
      (ConceptNode "pubmed:15299005")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "MAP2K4")
            (GeneNode "MAPK10")
         )
      )
      (ConceptNode "pubmed:12788955")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "MAP2K4")
            (GeneNode "MAP3K1")
         )
      )
      (ConceptNode "pubmed:9808624")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "MAP2K4")
            (GeneNode "MAP3K1")
         )
      )
      (ConceptNode "pubmed:15866172")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "MAP2K4")
            (GeneNode "MAP3K1")
         )
      )
      (ConceptNode "pubmed:10713157")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "MAP2K4")
            (GeneNode "MAP3K1")
         )
      )
      (ConceptNode "pubmed:16472679")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "MAP2K4")
            (GeneNode "MAP3K1")
         )
      )
      (ConceptNode "pubmed:27806347")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "MAP2K4")
            (GeneNode "MAP3K1")
         )
      )
      (ConceptNode "pubmed:14581471")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "MAP2K4")
            (GeneNode "MAP3K1")
         )
      )
      (ConceptNode "pubmed:12228228")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "MAP2K4")
            (GeneNode "MAP3K1")
         )
      )
      (ConceptNode "pubmed:14500727")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "MAP2K4")
            (GeneNode "MAP3K1")
         )
      )
      (ConceptNode "pubmed:15299005")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "MAP2K4")
            (GeneNode "MAP3K4")
         )
      )
      (ConceptNode "pubmed:9841871")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "MAP2K4")
            (GeneNode "MAP3K4")
         )
      )
      (ConceptNode "pubmed:15866172")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "MAP2K4")
            (GeneNode "MAPK8")
         )
      )
      (ConceptNode "pubmed:13130464")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "MAP2K4")
            (GeneNode "MAPK8")
         )
      )
      (ConceptNode "pubmed:16533805")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "MAP2K4")
            (GeneNode "MAPK8")
         )
      )
      (ConceptNode "pubmed:10713157")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "MAP2K4")
            (GeneNode "MAPK8")
         )
      )
      (ConceptNode "pubmed:15998799")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "MAP2K4")
            (GeneNode "MAPK8")
         )
      )
      (ConceptNode "pubmed:12391307")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "MAP2K4")
            (GeneNode "MAPK8")
         )
      )
      (ConceptNode "pubmed:11707464")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "MAP2K4")
            (GeneNode "MAPK8")
         )
      )
      (ConceptNode "pubmed:9808624")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "MAP2K4")
            (GeneNode "MAPK8")
         )
      )
      (ConceptNode "pubmed:12788955")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "MAP2K4")
            (GeneNode "MAPK8")
         )
      )
      (ConceptNode "pubmed:9207092")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "MAP2K4")
            (GeneNode "MAPK8")
         )
      )
      (ConceptNode "pubmed:11279118")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "MAP2K4")
            (GeneNode "MAPK8")
         )
      )
      (ConceptNode "pubmed:9162092")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "MAP2K4")
            (GeneNode "MAPK14")
         )
      )
      (ConceptNode "pubmed:9162092")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "MAP2K4")
            (GeneNode "MAPK14")
         )
      )
      (ConceptNode "pubmed:9808624")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "MAP2K4")
            (GeneNode "APP")
         )
      )
      (ConceptNode "pubmed:21832049")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "MAP2K4")
            (GeneNode "JUN")
         )
      )
      (ConceptNode "pubmed:13130464")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "MAP2K4")
            (GeneNode "MAP3K7")
         )
      )
      (ConceptNode "pubmed:12429732")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "MAP2K4")
            (GeneNode "MAP3K7")
         )
      )
      (ConceptNode "pubmed:12556533")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "MAP2K4")
            (GeneNode "MAPK10")
         )
      )
      (ConceptNode "pubmed:15299005")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "MAP2K4")
            (GeneNode "MAPK10")
         )
      )
      (ConceptNode "pubmed:12788955")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "MAP2K4")
            (GeneNode "MAPK9")
         )
      )
      (ConceptNode "pubmed:12788955")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "MAP2K4")
            (GeneNode "MAPK9")
         )
      )
      (ConceptNode "pubmed:21900206")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "MAP2K4")
            (GeneNode "MAPK9")
         )
      )
      (ConceptNode "pubmed:22366412")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "MAP2K4")
            (GeneNode "MAPK1")
         )
      )
      (ConceptNode "pubmed:12788955")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "MAP2K4")
            (GeneNode "GEMIN5")
         )
      )
      (ConceptNode "pubmed:17541429")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "MAP2K4")
            (GeneNode "RBBP8")
         )
      )
      (ConceptNode "pubmed:21988832")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "MAP2K4")
            (GeneNode "NBR1")
         )
      )
      (ConceptNode "pubmed:25043814")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "MAP2K4")
            (GeneNode "MAP3K3")
         )
      )
      (ConceptNode "pubmed:9162092")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "MAP2K4")
            (GeneNode "MAP3K3")
         )
      )
      (ConceptNode "pubmed:25043814")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "MAP2K4")
            (GeneNode "NBR1")
         )
      )
      (ConceptNode "pubmed:25043814")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "MAP2K4")
            (GeneNode "KTI12")
         )
      )
      (ConceptNode "pubmed:26344197")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "MAP2K4")
            (GeneNode "VASP")
         )
      )
      (ConceptNode "pubmed:26344197")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "MAP2K4")
            (GeneNode "FLNB")
         )
      )
      (ConceptNode "pubmed:19270716")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "SPAG9")
            (GeneNode "MAP2K4")
         )
      )
      (ConceptNode "pubmed:12391307")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "SPAG9")
            (GeneNode "MAPK8")
         )
      )
      (ConceptNode "pubmed:12391307")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "SPAG9")
            (GeneNode "MAP2K4")
         )
      )
      (ConceptNode "pubmed:12391307")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "SPAG9")
            (GeneNode "MAP3K3")
         )
      )
      (ConceptNode "pubmed:12391307")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "SPAG9")
            (GeneNode "NDRG1")
         )
      )
      (ConceptNode "pubmed:22939629")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "SPAG9")
            (GeneNode "NENF")
         )
      )
      (ConceptNode "pubmed:22939629")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "SPAG9")
            (GeneNode "CD2AP")
         )
      )
      (ConceptNode "pubmed:22863883")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "SPAG9")
            (GeneNode "HUWE1")
         )
      )
      (ConceptNode "pubmed:22863883")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "SPAG9")
            (GeneNode "LARP7")
         )
      )
      (ConceptNode "pubmed:22863883")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "SPAG9")
            (GeneNode "NOLC1")
         )
      )
      (ConceptNode "pubmed:22863883")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "SPAG9")
            (GeneNode "RABEP2")
         )
      )
      (ConceptNode "pubmed:22863883")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "SPAG9")
            (GeneNode "TXNDC9")
         )
      )
      (ConceptNode "pubmed:22863883")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "SPAG9")
            (GeneNode "ABL1")
         )
      )
      (ConceptNode "pubmed:19470755")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "SPAG9")
            (GeneNode "USP15")
         )
      )
      (ConceptNode "pubmed:27173435")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "SPAG9")
            (GeneNode "MCM2")
         )
      )
      (ConceptNode "pubmed:27173435")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "SPAG9")
            (GeneNode "MCM4")
         )
      )
      (ConceptNode "pubmed:27173435")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "SPAG9")
            (GeneNode "MCM6")
         )
      )
      (ConceptNode "pubmed:27173435")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "SPAG9")
            (GeneNode "IVNS1ABP")
         )
      )
      (ConceptNode "pubmed:27173435")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "SPAG9")
            (GeneNode "SMC1A")
         )
      )
      (ConceptNode "pubmed:27173435")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "SPAG9")
            (GeneNode "ANK3")
         )
      )
      (ConceptNode "pubmed:27173435")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "SPAG9")
            (GeneNode "GAPVD1")
         )
      )
      (ConceptNode "pubmed:27173435")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "SPAG9")
            (GeneNode "SMC3")
         )
      )
      (ConceptNode "pubmed:27173435")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "SPAG9")
            (GeneNode "SBNO1")
         )
      )
      (ConceptNode "pubmed:27173435")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "SPAG9")
            (GeneNode "SOX4")
         )
      )
      (ConceptNode "pubmed:27173435")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "SPAG9")
            (GeneNode "PPP4R2")
         )
      )
      (ConceptNode "pubmed:27173435")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "SPAG9")
            (GeneNode "HSF1")
         )
      )
      (ConceptNode "pubmed:27173435")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "SPAG9")
            (GeneNode "KIAA1468")
         )
      )
      (ConceptNode "pubmed:27173435")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "SPAG9")
            (GeneNode "MCM7")
         )
      )
      (ConceptNode "pubmed:27173435")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "SPAG9")
            (GeneNode "PLK1")
         )
      )
      (ConceptNode "pubmed:27173435")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "SPAG9")
            (GeneNode "PLK1")
         )
      )
      (ConceptNode "pubmed:19596235")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "SPAG9")
            (GeneNode "PLK1")
         )
      )
      (ConceptNode "pubmed:28514442")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "SPAG9")
            (GeneNode "ATG2B")
         )
      )
      (ConceptNode "pubmed:27173435")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "SPAG9")
            (GeneNode "SMEK1")
         )
      )
      (ConceptNode "pubmed:27173435")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "SPAG9")
            (GeneNode "WEE1")
         )
      )
      (ConceptNode "pubmed:27173435")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "SPAG9")
            (GeneNode "MAX")
         )
      )
      (ConceptNode "pubmed:12391307")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "JUN")
            (GeneNode "MAPK1")
         )
      )
      (ConceptNode "pubmed:29225075")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "JUN")
            (GeneNode "MAPK1")
         )
      )
      (ConceptNode "pubmed:10419510")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "JUN")
            (GeneNode "MAPK1")
         )
      )
      (ConceptNode "pubmed:11431474")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "GEMIN5")
            (GeneNode "MAPK8")
         )
      )
      (ConceptNode "pubmed:17541429")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "SMC1A")
            (GeneNode "USP15")
         )
      )
      (ConceptNode "pubmed:27173435")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "MCM6")
            (GeneNode "GAPVD1")
         )
      )
      (ConceptNode "pubmed:27173435")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "USP15")
            (GeneNode "IVNS1ABP")
         )
      )
      (ConceptNode "pubmed:27173435")
   )
)
 (EvaluationLink
   (PredicateNode "has_pubmedID")
   (ListLink
      (EvaluationLink
         (PredicateNode "interacts_with")
         (ListLink
            (GeneNode "SMC1A")
            (GeneNode "LARP7")
         )
      )
      (ConceptNode "pubmed:29845934")
   )
)

(EvaluationLink
(PredicateNode "has_entrez_id")
(ListLink 
(GeneNode "MAP2K4")
(ConceptNode "entrez:6416")))

(EvaluationLink
(PredicateNode "has_entrez_id")
(ListLink 
(GeneNode "SPAG9")
(ConceptNode "entrez:9043")))


;; Output genes interacting eachother

 (EvaluationLink
   (PredicateNode "interacts_with")
   (ListLink
      (GeneNode "JUN")
      (GeneNode "MAPK1")
   )
)

 (EvaluationLink
   (PredicateNode "interacts_with")
   (ListLink
      (GeneNode "GEMIN5")
      (GeneNode "MAPK8")
   )
)

   (EvaluationLink
      (PredicateNode "interacts_with")
      (ListLink
         (GeneNode "SMC1A")
         (GeneNode "USP15")
      )
   )
   (EvaluationLink
      (PredicateNode "interacts_with")
      (ListLink
         (GeneNode "MCM6")
         (GeneNode "GAPVD1")
      )
   )
   (EvaluationLink
      (PredicateNode "interacts_with")
      (ListLink
         (GeneNode "USP15")
         (GeneNode "IVNS1ABP")
      )
   )
   (EvaluationLink
      (PredicateNode "interacts_with")
      (ListLink
         (GeneNode "SMC1A")
         (GeneNode "LARP7")
      )
   )

;;;;; Details about each gene interacting with given gene MAP2K4 and SPAG9

(EvaluationLink
   (PredicateNode "has_entrez_id")
   (ListLink
      (GeneNode "KTI12")
      (ConceptNode "entrez:112970")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (GeneNode "KTI12")
      (ConceptNode "Protein KTI12 homolog")
   )
)
 (EvaluationLink
   (PredicateNode "has_entrez_id")
   (ListLink
      (GeneNode "NBR1")
      (ConceptNode "entrez:4077")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (GeneNode "NBR1")
      (ConceptNode "Next to BRCA1 gene 1 protein")
   )
)
 (EvaluationLink
   (PredicateNode "has_entrez_id")
   (ListLink
      (GeneNode "MAPK1")
      (ConceptNode "entrez:5594")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (GeneNode "MAPK1")
      (ConceptNode "Mitogen-activated protein kinase 1")
   )
)
 (EvaluationLink
   (PredicateNode "has_entrez_id")
   (ListLink
      (GeneNode "AKT1")
      (ConceptNode "entrez:207")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (GeneNode "AKT1")
      (ConceptNode "RAC-alpha serine/threonine-protein kinase")
   )
)
 (EvaluationLink
   (PredicateNode "has_entrez_id")
   (ListLink
      (GeneNode "MAPK8")
      (ConceptNode "entrez:5599")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (GeneNode "MAPK8")
      (ConceptNode "Mitogen-activated protein kinase 8")
   )
)
 (EvaluationLink
   (PredicateNode "has_entrez_id")
   (ListLink
      (GeneNode "MAP3K1")
      (ConceptNode "entrez:4214")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (GeneNode "MAP3K1")
      (ConceptNode "Mitogen-activated protein kinase kinase kinase 1")
   )
)
 (EvaluationLink
   (PredicateNode "has_entrez_id")
   (ListLink
      (GeneNode "MAP3K3")
      (ConceptNode "entrez:4215")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (GeneNode "MAP3K3")
      (ConceptNode "Mitogen-activated protein kinase kinase kinase 3")
   )
)
 (EvaluationLink
   (PredicateNode "has_entrez_id")
   (ListLink
      (GeneNode "MAP3K7")
      (ConceptNode "entrez:6885")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (GeneNode "MAP3K7")
      (ConceptNode "Mitogen-activated protein kinase kinase kinase 7")
   )
)
 (EvaluationLink
   (PredicateNode "has_entrez_id")
   (ListLink
      (GeneNode "Flna")
      (ConceptNode "entrez:192176")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (GeneNode "Flna")
   )
)
 (EvaluationLink
   (PredicateNode "has_entrez_id")
   (ListLink
      (GeneNode "MAP2K7")
      (ConceptNode "entrez:5609")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (GeneNode "MAP2K7")
      (ConceptNode "Dual specificity mitogen-activated protein kinase kinase 7")
   )
)
 (EvaluationLink
   (PredicateNode "has_entrez_id")
   (ListLink
      (GeneNode "RBBP8")
      (ConceptNode "entrez:5932")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (GeneNode "RBBP8")
      (ConceptNode "DNA endonuclease RBBP8")
   )
)
 (EvaluationLink
   (PredicateNode "has_entrez_id")
   (ListLink
      (GeneNode "MAP3K5")
      (ConceptNode "entrez:4217")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (GeneNode "MAP3K5")
      (ConceptNode "Mitogen-activated protein kinase kinase kinase 5")
   )
)
 (EvaluationLink
   (PredicateNode "has_entrez_id")
   (ListLink
      (GeneNode "ITCH")
      (ConceptNode "entrez:83737")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (GeneNode "ITCH")
      (ConceptNode "E3 ubiquitin-protein ligase Itchy homolog")
   )
)
 (EvaluationLink
   (PredicateNode "has_entrez_id")
   (ListLink
      (GeneNode "MAP3K4")
      (ConceptNode "entrez:4216")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (GeneNode "MAP3K4")
      (ConceptNode "Mitogen-activated protein kinase kinase kinase 4")
   )
)
 (EvaluationLink
   (PredicateNode "has_entrez_id")
   (ListLink
      (GeneNode "VASP")
      (ConceptNode "entrez:7408")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (GeneNode "VASP")
      (ConceptNode "Vasodilator-stimulated phosphoprotein")
   )
)
 (EvaluationLink
   (PredicateNode "has_entrez_id")
   (ListLink
      (GeneNode "GEMIN5")
      (ConceptNode "entrez:25929")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (GeneNode "GEMIN5")
      (ConceptNode "Gem-associated protein 5")
   )
)
 (EvaluationLink
   (PredicateNode "has_entrez_id")
   (ListLink
      (GeneNode "MAPK14")
      (ConceptNode "entrez:1432")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (GeneNode "MAPK14")
      (ConceptNode "Mitogen-activated protein kinase 14")
   )
)
 (EvaluationLink
   (PredicateNode "has_entrez_id")
   (ListLink
      (GeneNode "JUN")
      (ConceptNode "entrez:3725")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (GeneNode "JUN")
      (ConceptNode "Transcription factor AP-1")
   )
)
 (EvaluationLink
   (PredicateNode "has_entrez_id")
   (ListLink
      (GeneNode "PML")
      (ConceptNode "entrez:5371")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (GeneNode "PML")
      (ConceptNode "Protein PML")
   )
)
 (EvaluationLink
   (PredicateNode "has_entrez_id")
   (ListLink
      (GeneNode "MAPK10")
      (ConceptNode "entrez:5602")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (GeneNode "MAPK10")
      (ConceptNode "Mitogen-activated protein kinase 10")
   )
)
 (EvaluationLink
   (PredicateNode "has_entrez_id")
   (ListLink
      (GeneNode "FLNC")
      (ConceptNode "entrez:2318")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (GeneNode "FLNC")
      (ConceptNode "Filamin-C")
   )
)
 (EvaluationLink
   (PredicateNode "has_entrez_id")
   (ListLink
      (GeneNode "APP")
      (ConceptNode "entrez:351")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (GeneNode "APP")
      (ConceptNode "Amyloid-beta A4 protein")
   )
)
 (EvaluationLink
   (PredicateNode "has_entrez_id")
   (ListLink
      (GeneNode "MAPK9")
      (ConceptNode "entrez:5601")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (GeneNode "MAPK9")
      (ConceptNode "Mitogen-activated protein kinase 9")
   )
)
 (EvaluationLink
   (PredicateNode "has_entrez_id")
   (ListLink
      (GeneNode "FLNB")
      (ConceptNode "entrez:2317")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (GeneNode "FLNB")
      (ConceptNode "Filamin-B")
   )
)

(EvaluationLink
   (PredicateNode "has_entrez_id")
   (ListLink
      (GeneNode "IVNS1ABP")
      (ConceptNode "entrez:10625")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (GeneNode "IVNS1ABP")
      (ConceptNode "Influenza virus NS1A-binding protein")
   )
)
 (EvaluationLink
   (PredicateNode "has_entrez_id")
   (ListLink
      (GeneNode "MCM4")
      (ConceptNode "entrez:856130")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (GeneNode "MCM4")
      (ConceptNode "DNA replication licensing factor MCM4")
   )
)
 (EvaluationLink
   (PredicateNode "has_entrez_id")
   (ListLink
      (GeneNode "PLK1")
      (ConceptNode "entrez:5347")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (GeneNode "PLK1")
      (ConceptNode "Serine/threonine-protein kinase PLK1")
   )
)
 (EvaluationLink
   (PredicateNode "has_entrez_id")
   (ListLink
      (GeneNode "NOLC1")
      (ConceptNode "entrez:9221")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (GeneNode "NOLC1")
      (ConceptNode "Nucleolar and coiled-body phosphoprotein 1")
   )
)
 (EvaluationLink
   (PredicateNode "has_entrez_id")
   (ListLink
      (GeneNode "MAP2K4")
      (ConceptNode "entrez:6416")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (GeneNode "MAP2K4")
      (ConceptNode "Dual specificity mitogen-activated protein kinase kinase 4")
   )
)
 (EvaluationLink
   (PredicateNode "has_entrez_id")
   (ListLink
      (GeneNode "MAX")
      (ConceptNode "entrez:4149")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (GeneNode "MAX")
      (ConceptNode "Protein max")
   )
)
 (EvaluationLink
   (PredicateNode "has_entrez_id")
   (ListLink
      (GeneNode "ABL1")
      (ConceptNode "entrez:25")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (GeneNode "ABL1")
      (ConceptNode "Tyrosine-protein kinase ABL1")
   )
)
 (EvaluationLink
   (PredicateNode "has_entrez_id")
   (ListLink
      (GeneNode "MCM7")
      (ConceptNode "entrez:4176")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (GeneNode "MCM7")
      (ConceptNode "DNA replication licensing factor MCM7")
   )
)
 (EvaluationLink
   (PredicateNode "has_entrez_id")
   (ListLink
      (GeneNode "LARP7")
      (ConceptNode "entrez:51574")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (GeneNode "LARP7")
      (ConceptNode "La-related protein 7")
   )
)
 (EvaluationLink
   (PredicateNode "has_entrez_id")
   (ListLink
      (GeneNode "TXNDC9")
      (ConceptNode "entrez:10190")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (GeneNode "TXNDC9")
      (ConceptNode "Thioredoxin domain-containing protein 9")
   )
)
 (EvaluationLink
   (PredicateNode "has_entrez_id")
   (ListLink
      (GeneNode "HSF1")
      (ConceptNode "entrez:422169")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (GeneNode "HSF1")
      (ConceptNode "Heat shock factor protein 1")
   )
)
 (EvaluationLink
   (PredicateNode "has_entrez_id")
   (ListLink
      (GeneNode "NDRG1")
      (ConceptNode "entrez:10397")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (GeneNode "NDRG1")
      (ConceptNode "Protein NDRG1")
   )
)
 (EvaluationLink
   (PredicateNode "has_entrez_id")
   (ListLink
      (GeneNode "SMC1A")
      (ConceptNode "entrez:8243")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (GeneNode "SMC1A")
      (ConceptNode "Structural maintenance of chromosomes protein 1A")
   )
)
 (EvaluationLink
   (PredicateNode "has_entrez_id")
   (ListLink
      (GeneNode "USP15")
      (ConceptNode "entrez:9958")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (GeneNode "USP15")
      (ConceptNode "Ubiquitin carboxyl-terminal hydrolase 15")
   )
)
 (EvaluationLink
   (PredicateNode "has_entrez_id")
   (ListLink
      (GeneNode "NENF")
      (ConceptNode "entrez:29937")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (GeneNode "NENF")
      (ConceptNode "Neudesin")
   )
)
 (EvaluationLink
   (PredicateNode "has_entrez_id")
   (ListLink
      (GeneNode "MCM2")
      (ConceptNode "entrez:4171")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (GeneNode "MCM2")
      (ConceptNode "DNA replication licensing factor MCM2")
   )
)
 (EvaluationLink
   (PredicateNode "has_entrez_id")
   (ListLink
      (GeneNode "MAPK8")
      (ConceptNode "entrez:5599")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (GeneNode "MAPK8")
      (ConceptNode "Mitogen-activated protein kinase 8")
   )
)
 (EvaluationLink
   (PredicateNode "has_entrez_id")
   (ListLink
      (GeneNode "SOX4")
      (ConceptNode "entrez:6659")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (GeneNode "SOX4")
      (ConceptNode "Transcription factor SOX-4")
   )
)
 (EvaluationLink
   (PredicateNode "has_entrez_id")
   (ListLink
      (GeneNode "MAP3K3")
      (ConceptNode "entrez:4215")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (GeneNode "MAP3K3")
      (ConceptNode "Mitogen-activated protein kinase kinase kinase 3")
   )
)
 (EvaluationLink
   (PredicateNode "has_entrez_id")
   (ListLink
      (GeneNode "HUWE1")
      (ConceptNode "entrez:10075")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (GeneNode "HUWE1")
      (ConceptNode "E3 ubiquitin-protein ligase HUWE1")
   )
)
 (EvaluationLink
   (PredicateNode "has_entrez_id")
   (ListLink
      (GeneNode "GAPVD1")
      (ConceptNode "entrez:26130")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (GeneNode "GAPVD1")
      (ConceptNode "GTPase-activating protein and VPS9 domain-containing protein 1")
   )
)
 (EvaluationLink
   (PredicateNode "has_entrez_id")
   (ListLink
      (GeneNode "MCM6")
      (ConceptNode "entrez:4175")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (GeneNode "MCM6")
      (ConceptNode "DNA replication licensing factor MCM6")
   )
)
 (EvaluationLink
   (PredicateNode "has_entrez_id")
   (ListLink
      (GeneNode "PPP4R2")
      (ConceptNode "entrez:151987")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (GeneNode "PPP4R2")
      (ConceptNode "Serine/threonine-protein phosphatase 4 regulatory subunit 2")
   )
)
 (EvaluationLink
   (PredicateNode "has_entrez_id")
   (ListLink
      (GeneNode "KIAA1468")
      (ConceptNode "entrez:57614")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (GeneNode "KIAA1468")
   )
)
 (EvaluationLink
   (PredicateNode "has_entrez_id")
   (ListLink
      (GeneNode "SMC3")
      (ConceptNode "entrez:9126")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (GeneNode "SMC3")
      (ConceptNode "Structural maintenance of chromosomes protein 3")
   )
)
 (EvaluationLink
   (PredicateNode "has_entrez_id")
   (ListLink
      (GeneNode "WEE1")
      (ConceptNode "entrez:7465")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (GeneNode "WEE1")
      (ConceptNode "Wee1-like protein kinase")
   )
)
 (EvaluationLink
   (PredicateNode "has_entrez_id")
   (ListLink
      (GeneNode "SBNO1")
      (ConceptNode "entrez:55206")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (GeneNode "SBNO1")
      (ConceptNode "Protein strawberry notch homolog 1")
   )
)
 (EvaluationLink
   (PredicateNode "has_entrez_id")
   (ListLink
      (GeneNode "MAPK14")
      (ConceptNode "entrez:1432")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (GeneNode "MAPK14")
      (ConceptNode "Mitogen-activated protein kinase 14")
   )
)
 (EvaluationLink
   (PredicateNode "has_entrez_id")
   (ListLink
      (GeneNode "ANK3")
      (ConceptNode "entrez:288")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (GeneNode "ANK3")
      (ConceptNode "Ankyrin-3")
   )
)
 (EvaluationLink
   (PredicateNode "has_entrez_id")
   (ListLink
      (GeneNode "SMEK1")
      (ConceptNode "entrez:55671")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (GeneNode "SMEK1")
   )
)
 (EvaluationLink
   (PredicateNode "has_entrez_id")
   (ListLink
      (GeneNode "ATG2B")
      (ConceptNode "entrez:55102")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (GeneNode "ATG2B")
      (ConceptNode "Autophagy-related protein 2 homolog B")
   )
)
 (EvaluationLink
   (PredicateNode "has_entrez_id")
   (ListLink
      (GeneNode "RABEP2")
      (ConceptNode "entrez:79874")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (GeneNode "RABEP2")
      (ConceptNode "Rab GTPase-binding effector protein 2")
   )
)
 (EvaluationLink
   (PredicateNode "has_entrez_id")
   (ListLink
      (GeneNode "CD2AP")
      (ConceptNode "entrez:23607")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (GeneNode "CD2AP")
      (ConceptNode "CD2-associated protein")
   )
)

;; Genes MAP2K4 and SPAG9 and GO catagories (with their detail)
;; GO annotations

(EvaluationLink
(PredicateNode "has_name")
(ListLink 
(GeneNode "SPAG9")
(ConceptNode "C-Jun-amino-terminal kinase-interacting protein 4")))

(MemberLink 
 	(GeneNode "SPAG9")
	(ConceptNode "GO:0001669"))

(EvaluationLink 
	 (PredicateNode "GO_name")
	 (ListLink 
		 (ConceptNode "GO:0001669")
		 (ConceptNode "acrosomal vesicle")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_namespace")
	 (ListLink 
		 (ConceptNode "GO:0001669")
		 (ConceptNode "cellular_component")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_definition")
	 (ListLink 
		 (ConceptNode "GO:0001669")
		 (ConceptNode "A structure in the head of a spermatozoon that contains acid hydrolases, and is concerned with the breakdown of the outer membrane of the ovum during fertilization. It lies just beneath the plasma membrane and is derived from the lysosome.")
	 )
)

(MemberLink 
 	(GeneNode "SPAG9")
	(ConceptNode "GO:0005515"))

(EvaluationLink 
	 (PredicateNode "GO_name")
	 (ListLink 
		 (ConceptNode "GO:0005515")
		 (ConceptNode "protein binding")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_namespace")
	 (ListLink 
		 (ConceptNode "GO:0005515")
		 (ConceptNode "molecular_function")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_definition")
	 (ListLink 
		 (ConceptNode "GO:0005515")
		 (ConceptNode "Interacting selectively and non-covalently with any protein or protein complex [a complex of two or more proteins that may include other nonprotein molecules].")
	 )
)

(MemberLink 
 	(GeneNode "SPAG9")
	(ConceptNode "GO:0005815"))

(EvaluationLink 
	 (PredicateNode "GO_name")
	 (ListLink 
		 (ConceptNode "GO:0005815")
		 (ConceptNode "microtubule organizing center")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_namespace")
	 (ListLink 
		 (ConceptNode "GO:0005815")
		 (ConceptNode "cellular_component")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_definition")
	 (ListLink 
		 (ConceptNode "GO:0005815")
		 (ConceptNode "An intracellular structure that can catalyze gamma-tubulin-dependent microtubule nucleation and that can anchor microtubules by interacting with their minus ends, plus ends or sides.")
	 )
)

(MemberLink 
 	(GeneNode "SPAG9")
	(ConceptNode "GO:0005829"))

(EvaluationLink 
	 (PredicateNode "GO_name")
	 (ListLink 
		 (ConceptNode "GO:0005829")
		 (ConceptNode "cytosol")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_namespace")
	 (ListLink 
		 (ConceptNode "GO:0005829")
		 (ConceptNode "cellular_component")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_definition")
	 (ListLink 
		 (ConceptNode "GO:0005829")
		 (ConceptNode "The part of the cytoplasm that does not contain organelles but which does contain other particulate matter, such as protein complexes.")
	 )
)

(MemberLink 
 	(GeneNode "SPAG9")
	(ConceptNode "GO:0030335"))
(EvaluationLink 
	 (PredicateNode "GO_name")
	 (ListLink 
		 (ConceptNode "GO:0030335")
		 (ConceptNode "positive regulation of cell migration")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_namespace")
	 (ListLink 
		 (ConceptNode "GO:0030335")
		 (ConceptNode "biological_process")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_definition")
	 (ListLink 
		 (ConceptNode "GO:0030335")
		 (ConceptNode "Any process that activates or increases the frequency, rate or extent of cell migration.")
	 )
)

(MemberLink 
 	(GeneNode "SPAG9")
	(ConceptNode "GO:0042147"))
(EvaluationLink 
	 (PredicateNode "GO_name")
	 (ListLink 
		 (ConceptNode "GO:0042147")
		 (ConceptNode "retrograde transport, endosome to Golgi")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_namespace")
	 (ListLink 
		 (ConceptNode "GO:0042147")
		 (ConceptNode "biological_process")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_definition")
	 (ListLink 
		 (ConceptNode "GO:0042147")
		 (ConceptNode "The directed movement of membrane-bounded vesicles from endosomes back to the trans-Golgi network where they are recycled for further rounds of transport.")
	 )
)

(MemberLink 
 	(GeneNode "SPAG9")
	(ConceptNode "GO:0045666"))

(EvaluationLink 
	 (PredicateNode "GO_name")
	 (ListLink 
		 (ConceptNode "GO:0045666")
		 (ConceptNode "positive regulation of neuron differentiation")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_namespace")
	 (ListLink 
		 (ConceptNode "GO:0045666")
		 (ConceptNode "biological_process")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_definition")
	 (ListLink 
		 (ConceptNode "GO:0045666")
		 (ConceptNode "Any process that activates or increases the frequency, rate or extent of neuron differentiation.")
	 )
)

(MemberLink 
 	(GeneNode "SPAG9")
	(ConceptNode "GO:0048471"))
(EvaluationLink 
	 (PredicateNode "GO_name")
	 (ListLink 
		 (ConceptNode "GO:0048471")
		 (ConceptNode "perinuclear region of cytoplasm")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_namespace")
	 (ListLink 
		 (ConceptNode "GO:0048471")
		 (ConceptNode "cellular_component")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_definition")
	 (ListLink 
		 (ConceptNode "GO:0048471")
		 (ConceptNode "Cytoplasm situated near, or occurring around, the nucleus.")
	 )
)

(MemberLink 
 	(GeneNode "SPAG9")
	(ConceptNode "GO:0051146"))
(EvaluationLink 
	 (PredicateNode "GO_name")
	 (ListLink 
		 (ConceptNode "GO:0051146")
		 (ConceptNode "striated muscle cell differentiation")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_namespace")
	 (ListLink 
		 (ConceptNode "GO:0051146")
		 (ConceptNode "biological_process")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_definition")
	 (ListLink 
		 (ConceptNode "GO:0051146")
		 (ConceptNode "The process in which a relatively unspecialized cell acquires specialized features of a striated muscle cell; striated muscle fibers are divided by transverse bands into striations, and cardiac and voluntary muscle are types of striated muscle.")
	 )
)

(MemberLink 
 	(GeneNode "SPAG9")
	(ConceptNode "GO:0051149"))

(EvaluationLink 
	 (PredicateNode "GO_name")
	 (ListLink 
		 (ConceptNode "GO:0051149")
		 (ConceptNode "positive regulation of muscle cell differentiation")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_namespace")
	 (ListLink 
		 (ConceptNode "GO:0051149")
		 (ConceptNode "biological_process")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_definition")
	 (ListLink 
		 (ConceptNode "GO:0051149")
		 (ConceptNode "Any process that activates or increases the frequency, rate or extent of muscle cell differentiation.")
	 )
)

(MemberLink 
 	(GeneNode "SPAG9")
	(ConceptNode "GO:0051260"))
(EvaluationLink 
	 (PredicateNode "GO_name")
	 (ListLink 
		 (ConceptNode "GO:0051260")
		 (ConceptNode "protein homooligomerization")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_namespace")
	 (ListLink 
		 (ConceptNode "GO:0051260")
		 (ConceptNode "biological_process")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_definition")
	 (ListLink 
		 (ConceptNode "GO:0051260")
		 (ConceptNode "The process of creating protein oligomers, compounds composed of a small number, usually between three and ten, of identical component monomers. Oligomers may be formed by the polymerization of a number of monomers or the depolymerization of a large protein polymer.")
	 )
)

(MemberLink 
 	(GeneNode "SPAG9")
	(ConceptNode "GO:0070062"))
(EvaluationLink 
	 (PredicateNode "GO_name")
	 (ListLink 
		 (ConceptNode "GO:0070062")
		 (ConceptNode "extracellular exosome")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_namespace")
	 (ListLink 
		 (ConceptNode "GO:0070062")
		 (ConceptNode "cellular_component")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_definition")
	 (ListLink 
		 (ConceptNode "GO:0070062")
		 (ConceptNode "A vesicle that is released into the extracellular region by fusion of the limiting endosomal membrane of a multivesicular body with the plasma membrane. Extracellular exosomes, also simply called exosomes, have a diameter of about 40-100 nm.")
	 )
)

(MemberLink 
 	(GeneNode "SPAG9")
	(ConceptNode "GO:0030159"))
(EvaluationLink 
	 (PredicateNode "GO_name")
	 (ListLink 
		 (ConceptNode "GO:0030159")
		 (ConceptNode "receptor signaling complex scaffold activity")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_namespace")
	 (ListLink 
		 (ConceptNode "GO:0030159")
		 (ConceptNode "molecular_function")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_definition")
	 (ListLink 
		 (ConceptNode "GO:0030159")
		 (ConceptNode "Functions to provide a physical support for the assembly of a multiprotein receptor signaling complex.")
	 )
)

(MemberLink 
 	(GeneNode "SPAG9")
	(ConceptNode "GO:0005078"))
(EvaluationLink 
	 (PredicateNode "GO_name")
	 (ListLink 
		 (ConceptNode "GO:0005078")
		 (ConceptNode "MAP-kinase scaffold activity")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_namespace")
	 (ListLink 
		 (ConceptNode "GO:0005078")
		 (ConceptNode "molecular_function")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_definition")
	 (ListLink 
		 (ConceptNode "GO:0005078")
		 (ConceptNode "The binding activity of a molecule that functions as a physical support for the assembly of a multiprotein mitogen-activated protein kinase [MAPK] complex. Binds multiple kinases of the MAPKKK cascade, and also upstream signaling proteins, permitting those molecules to function in a coordinated way. Bringing together multiple enzymes and their substrates enables the signal to be transduced quickly and efficiently.")
	 )
)

(MemberLink 
 	(GeneNode "SPAG9")
	(ConceptNode "GO:0007257"))
(EvaluationLink 
	 (PredicateNode "GO_name")
	 (ListLink 
		 (ConceptNode "GO:0007257")
		 (ConceptNode "activation of JUN kinase activity")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_namespace")
	 (ListLink 
		 (ConceptNode "GO:0007257")
		 (ConceptNode "biological_process")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_definition")
	 (ListLink 
		 (ConceptNode "GO:0007257")
		 (ConceptNode "The initiation of the activity of the inactive enzyme JUN kinase [JNK].")
	 )
)

(MemberLink 
 	(GeneNode "SPAG9")
	(ConceptNode "GO:0005737"))
(EvaluationLink 
	 (PredicateNode "GO_name")
	 (ListLink 
		 (ConceptNode "GO:0005737")
		 (ConceptNode "cytoplasm")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_namespace")
	 (ListLink 
		 (ConceptNode "GO:0005737")
		 (ConceptNode "cellular_component")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_definition")
	 (ListLink 
		 (ConceptNode "GO:0005737")
		 (ConceptNode "All of the contents of a cell excluding the plasma membrane and nucleus, but including other subcellular structures.")
	 )
)

(MemberLink 
 	(GeneNode "SPAG9")
	(ConceptNode "GO:0008432"))
(EvaluationLink 
	 (PredicateNode "GO_name")
	 (ListLink 
		 (ConceptNode "GO:0008432")
		 (ConceptNode "JUN kinase binding")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_namespace")
	 (ListLink 
		 (ConceptNode "GO:0008432")
		 (ConceptNode "molecular_function")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_definition")
	 (ListLink 
		 (ConceptNode "GO:0008432")
		 (ConceptNode "Interacting selectively and non-covalently with JUN kinase, an enzyme that catalyzes the phosphorylation and activation of members of the JUN family.")
	 )
)

(MemberLink 
 	(GeneNode "SPAG9")
	(ConceptNode "GO:0019894"))
(EvaluationLink 
	 (PredicateNode "GO_name")
	 (ListLink 
		 (ConceptNode "GO:0019894")
		 (ConceptNode "kinesin binding")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_namespace")
	 (ListLink 
		 (ConceptNode "GO:0019894")
		 (ConceptNode "molecular_function")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_definition")
	 (ListLink 
		 (ConceptNode "GO:0019894")
		 (ConceptNode "Interacting selectively and non-covalently and stoichiometrically with kinesin, a member of a superfamily of microtubule-based motor proteins that perform force-generating tasks such as organelle transport and chromosome segregation.")
	 )
)

(MemberLink 
 	(GeneNode "SPAG9")
	(ConceptNode "GO:0016192"))

(EvaluationLink 
	 (PredicateNode "GO_name")
	 (ListLink 
		 (ConceptNode "GO:0016192")
		 (ConceptNode "vesicle-mediated transport")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_namespace")
	 (ListLink 
		 (ConceptNode "GO:0016192")
		 (ConceptNode "biological_process")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_definition")
	 (ListLink 
		 (ConceptNode "GO:0016192")
		 (ConceptNode "A cellular transport process in which transported substances are moved in membrane-bounded vesicles; transported substances are enclosed in the vesicle lumen or located in the vesicle membrane. The process begins with a step that directs a substance to the forming vesicle, and includes vesicle budding and coating. Vesicles are then targeted to, and fuse with, an acceptor membrane.")
	 )
)
;;;

(EvaluationLink
(PredicateNode "has_name")
(ListLink 
(GeneNode "MAP2K4")
(ConceptNode "Dual specificity mitogen-activated protein kinase kinase 4")))

(MemberLink 
 	(GeneNode "MAP2K4")
	(ConceptNode "GO:0004672"))
(EvaluationLink 
	 (PredicateNode "GO_name")
	 (ListLink 
		 (ConceptNode "GO:0004672")
		 (ConceptNode "protein kinase activity")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_namespace")
	 (ListLink 
		 (ConceptNode "GO:0004672")
		 (ConceptNode "molecular_function")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_definition")
	 (ListLink 
		 (ConceptNode "GO:0004672")
		 (ConceptNode "Catalysis of the phosphorylation of an amino acid residue in a protein, usually according to the reaction: a protein + ATP = a phosphoprotein + ADP.")
	 )
)

(MemberLink 
 	(GeneNode "MAP2K4")
	(ConceptNode "GO:0004713"))
(EvaluationLink 
	 (PredicateNode "GO_name")
	 (ListLink 
		 (ConceptNode "GO:0004713")
		 (ConceptNode "protein tyrosine kinase activity")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_namespace")
	 (ListLink 
		 (ConceptNode "GO:0004713")
		 (ConceptNode "molecular_function")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_definition")
	 (ListLink 
		 (ConceptNode "GO:0004713")
		 (ConceptNode "Catalysis of the reaction: ATP + a protein tyrosine = ADP + protein tyrosine phosphate.")
	 )
)

(MemberLink 
 	(GeneNode "MAP2K4")
	(ConceptNode "GO:0005515"))
(EvaluationLink 
	 (PredicateNode "GO_name")
	 (ListLink 
		 (ConceptNode "GO:0005515")
		 (ConceptNode "protein binding")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_namespace")
	 (ListLink 
		 (ConceptNode "GO:0005515")
		 (ConceptNode "molecular_function")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_definition")
	 (ListLink 
		 (ConceptNode "GO:0005515")
		 (ConceptNode "Interacting selectively and non-covalently with any protein or protein complex [a complex of two or more proteins that may include other nonprotein molecules].")
	 )
)

(MemberLink 
 	(GeneNode "MAP2K4")
	(ConceptNode "GO:0005524"))
(InheritanceLink 
	 (ConceptNode "GO:0005524")
	 (ConceptNode "GO_term")
)

(EvaluationLink 
	 (PredicateNode "GO_name")
	 (ListLink 
		 (ConceptNode "GO:0005524")
		 (ConceptNode "ATP binding")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_namespace")
	 (ListLink 
		 (ConceptNode "GO:0005524")
		 (ConceptNode "molecular_function")
	 )
)

(MemberLink 
 	(GeneNode "MAP2K4")
	(ConceptNode "GO:0005634"))
(EvaluationLink 
	 (PredicateNode "GO_name")
	 (ListLink 
		 (ConceptNode "GO:0005634")
		 (ConceptNode "nucleus")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_namespace")
	 (ListLink 
		 (ConceptNode "GO:0005634")
		 (ConceptNode "cellular_component")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_definition")
	 (ListLink 
		 (ConceptNode "GO:0005634")
		 (ConceptNode "A membrane-bounded organelle of eukaryotic cells in which chromosomes are housed and replicated. In most cells, the nucleus contains all of the cell's chromosomes except the organellar chromosomes, and is the site of RNA synthesis and processing. In some species, or in specialized cell types, RNA metabolism or DNA replication may be absent.")
	 )
)

(MemberLink 
 	(GeneNode "MAP2K4")
	(ConceptNode "GO:0005829"))
(EvaluationLink 
	 (PredicateNode "GO_name")
	 (ListLink 
		 (ConceptNode "GO:0005829")
		 (ConceptNode "cytosol")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_namespace")
	 (ListLink 
		 (ConceptNode "GO:0005829")
		 (ConceptNode "cellular_component")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_definition")
	 (ListLink 
		 (ConceptNode "GO:0005829")
		 (ConceptNode "The part of the cytoplasm that does not contain organelles but which does contain other particulate matter, such as protein complexes.")
	 )
)
(MemberLink 
 	(GeneNode "MAP2K4")
	(ConceptNode "GO:0006915"))
(EvaluationLink 
	 (PredicateNode "GO_name")
	 (ListLink 
		 (ConceptNode "GO:0006915")
		 (ConceptNode "apoptotic process")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_namespace")
	 (ListLink 
		 (ConceptNode "GO:0006915")
		 (ConceptNode "biological_process")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_definition")
	 (ListLink 
		 (ConceptNode "GO:0006915")
		 (ConceptNode "A programmed cell death process which begins when a cell receives an internal [e.g. DNA damage] or external signal [e.g. an extracellular death ligand], and proceeds through a series of biochemical events [signaling pathway phase] which trigger an execution phase. The execution phase is the last step of an apoptotic process, and is typically characterized by rounding-up of the cell, retraction of pseudopodes, reduction of cellular volume [pyknosis], chromatin condensation, nuclear fragmentation [karyorrhexis], plasma membrane blebbing and fragmentation of the cell into apoptotic bodies. When the execution phase is completed, the cell has died.")
	 )
)

(MemberLink 
 	(GeneNode "MAP2K4")
	(ConceptNode "GO:0007165"))
(EvaluationLink 
	 (PredicateNode "GO_name")
	 (ListLink 
		 (ConceptNode "GO:0007165")
		 (ConceptNode "signal transduction")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_namespace")
	 (ListLink 
		 (ConceptNode "GO:0007165")
		 (ConceptNode "biological_process")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_definition")
	 (ListLink 
		 (ConceptNode "GO:0007165")
		 (ConceptNode "The cellular process in which a signal is conveyed to trigger a change in the activity or state of a cell. Signal transduction begins with reception of a signal [e.g. a ligand binding to a receptor or receptor activation by a stimulus such as light], or for signal transduction in the absence of ligand, signal-withdrawal or the activity of a constitutively active receptor. Signal transduction ends with regulation of a downstream cellular process, e.g. regulation of transcription or regulation of a metabolic process. Signal transduction covers signaling from receptors located on the surface of the cell and signaling via molecules located within the cell. For signaling between cells, signal transduction is restricted to events at and within the receiving cell.")
	 )
)

(MemberLink 
 	(GeneNode "MAP2K4")
	(ConceptNode "GO:0007254"))
(EvaluationLink 
	 (PredicateNode "GO_name")
	 (ListLink 
		 (ConceptNode "GO:0007254")
		 (ConceptNode "JNK cascade")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_namespace")
	 (ListLink 
		 (ConceptNode "GO:0007254")
		 (ConceptNode "biological_process")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_definition")
	 (ListLink 
		 (ConceptNode "GO:0007254")
		 (ConceptNode "An intracellular protein kinase cascade containing at least a JNK [a MAPK], a JNKK [a MAPKK] and a JUN3K [a MAP3K]. The cascade can also contain two additional tiers: the upstream MAP4K and the downstream MAP Kinase-activated kinase [MAPKAPK]. The kinases in each tier phosphorylate and activate the kinases in the downstream tier to transmit a signal within a cell.")
	 )
)


(MemberLink 
 	(GeneNode "MAP2K4")
	(ConceptNode "GO:0009611"))
(EvaluationLink 
	 (PredicateNode "GO_name")
	 (ListLink 
		 (ConceptNode "GO:0009611")
		 (ConceptNode "response to wounding")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_namespace")
	 (ListLink 
		 (ConceptNode "GO:0009611")
		 (ConceptNode "biological_process")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_definition")
	 (ListLink 
		 (ConceptNode "GO:0009611")
		 (ConceptNode "Any process that results in a change in state or activity of a cell or an organism [in terms of movement, secretion, enzyme production, gene expression, etc.] as a result of a stimulus indicating damage to the organism.")
	 )
)

(MemberLink 
 	(GeneNode "MAP2K4")
	(ConceptNode "GO:0018108"))
(EvaluationLink 
	 (PredicateNode "GO_name")
	 (ListLink 
		 (ConceptNode "GO:0018108")
		 (ConceptNode "peptidyl-tyrosine phosphorylation")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_namespace")
	 (ListLink 
		 (ConceptNode "GO:0018108")
		 (ConceptNode "biological_process")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_definition")
	 (ListLink 
		 (ConceptNode "GO:0018108")
		 (ConceptNode "The phosphorylation of peptidyl-tyrosine to form peptidyl-O4'-phospho-L-tyrosine.")
	 )
)

(MemberLink 
 	(GeneNode "MAP2K4")
	(ConceptNode "GO:0030424"))
(EvaluationLink 
	 (PredicateNode "GO_name")
	 (ListLink 
		 (ConceptNode "GO:0030424")
		 (ConceptNode "axon")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_namespace")
	 (ListLink 
		 (ConceptNode "GO:0030424")
		 (ConceptNode "cellular_component")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_definition")
	 (ListLink 
		 (ConceptNode "GO:0030424")
		 (ConceptNode "The long process of a neuron that conducts nerve impulses, usually away from the cell body to the terminals and varicosities, which are sites of storage and release of neurotransmitter.")
	 )
)
(MemberLink 
 	(GeneNode "MAP2K4")
	(ConceptNode "GO:0031435"))
(EvaluationLink 
	 (PredicateNode "GO_name")
	 (ListLink 
		 (ConceptNode "GO:0031435")
		 (ConceptNode "mitogen-activated protein kinase kinase kinase binding")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_namespace")
	 (ListLink 
		 (ConceptNode "GO:0031435")
		 (ConceptNode "molecular_function")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_definition")
	 (ListLink 
		 (ConceptNode "GO:0031435")
		 (ConceptNode "Interacting selectively and non-covalently with a mitogen-activated protein kinase kinase kinase, any protein that can phosphorylate a MAP kinase kinase.")
	 )
)

(MemberLink 
 	(GeneNode "MAP2K4")
	(ConceptNode "GO:0032839"))
(EvaluationLink 
	 (PredicateNode "GO_name")
	 (ListLink 
		 (ConceptNode "GO:0032839")
		 (ConceptNode "dendrite cytoplasm")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_namespace")
	 (ListLink 
		 (ConceptNode "GO:0032839")
		 (ConceptNode "cellular_component")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_definition")
	 (ListLink 
		 (ConceptNode "GO:0032839")
		 (ConceptNode "All of the contents of a dendrite, excluding the surrounding plasma membrane.")
	 )
)


(MemberLink 
 	(GeneNode "MAP2K4")
	(ConceptNode "GO:0034393"))
(EvaluationLink 
	 (PredicateNode "GO_name")
	 (ListLink 
		 (ConceptNode "GO:0034393")
		 (ConceptNode "positive regulation of smooth muscle cell apoptotic process")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_namespace")
	 (ListLink 
		 (ConceptNode "GO:0034393")
		 (ConceptNode "biological_process")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_definition")
	 (ListLink 
		 (ConceptNode "GO:0034393")
		 (ConceptNode "Any process that activates or increases the frequency, rate, or extent of smooth muscle cell apoptotic process.")
	 )
)


(MemberLink 
 	(GeneNode "MAP2K4")
	(ConceptNode "GO:0043204"))
(EvaluationLink 
	 (PredicateNode "GO_name")
	 (ListLink 
		 (ConceptNode "GO:0043204")
		 (ConceptNode "perikaryon")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_namespace")
	 (ListLink 
		 (ConceptNode "GO:0043204")
		 (ConceptNode "cellular_component")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_definition")
	 (ListLink 
		 (ConceptNode "GO:0043204")
		 (ConceptNode "The portion of the cell soma [neuronal cell body] that excludes the nucleus.")
	 )
)

(MemberLink 
 	(GeneNode "MAP2K4")
	(ConceptNode "GO:0043525"))
(EvaluationLink 
	 (PredicateNode "GO_name")
	 (ListLink 
		 (ConceptNode "GO:0043525")
		 (ConceptNode "positive regulation of neuron apoptotic process")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_namespace")
	 (ListLink 
		 (ConceptNode "GO:0043525")
		 (ConceptNode "biological_process")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_definition")
	 (ListLink 
		 (ConceptNode "GO:0043525")
		 (ConceptNode "Any process that activates or increases the frequency, rate or extent of cell death of neurons by apoptotic process.")
	 )
)

(MemberLink 
 	(GeneNode "MAP2K4")
	(ConceptNode "GO:0045740"))
(EvaluationLink 
	 (PredicateNode "GO_name")
	 (ListLink 
		 (ConceptNode "GO:0045740")
		 (ConceptNode "positive regulation of DNA replication")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_namespace")
	 (ListLink 
		 (ConceptNode "GO:0045740")
		 (ConceptNode "biological_process")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_definition")
	 (ListLink 
		 (ConceptNode "GO:0045740")
		 (ConceptNode "Any process that activates or increases the frequency, rate or extent of DNA replication.")
	 )
)

(MemberLink 
 	(GeneNode "MAP2K4")
	(ConceptNode "GO:0051770"))
(EvaluationLink 
	 (PredicateNode "GO_name")
	 (ListLink 
		 (ConceptNode "GO:0051770")
		 (ConceptNode "positive regulation of nitric-oxide synthase biosynthetic process")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_namespace")
	 (ListLink 
		 (ConceptNode "GO:0051770")
		 (ConceptNode "biological_process")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_definition")
	 (ListLink 
		 (ConceptNode "GO:0051770")
		 (ConceptNode "Any process that activates or increases the frequency, rate or extent of the chemical reactions and pathways resulting in the formation of a nitric oxide synthase enzyme.")
	 )
)

(MemberLink 
 	(GeneNode "MAP2K4")
	(ConceptNode "GO:0061049"))
(EvaluationLink 
	 (PredicateNode "GO_name")
	 (ListLink 
		 (ConceptNode "GO:0061049")
		 (ConceptNode "cell growth involved in cardiac muscle cell development")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_namespace")
	 (ListLink 
		 (ConceptNode "GO:0061049")
		 (ConceptNode "biological_process")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_definition")
	 (ListLink 
		 (ConceptNode "GO:0061049")
		 (ConceptNode "The growth of a cardiac muscle cell, where growth contributes to the progression of the cell over time from its initial formation to its mature state.")
	 )
)

(MemberLink 
 	(GeneNode "MAP2K4")
	(ConceptNode "GO:0071260"))
(EvaluationLink 
	 (PredicateNode "GO_name")
	 (ListLink 
		 (ConceptNode "GO:0071260")
		 (ConceptNode "cellular response to mechanical stimulus")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_namespace")
	 (ListLink 
		 (ConceptNode "GO:0071260")
		 (ConceptNode "biological_process")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_definition")
	 (ListLink 
		 (ConceptNode "GO:0071260")
		 (ConceptNode "Any process that results in a change in state or activity of a cell [in terms of movement, secretion, enzyme production, gene expression, etc.] as a result of a mechanical stimulus.")
	 )
)

(MemberLink 
 	(GeneNode "MAP2K4")
	(ConceptNode "GO:0072709"))
(EvaluationLink 
	 (PredicateNode "GO_name")
	 (ListLink 
		 (ConceptNode "GO:0072709")
		 (ConceptNode "cellular response to sorbitol")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_namespace")
	 (ListLink 
		 (ConceptNode "GO:0072709")
		 (ConceptNode "biological_process")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_definition")
	 (ListLink 
		 (ConceptNode "GO:0072709")
		 (ConceptNode "Any process that results in a change in state or activity of a cell [in terms of movement, secretion, enzyme production, gene expression, etc.] as a result of a sorbitol stimulus.")
	 )
)


(MemberLink 
 	(GeneNode "MAP2K4")
	(ConceptNode "GO:2000672"))
(EvaluationLink 
	 (PredicateNode "GO_name")
	 (ListLink 
		 (ConceptNode "GO:2000672")
		 (ConceptNode "negative regulation of motor neuron apoptotic process")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_namespace")
	 (ListLink 
		 (ConceptNode "GO:2000672")
		 (ConceptNode "biological_process")
	 )
)

(EvaluationLink 
	 (PredicateNode "GO_definition")
	 (ListLink 
		 (ConceptNode "GO:2000672")
		 (ConceptNode "Any process that stops, prevents or reduces the frequency, rate or extent of motor neuron apoptotic process.")
	 )
)

;;;
;; Pathways and proteins a given gene is part of

(MemberLink
   (GeneNode "MAP2K4")
   (ConceptNode "SMP0063792")
)
 (MemberLink
   (MoleculeNode "ChEBI:18420")
   (ConceptNode "SMP0063792")
)
 (MemberLink
   (MoleculeNode "ChEBI:18367")
   (ConceptNode "SMP0063792")
)
 (MemberLink
   (GeneNode "MAP2K4")
   (ConceptNode "SMP0063810")
)
 (MemberLink
   (MoleculeNode "ChEBI:16595.0")
   (ConceptNode "SMP0063810")
)
 (MemberLink
   (MoleculeNode "ChEBI:29108.0")
   (ConceptNode "SMP0063810")
)
 (MemberLink
   (MoleculeNode "ChEBI:17633.0")
   (ConceptNode "SMP0063810")
)
 (MemberLink
   (MoleculeNode "ChEBI:17552.0")
   (ConceptNode "SMP0063810")
)
 (MemberLink
   (MoleculeNode "ChEBI:15996.0")
   (ConceptNode "SMP0063810")
)
 (MemberLink
   (MoleculeNode "ChEBI:nan")
   (ConceptNode "SMP0063810")
)
 (MemberLink
   (GeneNode "MAP2K4")
   (ConceptNode "SMP0063899")
)
 (MemberLink
   (MoleculeNode "ChEBI:18420")
   (ConceptNode "SMP0063899")
)
 (MemberLink
   (MoleculeNode "ChEBI:18367")
   (ConceptNode "SMP0063899")
)
 (MemberLink
   (GeneNode "MAP2K4")
   (ConceptNode "SMP0069695")
)
 (MemberLink
   (MoleculeNode "ChEBI:18420")
   (ConceptNode "SMP0069695")
)
 (MemberLink
   (MoleculeNode "ChEBI:18367")
   (ConceptNode "SMP0069695")
)
 (MemberLink
   (MoleculeNode "ChEBI:27363")
   (ConceptNode "SMP0069695")
)
 (MemberLink
   (GeneNode "MAP2K4")
   (ConceptNode "SMP0069593")
)
 (MemberLink
   (MoleculeNode "ChEBI:59309")
   (ConceptNode "SMP0069593")
)
 (MemberLink
   (MoleculeNode "ChEBI:36704")
   (ConceptNode "SMP0069593")
)
 (MemberLink
   (MoleculeNode "ChEBI:18367")
   (ConceptNode "SMP0069593")
)
 (MemberLink
   (GeneNode "MAP2K4")
   (ConceptNode "SMP0000358")
)
 (MemberLink
   (MoleculeNode "ChEBI:16595.0")
   (ConceptNode "SMP0000358")
)
 (MemberLink
   (MoleculeNode "ChEBI:16978.0")
   (ConceptNode "SMP0000358")
)
 (MemberLink
   (MoleculeNode "ChEBI:29108.0")
   (ConceptNode "SMP0000358")
)
 (MemberLink
   (MoleculeNode "ChEBI:18420.0")
   (ConceptNode "SMP0000358")
)
 (MemberLink
   (MoleculeNode "ChEBI:28666.0")
   (ConceptNode "SMP0000358")
)
 (MemberLink
   (MoleculeNode "ChEBI:18295.0")
   (ConceptNode "SMP0000358")
)
 (MemberLink
   (MoleculeNode "ChEBI:15650.0")
   (ConceptNode "SMP0000358")
)
 (MemberLink
   (MoleculeNode "ChEBI:29035.0")
   (ConceptNode "SMP0000358")
)
 (MemberLink
   (MoleculeNode "ChEBI:15555.0")
   (ConceptNode "SMP0000358")
)
 (MemberLink
   (MoleculeNode "ChEBI:28304.0")
   (ConceptNode "SMP0000358")
)
 (MemberLink
   (MoleculeNode "ChEBI:27363.0")
   (ConceptNode "SMP0000358")
)
 (MemberLink
   (MoleculeNode "ChEBI:15843.0")
   (ConceptNode "SMP0000358")
)
 (MemberLink
   (MoleculeNode "ChEBI:nan")
   (ConceptNode "SMP0000358")
)
 (MemberLink
   (MoleculeNode "ChEBI:16618.0")
   (ConceptNode "SMP0000358")
)
 (MemberLink
   (GeneNode "MAP2K4")
   (ConceptNode "SMP0066977")
)
 (MemberLink
   (MoleculeNode "ChEBI:16595.0")
   (ConceptNode "SMP0066977")
)
 (MemberLink
   (MoleculeNode "ChEBI:29108.0")
   (ConceptNode "SMP0066977")
)
 (MemberLink
   (MoleculeNode "ChEBI:18367.0")
   (ConceptNode "SMP0066977")
)
 (MemberLink
   (MoleculeNode "ChEBI:15377.0")
   (ConceptNode "SMP0066977")
)
 (MemberLink
   (MoleculeNode "ChEBI:15996.0")
   (ConceptNode "SMP0066977")
)
 (MemberLink
   (MoleculeNode "ChEBI:nan")
   (ConceptNode "SMP0066977")
)
 (MemberLink
   (MoleculeNode "ChEBI:61049.0")
   (ConceptNode "SMP0066977")
)
 (EvaluationLink
   (PredicateNode "expresses")
   (ListLink
      (GeneNode "MAP2K4")
      (MoleculeNode "Uniprot:P45985")
   )
)

(AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (GeneNode "MAP2K4")
         (ConceptNode "cytosol")
      )
   )
   (MemberLink (stv 1 1)
      (GeneNode "MAP2K4")
      (ConceptNode "R-HSA-5684264")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q8NFZ5")
      (ConceptNode "R-HSA-5684264")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q8NFZ5")
         (ConceptNode "cytosol")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P45985")
      (ConceptNode "R-HSA-5684264")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P45985")
         (ConceptNode "cytosol")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P62987")
         (ConceptNode "nucleoplasm")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P62987")
      (ConceptNode "R-HSA-5684264")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P62987")
         (ConceptNode "cytosol")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P62987")
      (ConceptNode "R-HSA-5684264")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P62987")
         (ConceptNode "mitochondrial outer membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P62987")
      (ConceptNode "R-HSA-5684264")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P62987")
      (ConceptNode "R-HSA-5684264")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P62987")
         (ConceptNode "endosome membrane")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P62987")
         (ConceptNode "endoplasmic reticulum membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P62987")
      (ConceptNode "R-HSA-5684264")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P62987")
         (ConceptNode "plasma membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P62987")
      (ConceptNode "R-HSA-5684264")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P62987")
         (ConceptNode "endocytic vesicle membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P62987")
      (ConceptNode "R-HSA-5684264")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q02750")
      (ConceptNode "R-HSA-5684264")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q02750")
         (ConceptNode "cytosol")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P0CG48")
      (ConceptNode "R-HSA-5684264")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P0CG48")
         (ConceptNode "endocytic vesicle membrane")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P0CG48")
         (ConceptNode "cytosol")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P0CG48")
      (ConceptNode "R-HSA-5684264")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P0CG48")
      (ConceptNode "R-HSA-5684264")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P0CG48")
         (ConceptNode "plasma membrane")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P0CG48")
      (ConceptNode "R-HSA-5684264")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P0CG48")
         (ConceptNode "nucleoplasm")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P0CG48")
         (ConceptNode "endosome membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P0CG48")
      (ConceptNode "R-HSA-5684264")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P0CG48")
      (ConceptNode "R-HSA-5684264")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P0CG48")
         (ConceptNode "endoplasmic reticulum membrane")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P0CG48")
         (ConceptNode "mitochondrial outer membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P0CG48")
      (ConceptNode "R-HSA-5684264")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P0CG47")
      (ConceptNode "R-HSA-5684264")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P0CG47")
         (ConceptNode "plasma membrane")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P0CG47")
         (ConceptNode "endosome membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P0CG47")
      (ConceptNode "R-HSA-5684264")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P0CG47")
      (ConceptNode "R-HSA-5684264")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P0CG47")
         (ConceptNode "endocytic vesicle membrane")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P0CG47")
         (ConceptNode "mitochondrial outer membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P0CG47")
      (ConceptNode "R-HSA-5684264")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P0CG47")
      (ConceptNode "R-HSA-5684264")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P0CG47")
         (ConceptNode "nucleoplasm")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P0CG47")
      (ConceptNode "R-HSA-5684264")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P0CG47")
         (ConceptNode "endoplasmic reticulum membrane")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P0CG47")
      (ConceptNode "R-HSA-5684264")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P0CG47")
         (ConceptNode "cytosol")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P62979")
      (ConceptNode "R-HSA-5684264")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P62979")
         (ConceptNode "endosome membrane")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P62979")
      (ConceptNode "R-HSA-5684264")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P62979")
         (ConceptNode "mitochondrial outer membrane")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P62979")
      (ConceptNode "R-HSA-5684264")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P62979")
         (ConceptNode "nucleoplasm")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P62979")
      (ConceptNode "R-HSA-5684264")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P62979")
         (ConceptNode "cytosol")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P62979")
      (ConceptNode "R-HSA-5684264")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P62979")
         (ConceptNode "endoplasmic reticulum membrane")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P62979")
      (ConceptNode "R-HSA-5684264")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P62979")
         (ConceptNode "plasma membrane")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P62979")
      (ConceptNode "R-HSA-5684264")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P62979")
         (ConceptNode "endocytic vesicle membrane")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q13616")
      (ConceptNode "R-HSA-5684264")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q13616")
         (ConceptNode "cytosol")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q13616")
      (ConceptNode "R-HSA-5684264")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q13616")
         (ConceptNode "nucleoplasm")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q9Y297")
      (ConceptNode "R-HSA-5684264")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q9Y297")
         (ConceptNode "cytosol")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q9Y297")
      (ConceptNode "R-HSA-5684264")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q9Y297")
         (ConceptNode "nucleoplasm")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P41279")
         (ConceptNode "cytosol")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P41279")
      (ConceptNode "R-HSA-5684264")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q9Y6K9")
         (ConceptNode "cytosol")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q9Y6K9")
      (ConceptNode "R-HSA-5684264")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q9Y6K9")
         (ConceptNode "nucleoplasm")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q9Y6K9")
      (ConceptNode "R-HSA-5684264")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P19838")
      (ConceptNode "R-HSA-5684264")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P19838")
         (ConceptNode "cytosol")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P19838")
      (ConceptNode "R-HSA-5684264")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P19838")
         (ConceptNode "nucleoplasm")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P19838")
      (ConceptNode "R-HSA-5684264")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P19838")
         (ConceptNode "secretory granule lumen")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P19838")
      (ConceptNode "R-HSA-5684264")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P19838")
         (ConceptNode "specific granule lumen")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P19838")
      (ConceptNode "R-HSA-5684264")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P19838")
         (ConceptNode "extracellular region")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P63208")
         (ConceptNode "nucleoplasm")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P63208")
      (ConceptNode "R-HSA-5684264")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P63208")
      (ConceptNode "R-HSA-5684264")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P63208")
         (ConceptNode "cytosol")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q9UKB1")
      (ConceptNode "R-HSA-5684264")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q9UKB1")
         (ConceptNode "cytosol")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:16761")
      (ConceptNode "R-HSA-5684264")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:16761")
         (ConceptNode "cytosol")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:16761")
      (ConceptNode "R-HSA-5684264")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:16761")
         (ConceptNode "extracellular region")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:16761")
      (ConceptNode "R-HSA-5684264")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:16761")
         (ConceptNode "plasma membrane")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:16761")
      (ConceptNode "R-HSA-5684264")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:16761")
         (ConceptNode "endoplasmic reticulum lumen")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:16761")
      (ConceptNode "R-HSA-5684264")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:16761")
         (ConceptNode "cilium")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:16761")
      (ConceptNode "R-HSA-5684264")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:16761")
         (ConceptNode "mitochondrial matrix")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:16761")
      (ConceptNode "R-HSA-5684264")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:16761")
         (ConceptNode "endoplasmic reticulum membrane")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:16761")
      (ConceptNode "R-HSA-5684264")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:16761")
         (ConceptNode "mitochondrial intermembrane space")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:16761")
      (ConceptNode "R-HSA-5684264")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:16761")
         (ConceptNode "nucleoplasm")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:16761")
      (ConceptNode "R-HSA-5684264")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:16761")
         (ConceptNode "platelet dense granule lumen")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15422")
         (ConceptNode "nucleoplasm")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15422")
      (ConceptNode "R-HSA-5684264")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15422")
         (ConceptNode "plasma membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15422")
      (ConceptNode "R-HSA-5684264")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15422")
      (ConceptNode "R-HSA-5684264")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15422")
         (ConceptNode "cilium")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15422")
         (ConceptNode "extracellular region")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15422")
      (ConceptNode "R-HSA-5684264")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15422")
      (ConceptNode "R-HSA-5684264")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15422")
         (ConceptNode "mitochondrial intermembrane space")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15422")
         (ConceptNode "endoplasmic reticulum membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15422")
      (ConceptNode "R-HSA-5684264")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15422")
         (ConceptNode "peroxisomal matrix")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15422")
      (ConceptNode "R-HSA-5684264")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15422")
         (ConceptNode "endoplasmic reticulum lumen")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15422")
      (ConceptNode "R-HSA-5684264")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15422")
         (ConceptNode "mitochondrial matrix")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15422")
      (ConceptNode "R-HSA-5684264")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15422")
      (ConceptNode "R-HSA-5684264")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15422")
         (ConceptNode "cytosol")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15422")
         (ConceptNode "platelet dense granule lumen")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15422")
      (ConceptNode "R-HSA-5684264")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (GeneNode "MAP2K4")
         (ConceptNode "cytosol")
      )
   )
   (MemberLink (stv 1 1)
      (GeneNode "MAP2K4")
      (ConceptNode "R-HSA-5210891")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q9H6X2-1")
         (ConceptNode "endosome membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q9H6X2-1")
      (ConceptNode "R-HSA-5210891")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q9H6X2-1")
         (ConceptNode "plasma membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q9H6X2-1")
      (ConceptNode "R-HSA-5210891")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q8WUM4")
      (ConceptNode "R-HSA-5210891")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q8WUM4")
         (ConceptNode "cytosol")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P40136")
      (ConceptNode "R-HSA-5210891")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P40136")
         (ConceptNode "cytosol")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P40136")
         (ConceptNode "endosome membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P40136")
      (ConceptNode "R-HSA-5210891")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P40136")
         (ConceptNode "plasma membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P40136")
      (ConceptNode "R-HSA-5210891")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P40136")
      (ConceptNode "R-HSA-5210891")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P40136")
         (ConceptNode "extracellular region")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P58335-4")
         (ConceptNode "endosome membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P58335-4")
      (ConceptNode "R-HSA-5210891")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P58335-4")
         (ConceptNode "plasma membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P58335-4")
      (ConceptNode "R-HSA-5210891")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P45985")
         (ConceptNode "cytosol")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P45985")
      (ConceptNode "R-HSA-5210891")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P13423")
      (ConceptNode "R-HSA-5210891")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P13423")
         (ConceptNode "endosome membrane")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P13423")
         (ConceptNode "plasma membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P13423")
      (ConceptNode "R-HSA-5210891")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P13423")
         (ConceptNode "extracellular region")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P13423")
      (ConceptNode "R-HSA-5210891")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q02750")
      (ConceptNode "R-HSA-5210891")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q02750")
         (ConceptNode "cytosol")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P09958")
         (ConceptNode "extracellular region")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P09958")
      (ConceptNode "R-HSA-5210891")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P09958")
         (ConceptNode "plasma membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P09958")
      (ConceptNode "R-HSA-5210891")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P09958")
         (ConceptNode "Golgi lumen")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P09958")
      (ConceptNode "R-HSA-5210891")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P09958")
         (ConceptNode "Golgi membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P09958")
      (ConceptNode "R-HSA-5210891")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P58335-1")
         (ConceptNode "plasma membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P58335-1")
      (ConceptNode "R-HSA-5210891")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P58335-1")
         (ConceptNode "endosome membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P58335-1")
      (ConceptNode "R-HSA-5210891")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P52564-1")
      (ConceptNode "R-HSA-5210891")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P52564-1")
         (ConceptNode "cytosol")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P36507")
      (ConceptNode "R-HSA-5210891")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P36507")
         (ConceptNode "cytosol")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P46734-3")
      (ConceptNode "R-HSA-5210891")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P46734-3")
         (ConceptNode "cytosol")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P0DP23")
         (ConceptNode "plasma membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P0DP23")
      (ConceptNode "R-HSA-5210891")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P0DP23")
      (ConceptNode "R-HSA-5210891")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P0DP23")
         (ConceptNode "extracellular region")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P0DP23")
      (ConceptNode "R-HSA-5210891")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P0DP23")
         (ConceptNode "nucleoplasm")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P0DP23")
      (ConceptNode "R-HSA-5210891")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P0DP23")
         (ConceptNode "cytosol")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P15917")
         (ConceptNode "cytosol")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P15917")
      (ConceptNode "R-HSA-5210891")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P15917")
      (ConceptNode "R-HSA-5210891")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P15917")
         (ConceptNode "endosome membrane")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P15917")
      (ConceptNode "R-HSA-5210891")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P15917")
         (ConceptNode "plasma membrane")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P15917")
      (ConceptNode "R-HSA-5210891")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P15917")
         (ConceptNode "extracellular region")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q9H6X2-2")
         (ConceptNode "endosome membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q9H6X2-2")
      (ConceptNode "R-HSA-5210891")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q9H6X2-2")
         (ConceptNode "plasma membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q9H6X2-2")
      (ConceptNode "R-HSA-5210891")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:O14733")
         (ConceptNode "cytosol")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:O14733")
      (ConceptNode "R-HSA-5210891")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15378")
      (ConceptNode "R-HSA-5210891")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15378")
         (ConceptNode "cytosol")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15378")
      (ConceptNode "R-HSA-5210891")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15378")
         (ConceptNode "endosome lumen")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15378")
      (ConceptNode "R-HSA-5210891")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15378")
         (ConceptNode "peroxisomal matrix")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15378")
      (ConceptNode "R-HSA-5210891")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15378")
         (ConceptNode "Golgi lumen")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15378")
      (ConceptNode "R-HSA-5210891")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15378")
         (ConceptNode "synaptic vesicle")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15378")
      (ConceptNode "R-HSA-5210891")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15378")
         (ConceptNode "melanosome lumen")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15378")
      (ConceptNode "R-HSA-5210891")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15378")
         (ConceptNode "clathrin-sculpted acetylcholine transport vesicle lumen")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15378")
      (ConceptNode "R-HSA-5210891")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15378")
         (ConceptNode "platelet dense tubular network lumen")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15378")
      (ConceptNode "R-HSA-5210891")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15378")
         (ConceptNode "extracellular region")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15378")
      (ConceptNode "R-HSA-5210891")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15378")
         (ConceptNode "endolysosome lumen")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15378")
      (ConceptNode "R-HSA-5210891")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15378")
         (ConceptNode "cytoplasm")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15378")
      (ConceptNode "R-HSA-5210891")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15378")
         (ConceptNode "sperm flagellum")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15378")
      (ConceptNode "R-HSA-5210891")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15378")
         (ConceptNode "endoplasmic reticulum lumen")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15378")
      (ConceptNode "R-HSA-5210891")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15378")
         (ConceptNode "phagolysosome")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15378")
      (ConceptNode "R-HSA-5210891")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15378")
         (ConceptNode "lysosomal lumen")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15378")
      (ConceptNode "R-HSA-5210891")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15378")
         (ConceptNode "mitochondrial matrix")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15378")
      (ConceptNode "R-HSA-5210891")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15378")
         (ConceptNode "synaptic vesicle lumen")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15378")
      (ConceptNode "R-HSA-5210891")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15378")
         (ConceptNode "mitochondrial intermembrane space")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15378")
      (ConceptNode "R-HSA-5210891")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15378")
         (ConceptNode "endocytic vesicle lumen")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15378")
      (ConceptNode "R-HSA-5210891")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15378")
         (ConceptNode "early endosome lumen")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15378")
      (ConceptNode "R-HSA-5210891")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15378")
         (ConceptNode "late endosome lumen")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15378")
      (ConceptNode "R-HSA-5210891")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15378")
         (ConceptNode "nuclear envelope")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15378")
      (ConceptNode "R-HSA-5210891")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15378")
         (ConceptNode "early endosome")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15378")
      (ConceptNode "R-HSA-5210891")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15378")
         (ConceptNode "phagocytic vesicle lumen")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15378")
      (ConceptNode "R-HSA-5210891")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15378")
         (ConceptNode "mitochondrial inner membrane")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15378")
      (ConceptNode "R-HSA-5210891")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15378")
         (ConceptNode "clathrin-sculpted monoamine transport vesicle lumen")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15422")
      (ConceptNode "R-HSA-5210891")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15422")
         (ConceptNode "extracellular region")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15422")
         (ConceptNode "endoplasmic reticulum membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15422")
      (ConceptNode "R-HSA-5210891")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15422")
      (ConceptNode "R-HSA-5210891")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15422")
         (ConceptNode "platelet dense granule lumen")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15422")
      (ConceptNode "R-HSA-5210891")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15422")
         (ConceptNode "cytosol")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15422")
      (ConceptNode "R-HSA-5210891")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15422")
         (ConceptNode "nucleoplasm")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15422")
      (ConceptNode "R-HSA-5210891")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15422")
         (ConceptNode "endoplasmic reticulum lumen")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15422")
      (ConceptNode "R-HSA-5210891")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15422")
         (ConceptNode "plasma membrane")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15422")
      (ConceptNode "R-HSA-5210891")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15422")
         (ConceptNode "peroxisomal matrix")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15422")
      (ConceptNode "R-HSA-5210891")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15422")
         (ConceptNode "mitochondrial matrix")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15422")
      (ConceptNode "R-HSA-5210891")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15422")
         (ConceptNode "cilium")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15422")
      (ConceptNode "R-HSA-5210891")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15422")
         (ConceptNode "mitochondrial intermembrane space")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:29108")
         (ConceptNode "extracellular region")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:29108")
      (ConceptNode "R-HSA-5210891")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:29108")
         (ConceptNode "mitochondrial inner membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:29108")
      (ConceptNode "R-HSA-5210891")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:29108")
         (ConceptNode "nuclear envelope")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:29108")
      (ConceptNode "R-HSA-5210891")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:29108")
      (ConceptNode "R-HSA-5210891")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:29108")
         (ConceptNode "platelet dense tubular network lumen")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:29108")
         (ConceptNode "endocytic vesicle lumen")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:29108")
      (ConceptNode "R-HSA-5210891")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:29108")
      (ConceptNode "R-HSA-5210891")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:29108")
         (ConceptNode "mitochondrial matrix")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:29108")
         (ConceptNode "mitochondrial intermembrane space")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:29108")
      (ConceptNode "R-HSA-5210891")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:29108")
      (ConceptNode "R-HSA-5210891")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:29108")
         (ConceptNode "plasma membrane")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:29108")
      (ConceptNode "R-HSA-5210891")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:29108")
         (ConceptNode "platelet dense tubular network membrane")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:29108")
      (ConceptNode "R-HSA-5210891")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:29108")
         (ConceptNode "secretory granule lumen")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:29108")
      (ConceptNode "R-HSA-5210891")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:29108")
         (ConceptNode "cytosol")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:29108")
         (ConceptNode "nucleoplasm")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:29108")
      (ConceptNode "R-HSA-5210891")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:29108")
         (ConceptNode "sarcoplasmic reticulum lumen")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:29108")
      (ConceptNode "R-HSA-5210891")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:29108")
         (ConceptNode "endoplasmic reticulum membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:29108")
      (ConceptNode "R-HSA-5210891")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:29108")
         (ConceptNode "Golgi lumen")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:29108")
      (ConceptNode "R-HSA-5210891")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:29108")
         (ConceptNode "lysosomal lumen")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:29108")
      (ConceptNode "R-HSA-5210891")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:29108")
      (ConceptNode "R-HSA-5210891")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:29108")
         (ConceptNode "endoplasmic reticulum lumen")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:29108")
         (ConceptNode "endosome membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:29108")
      (ConceptNode "R-HSA-5210891")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:29108")
      (ConceptNode "R-HSA-5210891")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:29108")
         (ConceptNode "platelet dense granule lumen")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:17489")
      (ConceptNode "R-HSA-5210891")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:17489")
         (ConceptNode "cytosol")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:29105")
         (ConceptNode "endoplasmic reticulum lumen")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:29105")
      (ConceptNode "R-HSA-5210891")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:29105")
      (ConceptNode "R-HSA-5210891")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:29105")
         (ConceptNode "synaptic vesicle membrane")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:29105")
         (ConceptNode "secretory granule lumen")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:29105")
      (ConceptNode "R-HSA-5210891")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:29105")
      (ConceptNode "R-HSA-5210891")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:29105")
         (ConceptNode "melanosome membrane")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:29105")
      (ConceptNode "R-HSA-5210891")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:29105")
         (ConceptNode "synaptic vesicle")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:29105")
         (ConceptNode "endosome membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:29105")
      (ConceptNode "R-HSA-5210891")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:29105")
      (ConceptNode "R-HSA-5210891")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:29105")
         (ConceptNode "lysosomal lumen")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:29105")
         (ConceptNode "endosome lumen")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:29105")
      (ConceptNode "R-HSA-5210891")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:29105")
         (ConceptNode "Golgi lumen")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:29105")
      (ConceptNode "R-HSA-5210891")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:29105")
      (ConceptNode "R-HSA-5210891")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:29105")
         (ConceptNode "mitochondrial inner membrane")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:29105")
         (ConceptNode "mitochondrial matrix")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:29105")
      (ConceptNode "R-HSA-5210891")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:29105")
      (ConceptNode "R-HSA-5210891")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:29105")
         (ConceptNode "clathrin-coated endocytic vesicle membrane")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:29105")
      (ConceptNode "R-HSA-5210891")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:29105")
         (ConceptNode "endoplasmic reticulum membrane")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:29105")
         (ConceptNode "phagocytic vesicle lumen")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:29105")
      (ConceptNode "R-HSA-5210891")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:29105")
         (ConceptNode "cytosol")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:29105")
      (ConceptNode "R-HSA-5210891")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:29105")
      (ConceptNode "R-HSA-5210891")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:29105")
         (ConceptNode "mitochondrial intermembrane space")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:29105")
      (ConceptNode "R-HSA-5210891")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:29105")
         (ConceptNode "Golgi membrane")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:29105")
      (ConceptNode "R-HSA-5210891")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:29105")
         (ConceptNode "nucleoplasm")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:29105")
         (ConceptNode "plasma membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:29105")
      (ConceptNode "R-HSA-5210891")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:29105")
      (ConceptNode "R-HSA-5210891")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:29105")
         (ConceptNode "extracellular region")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:29105")
      (ConceptNode "R-HSA-5210891")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:29105")
         (ConceptNode "endocytic vesicle membrane")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:29888")
         (ConceptNode "cytosol")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:29888")
      (ConceptNode "R-HSA-5210891")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:29888")
         (ConceptNode "peroxisomal matrix")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:29888")
      (ConceptNode "R-HSA-5210891")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:29888")
         (ConceptNode "nucleoplasm")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:29888")
      (ConceptNode "R-HSA-5210891")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:29888")
         (ConceptNode "extracellular region")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:29888")
      (ConceptNode "R-HSA-5210891")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:29888")
         (ConceptNode "endoplasmic reticulum membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:29888")
      (ConceptNode "R-HSA-5210891")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:29888")
      (ConceptNode "R-HSA-5210891")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:29888")
         (ConceptNode "endoplasmic reticulum lumen")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:29888")
         (ConceptNode "platelet dense granule lumen")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:29888")
      (ConceptNode "R-HSA-5210891")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:29888")
         (ConceptNode "mitochondrial matrix")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:29888")
      (ConceptNode "R-HSA-5210891")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (GeneNode "MAP2K4")
         (ConceptNode "cytosol")
      )
   )
   (MemberLink (stv 1 1)
      (GeneNode "MAP2K4")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P19174")
         (ConceptNode "plasma membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P19174")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P19174")
         (ConceptNode "cytosol")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P19174")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01614")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01614")
         (ConceptNode "plasma membrane")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01614")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01614")
         (ConceptNode "extracellular region")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P06315")
         (ConceptNode "plasma membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P06315")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P06315")
         (ConceptNode "extracellular region")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P06315")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01705")
         (ConceptNode "extracellular region")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01705")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01705")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01705")
         (ConceptNode "plasma membrane")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q13177")
         (ConceptNode "nucleoplasm")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q13177")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q13177")
         (ConceptNode "cytosol")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q13177")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q13177")
         (ConceptNode "plasma membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q13177")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q13153")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q13153")
         (ConceptNode "plasma membrane")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q13153")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q13153")
         (ConceptNode "cytosol")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P04211")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P04211")
         (ConceptNode "extracellular region")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P04211")
         (ConceptNode "plasma membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P04211")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01762")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01762")
         (ConceptNode "plasma membrane")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01762")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01762")
         (ConceptNode "extracellular region")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01594")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01594")
         (ConceptNode "plasma membrane")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01594")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01594")
         (ConceptNode "extracellular region")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01817")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01817")
         (ConceptNode "plasma membrane")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01817")
         (ConceptNode "extracellular region")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01817")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q5NV64")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q5NV64")
         (ConceptNode "extracellular region")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01111")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01111")
         (ConceptNode "plasma membrane")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01111")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01111")
         (ConceptNode "tertiary granule membrane")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01706")
         (ConceptNode "plasma membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01706")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01706")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01706")
         (ConceptNode "extracellular region")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01743")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01743")
         (ConceptNode "extracellular region")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01743")
         (ConceptNode "plasma membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01743")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P53779")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P53779")
         (ConceptNode "nucleoplasm")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P53779")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P53779")
         (ConceptNode "cytosol")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P45984")
         (ConceptNode "cytosol")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P45984")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P45984")
         (ConceptNode "nucleoplasm")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P45984")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01116")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01116")
         (ConceptNode "plasma membrane")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:A0A0C4DH73")
         (ConceptNode "plasma membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:A0A0C4DH73")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:A0A0C4DH73")
         (ConceptNode "extracellular region")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:A0A0C4DH73")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q5NV62")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q5NV62")
         (ConceptNode "extracellular region")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01701")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01701")
         (ConceptNode "extracellular region")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01701")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01701")
         (ConceptNode "plasma membrane")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q5NV69")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q5NV69")
         (ConceptNode "extracellular region")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P12319")
         (ConceptNode "plasma membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P12319")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01721")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01721")
         (ConceptNode "plasma membrane")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01721")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01721")
         (ConceptNode "extracellular region")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01112")
         (ConceptNode "plasma membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01112")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01700")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01700")
         (ConceptNode "plasma membrane")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01700")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01700")
         (ConceptNode "extracellular region")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P45985")
         (ConceptNode "cytosol")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P45985")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P15498")
         (ConceptNode "cytosol")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P15498")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P15498")
         (ConceptNode "plasma membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P15498")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q5NV68")
         (ConceptNode "extracellular region")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q5NV68")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P06312")
         (ConceptNode "plasma membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P06312")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P06312")
         (ConceptNode "extracellular region")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P06312")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01764")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01764")
         (ConceptNode "extracellular region")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01764")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01764")
         (ConceptNode "plasma membrane")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01825")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01825")
         (ConceptNode "plasma membrane")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01825")
         (ConceptNode "extracellular region")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01825")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P52735")
         (ConceptNode "cytosol")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P52735")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01597")
         (ConceptNode "plasma membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01597")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01597")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01597")
         (ConceptNode "extracellular region")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q07889")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q07889")
         (ConceptNode "cytosol")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q07889")
         (ConceptNode "plasma membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q07889")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P0CF74")
         (ConceptNode "plasma membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P0CF74")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P0CF74")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P0CF74")
         (ConceptNode "extracellular region")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01601")
         (ConceptNode "plasma membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01601")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01601")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01601")
         (ConceptNode "extracellular region")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P62993-1")
         (ConceptNode "plasma membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P62993-1")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P62993-1")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P62993-1")
         (ConceptNode "cytosol")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01715")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01715")
         (ConceptNode "plasma membrane")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01715")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01715")
         (ConceptNode "extracellular region")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q5NV80")
         (ConceptNode "extracellular region")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q5NV80")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01100")
         (ConceptNode "nucleoplasm")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01100")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q5NV87")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q5NV87")
         (ConceptNode "extracellular region")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P43405")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P43405")
         (ConceptNode "plasma membrane")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P43405")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P43405")
         (ConceptNode "cytosol")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01766")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01766")
         (ConceptNode "extracellular region")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01766")
         (ConceptNode "plasma membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01766")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01780")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01780")
         (ConceptNode "extracellular region")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01780")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01780")
         (ConceptNode "plasma membrane")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P06310")
         (ConceptNode "extracellular region")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P06310")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P06310")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P06310")
         (ConceptNode "plasma membrane")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01717")
         (ConceptNode "plasma membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01717")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01717")
         (ConceptNode "extracellular region")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01717")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:A0A0C4DH25")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:A0A0C4DH25")
         (ConceptNode "plasma membrane")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:A0A0C4DH25")
         (ConceptNode "extracellular region")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:A0A0C4DH25")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q5NV90")
         (ConceptNode "extracellular region")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q5NV90")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q5NV65")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q5NV65")
         (ConceptNode "extracellular region")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q13094")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q13094")
         (ConceptNode "cytosol")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q5NV66")
         (ConceptNode "extracellular region")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q5NV66")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P45983")
         (ConceptNode "nucleoplasm")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P45983")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P45983")
         (ConceptNode "cytosol")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P45983")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P63000")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P63000")
         (ConceptNode "ficolin-1-rich granule membrane")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P63000")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P63000")
         (ConceptNode "cytosol")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P63000")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P63000")
         (ConceptNode "secretory granule membrane")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P63000")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P63000")
         (ConceptNode "endoplasmic reticulum membrane")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P63000")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P63000")
         (ConceptNode "plasma membrane")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01742")
         (ConceptNode "extracellular region")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01742")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01742")
         (ConceptNode "plasma membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01742")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01703")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01703")
         (ConceptNode "plasma membrane")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01703")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01703")
         (ConceptNode "extracellular region")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q5NV89")
         (ConceptNode "extracellular region")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q5NV89")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:A2NXD2")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:A2NXD2")
         (ConceptNode "plasma membrane")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:A2NXD2")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:A2NXD2")
         (ConceptNode "extracellular region")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P07948")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P07948")
         (ConceptNode "plasma membrane")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P07948")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P07948")
         (ConceptNode "cytosol")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q5NV79")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q5NV79")
         (ConceptNode "extracellular region")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01624")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01624")
         (ConceptNode "extracellular region")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01624")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01624")
         (ConceptNode "plasma membrane")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01763")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01763")
         (ConceptNode "extracellular region")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01763")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01763")
         (ConceptNode "plasma membrane")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P30273")
         (ConceptNode "plasma membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P30273")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P30273")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P30273")
         (ConceptNode "ficolin-1-rich granule membrane")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P30273")
         (ConceptNode "tertiary granule membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P30273")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01824")
         (ConceptNode "extracellular region")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01824")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01824")
         (ConceptNode "plasma membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01824")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q5NV85")
         (ConceptNode "extracellular region")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q5NV85")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P0CG04")
         (ConceptNode "extracellular region")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P0CG04")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P0CG04")
         (ConceptNode "plasma membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P0CG04")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01767")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01767")
         (ConceptNode "extracellular region")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01767")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01767")
         (ConceptNode "plasma membrane")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01699")
         (ConceptNode "plasma membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01699")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01699")
         (ConceptNode "extracellular region")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01699")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P23083")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P23083")
         (ConceptNode "extracellular region")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P23083")
         (ConceptNode "plasma membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P23083")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q5NV92")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q5NV92")
         (ConceptNode "extracellular region")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q5NV67")
         (ConceptNode "extracellular region")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q5NV67")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P04432")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P04432")
         (ConceptNode "extracellular region")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P04432")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P04432")
         (ConceptNode "plasma membrane")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:O43561-2")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:O43561-2")
         (ConceptNode "plasma membrane")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:A2KUC3")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:A2KUC3")
         (ConceptNode "plasma membrane")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:A2KUC3")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:A2KUC3")
         (ConceptNode "extracellular region")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q5NV75")
         (ConceptNode "extracellular region")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q5NV75")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:O75791")
         (ConceptNode "cytosol")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:O75791")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q5NV82")
         (ConceptNode "extracellular region")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q5NV82")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P04433")
         (ConceptNode "plasma membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P04433")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P04433")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P04433")
         (ConceptNode "extracellular region")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01615")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01615")
         (ConceptNode "plasma membrane")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01615")
         (ConceptNode "extracellular region")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01615")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01854")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01854")
         (ConceptNode "extracellular region")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:A0A075B6S6")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:A0A075B6S6")
         (ConceptNode "extracellular region")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:A0A075B6S6")
         (ConceptNode "plasma membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:A0A075B6S6")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01593")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01593")
         (ConceptNode "extracellular region")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01593")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01593")
         (ConceptNode "plasma membrane")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q5NV86")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q5NV86")
         (ConceptNode "extracellular region")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01768")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01768")
         (ConceptNode "plasma membrane")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01768")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01768")
         (ConceptNode "extracellular region")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01602")
         (ConceptNode "plasma membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01602")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01602")
         (ConceptNode "extracellular region")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01602")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01611")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01611")
         (ConceptNode "plasma membrane")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01611")
         (ConceptNode "extracellular region")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01611")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01619")
         (ConceptNode "plasma membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01619")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01619")
         (ConceptNode "extracellular region")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01619")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01714")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01714")
         (ConceptNode "extracellular region")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01714")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01714")
         (ConceptNode "plasma membrane")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:A0A075B6P5")
         (ConceptNode "extracellular region")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:A0A075B6P5")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:A0A075B6P5")
         (ConceptNode "plasma membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:A0A075B6P5")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q5NV61")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q5NV61")
         (ConceptNode "extracellular region")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P16885")
         (ConceptNode "cytosol")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P16885")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P16885")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P16885")
         (ConceptNode "plasma membrane")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:A0M8Q6")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:A0M8Q6")
         (ConceptNode "plasma membrane")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:A0M8Q6")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:A0M8Q6")
         (ConceptNode "extracellular region")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P04430")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P04430")
         (ConceptNode "extracellular region")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P04430")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P04430")
         (ConceptNode "plasma membrane")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01814")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01814")
         (ConceptNode "plasma membrane")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01814")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01814")
         (ConceptNode "extracellular region")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q5NV83")
         (ConceptNode "extracellular region")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q5NV83")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q5NV84")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q5NV84")
         (ConceptNode "extracellular region")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P05412")
         (ConceptNode "cytosol")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P05412")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P05412")
         (ConceptNode "nucleoplasm")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P05412")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01834")
         (ConceptNode "extracellular region")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01834")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01834")
         (ConceptNode "plasma membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01834")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q5NV91")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q5NV91")
         (ConceptNode "extracellular region")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q5NV81")
         (ConceptNode "extracellular region")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q5NV81")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q13233")
         (ConceptNode "cytosol")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q13233")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P80748")
         (ConceptNode "extracellular region")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P80748")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P80748")
         (ConceptNode "plasma membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P80748")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01782")
         (ConceptNode "extracellular region")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01782")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01782")
         (ConceptNode "plasma membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01782")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q6PIL0")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q6PIL0")
         (ConceptNode "plasma membrane")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q6PIL0")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q6PIL0")
         (ConceptNode "extracellular region")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P06331")
         (ConceptNode "extracellular region")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P06331")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P06331")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P06331")
         (ConceptNode "plasma membrane")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q9UKW4")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q9UKW4")
         (ConceptNode "cytosol")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01709")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01709")
         (ConceptNode "extracellular region")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01709")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01709")
         (ConceptNode "plasma membrane")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01718")
         (ConceptNode "extracellular region")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01718")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01718")
         (ConceptNode "plasma membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01718")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:A2NJV5")
         (ConceptNode "extracellular region")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:A2NJV5")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:A2NJV5")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:A2NJV5")
         (ConceptNode "plasma membrane")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P29353-2")
         (ConceptNode "cytosol")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P29353-2")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P29353-2")
         (ConceptNode "plasma membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P29353-2")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:O14733")
         (ConceptNode "cytosol")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:O14733")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01704")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01704")
         (ConceptNode "plasma membrane")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01704")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01704")
         (ConceptNode "extracellular region")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01599")
         (ConceptNode "plasma membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01599")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01599")
         (ConceptNode "extracellular region")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01599")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01772")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01772")
         (ConceptNode "plasma membrane")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01772")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01772")
         (ConceptNode "extracellular region")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:17552")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:17552")
         (ConceptNode "lysosomal membrane")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:17552")
         (ConceptNode "Golgi lumen")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:17552")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:17552")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:17552")
         (ConceptNode "nucleoplasm")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:17552")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:17552")
         (ConceptNode "extracellular region")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:17552")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:17552")
         (ConceptNode "mitochondrial matrix")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:17552")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:17552")
         (ConceptNode "cytoplasmic vesicle membrane")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:17552")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:17552")
         (ConceptNode "platelet dense granule lumen")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:17552")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:17552")
         (ConceptNode "endoplasmic reticulum lumen")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:17552")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:17552")
         (ConceptNode "plasma membrane")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:17552")
         (ConceptNode "cilium")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:17552")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:17552")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:17552")
         (ConceptNode "cytosol")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:17552")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:17552")
         (ConceptNode "endocytic vesicle lumen")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:16761")
         (ConceptNode "extracellular region")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:16761")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:16761")
         (ConceptNode "plasma membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:16761")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:16761")
         (ConceptNode "endoplasmic reticulum lumen")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:16761")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:16761")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:16761")
         (ConceptNode "cytosol")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:16761")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:16761")
         (ConceptNode "mitochondrial intermembrane space")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:16761")
         (ConceptNode "mitochondrial matrix")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:16761")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:16761")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:16761")
         (ConceptNode "endoplasmic reticulum membrane")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:16761")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:16761")
         (ConceptNode "platelet dense granule lumen")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:16761")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:16761")
         (ConceptNode "cilium")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:16761")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:16761")
         (ConceptNode "nucleoplasm")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15422")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15422")
         (ConceptNode "plasma membrane")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15422")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15422")
         (ConceptNode "extracellular region")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15422")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15422")
         (ConceptNode "nucleoplasm")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15422")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15422")
         (ConceptNode "peroxisomal matrix")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15422")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15422")
         (ConceptNode "endoplasmic reticulum lumen")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15422")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15422")
         (ConceptNode "platelet dense granule lumen")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15422")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15422")
         (ConceptNode "cytosol")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15422")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15422")
         (ConceptNode "cilium")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15422")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15422")
         (ConceptNode "mitochondrial matrix")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15422")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15422")
         (ConceptNode "mitochondrial intermembrane space")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15422")
         (ConceptNode "endoplasmic reticulum membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15422")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15996")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15996")
         (ConceptNode "extracellular region")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15996")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15996")
         (ConceptNode "cytoplasmic vesicle membrane")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15996")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15996")
         (ConceptNode "lysosomal membrane")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15996")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15996")
         (ConceptNode "Golgi lumen")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15996")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15996")
         (ConceptNode "platelet dense granule lumen")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15996")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15996")
         (ConceptNode "ER to Golgi transport vesicle membrane")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15996")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15996")
         (ConceptNode "cilium")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15996")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15996")
         (ConceptNode "Golgi membrane")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15996")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15996")
         (ConceptNode "cytosol")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15996")
         (ConceptNode "endocytic vesicle lumen")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15996")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15996")
         (ConceptNode "mitochondrial matrix")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15996")
      (ConceptNode "R-HSA-2871796")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15996")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15996")
         (ConceptNode "nucleoplasm")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15996")
      (ConceptNode "R-HSA-2871796")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15996")
         (ConceptNode "early endosome membrane")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (GeneNode "MAP2K4")
         (ConceptNode "cytosol")
      )
   )
   (MemberLink (stv 1 1)
      (GeneNode "MAP2K4")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P62805")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P62805")
         (ConceptNode "extracellular region")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P62805")
         (ConceptNode "nucleoplasm")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P62805")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q99878")
         (ConceptNode "extracellular region")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q99878")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q99878")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q99878")
         (ConceptNode "nucleoplasm")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q71UI9")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q71UI9")
         (ConceptNode "nucleoplasm")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q06587")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q06587")
         (ConceptNode "nucleoplasm")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P52564")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P52564")
         (ConceptNode "nucleoplasm")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P52564")
         (ConceptNode "cytosol")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P52564")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P53779")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P53779")
         (ConceptNode "nucleoplasm")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P53779")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P53779")
         (ConceptNode "cytosol")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:O60814")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:O60814")
         (ConceptNode "extracellular region")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:O60814")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:O60814")
         (ConceptNode "nucleoplasm")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P45984")
         (ConceptNode "nucleoplasm")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P45984")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P45984")
         (ConceptNode "cytosol")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P45984")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P04637")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P04637")
         (ConceptNode "cytosol")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P04637")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P04637")
         (ConceptNode "nucleoplasm")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P55273")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P55273")
         (ConceptNode "cytosol")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q9UKE5")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q9UKE5")
         (ConceptNode "cytosol")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:O15054")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:O15054")
         (ConceptNode "nucleoplasm")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:O00257")
         (ConceptNode "nucleoplasm")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:O00257")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:O15151")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:O15151")
         (ConceptNode "nucleoplasm")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q09028")
         (ConceptNode "nucleoplasm")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q09028")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q96A08")
         (ConceptNode "extracellular region")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q96A08")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q96A08")
         (ConceptNode "nucleoplasm")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q96A08")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q14781")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q14781")
         (ConceptNode "nucleoplasm")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q93079")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q93079")
         (ConceptNode "nucleoplasm")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q93079")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q93079")
         (ConceptNode "extracellular region")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:O95819")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:O95819")
         (ConceptNode "cytosol")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P68431")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P68431")
         (ConceptNode "cytosol")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P68431")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P68431")
         (ConceptNode "extracellular region")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P68431")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P68431")
         (ConceptNode "nucleoplasm")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P45985")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P45985")
         (ConceptNode "cytosol")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q93077")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q93077")
         (ConceptNode "extracellular region")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q93077")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q93077")
         (ConceptNode "nucleoplasm")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01574")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01574")
         (ConceptNode "extracellular region")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P49137")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P49137")
         (ConceptNode "nucleoplasm")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P49137")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P49137")
         (ConceptNode "cytosol")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q16576")
         (ConceptNode "nucleoplasm")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q16576")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P23527")
         (ConceptNode "nucleoplasm")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P23527")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P23527")
         (ConceptNode "extracellular region")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P23527")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q16777")
         (ConceptNode "extracellular region")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q16777")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q16777")
         (ConceptNode "nucleoplasm")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q16777")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q9HCK5")
         (ConceptNode "cytosol")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q9HCK5")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q99877")
         (ConceptNode "nucleoplasm")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q99877")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q99877")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q99877")
         (ConceptNode "extracellular region")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P0C0S5")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P0C0S5")
         (ConceptNode "extracellular region")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P0C0S5")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P0C0S5")
         (ConceptNode "nucleoplasm")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P62987")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P62987")
         (ConceptNode "endosome membrane")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P62987")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P62987")
         (ConceptNode "mitochondrial outer membrane")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P62987")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P62987")
         (ConceptNode "nucleoplasm")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P62987")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P62987")
         (ConceptNode "cytosol")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P62987")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P62987")
         (ConceptNode "endoplasmic reticulum membrane")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P62987")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P62987")
         (ConceptNode "endocytic vesicle membrane")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P62987")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P62987")
         (ConceptNode "plasma membrane")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P01100")
         (ConceptNode "nucleoplasm")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P01100")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q9HCE1")
         (ConceptNode "cytosol")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q9HCE1")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P11802")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P11802")
         (ConceptNode "cytosol")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P11802")
         (ConceptNode "nucleoplasm")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P11802")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q8IW41")
         (ConceptNode "nucleoplasm")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q8IW41")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q8IW41")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q8IW41")
         (ConceptNode "cytosol")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P04908")
         (ConceptNode "nucleoplasm")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P04908")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P04908")
         (ConceptNode "extracellular region")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P04908")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q8IXK0")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q8IXK0")
         (ConceptNode "nucleoplasm")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P58876")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P58876")
         (ConceptNode "extracellular region")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P58876")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P58876")
         (ConceptNode "nucleoplasm")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q14209")
         (ConceptNode "nucleoplasm")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q14209")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P10599")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P10599")
         (ConceptNode "nucleoplasm")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P10599")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P10599")
         (ConceptNode "cytosol")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q15910")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q15910")
         (ConceptNode "nucleoplasm")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q15022")
         (ConceptNode "nucleoplasm")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q15022")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q9HCJ0")
         (ConceptNode "cytosol")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q9HCJ0")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q8N4C8")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q8N4C8")
         (ConceptNode "cytosol")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P45983")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P45983")
         (ConceptNode "nucleoplasm")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P45983")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P45983")
         (ConceptNode "cytosol")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P42773")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P42773")
         (ConceptNode "cytosol")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q99496")
         (ConceptNode "nucleoplasm")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q99496")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q01094")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q01094")
         (ConceptNode "nucleoplasm")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P0CG48")
         (ConceptNode "endosome membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P0CG48")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P0CG48")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P0CG48")
         (ConceptNode "nucleoplasm")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P0CG48")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P0CG48")
         (ConceptNode "mitochondrial outer membrane")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P0CG48")
         (ConceptNode "cytosol")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P0CG48")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P0CG48")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P0CG48")
         (ConceptNode "endoplasmic reticulum membrane")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P0CG48")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P0CG48")
         (ConceptNode "plasma membrane")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P0CG48")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P0CG48")
         (ConceptNode "endocytic vesicle membrane")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q00534")
         (ConceptNode "nucleoplasm")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q00534")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q00534")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q00534")
         (ConceptNode "cytosol")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P0CG47")
         (ConceptNode "endosome membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P0CG47")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P0CG47")
         (ConceptNode "nucleoplasm")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P0CG47")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P0CG47")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P0CG47")
         (ConceptNode "endoplasmic reticulum membrane")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P0CG47")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P0CG47")
         (ConceptNode "endocytic vesicle membrane")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P0CG47")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P0CG47")
         (ConceptNode "plasma membrane")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P0CG47")
         (ConceptNode "mitochondrial outer membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P0CG47")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P0CG47")
         (ConceptNode "cytosol")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P0CG47")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P62979")
         (ConceptNode "mitochondrial outer membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P62979")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P62979")
         (ConceptNode "cytosol")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P62979")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P62979")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P62979")
         (ConceptNode "endosome membrane")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P62979")
         (ConceptNode "endoplasmic reticulum membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P62979")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P62979")
         (ConceptNode "endocytic vesicle membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P62979")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P62979")
         (ConceptNode "nucleoplasm")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P62979")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P62979")
         (ConceptNode "plasma membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P62979")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P78364")
         (ConceptNode "nucleoplasm")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P78364")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q9HC52")
         (ConceptNode "nucleoplasm")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q9HC52")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P42771")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P42771")
         (ConceptNode "cytosol")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q16539")
         (ConceptNode "secretory granule lumen")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q16539")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q16539")
         (ConceptNode "cytosol")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q16539")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q16539")
         (ConceptNode "nucleoplasm")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q16539")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q16539")
         (ConceptNode "extracellular region")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q16539")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q16539")
         (ConceptNode "ficolin-1-rich granule lumen")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q16539")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q96GD3-2")
         (ConceptNode "nucleoplasm")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q96GD3-2")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q16644")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q16644")
         (ConceptNode "cytosol")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q16644")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q16644")
         (ConceptNode "nucleoplasm")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P35226")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P35226")
         (ConceptNode "nucleoplasm")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q8NDV7")
         (ConceptNode "nucleoplasm")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q8NDV7")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q8NDV7")
         (ConceptNode "cytosol")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q8NDV7")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P46734")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P46734")
         (ConceptNode "cytosol")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P46734")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P46734")
         (ConceptNode "nucleoplasm")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q99879")
         (ConceptNode "nucleoplasm")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q99879")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q99879")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q99879")
         (ConceptNode "extracellular region")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P16104")
         (ConceptNode "extracellular region")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P16104")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P16104")
         (ConceptNode "nucleoplasm")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P16104")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:O75530")
         (ConceptNode "nucleoplasm")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:O75530")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q16778")
         (ConceptNode "extracellular region")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q16778")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q16778")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q16778")
         (ConceptNode "nucleoplasm")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P0C5Y9")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P0C5Y9")
         (ConceptNode "extracellular region")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P0C5Y9")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P0C5Y9")
         (ConceptNode "nucleoplasm")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q14188")
         (ConceptNode "nucleoplasm")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q14188")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q99683")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q99683")
         (ConceptNode "cytosol")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q9UPQ9")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q9UPQ9")
         (ConceptNode "cytosol")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P33778")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P33778")
         (ConceptNode "extracellular region")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P33778")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P33778")
         (ConceptNode "nucleoplasm")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q8N257")
         (ConceptNode "nucleoplasm")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q8N257")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q8N257")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q8N257")
         (ConceptNode "extracellular region")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q8N726")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q8N726")
         (ConceptNode "nucleoplasm")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q9BTM1")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q9BTM1")
         (ConceptNode "nucleoplasm")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q15759")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q15759")
         (ConceptNode "cytosol")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q15759")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q15759")
         (ConceptNode "nucleoplasm")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P42772")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P42772")
         (ConceptNode "cytosol")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q9UL18")
         (ConceptNode "cytosol")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q9UL18")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q9UL18")
         (ConceptNode "nucleoplasm")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q9UL18")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P06899")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P06899")
         (ConceptNode "extracellular region")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P06899")
         (ConceptNode "nucleoplasm")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P06899")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P05412")
         (ConceptNode "nucleoplasm")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P05412")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P05412")
         (ConceptNode "cytosol")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P05412")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:O00716")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:O00716")
         (ConceptNode "nucleoplasm")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q8NDX5")
         (ConceptNode "nucleoplasm")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q8NDX5")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P84243")
         (ConceptNode "extracellular region")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P84243")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P84243")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P84243")
         (ConceptNode "nucleoplasm")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P20671")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P20671")
         (ConceptNode "extracellular region")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P20671")
         (ConceptNode "nucleoplasm")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P20671")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q6FI13")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q6FI13")
         (ConceptNode "extracellular region")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q6FI13")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q6FI13")
         (ConceptNode "nucleoplasm")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q71DI3")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q71DI3")
         (ConceptNode "nucleoplasm")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q71DI3")
         (ConceptNode "extracellular region")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q71DI3")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q71DI3")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q71DI3")
         (ConceptNode "cytosol")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q14186")
         (ConceptNode "nucleoplasm")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q14186")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P57053")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P57053")
         (ConceptNode "extracellular region")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P57053")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P57053")
         (ConceptNode "nucleoplasm")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:O95503")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:O95503")
         (ConceptNode "nucleoplasm")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q99880")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q99880")
         (ConceptNode "extracellular region")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q99880")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q99880")
         (ConceptNode "nucleoplasm")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P62807")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P62807")
         (ConceptNode "extracellular region")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P62807")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P62807")
         (ConceptNode "nucleoplasm")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q9H9G7")
         (ConceptNode "cytosol")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q9H9G7")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:18248")
         (ConceptNode "cytosol")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:18248")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:16761")
         (ConceptNode "plasma membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:16761")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:16761")
         (ConceptNode "mitochondrial matrix")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:16761")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:16761")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:16761")
         (ConceptNode "cytosol")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:16761")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:16761")
         (ConceptNode "nucleoplasm")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:16761")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:16761")
         (ConceptNode "cilium")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:16761")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:16761")
         (ConceptNode "platelet dense granule lumen")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:16761")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:16761")
         (ConceptNode "mitochondrial intermembrane space")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:16761")
         (ConceptNode "extracellular region")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:16761")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:16761")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:16761")
         (ConceptNode "endoplasmic reticulum membrane")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:16761")
         (ConceptNode "endoplasmic reticulum lumen")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:16761")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15414")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15414")
         (ConceptNode "cytosol")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15414")
         (ConceptNode "mitochondrial matrix")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15414")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15414")
         (ConceptNode "nucleoplasm")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15414")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15414")
         (ConceptNode "cytoplasm")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15414")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15422")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15422")
         (ConceptNode "cilium")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15422")
         (ConceptNode "extracellular region")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15422")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15422")
         (ConceptNode "peroxisomal matrix")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15422")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15422")
         (ConceptNode "endoplasmic reticulum membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15422")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15422")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15422")
         (ConceptNode "mitochondrial intermembrane space")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15422")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15422")
         (ConceptNode "nucleoplasm")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15422")
         (ConceptNode "platelet dense granule lumen")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15422")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15422")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15422")
         (ConceptNode "plasma membrane")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15422")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15422")
         (ConceptNode "cytosol")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15422")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15422")
         (ConceptNode "mitochondrial matrix")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15422")
         (ConceptNode "endoplasmic reticulum lumen")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15422")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:30915")
         (ConceptNode "extracellular region")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:30915")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:30915")
         (ConceptNode "endoplasmic reticulum lumen")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:30915")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:30915")
         (ConceptNode "peroxisomal matrix")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:30915")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:30915")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:30915")
         (ConceptNode "mitochondrial matrix")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15741")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15741")
         (ConceptNode "mitochondrial matrix")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15741")
         (ConceptNode "endoplasmic reticulum lumen")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15741")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15741")
         (ConceptNode "extracellular region")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15741")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15741")
         (ConceptNode "peroxisomal matrix")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15741")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15741")
         (ConceptNode "cytoplasm")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15741")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:16680")
         (ConceptNode "cytosol")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:16680")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:16680")
         (ConceptNode "nucleoplasm")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:16680")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:16680")
         (ConceptNode "mitochondrial matrix")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:16680")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:16680")
         (ConceptNode "cytoplasm")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:16680")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:26523")
         (ConceptNode "nucleoplasm")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:26523")
      (ConceptNode "R-HSA-2559580")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:26523")
      (ConceptNode "R-HSA-2559580")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:26523")
         (ConceptNode "cytosol")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (GeneNode "MAP2K4")
         (ConceptNode "cytosol")
      )
   )
   (MemberLink (stv 1 1)
      (GeneNode "MAP2K4")
      (ConceptNode "R-HSA-450321")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q15750")
         (ConceptNode "endosome membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q15750")
      (ConceptNode "R-HSA-450321")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q15750")
         (ConceptNode "cytosol")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q15750")
      (ConceptNode "R-HSA-450321")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P53779")
      (ConceptNode "R-HSA-450321")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P53779")
         (ConceptNode "cytosol")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P53779")
      (ConceptNode "R-HSA-450321")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P53779")
         (ConceptNode "nucleoplasm")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P45984")
      (ConceptNode "R-HSA-450321")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P45984")
         (ConceptNode "cytosol")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P45984")
         (ConceptNode "nucleoplasm")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P45984")
      (ConceptNode "R-HSA-450321")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P45985")
         (ConceptNode "cytosol")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P45985")
      (ConceptNode "R-HSA-450321")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:O43353")
      (ConceptNode "R-HSA-450321")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:O43353")
         (ConceptNode "cytosol")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P62987")
         (ConceptNode "mitochondrial outer membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P62987")
      (ConceptNode "R-HSA-450321")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P62987")
      (ConceptNode "R-HSA-450321")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P62987")
         (ConceptNode "endocytic vesicle membrane")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P62987")
      (ConceptNode "R-HSA-450321")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P62987")
         (ConceptNode "nucleoplasm")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P62987")
      (ConceptNode "R-HSA-450321")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P62987")
         (ConceptNode "plasma membrane")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P62987")
      (ConceptNode "R-HSA-450321")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P62987")
         (ConceptNode "cytosol")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P62987")
      (ConceptNode "R-HSA-450321")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P62987")
         (ConceptNode "endosome membrane")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P62987")
      (ConceptNode "R-HSA-450321")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P62987")
         (ConceptNode "endoplasmic reticulum membrane")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q8N5C8")
         (ConceptNode "endosome membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q8N5C8")
      (ConceptNode "R-HSA-450321")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q8N5C8")
      (ConceptNode "R-HSA-450321")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q8N5C8")
         (ConceptNode "cytosol")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q8N5C8")
      (ConceptNode "R-HSA-450321")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q8N5C8")
         (ConceptNode "plasma membrane")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q9NYJ8")
         (ConceptNode "cytosol")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q9NYJ8")
      (ConceptNode "R-HSA-450321")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q9NYJ8")
         (ConceptNode "plasma membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q9NYJ8")
      (ConceptNode "R-HSA-450321")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q9NYJ8")
         (ConceptNode "nucleoplasm")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q9NYJ8")
      (ConceptNode "R-HSA-450321")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q9NYJ8")
         (ConceptNode "endosome membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q9NYJ8")
      (ConceptNode "R-HSA-450321")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P61088")
         (ConceptNode "cytosol")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P61088")
      (ConceptNode "R-HSA-450321")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P61088")
         (ConceptNode "nucleoplasm")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P61088")
      (ConceptNode "R-HSA-450321")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P45983")
      (ConceptNode "R-HSA-450321")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P45983")
         (ConceptNode "cytosol")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P45983")
         (ConceptNode "nucleoplasm")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P45983")
      (ConceptNode "R-HSA-450321")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P0CG48")
         (ConceptNode "mitochondrial outer membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P0CG48")
      (ConceptNode "R-HSA-450321")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P0CG48")
      (ConceptNode "R-HSA-450321")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P0CG48")
         (ConceptNode "endoplasmic reticulum membrane")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P0CG48")
      (ConceptNode "R-HSA-450321")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P0CG48")
         (ConceptNode "nucleoplasm")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P0CG48")
         (ConceptNode "endosome membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P0CG48")
      (ConceptNode "R-HSA-450321")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P0CG48")
         (ConceptNode "cytosol")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P0CG48")
      (ConceptNode "R-HSA-450321")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P0CG48")
      (ConceptNode "R-HSA-450321")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P0CG48")
         (ConceptNode "endocytic vesicle membrane")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P0CG48")
      (ConceptNode "R-HSA-450321")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P0CG48")
         (ConceptNode "plasma membrane")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P0CG47")
         (ConceptNode "cytosol")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P0CG47")
      (ConceptNode "R-HSA-450321")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P0CG47")
         (ConceptNode "nucleoplasm")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P0CG47")
      (ConceptNode "R-HSA-450321")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P0CG47")
         (ConceptNode "endosome membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P0CG47")
      (ConceptNode "R-HSA-450321")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P0CG47")
      (ConceptNode "R-HSA-450321")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P0CG47")
         (ConceptNode "plasma membrane")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P0CG47")
         (ConceptNode "mitochondrial outer membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P0CG47")
      (ConceptNode "R-HSA-450321")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P0CG47")
      (ConceptNode "R-HSA-450321")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P0CG47")
         (ConceptNode "endoplasmic reticulum membrane")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P0CG47")
      (ConceptNode "R-HSA-450321")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P0CG47")
         (ConceptNode "endocytic vesicle membrane")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P62979")
         (ConceptNode "cytosol")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P62979")
      (ConceptNode "R-HSA-450321")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P62979")
      (ConceptNode "R-HSA-450321")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P62979")
         (ConceptNode "plasma membrane")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P62979")
         (ConceptNode "endocytic vesicle membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P62979")
      (ConceptNode "R-HSA-450321")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P62979")
         (ConceptNode "endoplasmic reticulum membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P62979")
      (ConceptNode "R-HSA-450321")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P62979")
         (ConceptNode "mitochondrial outer membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P62979")
      (ConceptNode "R-HSA-450321")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P62979")
      (ConceptNode "R-HSA-450321")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P62979")
         (ConceptNode "endosome membrane")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P62979")
         (ConceptNode "nucleoplasm")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P62979")
      (ConceptNode "R-HSA-450321")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q9Y4K3")
      (ConceptNode "R-HSA-450321")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q9Y4K3")
         (ConceptNode "plasma membrane")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q9Y4K3")
         (ConceptNode "cytosol")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q9Y4K3")
      (ConceptNode "R-HSA-450321")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q9Y4K3")
      (ConceptNode "R-HSA-450321")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q9Y4K3")
         (ConceptNode "endosome membrane")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q13404")
         (ConceptNode "cytosol")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q13404")
      (ConceptNode "R-HSA-450321")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:O43318")
         (ConceptNode "endosome membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:O43318")
      (ConceptNode "R-HSA-450321")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:O43318")
         (ConceptNode "cytosol")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:O43318")
      (ConceptNode "R-HSA-450321")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q9HC29")
      (ConceptNode "R-HSA-450321")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q9HC29")
         (ConceptNode "cytosol")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q9Y6K9")
         (ConceptNode "nucleoplasm")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q9Y6K9")
      (ConceptNode "R-HSA-450321")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q9Y6K9")
      (ConceptNode "R-HSA-450321")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q9Y6K9")
         (ConceptNode "cytosol")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:O43187")
         (ConceptNode "endosome membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:O43187")
      (ConceptNode "R-HSA-450321")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:O43187")
      (ConceptNode "R-HSA-450321")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:O43187")
         (ConceptNode "plasma membrane")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:O43187")
         (ConceptNode "cytosol")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:O43187")
      (ConceptNode "R-HSA-450321")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q9Y239")
         (ConceptNode "cytosol")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q9Y239")
      (ConceptNode "R-HSA-450321")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:O14733")
         (ConceptNode "cytosol")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:O14733")
      (ConceptNode "R-HSA-450321")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:16761")
         (ConceptNode "cilium")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:16761")
      (ConceptNode "R-HSA-450321")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:16761")
         (ConceptNode "cytosol")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:16761")
      (ConceptNode "R-HSA-450321")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:16761")
      (ConceptNode "R-HSA-450321")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:16761")
         (ConceptNode "nucleoplasm")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:16761")
         (ConceptNode "endoplasmic reticulum membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:16761")
      (ConceptNode "R-HSA-450321")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:16761")
         (ConceptNode "mitochondrial matrix")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:16761")
      (ConceptNode "R-HSA-450321")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:16761")
      (ConceptNode "R-HSA-450321")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:16761")
         (ConceptNode "platelet dense granule lumen")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:16761")
         (ConceptNode "extracellular region")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:16761")
      (ConceptNode "R-HSA-450321")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:16761")
         (ConceptNode "endoplasmic reticulum lumen")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:16761")
      (ConceptNode "R-HSA-450321")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:16761")
         (ConceptNode "plasma membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:16761")
      (ConceptNode "R-HSA-450321")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:16761")
      (ConceptNode "R-HSA-450321")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:16761")
         (ConceptNode "mitochondrial intermembrane space")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15422")
      (ConceptNode "R-HSA-450321")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15422")
         (ConceptNode "cytosol")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15422")
      (ConceptNode "R-HSA-450321")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15422")
         (ConceptNode "plasma membrane")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15422")
         (ConceptNode "peroxisomal matrix")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15422")
      (ConceptNode "R-HSA-450321")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15422")
      (ConceptNode "R-HSA-450321")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15422")
         (ConceptNode "nucleoplasm")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15422")
         (ConceptNode "endoplasmic reticulum membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15422")
      (ConceptNode "R-HSA-450321")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15422")
      (ConceptNode "R-HSA-450321")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15422")
         (ConceptNode "mitochondrial matrix")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15422")
         (ConceptNode "platelet dense granule lumen")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15422")
      (ConceptNode "R-HSA-450321")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15422")
      (ConceptNode "R-HSA-450321")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15422")
         (ConceptNode "mitochondrial intermembrane space")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15422")
      (ConceptNode "R-HSA-450321")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15422")
         (ConceptNode "cilium")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15422")
         (ConceptNode "endoplasmic reticulum lumen")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15422")
      (ConceptNode "R-HSA-450321")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15422")
         (ConceptNode "extracellular region")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15422")
      (ConceptNode "R-HSA-450321")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:59414")
         (ConceptNode "cytosol")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:59414")
      (ConceptNode "R-HSA-450321")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:59271")
         (ConceptNode "cytosol")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:59271")
      (ConceptNode "R-HSA-450321")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (GeneNode "SPAG9")
         (ConceptNode "cytosol")
      )
   )
   (MemberLink (stv 1 1)
      (GeneNode "SPAG9")
      (ConceptNode "R-HSA-375170")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P53778")
      (ConceptNode "R-HSA-375170")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P53778")
         (ConceptNode "nucleoplasm")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P53778")
      (ConceptNode "R-HSA-375170")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P53778")
         (ConceptNode "cytosol")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P35222")
         (ConceptNode "cytosol")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P35222")
      (ConceptNode "R-HSA-375170")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P35222")
         (ConceptNode "nucleoplasm")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P35222")
      (ConceptNode "R-HSA-375170")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P35222")
         (ConceptNode "plasma membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P35222")
      (ConceptNode "R-HSA-375170")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:O00634")
      (ConceptNode "R-HSA-375170")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:O00634")
         (ConceptNode "extracellular region")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P55283")
         (ConceptNode "plasma membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P55283")
      (ConceptNode "R-HSA-375170")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q02080")
      (ConceptNode "R-HSA-375170")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q02080")
         (ConceptNode "nucleoplasm")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q12982")
      (ConceptNode "R-HSA-375170")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q12982")
         (ConceptNode "cytosol")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q4KMG0")
         (ConceptNode "plasma membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q4KMG0")
      (ConceptNode "R-HSA-375170")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P23409")
      (ConceptNode "R-HSA-375170")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P23409")
         (ConceptNode "nucleoplasm")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:O60271")
      (ConceptNode "R-HSA-375170")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:O60271")
         (ConceptNode "cytosol")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P19022")
      (ConceptNode "R-HSA-375170")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P19022")
         (ConceptNode "endoplasmic reticulum lumen")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P19022")
      (ConceptNode "R-HSA-375170")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P19022")
         (ConceptNode "plasma membrane")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P15923")
         (ConceptNode "nucleoplasm")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P15923")
      (ConceptNode "R-HSA-375170")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P60953")
      (ConceptNode "R-HSA-375170")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P60953")
         (ConceptNode "plasma membrane")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P60953")
      (ConceptNode "R-HSA-375170")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P60953")
         (ConceptNode "cytosol")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P60953")
      (ConceptNode "R-HSA-375170")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P60953")
         (ConceptNode "endoplasmic reticulum membrane")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P00519")
      (ConceptNode "R-HSA-375170")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P00519")
         (ConceptNode "cytosol")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P00519")
         (ConceptNode "nucleoplasm")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P00519")
      (ConceptNode "R-HSA-375170")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q92859")
         (ConceptNode "plasma membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q92859")
      (ConceptNode "R-HSA-375170")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q99081")
      (ConceptNode "R-HSA-375170")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q99081")
         (ConceptNode "nucleoplasm")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P55291")
      (ConceptNode "R-HSA-375170")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P55291")
         (ConceptNode "plasma membrane")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q9BWV1-1")
      (ConceptNode "R-HSA-375170")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q9BWV1-1")
         (ConceptNode "plasma membrane")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P15884")
         (ConceptNode "nucleoplasm")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P15884")
      (ConceptNode "R-HSA-375170")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q06413")
         (ConceptNode "nucleoplasm")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q06413")
      (ConceptNode "R-HSA-375170")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P13349")
      (ConceptNode "R-HSA-375170")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P13349")
         (ConceptNode "nucleoplasm")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q16539")
         (ConceptNode "nucleoplasm")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q16539")
      (ConceptNode "R-HSA-375170")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q16539")
         (ConceptNode "cytosol")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q16539")
      (ConceptNode "R-HSA-375170")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q16539")
         (ConceptNode "ficolin-1-rich granule lumen")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q16539")
      (ConceptNode "R-HSA-375170")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q16539")
         (ConceptNode "extracellular region")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q16539")
      (ConceptNode "R-HSA-375170")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q16539")
         (ConceptNode "secretory granule lumen")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q16539")
      (ConceptNode "R-HSA-375170")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P35221")
         (ConceptNode "cytosol")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P35221")
      (ConceptNode "R-HSA-375170")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P35221")
         (ConceptNode "plasma membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P35221")
      (ConceptNode "R-HSA-375170")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P26232")
         (ConceptNode "cytosol")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P26232")
      (ConceptNode "R-HSA-375170")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P15172")
         (ConceptNode "nucleoplasm")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P15172")
      (ConceptNode "R-HSA-375170")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q14814")
         (ConceptNode "nucleoplasm")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q14814")
      (ConceptNode "R-HSA-375170")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:P15173")
      (ConceptNode "R-HSA-375170")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:P15173")
         (ConceptNode "nucleoplasm")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q15759")
         (ConceptNode "cytosol")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q15759")
      (ConceptNode "R-HSA-375170")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q15759")
         (ConceptNode "nucleoplasm")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q15759")
      (ConceptNode "R-HSA-375170")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "Uniprot:Q02078")
      (ConceptNode "R-HSA-375170")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "Uniprot:Q02078")
         (ConceptNode "nucleoplasm")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:16761")
      (ConceptNode "R-HSA-375170")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:16761")
         (ConceptNode "platelet dense granule lumen")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:16761")
         (ConceptNode "endoplasmic reticulum membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:16761")
      (ConceptNode "R-HSA-375170")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:16761")
         (ConceptNode "plasma membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:16761")
      (ConceptNode "R-HSA-375170")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:16761")
      (ConceptNode "R-HSA-375170")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:16761")
         (ConceptNode "mitochondrial intermembrane space")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:16761")
         (ConceptNode "mitochondrial matrix")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:16761")
      (ConceptNode "R-HSA-375170")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:16761")
      (ConceptNode "R-HSA-375170")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:16761")
         (ConceptNode "nucleoplasm")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:16761")
         (ConceptNode "endoplasmic reticulum lumen")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:16761")
      (ConceptNode "R-HSA-375170")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:16761")
         (ConceptNode "cytosol")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:16761")
      (ConceptNode "R-HSA-375170")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:16761")
         (ConceptNode "extracellular region")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:16761")
      (ConceptNode "R-HSA-375170")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:16761")
         (ConceptNode "cilium")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:16761")
      (ConceptNode "R-HSA-375170")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15422")
         (ConceptNode "platelet dense granule lumen")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15422")
      (ConceptNode "R-HSA-375170")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15422")
      (ConceptNode "R-HSA-375170")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15422")
         (ConceptNode "cytosol")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15422")
      (ConceptNode "R-HSA-375170")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15422")
         (ConceptNode "mitochondrial matrix")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15422")
      (ConceptNode "R-HSA-375170")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15422")
         (ConceptNode "cilium")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15422")
      (ConceptNode "R-HSA-375170")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15422")
         (ConceptNode "nucleoplasm")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15422")
      (ConceptNode "R-HSA-375170")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15422")
         (ConceptNode "mitochondrial intermembrane space")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15422")
      (ConceptNode "R-HSA-375170")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15422")
         (ConceptNode "plasma membrane")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15422")
         (ConceptNode "endoplasmic reticulum membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15422")
      (ConceptNode "R-HSA-375170")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15422")
         (ConceptNode "peroxisomal matrix")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15422")
      (ConceptNode "R-HSA-375170")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15422")
         (ConceptNode "endoplasmic reticulum lumen")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15422")
      (ConceptNode "R-HSA-375170")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15422")
         (ConceptNode "extracellular region")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15422")
      (ConceptNode "R-HSA-375170")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15996")
      (ConceptNode "R-HSA-375170")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15996")
         (ConceptNode "cytoplasmic vesicle membrane")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15996")
         (ConceptNode "endocytic vesicle lumen")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15996")
      (ConceptNode "R-HSA-375170")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15996")
      (ConceptNode "R-HSA-375170")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15996")
         (ConceptNode "cilium")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15996")
      (ConceptNode "R-HSA-375170")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15996")
         (ConceptNode "lysosomal membrane")
      )
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15996")
      (ConceptNode "R-HSA-375170")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15996")
         (ConceptNode "platelet dense granule lumen")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15996")
         (ConceptNode "cytosol")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15996")
      (ConceptNode "R-HSA-375170")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15996")
      (ConceptNode "R-HSA-375170")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15996")
         (ConceptNode "Golgi membrane")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15996")
         (ConceptNode "mitochondrial matrix")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15996")
      (ConceptNode "R-HSA-375170")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15996")
      (ConceptNode "R-HSA-375170")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15996")
         (ConceptNode "nucleoplasm")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15996")
         (ConceptNode "ER to Golgi transport vesicle membrane")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15996")
      (ConceptNode "R-HSA-375170")
   )
)
 (AndLink
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15996")
      (ConceptNode "R-HSA-375170")
   )
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15996")
         (ConceptNode "early endosome membrane")
      )
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15996")
         (ConceptNode "extracellular region")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15996")
      (ConceptNode "R-HSA-375170")
   )
)
 (AndLink
   (EvaluationLink (stv 1 1)
      (PredicateNode "has_location")
      (ListLink
         (MoleculeNode "ChEBI:15996")
         (ConceptNode "Golgi lumen")
      )
   )
   (MemberLink (stv 1 1)
      (MoleculeNode "ChEBI:15996")
      (ConceptNode "R-HSA-375170")
   )
)

;;; Names of Molecule Nodes

(EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P01772")
      (ConceptNode "Ig")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q9H9G7")
      (ConceptNode "EIF2C3")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P01599")
      (ConceptNode "Ig")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q9UKB1")
      (ConceptNode "FBXW11")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P01704")
      (ConceptNode "Ig")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:O14733")
      (ConceptNode "MAP2K7(2-?)")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P63208")
      (ConceptNode "SKP1")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P62807")
      (ConceptNode "AcK16-HIST1H2BC")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P29353-2")
      (ConceptNode "p-Y317-SHC1-2")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q9Y239")
      (ConceptNode "NOD1")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "ChEBI:29888")
      (ConceptNode "PPi ")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P19838")
      (ConceptNode "NFKB1(1-968)")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q99880")
      (ConceptNode "AcK6-HIST1H2BL")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "ChEBI:16618.0")
      (ConceptNode "{[(1S,2S,3S,4S,5R,6S)-3-({[2,2-bis(acetyloxy)ethoxy](hydroxy)phosphoryl}oxy)-2,4-dihydroxy-5,6-bis(phosphonooxy)cyclohexyl]oxy}phosphonic acid")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:O95503")
      (ConceptNode "CBX6")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:A2NJV5")
      (ConceptNode "IGKVA18(21-?)")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P01718")
      (ConceptNode "Ig")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P57053")
      (ConceptNode "H2BFS")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "ChEBI:59271")
      (ConceptNode "iE-DAP ")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P01709")
      (ConceptNode "Ig")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q9UKW4")
      (ConceptNode "VAV3")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q9H6X2-2")
      (ConceptNode "ANTXR1-2")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q14186")
      (ConceptNode "TFDP1")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "ChEBI:26523")
      (ConceptNode "ROS ")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P15917")
      (ConceptNode "LF")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q71DI3")
      (ConceptNode "2xAcK-HIST2H3A")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P06331")
      (ConceptNode "Ig")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q6PIL0")
      (ConceptNode "IGHV7-81(1-?)")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q6FI13")
      (ConceptNode "MeR4-HIST2H2AA3")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "ChEBI:61049.0")
      (ConceptNode "nan")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "ChEBI:nan")
      (ConceptNode "(2R)-2,3-bis(icosanoyloxy)propyl 22-methyltetracosanoate")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P20671")
      (ConceptNode "MeR12-HIST1H2AD")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:O43187")
      (ConceptNode "p-IRAK2")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P01782")
      (ConceptNode "Ig")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P80748")
      (ConceptNode "Ig")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P84243")
      (ConceptNode "H3F3A")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q9Y6K9")
      (ConceptNode "Ub-285-IKBKG")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P41279")
      (ConceptNode "MAP3K8")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q8NDX5")
      (ConceptNode "PHC3")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:O00716")
      (ConceptNode "p-E2F3")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q02078")
      (ConceptNode "p-S408-MEF2A")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q13233")
      (ConceptNode "MAP3K1")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "ChEBI:15843.0")
      (ConceptNode "(5Z,8Z,11Z,14Z)-icosa-5,8,11,14-tetraenoic acid")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "ChEBI:16680")
      (ConceptNode "AdoHcy ")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "ChEBI:27363")
      (ConceptNode "zinc")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "ChEBI:29105")
      (ConceptNode "zinc(2+) ion")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "ChEBI:27363.0")
      (ConceptNode "zinc")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q5NV81")
      (ConceptNode "IGLV1-44(1-?)")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P0DP23")
      (ConceptNode "Me3K115-CALM1")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q5NV91")
      (ConceptNode "IGLV3-27(1-?)")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P01834")
      (ConceptNode "IGKC")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P05412")
      (ConceptNode "Transcription factor AP-1")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P06899")
      (ConceptNode "AcK6-HIST1H2BJ")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "ChEBI:28304.0")
      (ConceptNode "nan")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q9UL18")
      (ConceptNode "EIF2C1")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P42772")
      (ConceptNode "CDKN2B")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q5NV84")
      (ConceptNode "IGLV2-11(1-?)")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q5NV83")
      (ConceptNode "IGLV7-46(1-?)")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P01814")
      (ConceptNode "Ig")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P04430")
      (ConceptNode "Ig")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:A0M8Q6")
      (ConceptNode "IGLC7")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P16885")
      (ConceptNode "p-Y-PLCG2")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q5NV61")
      (ConceptNode "IGLV4-3(1-?)")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q15759")
      (ConceptNode "Mitogen-activated protein kinase 11")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "ChEBI:15555.0")
      (ConceptNode "(5Z)-7-[(1R,2R,5S)-5-hydroxy-2-[(1E,3S)-3-hydroxyoct-1-en-1-yl]-3-oxocyclopentyl]hept-5-enoic acid")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:A0A075B6P5")
      (ConceptNode "IGKV2-28")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P01714")
      (ConceptNode "Ig")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P15173")
      (ConceptNode "MYOG")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q14814")
      (ConceptNode "MEF2D")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P01619")
      (ConceptNode "Ig")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P01611")
      (ConceptNode "Ig")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q9BTM1")
      (ConceptNode "H2AFJ")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P15172")
      (ConceptNode "MYOD1")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P01602")
      (ConceptNode "IGKV1-5(23-?)")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q9HC29")
      (ConceptNode "NOD2")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P46734-3")
      (ConceptNode "MAP2K3-3(1-26)")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q8N726")
      (ConceptNode "p14-ARF")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "ChEBI:15996")
      (ConceptNode "({[({[(2R,3S,4R,5R)-5-(2-amino-6-oxo-6,9-dihydro-1H-purin-9-yl)-3,4-dihydroxyoxolan-2-yl]methoxy}(hydroxy)phosphoryl)oxy](hydroxy)phosphoryl}oxy)phosphonic acid")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P01768")
      (ConceptNode "Ig")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q8N257")
      (ConceptNode "AcK16-HIST3H2BB")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q5NV86")
      (ConceptNode "IGLV10-54(1-?)")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P33778")
      (ConceptNode "AcK6-HIST1H2BB")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P36507")
      (ConceptNode "MAP2K2(11-400)")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "ChEBI:15996.0")
      (ConceptNode "({[({[(2R,3S,4R,5R)-5-(2-amino-6-oxo-6,9-dihydro-1H-purin-9-yl)-3,4-dihydroxyoxolan-2-yl]methoxy}(hydroxy)phosphoryl)oxy](hydroxy)phosphoryl}oxy)phosphonic acid")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "ChEBI:15741")
      (ConceptNode "butanedioic acid")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "ChEBI:29035.0")
      (ConceptNode "manganese(2+) ion")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P01593")
      (ConceptNode "Ig")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q9UPQ9")
      (ConceptNode "TNRC6B")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P52564-1")
      (ConceptNode "MAP2K6-1(15-334)")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "ChEBI:15377.0")
      (ConceptNode "water")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "ChEBI:18367")
      (ConceptNode "phosphate ")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:A0A075B6S6")
      (ConceptNode "IGKV2D-30")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P01854")
      (ConceptNode "Ig epsilon chain C region")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "ChEBI:17489")
      (ConceptNode "(4aR,6R,7R,7aS)-6-(6-amino-9H-purin-9-yl)-2,7-dihydroxy-hexahydro-2λ⁵-furo[3,2-d][1,3,2]dioxaphosphinin-2-one")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q99683")
      (ConceptNode "MAP3K5")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P01615")
      (ConceptNode "Ig")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P04433")
      (ConceptNode "Ig")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q14188")
      (ConceptNode "TFDP2")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P0C5Y9")
      (ConceptNode "H2AFB1")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P26232")
      (ConceptNode "CTNNA2")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q16778")
      (ConceptNode "AcK16-HIST2H2BE")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q5NV82")
      (ConceptNode "IGLV5-45(1-?)")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:O75791")
      (ConceptNode "GRAP2")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q9Y297")
      (ConceptNode "BTRC")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q5NV75")
      (ConceptNode "IGLV3-22(1-?)")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:A2KUC3")
      (ConceptNode "IGHV(1-?)")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:O75530")
      (ConceptNode "EED")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:O43561-2")
      (ConceptNode "p-5Y-LAT-2")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:O43318")
      (ConceptNode "PolyUb-MAP3K7")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P16104")
      (ConceptNode "Me2sR4-H2AFX")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P04432")
      (ConceptNode "Ig")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q99879")
      (ConceptNode "HIST1H2BM")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P46734")
      (ConceptNode "Dual specificity mitogen-activated protein kinase kinase 3")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q13404")
      (ConceptNode "UBE2V1")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "ChEBI:29108")
      (ConceptNode "Ca2+ ")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q5NV67")
      (ConceptNode "IGLV1-36(1-?)")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q5NV92")
      (ConceptNode "IGLV4-69(1-?)")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q8NDV7")
      (ConceptNode "TNRC6A")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P23083")
      (ConceptNode "IGHV1-2")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P01699")
      (ConceptNode "Ig")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P01767")
      (ConceptNode "Ig")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P0CG04")
      (ConceptNode "IGLC1")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P35226")
      (ConceptNode "BMI1")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P35221")
      (ConceptNode "CTNNA1")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q9Y4K3")
      (ConceptNode "K63polyUb-TRAF6")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q5NV85")
      (ConceptNode "IGLV3-12(1-?)")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q13616")
      (ConceptNode "CUL1")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q16644")
      (ConceptNode "MAPKAPK3")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q96GD3-2")
      (ConceptNode "SCMH1-2")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q16539")
      (ConceptNode "Mitogen-activated protein kinase 14")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P42771")
      (ConceptNode "p16-INK4a")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q9HC52")
      (ConceptNode "CBX8")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P01824")
      (ConceptNode "Ig")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P30273")
      (ConceptNode "FCER1G")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P78364")
      (ConceptNode "PHC1")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P01763")
      (ConceptNode "Ig")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P58335-1")
      (ConceptNode "ANTXR2-1")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P01624")
      (ConceptNode "Ig")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "ChEBI:15650.0")
      (ConceptNode "(5S,6R,7E,9E,11Z,14Z)-6-{[(2R)-2-amino-2-carboxyethyl]sulfanyl}-5-hydroxyicosa-7,9,11,14-tetraenoic acid")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q5NV79")
      (ConceptNode "IGLV4-60(1-?)")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P07948")
      (ConceptNode "MyrG2-PalmC3-LYN")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P62979")
      (ConceptNode "N6-glycyl-L-lysine-RPS27A(1-76)")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P0CG47")
      (ConceptNode "adenylatedG76-UBB(1-76)")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P13349")
      (ConceptNode "MYF5")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "ChEBI:36704")
      (ConceptNode "IMIQ ")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P09958")
      (ConceptNode "FURIN")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:A2NXD2")
      (ConceptNode "IGLV(23-?)")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q00534")
      (ConceptNode "p-T177-CDK6")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P0CG48")
      (ConceptNode "N6-glycyl-L-lysine-UBC(229-304)")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q01094")
      (ConceptNode "p-E2F1")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "ChEBI:30915")
      (ConceptNode "2-oxopentanedioic acid")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q99496")
      (ConceptNode "RNF2")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q5NV89")
      (ConceptNode "IGLV2-23(1-?)")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P01703")
      (ConceptNode "Ig")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q06413")
      (ConceptNode "p-S396-MEF2C")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P01742")
      (ConceptNode "Ig")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P42773")
      (ConceptNode "CDKN2C")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P15884")
      (ConceptNode "TCF4")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P63000")
      (ConceptNode "GGC-PalmC-RAC1")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P45983")
      (ConceptNode "Mitogen-activated protein kinase 8")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q5NV66")
      (ConceptNode "IGLV2-33(1-?)")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q9BWV1-1")
      (ConceptNode "BOC-1")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q13094")
      (ConceptNode "Lymphocyte cytosolic protein 2")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q5NV65")
      (ConceptNode "IGLV2-18(1-?)")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q8N4C8")
      (ConceptNode "MINK1")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q02750")
      (ConceptNode "Dual specificity mitogen-activated protein kinase kinase 1")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P0CG05")
      (ConceptNode "IGLC2")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q9HCJ0")
      (ConceptNode "TNRC6C")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q15022")
      (ConceptNode "SUZ12")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q5NV90")
      (ConceptNode "IGLV3-25(1-?)")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:A0A0C4DH25")
      (ConceptNode "IGKV3D-20")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "ChEBI:17552.0")
      (ConceptNode "[({[(2R,3S,4R,5R)-5-(2-amino-6-oxo-6,9-dihydro-1H-purin-9-yl)-3,4-dihydroxyoxolan-2-yl]methoxy}(hydroxy)phosphoryl)oxy]phosphonic acid")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "ChEBI:18295.0")
      (ConceptNode "2-(1H-imidazol-4-yl)ethan-1-amine")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q15910")
      (ConceptNode "EZH2")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P10599")
      (ConceptNode "Thioredoxin")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "ChEBI:59309")
      (ConceptNode "nan")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P01717")
      (ConceptNode "Ig")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P55291")
      (ConceptNode "CDH15")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q14209")
      (ConceptNode "E2F2")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q99081")
      (ConceptNode "TCF12")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q92859")
      (ConceptNode "NEO1")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P58876")
      (ConceptNode "AcK13-HIST1H2BD")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P00519")
      (ConceptNode "ABL1")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P06310")
      (ConceptNode "Ig")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P01780")
      (ConceptNode "Ig")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P60953")
      (ConceptNode "Cell division control protein 42 homolog")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "ChEBI:59414")
      (ConceptNode "MDP ")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q8IXK0")
      (ConceptNode "PHC2")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P04908")
      (ConceptNode "MeR4-HIST1H2AB")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P13423")
      (ConceptNode "PA83")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P15923")
      (ConceptNode "p-S139-TCF3")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q8IW41")
      (ConceptNode "p-S115")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P01766")
      (ConceptNode "Ig")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P43405")
      (ConceptNode "p-6Y-SYK")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P61088")
      (ConceptNode "Ub-C87-UBE2N")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q5NV87")
      (ConceptNode "IGLV11-55(1-?)")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P19022")
      (ConceptNode "CDH2")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P11802")
      (ConceptNode "p-T172-CDK4")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "ChEBI:15422")
      (ConceptNode "({[({[(2R,3S,4R,5R)-5-(6-amino-9H-purin-9-yl)-3,4-dihydroxyoxolan-2-yl]methoxy}(hydroxy)phosphoryl)oxy](hydroxy)phosphoryl}oxy)phosphonic acid")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:O60271")
      (ConceptNode "SPAG9")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q9NYJ8")
      (ConceptNode "TGF-beta-activated kinase 1 and MAP3K7-binding protein 2")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q8N5C8")
      (ConceptNode "TGF-beta-activated kinase 1 and MAP3K7-binding protein 3")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q9HCE1")
      (ConceptNode "MOV10")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P01100")
      (ConceptNode "FOS")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q5NV80")
      (ConceptNode "IGLV7-43(1-?)")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P01715")
      (ConceptNode "Ig")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P23409")
      (ConceptNode "MYF6")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P62993-1")
      (ConceptNode "GRB2-1")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P62987")
      (ConceptNode "N6-glycyl-L-lysine-UBA52(1-76)")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "ChEBI:28666.0")
      (ConceptNode "(5S,6R,7E,9E,11Z,14Z)-6-{[(2R)-2-amino-2-[(carboxymethyl)carbamoyl]ethyl]sulfanyl}-5-hydroxyicosa-7,9,11,14-tetraenoic acid")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "ChEBI:17633.0")
      (ConceptNode "nan")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P0C0S5")
      (ConceptNode "Me2sR4-H2AFZ")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:O43353")
      (ConceptNode "Receptor-interacting serine/threonine-protein kinase 2")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P01601")
      (ConceptNode "Ig")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P0CF74")
      (ConceptNode "IGLC6")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q07889")
      (ConceptNode "p-4S-SOS1")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P01597")
      (ConceptNode "Ig")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q99877")
      (ConceptNode "Ub-HIST1H2BN")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q9HCK5")
      (ConceptNode "EIF2C4")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "ChEBI:18367.0")
      (ConceptNode "phosphate")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q16777")
      (ConceptNode "HIST2H2AC")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "ChEBI:15414")
      (ConceptNode "[(3S)-3-amino-3-carboxypropyl]({[(2S,3S,4R,5R)-5-(6-amino-9H-purin-9-yl)-3,4-dihydroxyoxolan-2-yl]methyl})methylsulfanium")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P52735")
      (ConceptNode "p-Y172-VAV2")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P01825")
      (ConceptNode "Ig")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P23527")
      (ConceptNode "AcK6-HIST1H2BO")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q16576")
      (ConceptNode "RBBP7")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q4KMG0")
      (ConceptNode "CDON")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P49137")
      (ConceptNode "MAPKAPK2")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "ChEBI:16761")
      (ConceptNode "[({[(2R,3S,4R,5R)-5-(6-amino-9H-purin-9-yl)-3,4-dihydroxyoxolan-2-yl]methoxy}(hydroxy)phosphoryl)oxy]phosphonic acid")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P01764")
      (ConceptNode "IgH")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "ChEBI:18420.0")
      (ConceptNode "magnesium(2+) ion")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P01574")
      (ConceptNode "IFNB1")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "ChEBI:29108.0")
      (ConceptNode "calcium(2+) ion")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q93077")
      (ConceptNode "Ack6-HIST1H2AC")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q12982")
      (ConceptNode "BNIP2")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P06312")
      (ConceptNode "IGKV4-1(21-?)")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q5NV68")
      (ConceptNode "IGLV5-37(1-?)")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q02080")
      (ConceptNode "MEF2B")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P15498")
      (ConceptNode "p-Y174-VAV1")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P45985")
      (ConceptNode "MAP2K4")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P01700")
      (ConceptNode "Ig")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P01112")
      (ConceptNode "G12V")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P68431")
      (ConceptNode "AcK19-HIST1H3A")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:O95819")
      (ConceptNode "MAP4K4")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P01721")
      (ConceptNode "Ig")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q93079")
      (ConceptNode "AcK21-HIST1H2BH")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q14781")
      (ConceptNode "CBX2")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P12319")
      (ConceptNode "High affinity immunoglobulin epsilon receptor subunit alpha")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q5NV69")
      (ConceptNode "IGLV1-40(1-?)")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "ChEBI:16978.0")
      (ConceptNode "(5S,6R,7E,9E,11Z,14Z)-6-{[(2R)-2-[(4S)-4-amino-4-carboxybutanamido]-2-[(carboxymethyl)carbamoyl]ethyl]sulfanyl}-5-hydroxyicosa-7,9,11,14-tetraenoic acid")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P01701")
      (ConceptNode "Ig")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P55283")
      (ConceptNode "CDH4")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P0CG06")
      (ConceptNode "IGLC3")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q96A08")
      (ConceptNode "AcK17-HIST1H2BA")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q09028")
      (ConceptNode "RBBP4")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:O15151")
      (ConceptNode "p-S403-MDM4")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:O00257")
      (ConceptNode "CBX4")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q5NV62")
      (ConceptNode "IGLV8-61(1-?)")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:O15054")
      (ConceptNode "KDM6B")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q9UKE5")
      (ConceptNode "TNIK")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P55273")
      (ConceptNode "CDKN2D")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:A0A0C4DH73")
      (ConceptNode "IGKV1-12")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P04637")
      (ConceptNode "p-S37-TP53")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P01116")
      (ConceptNode "G12V")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P45984")
      (ConceptNode "MAPK9")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:O60814")
      (ConceptNode "AcK21-HIST1H2BK")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P53779")
      (ConceptNode "MAPK10")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P58335-4")
      (ConceptNode "ANTXR2-4")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P52564")
      (ConceptNode "Dual specificity mitogen-activated protein kinase kinase 6")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P01743")
      (ConceptNode "Ig")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "ChEBI:18420")
      (ConceptNode "Mg2+ ")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P01706")
      (ConceptNode "Ig")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P01111")
      (ConceptNode "G12S")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q5NV64")
      (ConceptNode "IGLV3-16(1-?)")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P01817")
      (ConceptNode "Ig")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:O00634")
      (ConceptNode "NTN3")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P40136")
      (ConceptNode "EF")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q8WUM4")
      (ConceptNode "PDCD6IP")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "ChEBI:15378")
      (ConceptNode "hydron")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q06587")
      (ConceptNode "RING1")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q9H6X2-1")
      (ConceptNode "ANTXR1-1")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P01594")
      (ConceptNode "Ig")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P01762")
      (ConceptNode "Ig")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P35222")
      (ConceptNode "p-S552-CTNNB1")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "ChEBI:16595.0")
      (ConceptNode "{[(1R,2S,3R,4R,5S,6R)-2,3,5-trihydroxy-4,6-bis(phosphonooxy)cyclohexyl]oxy}phosphonic acid")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P04211")
      (ConceptNode "Ig")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q71UI9")
      (ConceptNode "H2AFV")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q13153")
      (ConceptNode "PAK1")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "ChEBI:17552")
      (ConceptNode "[({[(2R,3S,4R,5R)-5-(2-amino-6-oxo-6,9-dihydro-1H-purin-9-yl)-3,4-dihydroxyoxolan-2-yl]methoxy}(hydroxy)phosphoryl)oxy]phosphonic acid")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q13177")
      (ConceptNode "PAK2")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q15750")
      (ConceptNode "TAB1")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q99878")
      (ConceptNode "Ub-HIST1H2AJ")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:Q8NFZ5")
      (ConceptNode "TNIP2")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P62805")
      (ConceptNode "Me2sR4-HIST1H4")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P01705")
      (ConceptNode "Ig")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P06315")
      (ConceptNode "Ig")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P53778")
      (ConceptNode "MAPK12")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P01614")
      (ConceptNode "Ig")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "Uniprot:P19174")
      (ConceptNode "1-phosphatidylinositol 4,5-bisphosphate phosphodiesterase gamma-1")
   )
)
 (EvaluationLink
   (PredicateNode "has_name")
   (ListLink
      (MoleculeNode "ChEBI:18248")
      (ConceptNode "λ²-iron(2+) ion")
   )
)








