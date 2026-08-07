# Compiler
CC = gcc

# Compiler and Preprocessor flags
CFLAGS = -Wall -Wextra -std=c11 -O2
CPPFLAGS = -I$(HFILE)

# Addresses
CFILE = src
HFILE = include
TFILE = target_files

all: stego

# Linker
stego: Main.o encode.o decode.o
	$(CC) Main.o encode.o decode.o -o stego

# Assembler
Main.o: Main.s
	$(CC) $(CFLAGS) -c Main.s -o Main.o

encode.o: encode.s
	$(CC) $(CFLAGS) -c encode.s -o encode.o

decode.o: decode.s
	$(CC) $(CFLAGS) -c decode.s -o decode.o

# Compiler
Main.s: Main.i
	$(CC) $(CFLAGS) -S Main.i -o Main.s

encode.s: encode.i
	$(CC) $(CFLAGS) -S encode.i -o encode.s

decode.s: decode.i
	$(CC) $(CFLAGS) -S decode.i -o decode.s

# Preprocessor
Main.i: $(CFILE)/Main.c $(HFILE)/encode.h $(HFILE)/decode.h $(HFILE)/types.h
	$(CC) $(CFLAGS) $(CPPFLAGS) -E $(CFILE)/Main.c -o Main.i

encode.i: $(CFILE)/encode.c $(HFILE)/encode.h $(HFILE)/types.h
	$(CC) $(CFLAGS) $(CPPFLAGS) -E $(CFILE)/encode.c -o encode.i

decode.i: $(CFILE)/decode.c $(HFILE)/decode.h $(HFILE)/types.h
	$(CC) $(CFLAGS) $(CPPFLAGS) -E $(CFILE)/decode.c -o decode.i

.PHONY: clean

clean:
	rm -f *.i *.s *.o stego
	rm -f $(TFILE)/veiled_words.bmp $(TFILE)/decoded_msg.* $(TFILE)/stego_img.bmp $(TFILE)/unveiled_words.*
