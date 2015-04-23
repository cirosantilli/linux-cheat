LD ?= ld
LIB_DIR ?= lib/
NASM ?= nasm -w+all -f $(shell if [ "`uname -m`" = 'x86_64' ]; then printf 'elf64'; else printf 'elf32'; fi )
OUT_EXT ?= .out
RUN ?= hello_world

IN_EXT := .asm
INS := $(wildcard *$(IN_EXT))
OUTS := $(patsubst %$(IN_EXT),%$(OUT_EXT),$(INS))
OUT_BNAME := $(RUN)$(OUT_EXT)

.PRECIOUS: %.o
.PHONY: all clean run

all: driver $(OUTS)

%$(OUT_EXT): $(OUT_DIR)%.o
	$(LD) -o '$@' '$<'

%.o: %.asm
	$(NASM) $(DEFINES) -o '$@' '$<'

clean:
	rm -f *.o *.out

run: all
	./$(OUT_BNAME)
