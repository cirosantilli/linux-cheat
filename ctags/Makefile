.POSIX:

IN_EXT ?= .c
OUT_EXT ?= .out
RUN ?= main

INS := $(wildcard *$(IN_EXT))
OUTS_NOEXT := $(basename $(INS))
OUTS := $(addsuffix $(OUT_EXT), $(OUTS_NOEXT))

.PHONY: all clean run

all: $(OUTS)
	-ctags -R
	#ctags --c-kinds=+l -R
	-cscope -Rb

%$(OUT_EXT): %$(IN_EXT)
	gcc -o '$@' -pedantic-errors -std=c89 -Wall '$<'

clean:
	rm -f *$(OUT_EXT) cscope.out tags

run: all
	./'$(RUN)$(OUT_EXT)'
