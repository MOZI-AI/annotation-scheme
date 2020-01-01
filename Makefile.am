include guile.am
AUTOMAKE_OPTIONS = foreign
SOURCES = \
    annotation/util.scm  \
    annotation/functions.scm \
    annotation/gene-go.scm \
    annotation/gene-pathway.scm \
    annotation/biogrid.scm \
    annotation/main.scm \
    annotation/parser.scm \
    annotation/rna.scm \
    annotation.scm 

TESTS = \
    tests/parser-tests.scm \
    tests/util-tests.scm \
    tests/pathway-tests.scm \
    tests/main-tests.scm

TEST_EXTENSIONS = .scm

clean-go:
	-$(RM) $(GOBJECTS)
.PHONY: clean-go

AM_COLOR_TESTS=always

CLEANFILES += \
	$(GOBJECTS)	\
	$(TESTS:tests/%.scm=%.log)	\
	*.log

EXTRA_DIST = \
	$(SOURCES) \
	$(TESTS)
