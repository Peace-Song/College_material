CC=gcc
CFLAGS=-Wall

.PHONY: doc

%.o: %.c %.h
	$(CC) $(CFLAGS) -c $<

compile: net.o

doc:
	doxygen doc/Doxyfile

clean:
	rm -f net.o

mrproper: clean
	rm -rf doc/html
