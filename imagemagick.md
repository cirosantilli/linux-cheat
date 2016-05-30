# ImageMagick

Tons of image conversion tools.

CLI + APIs in lots of languages, including C (native), C++ and Python.

Reading the manual is a great image manipulation course.

Man pages are very shallow: have a look at the online docs instead:

- <http://www.imagemagick.org/script/command-line-options.php>

## identify

Get info on ImageMagick on given image file and file formats supported by ImageMagick.

List supported formats:

    identify -list format

Supported colorspaces:

    identify -list colorspace

### format

<http://www.imagemagick.org/script/escape.php>

Get size of an image: <http://stackoverflow.com/questions/1555509/can-imagemagick-return-the-image-size>

    identify -format '%w %h' a.jpg

Number of bits:

    identify -format '%[fx:w*h]' a.jpg

`fx` expressions: <http://www.imagemagick.org/script/fx.php> TODO: how to prevent that from using scientific notation or at least infinite precision?

### ping

Makes identify operation potentially faster by not reading the entire file to memory:

- <http://stackoverflow.com/a/22393926/895245>
- <http://stackoverflow.com/questions/4670013/fast-way-to-get-image-dimensions-not-filesize>

### Check if image is black and white binary

TODO:

- <http://programmers.stackexchange.com/questions/131067/image-color-grayscale-classification>
- <http://superuser.com/questions/508472/how-to-recognize-black-and-white-images>

## convert

- process images
- converts between formats
- input/output format can be deduced automatically (from extension/magic)

Does not do:

- DJVU

### Order of arguments

The order of arguments matters! Transformations that come first, are applied first.

### Convert formats

The formats are deduced from the extension of the input and output.

Multiple JPG to a single PDF:

    convert in0.jpg in1.jpg out.pdf

#### Formats

Full format list with some notes: <http://www.imagemagick.org/script/formats.php>

Some useful formats:

-  `rgb`: export raw pixels

-  `gray`: export grayscale. E.g.:

        printf '\x00\xFF\x00\xFF' > f.gray
        convert -depth 8 -size 2x2 f.gray f.png

    If the `-size` is too small, e.g. `1x2`, make multiple images, e.g. `f-N.png`.

### Specify a format explicitly

To force the format of an input or output, prefix it with `format:`, e.g.:

    convert -depth 8 -size 320x200+0 gray:f pic.png

treats an unknown binary format in file `f` as `gray`.

### Output to stdout

Since output is determined by the file extension, we have to specify it with the magic syntax:

    convert in.jpg pbm:-

Or:

    convert in.jpg pbm:

- <http://superuser.com/questions/577992/convert-image-at-command-line-to-console-stream>
- <http://stackoverflow.com/questions/4066173/using-imagemagick-without-making-files>

There are also some magic formats, like:

    convert in.jpg info:

which produces the same as:

    identify in.jpg

### resize

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

Fixed height:

	convert large.png -resize x100 small.png

Force modified aspect ratio:

	convert large.png -resize '50x100!' small.png

### trim

Automagically remove white background.

Perfect to get smaller data like documents out of scanned A4 pages.

### depth

Specify number of bits for each channel.

If the input format does not specify it through metadata, you must specify if yourself.

E.g.:

    printf '\x00\xFF\x00\xFF\x00\xFF' > f.gray
    convert -depth 8 -size 2x3 f.gray -depth 16 g.gray
    hd g.gray

Gives:

    00000000  00 00 ff ff 00 00 ff ff  00 00 ff ff              |............|
    0000000c

The first `-depth 8`, specifies it for the input, and the second for the output.

#### Depths that are not multiple of 8

TODO: what happens when depth less than 8? http://stackoverflow.com/questions/10155092/how-do-i-convert-image-to-2-bit-per-pixel ImageMagick packs multiple bits per byte since it is not possible to address bits, but I don't understand exactly how. Specially, because it depends on the dimensions! E.g.;

    printf "%10s" | sed 's/ /\xFF\x00/g' > f.gray
    convert -depth 8 -size 1x20 f.gray -depth 2 g.gray
    hd g.gray
    convert -depth 8 -size 2x10 f.gray -depth 2 g.gray
    hd g.gray
    convert -depth 8 -size 10x2 f.gray -depth 2 g.gray
    hd g.gray
    convert -depth 8 -size 20x1 f.gray -depth 2 g.gray
    hd g.gray

Gives:

    00000000  80 00 80 00 80 00 80 00  80 00 80 00 80 00 80 00  |................|
    *
    00000014

    00000000  80 80 80 80 80 80 80 80  80 80                    |..........|
    0000000a

    00000000  aa 80 aa 80                                       |....|
    00000004

    00000000  aa aa a0                                          |...|
    00000003

So it seems that if depth < 8, then ImageMagick operates line wise, and 0 pads missing bits.

### crop

`10x10`: rectangle to keep:

    convert -crop 10x10 a.jpg b.jpg

`+10+10`: top left corner of rectangle

    convert -crop 10x10+10+10 a.jpg b.jpg

Top 50 percent:

    convert -crop 100x50% a.jpg b.jpg

Cannot give top left corner in percentage

Bottom 50 percent:

    convert -gravity south -crop 100x50% a.jpg b.jpg

### Color options

-   `-depth`: number of bits per pixel.

-   `-density`: PDFs are fixed width for printers, not pixel data, so you have to say how many DPI you want to take 300 makes output quite readable

    Always set this for PDFs.

    PDF to one JPG per page:

        convert -density 300 a.pdf a.jpg

    This produces horrible effects because there is no dithering.

-   `-level`: linear transform on color space:

        convert -level -100,100 a.jpg b.jpg

#### colorspace

`-colorspace gray`: convert to grayscale:

        convert in.png -colorspace Gray out.png

TODO what does `-colorspace hsl` mean? Do output formats support HSL?

#### Grayscale

-   `-threshold`: Simple way to convert to a binary black and white image: if color average is above threshold, pixel is white else pixel is black:

        convert -threshold 50 a.jpg b.jpg

-   `-monochrome`: seems to generate a black and white binary image with a good dithering.

        convert -monochrome a.jpg b.jpg

    Can likely be achieved with other options? But this is a convenient option

    <http://www.imagemagick.org/Usage/quantize/#monochrome>

### extent

Keep only the 50x50 central square of an image:

    convert in.png -gravity center -extent 50x50 out.png

Percentage version:

    convert in.png -gravity center -extent '50%x50%' out.png

### append

Paste multiple images into one vertically: <http://superuser.com/questions/290656/combine-multiple-images-using-imagemagick>

    convert -append in-*.jpg out.jpg

Size is not corrected automatically.

Horizontally:

    convert +append in-*.jpg out.jpg

### Transparency to white

<http://stackoverflow.com/questions/2322750/replace-transparency-in-png-images-with-white-background>

    convert image.png -background white -alpha remove white.png

### GIF operations

GIF to several images:

    convert a.gif a.png

Generates `a-N.png` images.

Several images to GIF loop forever:

    convert -delay 100 img*.png img.gif

or:

    convert -delay 100 -loop 0 img*.png img.gif

Loop once and stop

    convert -delay 100 -loop 1 img*.png img.gif

## animate

Animate multiple images interactively:

    animate -delay 100 img*.png

Not meant to generate a GIF from the command line, but good choice to preview a GIF before creating one.

## Applications

Random gray image:

    head -c 1000000 /dev/urandom > f.gray
    convert -depth 8 -size 1000x1000 f.gray f.png

Random RGB image:

    head -c 3000000 /dev/urandom > f.rgb
    convert -depth 8 -size 1000x1000 f.rgb f.png

Stripes:

    printf "%1000000s" | sed 's/ /\xFF\x00/g' > f.gray
    convert -depth 8 -size 2000x1000 f.gray f.png

Checkerboard:

    printf "%1002001s" | sed 's/ /\xFF\x00/g' > f.gray
    convert -depth 8 -size 1001x2002 f.gray f.png

## Trivia

- http://arstechnica.com/security/2016/05/exploits-gone-wild-hackers-target-critical-image-processing-bug/
