.POSIX:

IN_EXT ?= .c
OUT_EXT ?= .out
RUN ?= a

INS := $(wildcard *$(IN_EXT))
OUTS_NOEXT := $(basename $(INS))
OUTS := $(addsuffix $(OUT_EXT), $(OUTS_NOEXT))

.PHONY: all clean run

all: $(OUTS)

%$(OUT_EXT): %$(IN_EXT)
	gcc -o '$@' -pedantic-errors -std=c89 -Wall '$<'

clean:
	rm -f *'$(OUT_EXT)'

run: all
	./'$(RUN)$(OUT_EXT)'

test: all
	./test '$(OUT_EXT)'
