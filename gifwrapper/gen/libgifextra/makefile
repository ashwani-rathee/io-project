CC=gcc
CFLAGS=-I./include -fPIC 
DEPS = libgifextra.h 

all: libgifextra
UNAME_S := $(shell uname -s)

%.o: %.c $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS) -lgif

libgifextra.a: libgifextra.o
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

libgifextra: libgifextra.a
	$(CC) -shared $(SHARED_BEGIN) $^ $(SHARED_END) -o $@.$(LIBEXT) -lgif
