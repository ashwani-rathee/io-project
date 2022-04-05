CC=gcc
CFLAGS=-I./include -fPIC 
DEPS = libopenjpegextra.h 

all: libopenjpegextra
UNAME_S := $(shell uname -s)

%.o: %.c $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS) -lopenjp2

libopenjpegextra.a: libopenjpegextra.o
	ar rcs $@ $^ 

UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Linux)
	LIBEXT=so
	SHARED_BEGIN=-Wl,-whole-archive
	SHARED_END=-Wl,-no-whole-archive
endif
ifeq ($(UNAME_S),Darwin)
	LIBEXT=dylib
	SHARED_BEGIN=-all_load
	SHARED_END=
endif

libopenjpegextra: libopenjpegextra.a
	$(CC) -shared $(SHARED_BEGIN) $^ $(SHARED_END) -o $@.$(LIBEXT) -lopenjp2
