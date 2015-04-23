NASM ?= nasm -w+all -f $(shell if [ "`uname -m`" = 'x86_64' ]; then printf 'elf64'; else printf 'elf32'; fi )
TMP_EXT ?= .o
OUT_EXT ?= .out
RUN ?= main

OUT := $(RUN)$(OUT_EXT)

.PHONY: clean run

$(OUT): $(RUN).asm
	$(NASM) -o '$(RUN)$(TMP_EXT)' '$<'
	ld -o '$@' -s '$(RUN)$(TMP_EXT)'

clean:
	rm -f *$(TMP_EXT) *$(OUT_EXT)

run: $(OUT)
	./'$<'
