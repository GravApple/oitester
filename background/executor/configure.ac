#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_PREREQ([2.69])
AC_INIT([executor], [1.0], [wayne.wangdi@pku.edu.cn])
AC_CONFIG_SRCDIR([src/main.cc])
AM_INIT_AUTOMAKE([-Wall -Werror foreign])

DX_HTML_FEATURE(ON)
DX_CHM_FEATURE(OFF)
DX_CHI_FEATURE(OFF)
DX_MAN_FEATURE(OFF)
DX_RTF_FEATURE(OFF)
DX_XML_FEATURE(OFF)
DX_PDF_FEATURE(OFF)
DX_PS_FEATURE(OFF)
DX_INIT_DOXYGEN([executor],[doxygen.cfg],[doc/doxygen-doc])

# Checks for programs.
AC_PROG_CXX
AC_PROG_CC

# Checks for libraries.

# Checks for header files.
AC_CHECK_HEADERS([unistd.h sys/resource.h sys/ptrace.h sys/wait.h sys/user.h sys/syscall.h])

# Checks for typedefs, structures, and compiler characteristics.
AC_CHECK_HEADER_STDBOOL
AC_C_INLINE
AC_TYPE_PID_T
AC_TYPE_SIZE_T

# Checks for library functions.
AC_FUNC_FORK
AC_CHECK_FUNCS([strtol])

AC_CONFIG_FILES([Makefile
                 src/Makefile
                 doc/Makefile])
AC_OUTPUT
