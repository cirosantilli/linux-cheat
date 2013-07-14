book formats, viewers and manipulation tools

#formats

formats that contain image, text, fonts such as pdf or djvu
but not not formats that map directly to bits such as png or jpeg

- ps

    a programming language! can have goto, branch, variables
    levels refer to versions: 1, 2 and 3 exist up to today
    cannot split page by page

- eps:
- djvu:
- pdf: text layers, image layers, can be viewd page by page
- mobi: mobipocket company, free format
- rtf: proprietary microsoft

#readers

##okular

open at given page of document:

    okular -p 2 a.pdf

single instance:

    okular --unique a.pdf
    okular --unique b.pdf

`a.pdf` is closed, `b.pdf` is opened on same window.

##fbreader

mobi reader

#chm

microsoft proprietary

discontinued

non plain text: compiled

based on html?

has been reverse ingeneered

##chm to html

- archmage:

    produce non searchable html:

        archmage a.chm

##chm to pdf

- chm2pdf: <http://www.ubuntugeek.com/how-to-convert-chm-files-into-pdf-files-in-ubuntu.html>

    `chm2pdf --website a.chm`: index links were broken and did not show index pages

    `chm2pdf --book a.chm`: command did not work

##chm readers

- chmsee: gtk+, few preferences, just works.
- kchmreader: kde, broken colors on ubuntu

#calibre

book library management

#manipulation

##a2ps

txt to ps

does not work for utf8. For that use [paps][]

    a2ps -o a.ps a.txt

-1: one page per sheet (default is 2)

    a2ps -B -1 -o a.ps a.txt

-B: remove default headers:

    a2ps -B -o a.ps a.txt

--borders=no: no default borders:

    a2ps -B -1 --borders=no -o a.ps a.txt

output to stdout

    a2ps -o - a.txt

##paps

Converts txt to ps.

Works for utf8.

Much better defaults than a2ps.

Outputs to stdout by default, so you want:

    paps a.txt > a.ps

Font:

    paps --font="times 12" a.txt > a.ps

TODO list all fonts?

##ps2pdf

    ps2pdf a.ps

    ps2pdf a.ps out.pdf

read from stdin:

    ps2pdf - a.pdf

out to stdout:

    ps2pdf a.ps -

##pdftotext

extracts text layer from pdf

    pdftotext a.pdf
    less a.txt

##pdftk

pdf Tool Kit

merge two or more pdfs into a new document:

    pdftk 1.pdf 2.pdf 3.pdf cat output 123.pdf

or using handles:

    pdftk A=1.pdf B=2.pdf cat A B output 12.pdf

or using wildcards:

    pdftk *.pdf cat output combined.pdf

slice pdf: get pagets 1 to 7 only:

    pdftk A="$f.pdf" cat A1-7 output "$f.pdf"

select pages from multiple pdfs into a new document:

    pdftk A=one.pdf B=two.pdf cat A1-7 B1-5 A8 output combined.pdf

split pdf into single pages

    pdftk mydoc.pdf burst

get pdf metadata like number of pages:

    pdftk mydoc.pdf dump_data | less

rotate the first page of a pdf to 90 degrees clockwise:

    pdftk in.pdf cat 1E 2-end output out.pdf

rotate an entire pdf document’s pages to 180 degrees:

    pdftk in.pdf cat 1-endS output out.pdf

encrypt a pdf using 128-bit strength (the default) and withhold all permissions (the default):

    pdftk mydoc.pdf output mydoc.128.pdf owner_pw foopass

Same as Above, Except a Password is Required to Open the PDF:

    pdftk mydoc.pdf output mydoc.128.pdf owner_pw foo user_pw baz

Same as Above, Except Printing is Allowed (after the PDF is Open):

    pdftk mydoc.pdf output mydoc.128.pdf owner_pw foo user_pw baz allow printing

Decrypt a PDF:

    pdftk secured.pdf input_pw foopass output unsecured.pdf

Join Two Files, One of Which is Encrypted (the Output is Not Encrypted):

    pdftk A=secured.pdf mydoc.pdf input_pw A=foopass cat output combined.pdf

Uncompress PDF Page Streams for Editing the PDF Code in a Text Editor:

    pdftk mydoc.pdf output mydoc.clear.pdf uncompress

Repair a PDF’s Corrupted XREF Table and Stream Lengths (If Possible):

    pdftk broken.pdf output fixed.pdf

##edit pdf content

consider libreoffic draw + pdf importer.

##djvulibre-bin

djvu cli tools

###ddjvu

convert djvu to other formats

huge outputs! not practical sizes!

very slow!

possible: pbm, pgm, ppm, pnm, rle, tiff, and pdf

    ddjvu -format=pdf "$djvu" "$pdf"

outputs pages 1 and 3, followed by all the document pages in reverse order up to page 4:

    ddjvu -format=pdf -pages=1,3,99999-4 "$djvu" "$pdf"

loses text layer

###djvm

get number of pages of djvu:

    djvm -l speak\ chinese\ 2.djvu | sed -nre '$ s/.+#([0-9]+).+/\1/p'

#pdfcrop

remove empty margins of pdf files

greatly increases filesize (10x)

	pdfcrop a.pdf

#fonts

Description of how txt and utf data should look like.

Locations:

- /usr/share/X11/fonts
- /usr/share/fonts

##xlsfonts

TODO

---

Formats:

- TrueType:

    Proprietary Apple.

    Vector.

    File extension: ttf

- OpenType: 

    Proprietary Microsoft (ironic name... *open* type)

    Based on TrueType.

    File extensions: .ttf or .otf (compressed)

- Type-1:

    Designed for postscript.

    Was Adobe proprietary but has become free on condition that it is not modified. TODO check this crazy license.

    Extensions: afm, pfb, pfm.
