# Image

## Get info on image

- `file $f`: type, and for certain formats size other major parameters such as depth.
- ImageMagick `identify -format $f`

## Editors

[Gimp](gimp.md).

### Inkscape

Good SVG GUI editor.

### Dia

GNOME diagram editor

## Viewers

### eog

Eyes of GNOME.

Lightweight image viewer:

    eog a.jpg

### img2txt

Convert image to ASCII art.

caca-utils package.

Stdout output:

    img2txt a.jpg
    img2txt -W `tput cols` a.jpg

- `-W`: width

#### caca view

`img2text` on X window:

    cacaview a.pjg

### aview

Converts image to ASCII art! Not as good as `img2txt`.

Works only with Netpbm formats.

Seems to do black and white only:

    asciiview a.jpg

And changing the width was not working for me:

    asciiview -width a.jpg

## Utilities

[ImageMagick](imagemagick.md)

### ExactImage

ImageMagick competitor, supposedly faster. C++ template API.

### caca-utils

Contains `img2txt`.

### dvipng

Convert DVI to PNG.

Important application: LaTeX -> DVI -> PNG -> website.

## Misc

### Color spaces

- <https://en.wikipedia.org/wiki/SRGB>

- <https://en.wikipedia.org/wiki/HSL_and_HSV>

- <https://en.wikipedia.org/wiki/YUV>

Related concepts:

- <https://en.wikipedia.org/wiki/Chromaticity>

- <https://en.wikipedia.org/wiki/CIE_1931_color_space> 1931 CIE

- Human vision sensitivity per cone type: <https://en.wikipedia.org/wiki/CIE_1931_color_space#/media/File:Cones_SMJ2_E.svg>

- <https://en.wikipedia.org/wiki/RGB_color_model>

- <https://en.wikipedia.org/wiki/Secondary_color>

- <https://en.wikipedia.org/wiki/Additive_color> <https://en.wikipedia.org/wiki/Subtractive_color>

- <https://en.wikipedia.org/wiki/Chroma_subsampling>
