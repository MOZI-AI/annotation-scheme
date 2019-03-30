import sys
import re
import pandas as pd

def find_name(str):
	name = re.findall('"([^"]*)"', str)
	if len(name) > 0:
		return re.findall('"([^"]*)"', str)[0]
	return ""

def to_csv(file):
	member = []
	evalun = []
	interaction = []
	go_annotation = 0
	gene_pathway = 0
	biogrid = 0

	f = open(file, "r")
	lines=open(file, "r").readlines()

	for num, line in enumerate(f , 0):
		if "InheritanceLink" in line or "MemberLink" in line:
			member.append(num)
		elif "EvaluationLink" in line:
			evalun.append(num)
		elif "gene_go_annotation" in line:
			go_annotation = num
		elif "gene_pathway_annotation" in line:
			gene_pathway = num
		elif "biogrid_interaction_annotation" in line:
			biogrid = num

	GO_ns = {}
	node_name = {}
	node_defn = {}

	for i in evalun:
		if "GO_namespace" in lines[i+1]:
			GO_ns.update({find_name(lines[i+3]): find_name(lines[i+4])})
		elif "has_name" in lines[i+1]:
			node_name.update({find_name(lines[i+3]): find_name(lines[i+4])})
		elif "has_definition" in lines[i+1]:
			node_defn.update({find_name(lines[i+3]): find_name(lines[i+4])})
		elif "Interacts_with" in lines[i+1]:
			interaction.append(i+1)
	
	col = ["Gene_ID","GO_cellular_componenet", "GO_Molecular_function", "GO_Biological_process", "pathway", "proteins", "small_mol"]
	gene_go = pd.DataFrame([], columns= col)
	for i in member:
		gene = find_name(lines[i+1])
		go = find_name(lines[i+2])
		if "GeneNode" in lines[i+1] and "GO:" in lines[i+2] and GO_ns != {}:
			if GO_ns[go] == "cellular_component":
				gene_go = gene_go.append(pd.DataFrame([[gene, go +" (" +node_name[go] +")", "", "", "", "", ""]], columns=col))
			elif GO_ns[go] == "biological_process":
				gene_go = gene_go.append(pd.DataFrame([[gene, "", "", go +" (" +node_name[go] +")", "", "", ""]], columns=col))	
			elif GO_ns[go] == "molecular_function":
				gene_go = gene_go.append(pd.DataFrame([[gene, "", go +" (" +node_name[go] +")", "", "", "", ""]], columns=col))	
		elif "GeneNode" in lines[i+1] and ("R-HSA" in lines[i+2] or 'ConceptNode "SMP' in lines[i+2]):
			prot = []
			sm = []
			pathway = find_name(lines[i+2])
			for j in member:
				if 'ChEBI:' in lines[j+1] and find_name(lines[j+2]) == pathway:
					sm.append(find_name(lines[j+1]) + ' (' + node_defn[find_name(lines[j+1])] + ")" )
				elif 'Uniprot:' in lines[j+1] and find_name(lines[j+2]) == pathway:
					prot.append(find_name(lines[j+1]) + ' ('+ node_defn[find_name(lines[j+1])] + ")" )
			gene_go = gene_go.append(pd.DataFrame([[gene, "","", "", pathway, str(prot), str(sm)]], columns=col))
	
	# Gene Go annotation
	if go_annotation != 0:
		col_go = ["Gene_ID", "Gene_Name", "Gene_definition", "GO_cellular_componenet", "GO_Molecular_function", "GO_Biological_process"]
		go_df = pd.concat([pd.DataFrame([[g, node_name[g], node_defn[g], "\n".join(filter(None, gene_go[gene_go['Gene_ID'] == g]['GO_cellular_componenet'].get_values())), 
		"\n".join(filter(None, gene_go[gene_go['Gene_ID'] == g]['GO_Molecular_function'].get_values())),
		"\n".join(filter(None, gene_go[gene_go['Gene_ID'] == g]['GO_Biological_process'].get_values()))]], columns= col_go) for g in set(gene_go['Gene_ID'])], ignore_index=True)
		go_df.to_csv("Gene_GO_annotation.csv")

	# Gene Pathway annotation
	if gene_pathway != 0:
		col_pw = ["Pathway", "Pathway_Name", "Pathway_definition", "Proteins", "Small Molecules", "Genes"]
		pw_df = pd.concat([pd.DataFrame([[p, node_name[p], node_defn[p], '\n'.join(filter(None, gene_go[gene_go['pathway'] == p]['proteins'].get_values())), 
		"\n".join(filter(None, gene_go[gene_go['pathway'] == p]['small_mol'].get_values())), "\n".join(filter(None, gene_go[gene_go['pathway'] == p]['Gene_ID'].get_values()))]], 
		columns= col_pw) for p in set(filter(None, gene_go['pathway']))], ignore_index=True)
		pw_df.to_csv("Gene_pathway_annotations.csv")

	# Biogrid annotation
	if biogrid != 0:
		col_int = ["Interactor-1", "Interactor-1_Name", "Interactor-1_definition", "Interaction", "Interactor-2", "Interactor-2_Name", "Interactor-2_definition"]
		bg_df = pd.concat([pd.DataFrame([[find_name(lines[i+2]), node_name[find_name(lines[i+2])], node_defn[find_name(lines[i+2])], "Interacts_with", 
		find_name(lines[i+3]), node_name[find_name(lines[i+3])], node_defn[find_name(lines[i+3])]]], columns= col_int) for i in interaction], ignore_index=True)
		bg_df.to_csv("biogrid_annotation.csv")

if __name__ == "__main__":
	to_csv(sys.argv[1])