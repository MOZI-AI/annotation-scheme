include guile.am
AUTOMAKE_OPTIONS = foreign
ACLOCAL_AMFLAGS = -I m4


SOURCES = \
    annotation/util.scm  \
    annotation/functions.scm \
    annotation/go-helpers.scm \
    annotation/string-helpers.scm \
    annotation/gene-go.scm \
    annotation/gene-pathway.scm \
    annotation/biogrid.scm \
    annotation/string.scm \
    annotation/main.scm \
    annotation/graph.scm \
    annotation/gene-record.scm \
    annotation/parser.scm \
    annotation/rna.scm \
    annotation/writer.scm \
    annotation.scm 

TESTS = \
    tests/parser-tests.scm \
    tests/util-tests.scm \
    tests/pathway-tests.scm \
    tests/main-tests.scm \
    tests/string-tests.scm \
    tests/go-tests.scm
TEST_EXTENSIONS = .scm

SCM_LOG_DRIVER = \
	$(top_builddir)/env	\
	$(GUILE) --no-auto-compile -e main	\
	$(top_srcdir)/build-aux/test-driver.scm

clean-go:
	-$(RM) $(GOBJECTS)
.PHONY: clean-go

# Tell 'build-aux/test-driver.scm' to display only source file names,
# not indivdual test names.
AM_SCM_LOG_DRIVER_FLAGS = --brief=yes

AM_SCM_LOG_FLAGS = --no-auto-compile -L $(top_srcdir)

AM_COLOR_TESTS=always

CLEANFILES += \
	$(GOBJECTS)	\
	$(TESTS:tests/%.scm=%.log)	\
	*.log


EXTRA_DIST = \
	$(SOURCES) \
	$(TESTS)	\
	build-aux/test-driver.scm
