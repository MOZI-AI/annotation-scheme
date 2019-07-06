include guile.am

SOURCES = \
    annotation/util.scm  \
    annotation/functions.scm \
    annotation/gene-go.scm \
    annotation/gene-pathway.scm \
    annotation/biogrid.scm \
    annotation/parser.scm \
    annotation/main.scm \
    annotation.scm
clean-go:
	-$(RM) $(GOBJECTS)
.PHONY: clean-go

CLEANFILES = \
  $(GOBJECTS)

EXTRA_DIST = \
    boostrap \
    env.in