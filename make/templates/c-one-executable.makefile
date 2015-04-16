# Compile all C files in the current directory into a single executable.
#
# Put outputs in the current directory.
#
# TODO deal with .h dependencies. This requires a parser. GCC can do it.

IN_EXT ?= .c
OUT_EXT ?= .o
RUN ?= main

INS := $(wildcard *$(IN_EXT))
OUTS_NOEXT := $(basename $(INS))
OUTS := $(addsuffix $(OUT_EXT), $(OUTS_NOEXT))

.PHONY: all clean run

all: $(OUTS)

$(RUN): $(OUTS)
	gcc '$<' -o '$@'

%$(OUT_EXT): %$(IN_EXT)
	gcc -pedantic-errors -std=c99 -Wall -c '$<' -o '$@'

clean:
	rm *$(OUT_EXT) $(RUN)

run: all
	./'$(RUN)'
