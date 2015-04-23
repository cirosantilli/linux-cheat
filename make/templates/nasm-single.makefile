.PHONY: clean run

main.out: main.asm
	nasm -w+all -f elf64 -o main.o main.asm
	ld -o main.out -s main.o

clean:
	rm -f *.o *.out

run: main.out
	./main.out
