# make all files with one of the given extensions by IN_EXTS
# separatelly, possibly using a different rule per extension

IN_DIR 	?= ./
IN_EXTS 	?= .c .asm
OUT_DIR 	:= _out/
OUT_EXT 	:= .elf
RUN		?= c

INS			:= $(foreach IN_EXT, $(IN_EXTS), $(wildcard $(IN_DIR)*$(IN_EXT)) )
INS_NODIR 	:= $(notdir $(INS))
OUTS_NODIR	:= $(basename $(INS_NODIR))
OUTS_NODIR	:= $(addsuffix $(OUT_EXT), $(OUTS_NODIR))
OUTS		:= $(addprefix $(OUT_DIR), $(OUTS_NODIR))

.PHONY: all clean mkdir run

all: mkdir $(OUTS)

# rule to make c files
$(OUT_DIR)%$(OUT_EXT): %.c
	gcc -Wall -std=c99 -pedantic-errors -o "$@" "$<"

# rule to make asm files
$(OUT_DIR)%$(OUT_EXT): %.asm
	$(eval OBJ := "$(OUT_DIR)$*".o)
	nasm -w+all -f elf -o "$(OBJ)" "$<"
	ld -s -o "$@" "$(OBJ)"

clean:
	rm -rf $(OUT_DIR)

mkdir:
	mkdir -p $(OUT_DIR)

run: all
	cd $(OUT_DIR) && ./$(RUN)$(OUT_EXT)
