# Font

Font formats, viewers and editors.

<http://apple.stackexchange.com/questions/175311/which-font-extension-is-used-on-both-pc-and-mac>

## Types of formats

How the computer encodes the formats: <https://en.wikipedia.org/wiki/Computer_font>:

- bitmap: matrix of pixels. Cheap to render. Does not scale well.
- outline: the contour of the font is described with mathematical equations. Scales well, more expensive to render.
- stroke: TODO

## Formats

### TrueType

### ttf

<https://en.wikipedia.org/wiki/TrueType>

Developed by Apple and Microsoft in the 80's, competitor to Type 1.

Outline font, modelled by quadratic Bézier curves (3 points per segment)

Contains a programmable extension... <https://en.wikipedia.org/wiki/TrueType#Hinting_language> Reminds me of shading languages.

### OpenType

### otf

<https://en.wikipedia.org/wiki/OpenType>

Derived from TrueType.

Registered by Microsoft and Adobe.

Outline font, modelled by cubic Bézier curves.

#### EOT

#### Embedded OpenType

<https://en.wikipedia.org/wiki/Embedded_OpenType>

### PostScript fonts

<https://en.wikipedia.org/wiki/PostScript_fonts>

### WOFF

### Web Open Font Format

<http://www.w3schools.com/css/css3_fonts.asp>

W3C rec. This is what you should use for the web according to <https://developer.mozilla.org/en-US/docs/Web/CSS/@font-face>

### SVG

TODO.

### SVG

## Ubuntu install

<http://askubuntu.com/questions/3697/how-do-i-install-fonts>

Supports both ttf and otf.

Location:

- `~/.fonts`
- `~/.local/share/fonts`
- `/usr/share/fonts`

The file name does not seem to matter, as files contain their nice name as metadata, and utilities show that instead.

See also:

- `~/fonts.conf`
- `~/fontconfig`

How to try it them out: open any program that allows you to select fonts, and it shows on the font list. E.g. Gedit, LibreOffice, etc.

### fc-cache

Font Cache.

`fontconfig` package.

TODO what is it.

## Free font lists

- <https://www.google.com/fonts> `woff2`.
- <https://fontlibrary.org/> `otf`
- <https://www.gnu.org/software/freefont/>

## Concepts

- <https://en.wikipedia.org/wiki/Font_hinting>

## Editor

## Viewer

http://askubuntu.com/questions/171090/is-there-any-good-font-editor

## Licensing

http://askubuntu.com/questions/134549/is-it-legal-to-install-msttcorefonts-package-is-wine-legal

## Implementations

- <http://www.freetype.org/>
