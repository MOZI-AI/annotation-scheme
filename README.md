**Annotation Scheme**

This project contains the scheme code that is used by MOZI annotation service. It annotates Human Gene Symbols using three databases (GO, Reactome & Biogrid). It uses the [Atomspace](https://github.com/opencog/atomspace) to store the knoweldge in a hypergraph and uses the [Pattern Matcher](https://wiki.opencog.org/w/The_Pattern_Matcher) to retrieve relevant information for requested genes.

You can use the `Dockerfile` to build an image that has all the necessary dependencies to run the project or you can build everything manually.

To build the project manually, make sure you have [Atomspace](https://github.com/opencog/atomspace)  [Opencog](https://github.com/opencog/opencog),  [NYACC](http://download.savannah.nongnu.org/releases/nyacc/nyacc-0.99.0.tar.gz) and [guile-json](https://github.com/Habush/annotation-scheme) installed. Once you have installed these dependencies, you can build the project using the following instructions:

1. Clone the project.

    ~~~~
    $ git clone https://github.com/MOZI-AI/annotation-scheme.git
    ~~~~

2. Build the project

    ~~~~
    $ cd annotation-scheme && \
        autoreconf -vif && \
        ./configure && \
        make && \
        make install
    ~~~~

    To run the tests you can use `make check` 

3. Test using a sample dataset

    3a. Open `guile` and import the modules

    ```
    scheme@(guile-user)> (use-modules                    (annotation) (annotation main) 
            (annotation gene-go) 
            (annotation biogrid) 
            (annotation gene-pathway)
            (annotation functions) 
            (annotation util)
            (annotation parser)
            (annotation rna)
            (json))

    ```
    3b. Load the sample dataset

    ```
    scheme@(guile-user)> (primitive-load "path/to/annotation-scheme/tests/sample_dataset.scm")

    ```

    3c. Run annotations for gene **IGF1**

    **Gene-go annotation:**

    Annotates a gene/genes for its GO-term (of type biological_process, molecular_function or cellular_component) and n number of parents a Go-term has of the selected type. It will also annotate the protein form of the gene if protein option is set to True.   
    
    Required parameters are: list of genes, directory name to write the results, GO namespaces, number of parents to traverse for the GO term and boolean value to include proteins.

    ```
        scheme@(guile-user)> (gene-go-annotation (list "IGF1") "dir-name" #:namespace "biological_process molecular_function cellular_component" #:parents 0 #:protein "True")

    ```
    The default values has also been set to the namespace, number of parents and protein arguments to be "biological_process molecular_function cellular_component", 0 and "True" respectively. So, One can also do go-annotation by setting a value for list of genes and directory name as:

    ```
        scheme@(guile-user)> (gene-go-annotation (list "IGF1") "dir-name")

    ```

    **Gene-pathway annotation:**

    Annotates a gene/genes for its pathway(`reactome` or `smpdb`), finds other genes in the pathway and do cross annotation for biogrid and GO databases. The cross annotation will be done for the genes found in the pathway other than the given ones. The proteins and small molecules of the pathways will also be annotated if those parameters are set to true. 

    Required parameters includes the list of genes, directory name to write the results, pathways name, options to include proteins and small molecules, cross annotation parameters for biogrid(1 or 0) and gene go annotations(set the namespace and number of parents). 

    ```
    scheme@(guile-user)> (gene-pathway-annotation (list "IGF1") "dir-name" #:pathway "reactome smpdb" #:include_prot "True" #:include_sm "True" #:namespace "biological_process" #:parents 0 #:biogrid 1)

    ```
    With the default parameters set, One can also do pathways annotations as:

    ```
    scheme@(guile-user)> (gene-pathway-annotation (list "IGF1") "dir-name")

    ```

    **Biogrid annotation**

    Annotates a gene/genes interaction to the other genes from biogrid protein interaction database and do cross annotation of go-annotation for the resulting genes. The interaction can be in a gene level or/and a protein level depending on the value for the interaction argument. 

    Required parameters are list of genes, directory name to write the results, interaction type (`Proteins` or `Genes`), namespaces and number of parents for cross annotation of GO.

    ```
        scheme@(guile-user)> (biogrid-interaction-annotation (list "IGF1") "dir-name" #:interaction "Proteins" #:namespace "" #:parents 0)

    ```

    With the default parameters set, One can also do biogrid annotations as:

    ```
        scheme@(guile-user)> (biogrid-interaction-annotation (list "IGF1") "dir-name")

    ```

    **RNA annotation**

    Annotates a gene/genes for its transcribes of coding or non-coding RNA's and protein translates. 

    Required parameters are list of genes, directory name to write the results, options to include coding RNA's, non-coding RNA's and proteins.

    ```
        scheme@(guile-user)> (include-rna (list "IGF1") "dir-name" #:coding "True" #:noncoding "True" #:protein 0)

    ```

    With the default parameters set, One can also do RNA annotations as:

    ```
        scheme@(guile-user)> (include-rna (list "IGF1") "dir-name")

    ```