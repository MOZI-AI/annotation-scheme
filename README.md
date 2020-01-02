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
    scheme@(guile-user)> (use-modules
            (annotation)
            (annotation gene-go)
            (annotation functions))

    ```
    3b. Load the sample dataset

    ```
    scheme@(guile-user)> (primitive-load "path/to/annotation-scheme/tests/sample_dataset.scm")

    ```

    3c. Run Gene-Go annotation for gene **IGF1**

    ```
        scheme@(guile-user)> (gene-go-annotation (list "IGF1") "my-results-directory")
    ```

