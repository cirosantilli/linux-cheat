.POSIX:
.PHONY: all clean

IN_EXT ?= .texi
OUT_EXT ?= .html

INS := $(wildcard *$(IN_EXT))
OUTS := $(INS:$(IN_EXT)=$(OUT_EXT))

all: $(OUTS)

%$(OUT_EXT): %$(IN_EXT)
	makeinfo --html --no-split -o '$@' '$<'
	makeinfo '$<'

clean:
	rm -f *$(OUT_EXT) *.info
