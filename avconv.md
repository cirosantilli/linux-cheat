# avconv

`libav-tools` package.

Convert `ogg` into `mpg`:

    avconv -i input.ogv -f 24 output.mpg

You must specify frame rate, as the following fails because MPEG does not support the default 15fps:

    avconv -i input.ogv output.mpg

Cut music file starting from second 1 to second 5:

    avconv -i input.mp3 -ss 1 -t 5 output.mp3

Times may be either in seconds or in `hh:mm:ss[.xxx]` form.

Overwrite output file without asking:

    -y

Concatenate files: <http://stackoverflow.com/questions/18552901/how-to-merge-videos-by-avconv>
