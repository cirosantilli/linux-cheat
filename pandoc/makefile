#compiles all .md files in current directory into pdf and html.

#can mkdir and output that dir.

override CC := pandoc
override FLAGS ?= -s --toc --mathml -N  	#flags that apply to all output formats: (html, pdf, etc)
override ID ?=
override IN_EXT ?= .md
override OUT_DIR ?= _out/
override RUN_NOEXT ?= a 									#basename without extension of file to view (with firefox, okular, etc.)

SRCS := $(wildcard *$(IN_EXT))
OUTEXT := .html
OUT_HTML := $(patsubst %$(IN_EXT),$(OUT_DIR)%$(OUTEXT),$(SRCS))

OUTEXT := .pdf
OUT_PDF = $(patsubst %$(IN_EXT),$(OUT_DIR)%$(OUTEXT),$(SRCS))

ERASE_MSG := 'DONT PUT ANYTHING IMPORTANT IN THOSE DIRECTORIES SINCE `make clean` ERASES THEM!!!'

.PHONY: all mkdir html pdf firefox okular clean

all: html pdf
	@echo 'OUTPUT    FILES WERE BE PUT INTO: $(OUT_DIR)'
	@echo $(ERASE_MSG)

mkdir:
	mkdir -p $(OUT_DIR)
	@echo "MADE DIRS: $(OUT_DIR)"
	@echo $(ERASE_MSG)

html: mkdir $(OUT_HTML)

pdf: mkdir $(OUT_PDF)

firefox:
	firefox "$(OUT_DIR)$(RUN_NOEXT).html$(ID)"

okular:
	nohup okular --unique "$(OUT_DIR)$(RUN_NOEXT).pdf" >/dev/null &

$(OUT_DIR)%.html: %$(IN_EXT)
	$(CC) $(FLAGS) -o $@ $<

$(OUT_DIR)%.pdf: %$(IN_EXT)
	$(CC) $(FLAGS) -o $@ $<

clean:
	rm -r "$(OUT_DIR)"
	@echo "REMOVED DIRS: $(OUT_DIR)"
	@echo $(ERASE_MSG)
