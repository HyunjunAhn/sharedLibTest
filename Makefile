CC=gcc
CFLAGS=-Wall -g
BINS=test libmy.so
all: $(BINS)

libmy.o: my.c my.h
	$(CC) $(CFLAGS) -c my.c -o libmy.o -lpthread

libmy.so: my.c my.h
	$(CC) $(CFLAGS) -fPIC -shared -o $@ my.c -lpthread
	
test: test.c libmy.o
	$(CC) $(CFLAGS) -o $@ $^ -lpthread

clean:
	rm *.o *.so test