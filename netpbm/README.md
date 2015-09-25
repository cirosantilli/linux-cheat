# NetPBM

Simple text based or binary family of uncompressed image formats.

Suitable for simple script generation.

Those formats are also collectively knows as PNM, Portable aNymap Format.

Mainly used in Linux.

Bad browser support, but can be viewed well with many Linux viewers, including `eog` and Krusader. Make sure to do a huge zoom. Those viewers may do dithering by default.

Magic numbers: first thing in file, specifies the exact format. Cannot be determined by extension alone because of binary/ASCII forms.

- `P1`: `.pbm` ASCII
- `P2`: `.pgm` ASCII
- `P3`: `.ppm` ASCII
- `P4`: `.pbm` binary
- `P5`: `.pgm` binary
- `P6`: `.ppm` binary

Where:

- `.pbm`: binary
- `.pgm`: grayscale
- `.ppm`: RGB
