# split

Split large file into smaller ones:

Coreutils.

    split file my/prefix

## d

`d`: use numeric suffixes:

    prefix00
    prefix01
    prefix02

instead of the default `a`, `b`, `c`...

## b

Bytes per file:

    split -n1M file.txt

## C

Maximum size per file, *and* only whole lines are split:

    split -C1M file.txt

## a

Control number of prefix bytes.

If you generate more files than the prefix length, you need this, or else different prefix lengths are used.

## Split into sub-directories

E.g.:

    00/00/00
    00/00/01
    ...
    99/99/99

<http://superuser.com/questions/443972/using-coreutils-split-file-into-pieces-to-different-directories>
