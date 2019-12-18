INCLUDE=../utils

CC=gcc
CFLAGS=-Wall -O2 -I$(INCLUDE)

.PHONY: all doc clean

all: echoclient echoserveri echoserverp echoservert

echoserveri: echoserveri.c common.c common.h
	$(CC) $(CFLAGS) -o $@ $^ $(INCLUDE)/net.o

echoserverp: echoserverp.c common.c common.h
	$(CC) $(CFLAGS) -o $@ $^ $(INCLUDE)/net.o

echoservert: echoservert.c common.c common.h
	$(CC) $(CFLAGS) -o $@ $^ $(INCLUDE)/net.o -lpthread

echoclient: echoclient.c common.c common.h
	$(CC) $(CFLAGS) -o $@ $^ $(INCLUDE)/net.o

doc:
	doxygen doc/Doxyfile

clean:
	rm -rf echoclient echoserver{i,p,t} *.o doc/html
