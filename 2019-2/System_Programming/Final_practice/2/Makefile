CC=gcc
CFLAGS=-Wall

all: sum_process sum_thread

sum_process: sum_process.c
	$(CC) $(CFLAGS) -o $@ $^

sum_thread: sum_thread.c
	$(CC) $(CFLAGS) -o $@ $^ -pthread

clean:
	rm -f sum_process sum_thread
