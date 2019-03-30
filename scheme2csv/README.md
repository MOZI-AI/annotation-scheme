# Annotation service scheme result into CSV convertor

A python script scm2csv.py accepts the scheme result of the annotation service and change 
them into CSV in a way it can be used to do further data processing. 

The script will generate maximum of three CSV results depending on the number of annotations
the user requested. 

Example file:

Example-1.scm has scheme result of the gene_go_annotation and biogrid_interaction_annotation 
for genes "MAP2K4 and SPAG9"

Example-2.scm has the scheme result of the gene_go_annotation, gene_pathway_annotation and 
biogrid_interaction_annotation for genes "MAP2K4 and SPAG9"

Example-3.scm has the scheme result of the biogrid_interaction_annotation for gene "A1BG"


RUN:

Use Python3, open a terminal from current directory and run the following:

python3 scm2csv.py result_file_name.scm

Example:

python3 scm2csv.py Example-3.scm

Generates biogrid_annotation.csv for Gene-Gene interaction annotation of a given gene "A1BG"

------

python3 scm2csv.py Example-2.scm

Generates three CSV files for each annotation.

Gene_GO_annotation.csv, Gene_pathway_annotations.csv and biogrid_annotation.csv 

------

Note:

The latest annotation functions from ../functions/ are used to do the annotation (which includes 
name and definition of the nodes).

Running the annotation service, to generate the scheme result (without being parsed into JSON), 
use (do_annotation_scm annotation_list)


