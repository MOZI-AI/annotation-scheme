AC_INIT([gene-annotation], [0.1])
AC_CONFIG_SRCDIR([annotation.scm])
AC_CONFIG_AUX_DIR([build-aux])
AC_CONFIG_MACRO_DIR([m4])
AM_INIT_AUTOMAKE([-Wall])

GUILE_PKG([3.2 3.0 2.9 2.2])
GUILE_PROGS
if test "x$GUILD" = "x"; then
   AC_MSG_ERROR(['guild' binary not found; please check your guile-2.x installation.])
fi

GUILE_SITE_DIR
GUILE_SITE_GO_DIR

GUILE_MODULE_AVAILABLE(HAVE_JSON, [(json)])
if test "x$HAVE_JSON" = "xno"; then
	AC_MSG_ERROR([The (json) module is needed. See https://github.com/aconchillo/guile-json for details.])
fi

GUILE_MODULE_AVAILABLE(HAVE_NYACC, [(nyacc lalr)])
if test "x$HAVE_NYACC" = "xno"; then
	AC_MSG_ERROR([The (nyacc) module is needed. Download from http://download.savannah.nongnu.org/releases/nyacc/.])
fi

GUILE_MODULE_AVAILABLE(HAVE_BIOSCI, [(opencog bioscience)])
if test "x$HAVE_BIOSCI" = "xno"; then
	AC_MSG_ERROR([The (opencog bioscience) module is needed. See https://github.com/opencog/agi-bio for details.])
fi

AC_CONFIG_FILES([Makefile])
AC_CONFIG_FILES([env], [chmod +x env])

AC_OUTPUT
