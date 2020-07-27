AC_INIT([gene-annotation], [0.1])
AC_CONFIG_SRCDIR([annotation.scm])
AC_CONFIG_AUX_DIR([build-aux])
AC_CONFIG_MACRO_DIR([m4])
AM_INIT_AUTOMAKE([-Wall])

GUILE_PKG([3.0 2.2])
GUILE_PROGS
GUILE_SITE_DIR
GUILE_FLAGS

GUILE_MODULE_AVAILABLE(HAVE_JSON, [(json)])
if test "x$HAVE_JSON" = "xno"; then
	AC_MSG_ERROR([The (json) module is needed. See https://github.com/aconchillo/guile-json for details.])
fi

GUILE_MODULE_AVAILABLE(HAVE_BIOSCI, [(opencog bioscience)])
if test "x$HAVE_BIOSCI" = "xno"; then
	AC_MSG_ERROR([The (opencog bioscience) module is needed. See https://github.com/opencog/agi-bio for details.])
fi

GUILE_MODULE_AVAILABLE(HAVE_FIBERS, [(fibers) (fibers channels)])
if test "x$HAVE_FIBERS" = "xno"; then
	AC_MSG_ERROR([The fibers library is needed. See https://github.com/wingo/fibers for details])
fi

GUILE_MODULE_AVAILABLE(HAVE_ATOM_SERVICE, [(opencog grpc)])
if test "x$HAVE_ATOM_SERVICE" = "xno"; then
	AC_MSG_ERROR([The atom_service_scm library is needed. See https://github.com/Habush/atomspace-rpc for details])
fi

AC_CONFIG_FILES([env], [chmod +x env])
AC_CONFIG_FILES([Makefile])

AC_OUTPUT
