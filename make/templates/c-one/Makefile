.POSIX:

CCC ?= gcc -pedantic-errors -std=c89 -Wall
IN_EXT ?= .c
OUT_EXT ?= .out
RUN ?= main
TMP_EXT ?= .o

INS := $(wildcard *$(IN_EXT))
OUTS_NOEXT := $(basename $(INS))
OUTS := $(addsuffix $(TMP_EXT), $(OUTS_NOEXT))
RUN_BASENAME := $(RUN)$(OUT_EXT)

.PHONY: clean run

$(RUN_BASENAME): $(OUTS)
	$(CCC) $+ -o '$@'

%$(TMP_EXT): %$(IN_EXT)
	$(CCC) -c '$<' -o '$@'

clean:
	rm -f *'$(TMP_EXT)' '$(RUN_BASENAME)'

run: $(RUN_BASENAME)
	./'$(RUN_BASENAME)'
