#ImageMagick

Tons of image conversion tools.

CLI + APIs in lots of languages, including C (native), C++ and Python.

Reading the manual is a great image manipulation course.

Man pages are very shallow: have a look at the online docs instead:

- <http://www.imagemagick.org/script/command-line-options.php>

##identify

Get info on ImageMagick on given image file and file formats supported by ImageMagick.

List supported formats:

    identify -list format

Get size of an image:

    identify -format "%[fx:w]x%[fx:h]" a.jpg

##convert

- process images
- converts between formats
- input/output format can be deduced automatically (from extension/magic)

Does not do:

- DJVU

###resize

Resize to 50% or original size:

	convert large.png -resize 50% small.png

This:

- takes averages between pixels to make image have less pixels
- keeps bit depth

Therefore, the image file size will be just a bit more than 1/4 of the original because:

- 1/2 x 1/2 = 1/4 of the number of pixels
- the PNG metadata size is unchanged, so this is not divided by 4.

Resize to fixed width of 100 px, height maintains original proportion:

	convert large.png -resize 100x small.png

###crop

`10x10`: rectangle to keep:

        convert -crop 10x10 a.jpg b.jpg

`+10+10`: top left corner of rectangle

    convert -crop 10x10+10+10 a.jpg b.jpg

Top 50 percent:

    convert -crop 100x50% a.jpg b.jpg

Cannot give top left corner in percentage

Bottom 50 percent:

        convert -gravity south -crop 100x50% a.jpg b.jpg

###color

-   `-colorspace Gray`: convert to grayscale:

        convert in.png -colorspace Gray out.png

-   `-monochrome`: monochrome image. TODO == -depth 1? But not in my tests.

-   `-depth`: number of bits per pixel.

-   `-density`: PDFs are fixed width for printers, not pixel data, so you have to say how many DPI you want to take 300 makes output quite readable

    Always set this for PDFs.

    PDF to one JPG per page:

        convert -density 300 a.pdf a.jpg

-   `-threshold`: Simple way to convert to black and white: if color average is above threshold, pixel is white else pixel is black:

        convert -threshold 50 a.jpg b.jpg

-   `-level`: linear transform on color space:

        convert -level -100,100 a.jpg b.jpg

###Transparency to white

<http://stackoverflow.com/questions/2322750/replace-transparency-in-png-images-with-white-background>

    convert image.png -background white -alpha remove white.png

###GIF operations

GIF to several images:

    convert a.gif a.png

Generates `a-N.png` images.

Several images to GIF loop forever:

    convert -delay 100 img*.png img.gif

or:

    convert -delay 100 -loop 0 img*.png img.gif

Loop once and stop

    convert -delay 100 -loop 1 img*.png img.gif

##animate

Animate multiple images interactively:

    animate -delay 100 img*.png

Not meant to generate a GIF from the command line, but good choice to preview a GIF before creating one.
