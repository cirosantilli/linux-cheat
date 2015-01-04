# xxd

`od` alternative.

`vim-common` package.

Killer feature: reverse hexdump:

    printf 'a\0' | xxd | xxd -r

The reverse is quite flexible: it deals with minor formatting issues
(spaces, separators, base) intelligently.
