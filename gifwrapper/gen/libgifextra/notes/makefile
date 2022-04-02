main: main.o libgifextra.o
		gcc -o main main.o libgifextra.o -lgif
main.o: main.c libgifextra.h
		gcc -c -g main.c -lgif
libgifextra.o: libgifextra.c libgifextra.h
		gcc -c -g libgifextra.c -lgif

