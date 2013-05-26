override IN_DIR 	?= ./
override IN_EXTS 	?= .c .asm
override OUT_DIR 	:= _out/
override OUT_EXT 	:= .elf
override RUN		?= c

INS			:= $(foreach IN_EXT, $(IN_EXTS), $(wildcard $(IN_DIR)*$(IN_EXT)) )
INS_NODIR 	:= $(notdir $(INS))
OUTS_NODIR	:= $(patsubst %$(IN_EXT),%$(OUT_EXT),$(INS_NODIR))
OUTS		:= $(addprefix $(OUT_DIR),$(OUTS_NODIR))

.PHONY: all clean mkdir run

all: mkdir $(OUTS)

$(OUT_DIR)$(NAME)$(OUT_EXT): $(NAME).c
	gcc -Wall -std=c99 -pedantic-errors -D_XOPEN_SOURCE=700 -o "$@" "$<"

$(OUT_DIR)$(NAME)$(OUT_EXT): $(NAME).asm
	$(eval OBJ := "$(OUT_DIR)$*".o)
	nasm -w+all -f elf -o "$(OBJ)" "$<"
	ld -s -o "$@" "$(OBJ)"

clean:
	rm -rf $(OUT_DIR)

mkdir:
	@echo $(OUTS)
	mkdir -p $(OUT_DIR)

run: all
	cd $(OUT_DIR) && ./$(RUN)$(OUT_EXT)
