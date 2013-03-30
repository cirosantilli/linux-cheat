#compiles all .md files in current directory into pdf and html.

#can mkdir and output that dir.

override CCC ?= pandoc
override FLAGS ?= -s --toc #flags that apply to all kinds of output (html, pdf, etc)
override INEXT ?= .md
override OUT_DIR ?= _out/
override RUN_NOEXT ?= a #basename without extension of file to view (with firefox, okular, etc.)

SRCS := $(wildcard *$(INEXT))
OUTEXT := .html
OUT_HTML := $(patsubst %$(INEXT),$(OUT_DIR)%$(OUTEXT),$(SRCS))

OUTEXT := .pdf
OUT_PDF = $(patsubst %$(INEXT),$(OUT_DIR)%$(OUTEXT),$(SRCS))

.PHONY: all mkdir html pdf firefox okular clean

all: html pdf

mkdir:
	mkdir -p $(OUT_DIR)

html: mkdir $(OUT_HTML)

pdf: mkdir $(OUT_PDF)

firefox: html
	firefox "$(OUT_DIR)$(RUN_NOEXT).html"

okular: pdf
	nohup okular --unique "$(OUT_DIR)$(RUN_NOEXT).pdf" >/dev/null &

$(OUT_DIR)%.html: %.md
	$(CCC) $(FLAGS) -o $@ $<

$(OUT_DIR)%.pdf: %.md
	$(CCC) $(FLAGS) -o $@ $<

clean:
	rm -r "$(OUT_DIR)"
