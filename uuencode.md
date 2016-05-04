# uuencode

# uudecode

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
