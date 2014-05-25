bin_PROGRAMS = executor
executor_SOURCES = logger.cc compiler.cc monitor.cc main.cc
AM_CXXFLAGS = $(CXXFLAGS) -std=c++0x -I$(top_srcdir)/include -L$(top_srcdir)/lib
executor_LDADD = -lyaml-cpp
