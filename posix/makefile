override NAME 		:= main
override OUT_DIR 	:= _out/
override OUT_EXT 	:= .elf

override IN_EXTS 	?= .c .cpp

.PHONY: clean run

$(OUT_DIR)$(NAME)$(OUT_EXT): $(NAME).c
	mkdir -p _out/
	gcc -Wall -std=c99 -pedantic-errors -D_XOPEN_SOURCE=700 -o "$@" "$<"

run: $(OUT_DIR)$(NAME)$(OUT_EXT)
	cd $(OUT_DIR) && ./$(NAME)$(OUT_EXT) #run from out dir

clean:
	rm -rf $(OUT_DIR)
