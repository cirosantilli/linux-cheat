#PDF

First created by Adobe as a proprietary format in 1993.

Apparently not Turing complete in itself, although it can embed Turing complete objects like JavaScript and Flash, which viewers may or may not play.

Version 1.7 released in 2007 as a payed ISO standard and for public implementation without royalties, except for some proprietary extensions.

A free ISO approved copy is made freely available at the Adobe website free of charge: <http://www.adobe.com/devnet/pdf/pdf_reference.html>. It matches the ISO spec exactly.

The spec is quite readable, with many examples. In particular, Annex H contains a few examples of increasing complexity of PDF files.

Text layers, image layers, each page can be serially downloaded and viewed.

PDF fonts can be either found in a renderer path, or be embedded in the document. The [standard 14 fonts]](http://en.wikipedia.org/wiki/Portable_Document_Format#Standard_Type_1_Fonts_.28Standard_14_Fonts.29) must always be supported. 

PDF is human readable, so in theory it is possible to write it by hand with a text editor. (TODO no compression?)

However, it was not designed to be written by hand. For example:

- for the `xref` table it is necessary to include byte offsets of certain chunks of text.
- some objects have must have two sided parent child links between them.
- byte counts are necessary at certain points, like before streams.

This means that PDF is a base bad input format: it should be used as an output format only. Those design choices with redundancy are made to make PDFs faster to render.

PDF is influenced by PostScript.

##Capabilities

-   text: contains text layers. TODO: are text objects broken into lines? How does search work?

-   annotations: explicit support for common types of annotations, like highlighting, underlining, notes or drawing on top of the document.

-   optional content: it is possible to only show certain contents on certain situations. E.g.: editors often make annotations disappear when printing.

-   general vector drawing operations

-   images: only bitmaps or JPEG, no other compressed format supported

-   inner hyperlinks

-   arbitrary embedded files.

    I haven't tried an example yet, but I imagine that those files can be separated from the PDF by the viewer.

    Possible on `pdflatex` with: <http://texdoc.net/texmf-dist/doc/latex/attachfile/attachfile.pdf>.

-   URL hyperlinks

-   3D objects

-   images

-   audio

-   forms which can be submitted to URLs in several formats, including regular HTML HTTP 4 requests.

    Common HTML-like form elements are supported: text input, textareas, checkboxes, radio and dropdowns.

    TODO is it possible to save form data internally on the file?

    Okular saves data externally: if you change file path form content is not restored.

    Can be created on `pdflatex` through `hyperref`: <http://tex.stackexchange.com/questions/14842/creating-fillable-pdfs>

-   tagging and structure. The core of PDF is specifying how things should be printed on a page, with little semantic information about what is being drawn.

    However, it also has features that allow authors to do so, producing a semantic tree structure similar to HTML, that contains elements like paragraphs, lists, tables, spans, block quotes, code and links.

    Semantic metadata is stored separately from the drawing instructions, and they communicate through references.

-   metadata like author, creation date, title, keywords, etc., much like HTML `head`.

Viewers may explicitly ask if you want to enable more advanced / dangerous / interactive elements.

TODO: can PDFs be compressed? It seems that Stream objects can all be compressed, but what about the entire PDF file?

TODO: can PDFs automatically do line wrapping? Or does software like LaTeX have to explicitly position all characters?

##Implementations

A common Linux rendering library implementation is Poppler: <http://en.wikipedia.org/wiki/Poppler_%28software%29>. It also contains many useful utilities.

Another implementation is GNU PDF, which was removed from the list of GNU's high priority projects because of Poppler: <http://en.wikipedia.org/wiki/GNU_PDF>

PDF.js is a JavaScript browser PDF renderer: <https://github.com/mozilla/pdf.js>

##PDF subsets

<http://www.gnupdf.org/Standards_comparison#Standardized_subsets>

Reduce the amount of capabilities to make it easier to implement and print.

###PDF/X

<http://en.wikipedia.org/wiki/PDF-X>

PDF subset, easier for printing:

- all fonts embedded
- all images on a format suitable for printing

##TODO

- how to generate the `xref` table automatically to make it more feasible to write test PDFs by hand?
- fix byte counts on annex the hello world PDF: [hello-world.md](hello-world.md).

##Sources

Good information on PDF is *hard* to find. This is quite insane considering it is *the* most popular book format today, specially when compared to HTML. 

Part of this is because it is much harder to visualize a PDF when compared to HTML. Also, PDFs are not meant to be writable by hand.

Free:

-   Short but good intro: <http://www.gnupdf.org/Introduction_to_PDF>

    More information at: <http://www.gnupdf.org/Category:PDF>, compiled as the GNU project implements PDF libraries.

-   <http://brendanzagaeski.appspot.com/0005.html>

-   A few tutorials: <http://blog.idrsolutions.com/?s=%22Make+your+own+PDF+file%22>

Non-free:

-   <http://www.amazon.com/Developing-PDF-Portable-Document-Format/dp/1449327915>

    Developing PDF Portable Document Format - 2013 - Leonard Rosenthol.

    Simple, useful info that goes one step above the basic free 101 tutorials.

-   <http://www.amazon.com/PDF-Explained-John-Whitington/dp/1449310028>

    PDF Explained - 2011 - John Whitington
