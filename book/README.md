A book format is in general a format that can represent multiple images, text and multiple pages such as PDF, DJVU or PS.

Pure image or text formats such as JPEG or TeX are not covered here.

#Formats

Formats that contain image, text, fonts such as PDF or DJVU but not not formats that map directly to bits such as PNG or JPEG.

-   PS

    A Turing complete programming language. Can have goto, branch, variables.

    Versions are called levels: 1, 2 and 3 exist up to today.

    Since it is a programming language, it is not possible to evaluate the last pages without going through the previous ones, as those may contain variables or other definitions.

-   EPS: encapsulated postscript

-   DJVU:

-   epub: TODO

-   MOBI: Mobipocket company, free format, bought by Amazon. TODO vs epub.

-   RTF: Rich Text Format, proprietary Microsoft

##PDF

First created by Adobe as a proprietary format in 1993.

Version 1.7 released in 2007 as a payed ISO standard and for public implementation without royalties, except for some proprietary extensions.

A free ISO approved copy is made freely available at the Adobe website free of charge: <http://www.adobe.com/devnet/pdf/pdf_reference.html>. It matches the ISO spec exactly.

The spec is quite readable, with many examples. In particular, Annex H contains a few examples of increasing complexity of PDF files.

Text layers, image layers, each page can be serially downloaded and viewed.

A common Linux viewing library implementation is Poppler: <http://en.wikipedia.org/wiki/Poppler_%28software%29>. It also contains many useful utilities.

PDF fonts can be either found in a renderer path, or be embedded in the document. The [standard 14 fonts]](http://en.wikipedia.org/wiki/Portable_Document_Format#Standard_Type_1_Fonts_.28Standard_14_Fonts.29)must always be supported. 

PDF is human readable (TODO no compression?), so in theory it is possible to write it by hand with a text editor.

However, it was not designed to be written by hand. For example:

- for the `xref` table it is necessary to include byte offsets of certain chunks of text.
- some objects have must have two sided parent child links between them.
- byte counts are necessary at certain points, like before streams.

This means that PDF is a base bad input format: it should be used as an output format only. Those design choices with redundancy are made to make PDFs faster to render.

PDF is influenced by PostScript.

Sources:

- Short but good intro: <http://www.gnupdf.org/Introduction_to_PDF>
- <http://brendanzagaeski.appspot.com/0005.html>
- A few tutorials: <http://blog.idrsolutions.com/?s=%22Make+your+own+PDF+file%22>

TODO:

- how to generate the `xref` table automatically to make it more feasible to write test PDFs by hand?
- fix byte counts on annex the hello world PDF: [hello-world.md](hello-world.md).

#Viewers

##Okular

KDE default viewer.

Open at given page of document:

    okular -p 2 a.pdf

Single instance:

    okular --unique a.pdf
    okular --unique b.pdf

`a.pdf` is closed, `b.pdf` is opened on same window.

##fbreader

MOBI reader.

#Calibre

Book library management + command line utils

##ebook-convert

Convert between ebook formats: PDF, MOBI, etc.

#Utilities

##paps

Converts TXT to PS.

Works for UTF8.

Much better defaults than a2ps.

Outputs to stdout by default, so you want:

    paps a.txt > a.ps

Font:

    paps --font="times 12" a.txt > a.ps

TODO list all fonts?

##a2ps

TXT to PS

Does not work for UTF8. For that use `paps`:

    a2ps -o a.ps a.txt

-   `-1`: one page per sheet (default is 2)

        a2ps -B -1 -o a.ps a.txt

-   `-B`: remove default headers:

        a2ps -B -o a.ps a.txt

-   `--borders=no`: no default borders:

        a2ps -B -1 --borders=no -o a.ps a.txt

Output to stdout

    a2ps -o - a.txt

##ps2pdf

    ps2pdf a.ps

    ps2pdf a.ps out.pdf

Read from stdin:

    ps2pdf - a.pdf

Out to stdout:

    ps2pdf a.ps -

##pdftk

PDF Tool Kit

Large feature set on dealing with PDFs page wise.

Rather non standard command line interface (nothing to do with common POSIX or GNU conventions).

Merge two or more PDFs into a new document:

    pdftk 1.pdf 2.pdf 3.pdf cat output 123.pdf

or using handles:

    pdftk A=1.pdf B=2.pdf cat A B output 12.pdf

or using wildcards:

    pdftk *.pdf cat output combined.pdf

Slice PDF: get pages 1 to 7 only:

    pdftk A="$f.pdf" cat A1-7 output "$f.pdf"

Select pages from multiple PDFs into a new document:

    pdftk A=one.pdf B=two.pdf cat A1-7 B1-5 A8 output combined.pdf

Split pdf into single pages

    pdftk mydoc.pdf burst

Get pdf metadata like number of pages:

    pdftk mydoc.pdf dump_data | less

Rotate the first page of a PDF to 90 degrees clockwise:

    pdftk in.pdf cat 1E 2-end output out.pdf

Rotate an entire PDF document’s pages to 180 degrees:

    pdftk in.pdf cat 1-endS output out.pdf

Encrypt a PDF using 128-bit strength (the default) and withhold all permissions (the default):

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

##pdfjam

Package that includes several PDF utils.

##popler

###pdftotext

Extract text layer from PDF:

    pdftotext a.pdf
    less a.txt

###pdfimages

Extracts all images of a PDF as PPM or PBM.

    pdfimages a.pdf

###pdffonts

TODO lists which fonts? available on computer? used by given PDF?

    pdffonts a.pdf

###pdfinfo

Get various specs on the given PDF:

    pdfinfo a.pdf

##Edit PDF content in GUI

Consider LibreOffice draw + PDF importer.

<http://askubuntu.com/questions/162037/how-to-edit-pdfs/288020#288020>

##djvulibre-bin

DJVU CLI tools.

###ddjvu

Convert DJVU to other formats.

Huge outputs! Not practical sizes, and very slow!

Possible outputs: PBM, PGM, PPM, PNM, TIFF, and PDF

    ddjvu -format=pdf "$djvu" "$pdf"

Outputs pages 1 and 3, followed by all the document pages in reverse order up to page 4:

    ddjvu -format=pdf -pages=1,3,99999-4 "$djvu" "$pdf"

Loses text layer.

###djvm

Get number of pages of DJVU:

    djvm -l speak\ chinese\ 2.djvu | sed -nre '$ s/.+#([0-9]+).+/\1/p'

#pdfcrop

Remove empty margins of PDF files.

Greatly increases file size (10x).

	pdfcrop a.pdf

#Fonts

Description of how TXT and UTF data should look like.

Locations:

- `/usr/share/X11/fonts`
- `/usr/share/fonts`

##xlsfonts

TODO

---

Formats:

-   TrueType

    Proprietary Apple.

    Vector.

    File extension: `ttf`

-   OpenType

    Proprietary Microsoft (ironic name... *open* type)

    Based on TrueType.

    File extensions: `ttf` or `otf` (compressed)

-   Type-1:

    Designed for postscript.

    Was Adobe proprietary but has become free on condition that it is not modified. TODO check this crazy license.

    Extensions: `afm`, `pfb`, `pfm`.

#chm

Microsoft proprietary.

Discontinued.

Compiled form of HTML, not directly plain text.

Has been reverse engineered.

##chm to HTML

Archmage:

    archmage a.chm

##chm to PDF

`chm2pdf`: <http://www.ubuntugeek.com/how-to-convert-chm-files-into-pdf-files-in-ubuntu.html>

Index links were broken and did not show index pages:

    chm2pdf --website a.chm

Did not work for me:

    chm2pdf --book a.chm

##chm readers

- `chmsee`: GTK+, few preferences but just works.
- `kchmreader`: KDE, broken colors on Ubuntu 12.04.
