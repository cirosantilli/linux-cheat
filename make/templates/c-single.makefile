.PHONY: clean run

main.out: main.c
	gcc -std=c89 -o '$@' '$<'

clean:
	rm -f main.out

run: main.out
	./'$<'
