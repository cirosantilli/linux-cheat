# Book

1.  [PDF](pdf.md)
    1. [pdftk](pdftk.md)

A book format is in general a format that can represent multiple images, text and multiple pages such as PDF, DJVU or PS.

Pure image or text formats such as JPEG or TeX are not covered here.

## Formats

Formats that contain image, text, fonts such as PDF or DJVU but not not formats that map directly to bits such as PNG or JPEG.

-   PS, PostScript.

    By Adobe, like PDF, but created earlier. They both competed, but PDF ended winning.

    A Turing complete programming language. Can have goto, branch, variables.

    Versions are called levels: 1, 2 and 3 exist up to today.

    Since it is a programming language, it is not possible to evaluate the last pages without going through the previous ones, as those may contain variables or other definitions.

-   EPS: encapsulated postscript. Contains a PostScript, with some extra metadata.

-   DJVU:

-   DVI: specifically created for the output of TeX. It is possible to reverse engineer low level TeX from it, although not of course the high level macros. Not Turing complete. Cannot embed fonts. Not human readable. Can then be converted to other formats like PDF.

-   EPUB: multi file zipped XML + XHTML + CSS. Open source and large support.

-   [O'Reilly HTMLBook](http://oreillymedia.github.io/HTMLBook/). Single file HTML5 subset. Used for their books internally, cannot be converted to PDF for free although they [do have a closed source converter](http://forum.atlas.oreilly.com/t/is-is-possible-to-compile-books-locally/11), used as back-end in their Atlas platform.

-   MOBI: Mobipocket company, free format, bought by Amazon. TODO vs EPUB.

-   RTF: Rich Text Format, proprietary Microsoft. Can be opened with `fbreader`.

## Viewers

### Okular

KDE default viewer.

Open at given page of document:

    okular -p 2 a.pdf

Single instance:

    okular --unique a.pdf
    okular --unique b.pdf

`a.pdf` is closed, `b.pdf` is opened on same window.

### fbreader

MOBI reader.

## Calibre

Book library management + command line utils

### ebook-convert

Convert between ebook formats: PDF, MOBI, etc.

## Utilities

### paps

Converts TXT to PS.

Works for UTF8.

Much better defaults than a2ps.

Outputs to stdout by default, so you want:

    paps a.txt > a.ps

Font:

    paps --font="times 12" a.txt > a.ps

TODO list all fonts?

### a2ps

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

### ps2pdf

    ps2pdf a.ps

    ps2pdf a.ps out.pdf

Read from stdin:

    ps2pdf - a.pdf

Out to stdout:

    ps2pdf a.ps -

### pdfjam

Package that includes several PDF utils.

### popler

#### pdftotext

Extract text layer from PDF:

    pdftotext a.pdf
    less a.txt

#### pdfimages

Extracts all images of a PDF as PPM or PBM.

    pdfimages a.pdf

#### pdffonts

TODO lists which fonts? available on computer? used by given PDF?

    pdffonts a.pdf

#### pdfinfo

Get various specs on the given PDF:

    pdfinfo a.pdf

### Edit PDF content in GUI

Consider LibreOffice draw + PDF importer.

<http://askubuntu.com/questions/162037/how-to-edit-pdfs/288020#288020>

### djvulibre-bin

DJVU CLI tools.

#### ddjvu

Convert DJVU to other formats.

Huge outputs! Not practical sizes, and very slow!

Possible outputs: PBM, PGM, PPM, PNM, TIFF, and PDF

    ddjvu -format=pdf "$djvu" "$pdf"

Outputs pages 1 and 3, followed by all the document pages in reverse order up to page 4:

    ddjvu -format=pdf -pages=1,3,99999-4 "$djvu" "$pdf"

Loses text layer.

#### djvm

Get number of pages of DJVU:

    djvm -l speak\ chinese\ 2.djvu | sed -nre '$ s/.+#([0-9]+).+/\1/p'

## pdfcrop

Remove empty margins of PDF files.

Greatly increases file size (10x).

	pdfcrop a.pdf

## Fonts

Description of how TXT and UTF data should look like.

Locations:

- `/usr/share/X11/fonts`
- `/usr/share/fonts`

### xlsfonts

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

    Was Adobe proprietary but has become free on condition that it is not modified.

    Extensions: `afm`, `pfb`, `pfm`.

## chm

Microsoft proprietary.

Discontinued.

Compiled form of HTML, not directly plain text.

Has been reverse engineered.

### chm to HTML

Archmage:

    archmage a.chm

### chm to PDF

`chm2pdf`: <http://www.ubuntugeek.com/how-to-convert-chm-files-into-pdf-files-in-ubuntu.html>

Index links were broken and did not show index pages:

    chm2pdf --website a.chm

Did not work for me:

    chm2pdf --book a.chm

### chm readers

- `chmsee`: GTK+, few preferences but just works.
- `kchmreader`: KDE, broken colors on Ubuntu 12.04.
