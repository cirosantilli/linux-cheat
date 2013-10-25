#formats

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

- gif:

    max 8 bit colors.

    loseless compressed.

    obsolete.

    associated with the web: huge browser support.

    can contain multiple images to make very short videos.

- tif: lossless or lossy, in practice lossless aplications only.

- svg: vector, xml based, non compressed.

	image is described by mathematical formulas, not bits, therefore it is potentially tiny if the image is mathematically simple
	and the description is perfect (to floating point precision), which allows for example for infinite zoom.

	cannot however describe photos from real life in general (there are attempts to convert photos
	to vector, but they are far from usable). It is basically used for images which were genrated by the computer
	without a huge number of lines such as graphs.

	render size may be higher though, but at least over the internet this is countered by the
	matters less because bandwidth is a bottleneck

    reasonable browser support and increasing.

- png: lossless compression, alpha layer, wide software support.

	best format for non vector lossless.

	Interlacing: if yes, the image is streamed in random order with added pixel position information

	This is useful for slow data channels like the internet, so that when the browser loads it,
	pixels load all over, and not from tob to bottom.

	This increases the size of the image, since it is then necessary to keep bit position information.

- jpg: lossy, good compression/quality loss ratio, wide software support

	best format for non vector lossy.

	ammount to lose can be controlled to increase compression.

	algorithm: removes fourrier transform high freqs TODO confirm

#get info on image

- `file`: type, and for certain formats size other major parameters such as depth.

#editors

##gimp

Image manipulation.

Huge amount of functions.

Learn the shortcuts and be happy.

Avoid multi window madness:

    Menu > Windows > Single-Window Mode

Resize image:

    Menu > Image > Scale Image

Shortcuts:

- `<C-PageDown>`: go to previous tab

- `r`: rectangle select tool

    - `<c-a> drag`: move the selection elsewhere
    - `<c-s-v>`: open selection as new image

- `R`: rotate selection tool

- `<c-PageDown>`: rotate selection tool

- `<c-s-v>`: create new file containing only the clipboard selection
    (first do rectangle selection + control c)

##inkscape

svg gui editor.

Very good.

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

Tons of image conversion tools.

CLI + APIs in lots of langs, includeing c (native), c++ and python.

Reading the manual is a great image manipulation course!

##identify

Get info on imagemagick or specifig images.

List supported formats:

    identify -list format

Get size of an image:

    identify -format "%[fx:w]x%[fx:h]" a.jpg

##convert

- process images

- converts between formats

- input/output format can be deduced automatically (from extension/magic)

does not do:

- djvu

tons of options available

###convert gif

Gif to several images:

    convert a.gif a.png

Generates `a-N.png` images.

###resize

	convert large.png -resize 50% small.png

This:

- takes averages between pixels to make image have less pixels
- keeps bit depth

Therefore, the image file size will be just a bit more than 1/4 of the original because:

- 1/2 x 1/2 = 1/4 of the number of pixels
- the png metadata size is unchanged, so this is not divided by 4.

###crop

`10x10`: rectangle to keep:

        convert -crop 10x10 a.jpg b.jpg

`+10+10`: top left corner of rect

        convert -crop 10x10+10+10 a.jpg b.jpg

top 50 percent:

        convert -crop 100x50% a.jpg b.jpg

cannot give top left corner in percentage

bottom 50 percent:

        convert -gravity south -crop 100x50% a.jpg b.jpg

###color

- `-colorspace Gray`: convert to grayscale

    convert in.png -colorspace Gray out.png

- `-monochrome`: monochrome image. == -depth 1? but not in practice =)

- `-depth`: number of bits per pixel.

- `-density`: pdfs are fixed width for printers, not pixel data,
    so you have to say how many dpi you want to take
    300 makes output quite readable

    always set this for pdfs

    pdf to one jpg per page:

            convert -density 300 a.pdf a.jpg

- `-threshold`:

	simple way to convert to black and white:
	if color average is above threshold, pixel is white
	else pixel is black

            convert -threshold 50 a.jpg b.jpg

- `-level`:

	linear transform on color space

            convert -level -100,100 a.jpg b.jpg

#exactimage

concurrence to imagemagick, supposedly faster. c++ template api

#dvipng

convert dvi to png

important application: latex -> dvi -> png -> website.
