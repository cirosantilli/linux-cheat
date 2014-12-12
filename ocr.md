# OCR

Optical character recognition: transform images of text into ASCII or Unicode.

## Add text layer to PDFs

*OCR indexing*: transform PDF text-only to searchable PDF.

Sources:

- <https://help.ubuntu.com/community/OCR#OCR_on_a_Multi_Page_PDF>
- <http://blog.konradvoelkel.de/2010/01/linux-ocr-and-pdf-problem-solved/>

Before you go about extracting PDFs, you must use the right command to convert! Some good options are:

    convert -density 300 -monochrome -normalize a.pdf a.png
    convert -depth 1 -density 300 -normalize a.pdf a.png

## hORC

<http://en.wikipedia.org/wiki/HOCR>

Format that contains OCR + info about page position and certainty of match. Allows for example to add text layers to image only PDFs.

## Tools

### Tesseract

#### Chinese

Tesseract looks for `zho` instead of `chi_sim` there is probably a better way to do this in the Tesseract configs, but apparently not directly from vobsub2srt

    tesseract -l eng -psm 3 a.png a
    tesseract -l eng -psm 3 a.png a hocr

`-psm 1`: detects pages *and* script automatically. `1` is just a magic mode without meaning.

### Cuneiform

    cuneiform -l eng -f text -o "$f.txt" "$f.png"

`-f`: HTML, `hocr`

`-l`: Language, see `man cuneirform`.

### hocr2pdf from the ExactImage package

    hocr2pdf -i "$f.png" -s -o "$f.pdf" < "$f.hocr"
