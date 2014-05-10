#base64

Byte encoding method, and GNU Coreutils command line utility that implements it. Also possible with the POSIX 7 uuencode utility, which has a less convenient interface.

Transforms binary data which may contain non printable bytes like ASCII 0 into data that contain only printable bytes non space chars.

Advantage: makes it easier for humans to view and input the data.

Disadvantage: data gets 33% larger in average. TODO calculation.

To understand see Wikipedia: <http://en.wikipedia.org/wiki/base64#examples>

`-d` to decode:

    assert [ "`echo abc | base64 | base64 -d`" = abc ]

##Why 64?

There are at least 64 printable chars, but not 128.

##Why not use hexadecimal?

Even simpler for humans, but data gets much larger Ks the base is smaller.

#uudecode

#uuencode

POSIX 7.

Very inconvenient interfaces:

- must take input and output files
- the output contains MIME type lines
- decode requires those lines to be present

Example encode:

    uuencode -m <(printf "a\n\0") /dev/stdout

Output:

    begin-base64 600 /dev/stdout
    YQoA
    ====

Decode:

    uudecode -o /dev/stdout <(uuencode -m <(printf "a\0\n") /dev/stdout) | od -tx1

Output:

    0000000 61 00 0a
    0000003
