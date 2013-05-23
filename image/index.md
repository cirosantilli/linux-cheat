# formats

- btm: bit by bit, no compression

    specified by Microsoft

- netpbm

    - PBM: black and white (1 or 0!)

    - PGM: gray scale

    - PPM: color

    mainly used in linux

    bad browser suport

    not compressed

    very simple to edit on a text editor

    magic numbers: first thing in file, specifies the exact format
    (cannot be determined by extension alone because of binary/ascii forms)

    - P1 pbm ASCII
    - P2 pgm ASCII
    - P3 ppm ASCII
    - P4 pbm binary
    - P5 pgm binary
    - P6 ppm binary

    ASCII: human readable but not memory efficient in comparison to binary

    Ex: pbm: in ascii: 1 byte per pix, in binary 1 *bit* per pixel.

    to view the minimalistic examples in this repo, open them with an image editor (GIMP)
    and do a huge zoom

- svg: vector. image is described by mathematical formulas, not bits. xml. non compressed.

    reasonable browser support and increasing.

- gif:

    max 8 bit colors.

    loseless compressed.

    obsolete.

    associated with the web: huge browser support.

    can contain multiple images to make very short videos.

- png: lossless, alpha layer,

- tif: lossless or lossy, in practice lossless aplications only.

- jpg: lossy, huge compression. removes fourrier transform high freqs I think.

#editors

##gimp

image manipulation

huge amount of functions

learn the shortcuts and be happy

avoid multi window madness:

    Menu > Windows > Single-Window Mode

resize image:

    Menu > Image > Scale Image

shortcuts:

- `<C-PageDown>`: go to previous tab

- `r`: rectangle select tool

    - `<c-a> drag`: move the selection elsewhere
    - `<c-s-v>`: open selection as new image

- `R`: rotate selection tool

- `<c-PageDown>`: rotate selection tool

##inkscape

svg gui editor

very good

##dia

gnome diagram editor

##dot

graph editor

#viewers

##eog

eyes of gnome

lightweight

    eog a.jpg

##aview

converts image to ascii art!!!

aview is only for p.m formats

bw only?

    asciiview a.jpg

I CANT CHANGE THE WIDTH!!!

    asciiview -width a.jpg

#caca-utils

##img2txt

stdout output

    img2txt a.jpg
    img2txt -W `tput cols` a.jpg

-W: width

fit to terminal

##caca view

img2text on x window

    cacaview a.pjg

#imagemagick

tons of image conversion tools

cli + apis in lots of langs, includeing c (native), c++ and python

reading the manual is a great image manipulation course!

list supported formats:

    identify -list format

##convert

- process images
- converts between formats

- input/output format can be deduced automatically (from extension/or magic?)

does not do:

- djvu

###options

tons of options available

#####size

######-crop

10x10: rectangle to keep:

        convert -crop 10x10 a.jpg b.jpg

+10+10: top left corner of rect

        convert -crop 10x10+10+10 a.jpg b.jpg

top 50 percent:

        convert -crop 100x50% a.jpg b.jpg

cannot give top left corner in percentage

bottom 50 percent:

        convert -gravity south -crop 100x50% a.jpg b.jpg

#####color

-monochrome: monochrome image. == -depth 1? but not in practice =)

-depth: number of bits per pixel.

-density: pdfs are fixed width for printers, not pixel data,
    so you have to say how many dpi you want to take
    300 makes output quite readable

    always set this for pdfs

    pdf to one jpg per page:

            convert -density 300 a.pdf a.jpg

-threshold:

            convert -threshold 50 a.jpg b.jpg

-level:

            convert -level -100,100 a.jpg b.jpg

#exactimage

concurrence to imagemagick, supposedly faster. c++ template api

#dvipng

convert dvi to png

important application: latex -> dvi -> png -> website.
