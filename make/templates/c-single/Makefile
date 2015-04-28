.POSIX:
.PHONY: clean run

main.out: main.c
	gcc -pedantic-errors -std=c89 -Wall -o '$@' '$<'

clean:
	rm -f main.out

run: main.out
	./'$<'
