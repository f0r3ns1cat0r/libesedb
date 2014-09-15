if HAVE_PYTHON
AM_CFLAGS = \
	-I$(top_srcdir)/include \
	-I$(top_srcdir)/common \
	@LIBCSTRING_CPPFLAGS@ \
	@LIBCERROR_CPPFLAGS@ \
	@LIBCDATA_CPPFLAGS@ \
	@LIBCLOCALE_CPPFLAGS@ \
	@LIBUNA_CPPFLAGS@ \
	@LIBCFILE_CPPFLAGS@ \
	@LIBCPATH_CPPFLAGS@ \
	@LIBBFIO_CPPFLAGS@

pyexec_LTLIBRARIES = pyesedb.la

pyesedb_la_SOURCES = \
	pyesedb.c pyesedb.h \
	pyesedb_column.c pyesedb_column.h \
	pyesedb_column_types.c pyesedb_column_types.h \
	pyesedb_columns.c pyesedb_columns.h \
	pyesedb_datetime.c pyesedb_datetime.h \
	pyesedb_error.c pyesedb_error.h \
	pyesedb_file.c pyesedb_file.h \
	pyesedb_file_object_io_handle.c pyesedb_file_object_io_handle.h \
	pyesedb_index.c pyesedb_index.h \
	pyesedb_indexes.c pyesedb_indexes.h \
	pyesedb_integer.c pyesedb_integer.h \
	pyesedb_libbfio.h \
	pyesedb_libcerror.h \
	pyesedb_libclocale.h \
	pyesedb_libcstring.h \
	pyesedb_libesedb.h \
	pyesedb_multi_value.c pyesedb_multi_value.h \
	pyesedb_python.h \
	pyesedb_record.c pyesedb_record.h \
	pyesedb_records.c pyesedb_records.h \
	pyesedb_table.c pyesedb_table.h \
	pyesedb_tables.c pyesedb_tables.h \
	pyesedb_unused.h \
	pyesedb_value_flags.c pyesedb_value_flags.h

pyesedb_la_LIBADD = \
	@LIBCSTRING_LIBADD@ \
	@LIBCERROR_LIBADD@ \
	../libesedb/libesedb.la \
	@LIBCDATA_LIBADD@ \
	@LIBCLOCALE_LIBADD@ \
	@LIBCFILE_LIBADD@ \
	@LIBCPATH_LIBADD@ \
	@LIBBFIO_LIBADD@

pyesedb_la_CPPFLAGS = $(PYTHON_CPPFLAGS)
pyesedb_la_LDFLAGS  = -module -avoid-version $(PYTHON_LDFLAGS)

endif

EXTRA_DIST = \
	setup.py \
	setup.py.in

MAINTAINERCLEANFILES = \
	Makefile.in

distclean: clean
	/bin/rm -f setup.py
	/bin/rm -f Makefile
