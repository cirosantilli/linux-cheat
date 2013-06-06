# make all files with one of the given extensions by IN_EXTS
# separatelly, possibly using a different rule per extension

override IN_DIR 	?= ./
override IN_EXTS 	?= .c
override OUT_DIR 	:= _out/
override OUT_EXT 	:= .elf
override RUN		?= main

INS			:= $(foreach IN_EXT, $(IN_EXTS), $(wildcard $(IN_DIR)*$(IN_EXT)) )
INS_NODIR 	:= $(notdir $(INS))
OUTS_NODIR	:= $(basename $(INS_NODIR))
OUTS_NODIR	:= $(addsuffix $(OUT_EXT), $(OUTS_NODIR))
OUTS		:= $(addprefix $(OUT_DIR), $(OUTS_NODIR))

.PHONY: all clean mkdir run

all: mkdir $(OUTS)

# TODO why `-std=gnu99` does not let me use gnu extensions such as nested functions?
$(OUT_DIR)%$(OUT_EXT): %.c
	#gcc -Wall -pedantic-errors -std=gnu99 -o "$@" "$<"
	gcc -Wall -o "$@" "$<"

clean:
	rm -rf $(OUT_DIR)

mkdir:
	mkdir -p $(OUT_DIR)

run: all
	cd $(OUT_DIR) && ./$(RUN)$(OUT_EXT)
