**Annotation Scheme**

This project contains the scheme code that is used by MOZI annotation service. It annotates Human Gene Symbols using three databases (GO, Reactome & Biogrid). It uses the [Atomspace](https://github.com/opencog/atomspace) to store the knoweldge in a hypergraph and uses the [Pattern Matcher](https://wiki.opencog.org/w/The_Pattern_Matcher) to retrieve relevant information for requested genes.

You can use the `Dockerfile` to build an image that has all the necessary dependencies to run the project or you can build everything manually.

To build the project manually, make sure you have [Atomspace](https://github.com/opencog/atomspace)  [Opencog](https://github.com/opencog/opencog),  [NYACC](https://www.nongnu.org/nyacc/nyacc-ug.html) and [guile-json](https://github.com/Habush/annotation-scheme) installed. Once you have installed these dependencies, you can build the project using the following instructions:

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
            (json))

    ```
    3b. Load the sample dataset

    ```
    scheme@(guile-user)> (primitive-load "path/to/annotation-scheme/tests/sample_dataset.scm")

    ```

    3c. Run Gene-Go annotation for genen **MAP2K4**

    ```
        scheme@(guile-user)> (gene-go '("MAP2K4") "biological_process molecular_function cellular_component" 1)
    ```

