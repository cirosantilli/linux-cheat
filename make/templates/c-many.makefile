# Compile each C file in the current directory into an executable.
#
# Put outputs in the current directory.
#
# Since we have one executable per C file, no need for .o file management.
#
# We must add an extension to the generated files to be able to
# easily remote and gitignore them later.
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

%$(OUT_EXT): %$(IN_EXT)
	gcc -pedantic-errors -std=c99 -Wall '$<' -o '$@'

clean:
	rm -f *$(OUT_EXT) $(RUN)

run: all
	./'$(RUN)'
