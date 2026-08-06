# Compiler
CC = gcc
# Compiler flags
CFLAGS = -Wall -Wextra -std=c11 -Iinclude

all: stego

stego: Main.o encode.o decode.o
	$(CC) Main.o encode.o decode.o -o stego

Main.o: Main.c include/encode.h include/decode.h include/types.h
	$(CC) $(CFLAGS) -c Main.c

encode.o: encode.c include/encode.h include/types.h
	$(CC) $(CFLAGS) -c encode.c

decode.o: decode.c include/decode.h include/types.h
	$(CC) $(CFLAGS) -c decode.c

clean:
	rm -f *.o stego
