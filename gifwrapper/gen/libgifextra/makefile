CC=gcc
CFLAGS=-I./include -fPIC 
DEPS = libgifextra.h 
PREFIX = /usr/local

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

# PREFIX is environment variable, but if it is not set, then set default value
ifeq ($(PREFIX),)
	PREFIX := /usr/local
endif

install: libgifextra.a
	install -d $(DESTDIR)$(PREFIX)/lib/
	install -m 644 libgifextra.a $(DESTDIR)$(PREFIX)/lib/
	install -d $(DESTDIR)$(PREFIX)/include/
	install -m 644 libgifextra.h $(DESTDIR)$(PREFIX)/include/
