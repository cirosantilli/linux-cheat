.PHONY: all clean html pdf

all: html pdf

clean:
	rm -f *.html *.pdf

html: template.html.erb
	kramdown --template template.html.erb index.md > index.html

pdf: template.tex.erb
	kramdown -o latex --template template.tex.erb index.md > index.tex
	latexmk -pdf index.tex
	latexmk -c
