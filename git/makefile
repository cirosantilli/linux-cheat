#compiles all .md files in current directory into pdf and html.

#can mkdir and output that dir.

override CCC ?= pandoc
override FLAGS ?= -s --toc --mathml -N			#flags that apply to all kinds of output (html, pdf, etc)
override ID ?=
override IN_EXT ?= .md
override OUT_DIR ?= _out/
override RUN_NOEXT ?= a 									#basename without extension of file to view (with firefox, okular, etc.)

SRCS := $(wildcard *$(IN_EXT))
OUTEXT := .html
OUT_HTML := $(patsubst %$(IN_EXT),$(OUT_DIR)%$(OUTEXT),$(SRCS))

OUTEXT := .pdf
OUT_PDF = $(patsubst %$(IN_EXT),$(OUT_DIR)%$(OUTEXT),$(SRCS))

.PHONY: all mkdir html pdf firefox okular clean

all: html pdf

mkdir:
	mkdir -p $(OUT_DIR)

html: mkdir $(OUT_HTML)

pdf: mkdir $(OUT_PDF)

firefox:
	firefox "$(OUT_DIR)$(RUN_NOEXT).html$(ID)"

okular:
	nohup okular --unique "$(OUT_DIR)$(RUN_NOEXT).pdf" >/dev/null &

$(OUT_DIR)%.html: %$(IN_EXT)
	$(CCC) $(FLAGS) -o $@ $<

$(OUT_DIR)%.pdf: %$(IN_EXT)
	$(CCC) $(FLAGS) -o $@ $<

clean:
	rm -r "$(OUT_DIR)"
