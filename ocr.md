optical character recognition: transform images of text into ascii or utf8

possibilities:

*horc*: format that contains orc + info about page position and certainty

#add text layer to pdfs

*orc indexing*: tranform pdf textonly to searchable pdf

sources:

- <https://help.ubuntu.com/community/OCR#OCR_on_a_Multi_Page_PDF>
- <http://blog.konradvoelkel.de/2010/01/linux-ocr-and-pdf-problem-solved/>

before you go about extracting pdfs, you must use the right command to convert!
some good options are:

    convert -density 300 -monochrome -normalize a.pdf a.png
    convert -depth 1 -density 300 -normalize a.pdf a.png

#tesseract

##chinese hack

tesseract looks for zho instead of chi_sim
there is probably a better way to do this in the tesseract configs, but apparently not directly from vobsub2srt

    tesseract -l eng -psm 3 a.png a
    tesseract -l eng -psm 3 a.png a hocr

-psm 1 : detects pages *and* script automatically. most magic mode.

#cuneiform

    cuneiform -l eng -f text -o "$f.txt" "$f.png"

-f: html, hocr
-l: lang, see man cuneirform

#hocr2pdf from the ExactImage package.

    hocr2pdf -i "$f.png" -s -o "$f.pdf" < "$f.hocr"
