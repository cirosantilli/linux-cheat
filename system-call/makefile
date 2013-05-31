override IN_DIR 	?= ./
override IN_EXTS 	?= .c .asm
override OUT_DIR 	:= _out/
override OUT_EXT 	:= .elf
override RUN		?= c

INS			:= $(foreach IN_EXT, $(IN_EXTS), $(wildcard $(IN_DIR)*$(IN_EXT)) )
INS_NODIR 	:= $(notdir $(INS))
OUTS_NODIR	:= $(basename $(INS_NODIR))
OUTS_NODIR	:= $(addsuffix $(OUT_EXT), $(OUTS_NODIR))
OUTS		:= $(addprefix $(OUT_DIR), $(OUTS_NODIR))

.PHONY: all clean mkdir run

all: mkdir $(OUTS)

#cannot use `-std=99`, even if `_GNU_SOURCE` is defined in the file
#the reasion for this is related to `-std=99` automatically defining `__STRICT_ANSI__` cp variable
#which overrides `_GNU_SOURCE` and causes other flags not to be defined.
#see: `features.h`
$(OUT_DIR)%$(OUT_EXT): %.c
	gcc -Wall -pedantic-errors -o "$@" "$<"

$(OUT_DIR)%$(OUT_EXT): %.asm
	$(eval OBJ := "$(OUT_DIR)$*".o)
	nasm -w+all -f elf -o "$(OBJ)" "$<"
	ld -s -o "$@" "$(OBJ)"

clean:
	rm -rf $(OUT_DIR)

mkdir:
	#@echo 'for f in $(INS_NODIR); do echo -n "$${f%.*} "; done'
	echo $(OUTS)
	mkdir -p $(OUT_DIR)

run: all
	cd $(OUT_DIR) && ./$(RUN)$(OUT_EXT)
