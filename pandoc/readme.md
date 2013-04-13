#pandoc

input formats: extended markdown, subset of latex
output formats: html, pdf

   sudo aptitude install -y pandoc

description of markdown flavour:

   man pandoc_markdown

#output type is recognized by extension

generate html from markdown:

    pandoc a.md -o a.html

generate pdf from markdown:

    pandoc a.md -o a.pdf

#options

    pandoc -s --toc -c pandoc.css -A footer.html README -o example3.html

- -s : output is standalone. in output html for example,
- includes ``<html>`` and ``<body>`` tags
- --toc : creates a toc of links to headers,
- and headers are links to toc and have ids
- -A : include after
- -c : link to css
- -w rst : set input format to rst
