OUT_DIR := _doc/

.PHONY: all

all:
	doxygen

clean:
	rm -rf "$(OUT_DIR)"

view: all
	firefox "$(OUT_DIR)"html/index.html
