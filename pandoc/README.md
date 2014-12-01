#Pandoc

Converts between various input and output formats.

Written in Haskell... this alone makes me prefer a C based one like [Multimarkdown](https://github.com/fletcher/MultiMarkdown-4).

Very good command line interface and feature set.

Many markdown extensions, some useless because there are already standard / "much more common in other engine" ways of doing them like tilde `~~~` code blocks or parenthesis ordered lists `(1)`.

Input formats:

- extended markdown
- subset of LaTeX

Output formats:

- HTML
- PDF

Ubuntu install:

    sudo aptitude install -y pandoc

Description of markdown flavor:

    man pandoc_markdown

Output type is recognized by the output extension of the `-o` option.

HTML from markdown:

    pandoc a.md -o a.html

PDF from markdown:

    pandoc a.md -o a.pdf

Good standard invocation:

    pandoc -s --toc -c main.css -V geometry:margin=1in a.md -o a.html

- `-s`:                      output is standalone. For HTML for example, includes `<html>` and `<body>` tags.
- `--toc`:                   create a TOC of links to headers, and headers are links to toc and have ids.
- `-V geometry:margin=1inu`: sets margins. Only meaningful for PDFs.

Other useful options:

- `-A footer.html `: include after verbatim, i.e. before the `</body>` tag in HTML, or the `\end{document}` in LaTeX, and don't interpret Markdown.
- `-c main.css`:     relative link to external CSS.
- `-w rst`:          set input format to rst.
