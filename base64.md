#base64

Byte encoding method, and GNU Coreutils command line utility that implements it. Also possible with the POSIX 7 `uuencode` utility, which has a less convenient interface.

Transforms binary data which may contain non printable bytes like ASCII 0 into data that contain only printable bytes non space chars.

Advantage: makes it easier for humans to view and input the data.

Disadvantage: data gets 33% larger in average: every byte, 7 data bits + 1 check bit, can represent 64 values, thus 6 bits, so 4 characters represent 24 bits == 3 bytes, and so the 4/3 ratio.

To understand see Wikipedia: <http://en.wikipedia.org/wiki/base64#examples>

`-d` to decode:

    assert [ "`echo abc | base64 | base64 -d`" = abc ]

##Why 64?

There are at least 64 printable chars, but not 128.

##Why not use more than 64 character?

##Base85

There are more than 64 printable characters: 95 excluding space and line breaks, but 64 is a power of 2 which makes things easier.

Standards exist which drop the power of 2 requirement. Base85 encodes 4 bytes in 5 characters. 85 is chosen as it is the smallest value that allows 4 bytes in 5 characters because `85^5 > 256^4 > 84^5`.

Base85 implementations are slower than Base64 and less common. Data gets 25% bigger instead of 33% as for Base64.

##Base58

<http://en.wikipedia.org/wiki/Base58>

Base 64 with a few characters removed to make it easier for humans to read:

- `I` (capital `i`) and `l` (lower case `L`) because they look alike
- `O` (capital `o`) and `0` (zero) because they look alike
- non alpha characters: `+` and `/`

The actual order is not well specified, and more specific standards must be considered.

E.g., Bitcoin and Ripple use different orders.

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
