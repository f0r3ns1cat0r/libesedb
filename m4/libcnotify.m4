dnl Checks for libcnotify required headers and functions
dnl
dnl Version: 20240513

dnl Function to detect if libcnotify is available
dnl ac_libcnotify_dummy is used to prevent AC_CHECK_LIB adding unnecessary -l<library> arguments
AC_DEFUN([AX_LIBCNOTIFY_CHECK_LIB],
  [AS_IF(
    [test "x$ac_cv_enable_shared_libs" = xno || test "x$ac_cv_with_libcnotify" = xno],
    [ac_cv_libcnotify=no],
    [ac_cv_libcnotify=check
    dnl Check if the directory provided as parameter exists
    dnl For both --with-libcnotify which returns "yes" and --with-libcnotify= which returns ""
    dnl treat them as auto-detection.
    AS_IF(
      [test "x$ac_cv_with_libcnotify" != x && test "x$ac_cv_with_libcnotify" != xauto-detect && test "x$ac_cv_with_libcnotify" != xyes],
      [AX_CHECK_LIB_DIRECTORY_EXISTS([libcnotify])],
      [dnl Check for a pkg-config file
      AS_IF(
        [test "x$cross_compiling" != "xyes" && test "x$PKGCONFIG" != "x"],
        [PKG_CHECK_MODULES(
          [libcnotify],
          [libcnotify >= 20120425],
          [ac_cv_libcnotify=yes],
          [ac_cv_libcnotify=check])
        ])
      AS_IF(
        [test "x$ac_cv_libcnotify" = xyes],
        [ac_cv_libcnotify_CPPFLAGS="$pkg_cv_libcnotify_CFLAGS"
        ac_cv_libcnotify_LIBADD="$pkg_cv_libcnotify_LIBS"])
      ])

    AS_IF(
      [test "x$ac_cv_libcnotify" = xcheck],
      [dnl Check for headers
      AC_CHECK_HEADERS([libcnotify.h])

      AS_IF(
        [test "x$ac_cv_header_libcnotify_h" = xno],
        [ac_cv_libcnotify=no],
        [ac_cv_libcnotify=yes

        AX_CHECK_LIB_FUNCTIONS(
          [libcnotify],
          [cnotify],
          [[libcnotify_get_version],
           [libcnotify_printf],
           [libcnotify_print_data],
           [libcnotify_print_error_backtrace],
           [libcnotify_stream_set],
           [libcnotify_stream_open],
           [libcnotify_stream_close],
           [libcnotify_verbose_set]])

        ac_cv_libcnotify_LIBADD="-lcnotify"])
      ])

    AX_CHECK_LIB_DIRECTORY_MSG_ON_FAILURE([libcnotify])
    ])

  AS_IF(
    [test "x$ac_cv_libcnotify" = xyes],
    [AC_DEFINE(
      [HAVE_LIBCNOTIFY],
      [1],
      [Define to 1 if you have the `cnotify' library (-lcnotify).])
    ])

  AS_IF(
    [test "x$ac_cv_libcnotify" = xyes],
    [AC_SUBST(
      [HAVE_LIBCNOTIFY],
      [1]) ],
    [AC_SUBST(
      [HAVE_LIBCNOTIFY],
      [0])
    ])
  ])

dnl Function to detect if libcnotify dependencies are available
AC_DEFUN([AX_LIBCNOTIFY_CHECK_LOCAL],
  [dnl Headers included in libcnotify/libcnotify_print.c
  AC_CHECK_HEADERS([stdarg.h varargs.h])

  AS_IF(
    [test "x$ac_cv_header_stdarg_h" != xyes && test "x$ac_cv_header_varargs_h" != xyes],
    [AC_MSG_FAILURE(
      [Missing headers: stdarg.h and varargs.h],
      [1])
    ])

  dnl Headers included in libcnotify/libcnotify_stream.c
  AC_CHECK_HEADERS([errno.h])

  ac_cv_libcnotify_CPPFLAGS="-I../libcnotify -I\$(top_srcdir)/libcnotify";
  ac_cv_libcnotify_LIBADD="../libcnotify/libcnotify.la";

  ac_cv_libcnotify=local
  ])

dnl Function to detect how to enable libcnotify
AC_DEFUN([AX_LIBCNOTIFY_CHECK_ENABLE],
  [AX_COMMON_ARG_WITH(
    [libcnotify],
    [libcnotify],
    [search for libcnotify in includedir and libdir or in the specified DIR, or no if to use local version],
    [auto-detect],
    [DIR])

  dnl Check for a shared library version
  AX_LIBCNOTIFY_CHECK_LIB

  dnl Check if the dependencies for the local library version
  AS_IF(
    [test "x$ac_cv_libcnotify" != xyes],
    [AX_LIBCNOTIFY_CHECK_LOCAL

    AC_DEFINE(
      [HAVE_LOCAL_LIBCNOTIFY],
      [1],
      [Define to 1 if the local version of libcnotify is used.])
    AC_SUBST(
      [HAVE_LOCAL_LIBCNOTIFY],
      [1])
    ])

  AM_CONDITIONAL(
    [HAVE_LOCAL_LIBCNOTIFY],
    [test "x$ac_cv_libcnotify" = xlocal])
  AS_IF(
    [test "x$ac_cv_libcnotify_CPPFLAGS" != "x"],
    [AC_SUBST(
      [LIBCNOTIFY_CPPFLAGS],
      [$ac_cv_libcnotify_CPPFLAGS])
    ])
  AS_IF(
    [test "x$ac_cv_libcnotify_LIBADD" != "x"],
    [AC_SUBST(
      [LIBCNOTIFY_LIBADD],
      [$ac_cv_libcnotify_LIBADD])
    ])

  AS_IF(
    [test "x$ac_cv_libcnotify" = xyes],
    [AC_SUBST(
      [ax_libcnotify_pc_libs_private],
      [-lcnotify])
    ])

  AS_IF(
    [test "x$ac_cv_libcnotify" = xyes],
    [AC_SUBST(
      [ax_libcnotify_spec_requires],
      [libcnotify])
    AC_SUBST(
      [ax_libcnotify_spec_build_requires],
      [libcnotify-devel])
    ])
  ])

