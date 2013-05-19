IN_EXT := .dot
OUT_EXT := .dot

INS 		:= $(wildcard *$(IN_EXT))
OUTS_SVG	:= $(patsubst %$(IN_EXT),%.svg,$(INS))
OUTS_PNG	:= $(patsubst %$(IN_EXT),%.png,$(INS))

.PHONY: all clean

all: $(OUTS_SVG) $(OUTS_PNG)

%.svg: %$(IN_EXT)
	dot -Tsvg "$<" > "$@" 

%.png: %$(IN_EXT)
	dot -Tpng "$<" > "$@" 

clean:
	rm *.svg *.png
