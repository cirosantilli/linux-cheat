.PHONY: all clean html pdf

all: html pdf

html: after.md main.css
	pandoc -A after.md -c main.css -s --toc index.md -o index.html

pdf: after.md
	pandoc -A after.md -s --toc -V geometry:margin=1in index.md -o index.pdf

clean:
	rm -f *.html *.pdf
