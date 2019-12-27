AC_INIT([gene-annotation], [0.1])
AC_CONFIG_SRCDIR([annotation.scm])
AC_CONFIG_AUX_DIR([build-aux])
AC_CONFIG_MACRO_DIR([m4])
AM_INIT_AUTOMAKE([-Wall])

# GUILE_PKG is not compatible with GUILE_PROGS and must not be
# used together (due to GUILE_EFFECTIVE_VERSION).
# To find the C header files and libraries, use pkg-config ...
# PKG_CHECK_MODULES is needed only for compiling C code...
# But this project has not C/C++ code in it, so ...
#
# PKG_CHECK_MODULES([GUILE], [guile-3.0])
# if test "x$GUILE_CFLAGS" = "x"; then
# 	PKG_CHECK_MODULES([GUILE], [guile-2.2])
# fi

GUILE_PROGS
if test "x$GUILD" = "x"; then
   AC_MSG_ERROR(['guild' binary not found; please check your guile installation.])
fi

AC_CONFIG_FILES([Makefile])
AC_CONFIG_FILES([env], [chmod +x env])

AC_OUTPUT
