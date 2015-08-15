# makeinfo

Reference implementation of the Texinfo format.

Compile to one page HTML:

    makeinfo --html --no-split -o a.html a.info
    firefox a.html

`--no-split` is only needed for formats that can output multiple files, to prevent it from putting the output in a new directory.

Compile to html under directory `a`:

    makeinfo --html a.info
    firefox a/index.html

