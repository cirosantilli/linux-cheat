# gzip

# zlib

# gunzip

# gz

Extension: `gz`.

Library name: zlib, GNU.

Popular wrapper: `gzip`, and `gunzip` to unzip.

## gzip vs zip

-   Completely different file types.

-   Both use the DEFLATE algorithm: <https://en.wikipedia.org/wiki/DEFLATE>, and therefore have very similar compression ratios and speeds.

-   The zlib library does not focus on directories: only single files. For this reason it is commonly used together with `tar` which only packs directories into a file. For convenience however, the command line executable can deal with `.tgz` files.

-   gzip seems to have very one dominant implementation: GNU zlib, so that gzip can refer to either the utility or format used by that utility.

    zip has many implementations: WinRAR, WinZip on closed source on Windows, Info-ZIP and libzip open source, Info-ZIP being the default one present on Ubuntu 12.04. Therefore the term zip usually only refers to the file format.

If a file is only `.gz` but not `.tgz` you cannot use tar to extract it.

Create `a.txt.gz` and `rm` `a.txt`:

    gzip a.txt

Extract `a.gz` and erase it if successful:

    gunzip a.gz

`.gz` all files under given directory recursively individually. Remove each original:

    gzip -r .

`gunzip` requires files to have a given extension by default. Workaround:

    gunzip <file >out

or:

    gcat file >out

## gz file format

IETF standardized format: <https://www.ietf.org/rfc/rfc1952.txt>
