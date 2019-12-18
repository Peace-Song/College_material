CC=gcc
CFLAGS=-Wall

all: fileinfo

%: %.c
	$(CC) $(CFLAGS) -o $@ $^

clean:
	rm -f fileinfo
