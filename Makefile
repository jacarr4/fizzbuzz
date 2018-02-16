all:
	nasm -f elf64 -o fizzbuzz.o fizzbuzz.asm
	ld -o fizzbuzz fizzbuzz.o
