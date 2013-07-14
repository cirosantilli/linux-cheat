Utilities similar to `od` that can be used to view binary data.

Very useful for viewing binary data which contains values which
cannot be interpreted as some character set (ASCII, UTF-8)
that can be printed to terminal screen.

You have some fun exploring things such as:

- executables such as elf files

- partition tables:

        sudo hd -n 512 /dev/sda

#od

POSIX 7

Octal dump.

View byte values byte by byte in octal and other bases.

Sanest usage: view bytes in hexadecimal:

    echo -n ab | od -Ax -tx1

For interactive uses, you should either use another utility such as hd (non POSIX) which has saner defaults
or have an alias for this since it is much saner than the octal defaults:

    alias ods='od -Ax -tx1'

Which stands for `od` Sane.

Output:

    0000000 61 62
    0000002
    ^       ^   ^
    1       2   3

1. Number of the first byte in the line in.

Here the first byte in line 1 is byte 0 of the file.
The first byte of line 2, if it existed, would be byte 2.

2. First byte of each line.

`61` in hex is 97 in decimal, which is the ASCII for `a`.

3. Second byte of each line.

`62` in hex is 98 in decimal, which is the ASCII for `b`.

#-t

formaT specifier.

##-tx

x means hexadecimal

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

##-to

Octal.

Default format is `o2`.

Example:

    echo -n ab | od -to1

Output:

    0000000 141 142
    0000002

Note how this is less convenient that hexadeimal since each byte needs 3 characters
instead of 2 to be represented.

Another downside of using ocatl: 3 octal character makes 9 bits (3 per charcter) and not 8 as in a byte,
so it is not possible to have for example `444`.

##-tc

Show bytes that can be represented as ASCII characters as ASCII characters.

Useful when the input should contain mostly ASCII characters,
for example when trying to find some weird byte in a file such as source code
that should not contain such characters.

More precisely, there are the following cases:

- if the byte has a corresponding non whitespace ascii character or space, print that character.

- else if the character has a corresponding backslash `\` C escape squence,
    print that sequence. Ex: 0 is `\0`.

- else print the octal value of the byte as in `-to1`.

Example:

    echo -en '\x61\x0A\x01' | od -t c

Output:

    0000000   a  \n 001
    0000003

Here

- `0x61` has an ascii representation as `a`.
- `0x0A` is an ASCII newline.

Since it would be ugly to represent it as a lie break,
and since it has a C backslash representation as `\n`,
that is used.

- `0x01` falls in neither of the above cases, so it is represented in octal as `001`.

#-w

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

#duplicate lines

od automatically hides one or more duplicate lines and represents them with an asterisk `*`.

Example:

    echo -n 0101010 | od -tx1 -w2

Output:

    0000000 30 31
    *
    0000006 30
    0000007

If there was no line hidding, it would have looked like this:

    0000000 30 31
    0000002 30 31
    0000003 30 31
    0000006 30
    0000007

This is a very good behaviour since it lest you focus on the differences only.

#-A

Radix of the line numbers.

- o: octal
- d: decimal
- x: hexadecimal

Default value: `o`

Example:

    echo {a..z} | od -Ax -tx1

Output:

    000000 61 20 62 20 63 20 64 20 65 20 66 20 67 20 68 20
    000010 69 20 6a 20 6b 20 6c 20 6d 20 6e 20 6f 20 70 20
    000020 71 20 72 20 73 20 74 20 75 20 76 20 77 20 78 20
    000030 79 20 7a 0a
    000034

Note how the adresses are given in hexdecimal,

Since there are 16 bytes per line, the second line starts at
byte 16, so the address is `000010`.

In decimal:

    echo {a..z} | od -Ad -tx1

Output:

    0000000 61 20 62 20 63 20 64 20 65 20 66 20 67 20 68 20
    0000016 69 20 6a 20 6b 20 6c 20 6d 20 6e 20 6f 20 70 20
    0000032 71 20 72 20 73 20 74 20 75 20 76 20 77 20 78 20
    0000048 79 20 7a 0a
    0000052

#-N

Maximum number of bytes to read.

#hd

Very similar to od.

Uses saner hexacedimal defaults and shows ascii side by side.

Not POSIX 7.

Saner than hexdump.

Very close to hexdump, but also shows ASCII visualisation on the side of hexa visualisation.

Example:

    echo -en {a..z} "\n \x01" | hd

Output:

    00000000  61 20 62 20 63 20 64 20  65 20 66 20 67 20 68 20  |a b c d e f g h |
    00000010  69 20 6a 20 6b 20 6c 20  6d 20 6e 20 6f 20 70 20  |i j k l m n o p |
    00000020  71 20 72 20 73 20 74 20  75 20 76 20 77 20 78 20  |q r s t u v w x |
    00000030  79 20 7a 20 0a 20 01                              |y z . .|
    00000037

Non ASCII and whitespace chars or control chars such as newline or `\x01`
are represented as dots on the ASCII side notation.

Offsets are in hexadecimal: 00, 10, 20.

#hexdump

Very similar to od, but not POSIX 7.

Uses saner hexacedimal defaults.

`hd` has even saner defaults.

View bytes in hexadecimal.

    echo -n abc | hexdump -C

Options:

- -C : see bytes in hexadecimal
- -n32 : only 32 bytes
- -s32 : start at byte 32
- -v: show duplicate lines
- -e '1/1 " %02X"': format string
