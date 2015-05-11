# od

View binary data.

POSIX 7: <http://pubs.opengroup.org/onlinepubs/9699919799/utilities/od.html>

Mnemonic: Octal Dump.

Other non-POSIX 7 alternatives: `hd`, `hexdump`. Those usually produce more readable output by default.

Very useful for viewing binary data which contains values which cannot be interpreted as some character set (ASCII, UTF-8) that can be printed to terminal screen.

You have some fun exploring things such as:

-   executables such as elf files

-   partition tables:

        sudo hd -n 512 /dev/sda

View byte values byte by byte in octal and other bases.

## Most useful commands

The most useful command for inputs which are mostly ASCII is:

    printf "ab\n\x10" | od -c

Which interprets all ASCII chars or those that have standard backslash escapes, and prints the others as numbers:

    0000000   a   b  \n 020
    0000004

Note however how octal notation is used for the numbers TODO can this be converted to HEX or DEC?

The best option for files which are not mostly ASCII is:

    printf 'ab\n\x10' | od -Ax -tx1

Which outputs:

    000000 61 62 0a 10
    000004

For interactive uses, consider either:

-   using another utility such as `hd` (non-POSIX) which has saner defaults

-   having an alias which sets sane flags:

        alias ods='od -Ax -tx1'

Which stands for `od` Sane.

Output:

    0000000 61 62
    0000002
    ^       ^   ^
    1       2   3

Meaning of output:

1.  Number of the first byte in the line in.

    Here the first byte in line 1 is byte 0 of the file. The first byte of line 2, if it existed, would be byte 2.

2.  First byte of each line.

    `61` in hex is 97 in decimal, which is the ASCII for `a`.

3.  Second byte of each line.

    `62` in hex is 98 in decimal, which is the ASCII for `b`.

Best command for computational use:

    printf 'ab' | od -Ax -tx1

## t

`formaT` specifier.

### tx

`x` means hexadecimal.

1 and 2 means how many bytes per block.

Example:

    echo -n ab | od -tx1

Output:

    0000000 61 62
    0000002

Example:

    echo -n ab | od -tx2

Output:

    0000000 6261
    0000002

Note how the bytes are inverted in each block.

### to

Octal.

Default format is `o2`.

Example:

    echo -n ab | od -to1

Output:

    0000000 141 142
    0000002

Note how this is less convenient that hexadecimal since each byte needs 3 characters instead of 2 to be represented.

Another downside of using octal: 3 octal character makes 9 bits (3 per character) and not 8 as in a byte, so it is not possible to have for example `444`.

### tc

Show bytes that can be represented as ASCII characters as ASCII characters.

Useful when the input should contain mostly ASCII characters, for example when trying to find some weird byte in a file such as source code that should not contain such characters.

More precisely, there are the following cases:

- if the byte has a corresponding non whitespace ASCII character or space, print that character.

- else if the character has a corresponding backslash `\\` C escape sequence,
    print that sequence. Ex: 0 is `\0`.

- else print the octal value of the byte as in `-to1`.

Example:

    echo -en '\x61\x0A\x01' | od -t c

Output:

    0000000   a  \n 001
    0000003

Here

- `0x61` has an ASCII representation as `a`.
- `0x0A` is an ASCII newline.

Since it would be ugly to represent it as a lie break, and since it has a C backslash representation as `\n`, that is used.

- `0x01` falls in neither of the above cases, so it is represented in octal as `001`.

## w

Line width.

Default value: 16.

Example:

    echo -n 0123 | od -tx1 -w2

Output:

    0000000 30 31
    0000002 32 33
    0000004

Example:

    echo -n 0123 | od -tx1 -w1

Output:

    0000000 30
    0000001 31
    0000002 32
    0000003 33
    0000004

Example:

    echo -n 01234 | od -tx1 -w2

Output:

    0000000 30 31
    0000002 32 33
    0000004 34
    0000005

Note how the last line is always present and empty.

It always gives the total number of bytes.

## Duplicate lines

`od` automatically hides one or more duplicate lines and represents them with an asterisk `*`.

Example:

    echo -n 0101010 | od -tx1 -w2

Output:

    0000000 30 31
    *
    0000006 30
    0000007

If there was no line hiding, it would have looked like this:

    0000000 30 31
    0000002 30 31
    0000003 30 31
    0000006 30
    0000007

This is a very good behaviour since it lest you focus on the differences only.

## -A

Radix of the line numbers.

- `o`: octal
- `d`: decimal
- `x`: hexadecimal

Default value: `o`

Example:

    echo {a..z} | od -Ax -tx1

Output:

    000000 61 20 62 20 63 20 64 20 65 20 66 20 67 20 68 20
    000010 69 20 6a 20 6b 20 6c 20 6d 20 6e 20 6f 20 70 20
    000020 71 20 72 20 73 20 74 20 75 20 76 20 77 20 78 20
    000030 79 20 7a 0a
    000034

Note how the addresses are given in hexadecimal.

Since there are 16 bytes per line, the second line starts at byte 16, so the address is `000010`.

In decimal:

    echo {a..z} | od -Ad -tx1

Output:

    0000000 61 20 62 20 63 20 64 20 65 20 66 20 67 20 68 20
    0000016 69 20 6a 20 6b 20 6c 20 6d 20 6e 20 6f 20 70 20
    0000032 71 20 72 20 73 20 74 20 75 20 76 20 77 20 78 20
    0000048 79 20 7a 0a
    0000052

## N

Maximum number of bytes to read.

## w

Number of bytes per line. Default: 32.
