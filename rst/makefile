#compiles all .md files in current directory into pdf and html.

#can mkdir and output that dir.

CC_LATEX  	?= rst2latex.py
CC_HTML 		?= rst2html.py --math-output=MathML
ID 				?=
IN_EXT 		?= .rst
OUT_DIR 		?= _out/
RUN_NOEXT 	?= a 									#basename without extension of file to view (with firefox, okular, etc.)

SRCS := $(wildcard *$(IN_EXT))
OUTEXT := .html
OUT_HTML := $(patsubst %$(IN_EXT),$(OUT_DIR)%$(OUTEXT),$(SRCS))

OUTEXT := .pdf
OUT_PDF := $(patsubst %$(IN_EXT),$(OUT_DIR)%$(OUTEXT),$(SRCS))

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
	$(CC_HTML) $< $@

$(OUT_DIR)%.pdf: %$(IN_EXT)
	$(CC_LATEX) $< $(OUT_DIR)$*.tex
	(																												\
		cd $(OUT_DIR) 																				;\
		pdflatex -interaction=nonstopmode "$*".tex						;\
		-bibtex "$*" 																					;\
		pdflatex -interaction=nonstopmode "$*".tex 						;\
		pdflatex -interaction=nonstopmode -synctex=1 "$*".tex ;\
	)

clean:
	rm -r "$(OUT_DIR)"
