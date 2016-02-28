# pdftk

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

