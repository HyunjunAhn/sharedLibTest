CC=gcc
CFLAGS=-Wall -g
BINS=test my.so
all: $(BINS)

#my.o: my.c my.h
#	$(CC) $(CFLAGS) -c my.c -o my.o -lpthread
#
#sum.o: sum.c sum.h
#	$(CC) $(CFLAGS) -c sum.c -o sum.o

my.so: my.c sum.c
	$(CC) $(CFLAGS) -fPIC -shared -o $@ my.c sum.c -lpthread
	
test: test.c my.so
	$(CC) $(CFLAGS) -o $@ $^ -lpthread

clean:
	rm *.o *.so test