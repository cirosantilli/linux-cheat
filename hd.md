# hd

`od` alternative with better defaults, but not POSIX 7.

Ubuntu `bsdmainutils` package.

Uses saner hexadecimal defaults and shows ASCII side by side.

Saner than hexdump.

Very close to hexdump, but also shows ASCII visualization on the side of hexa visualization.

Example:

    echo -en {a..z} "\n \x01" | hd

Output:

    00000000  61 20 62 20 63 20 64 20  65 20 66 20 67 20 68 20  |a b c d e f g h |
    00000010  69 20 6a 20 6b 20 6c 20  6d 20 6e 20 6f 20 70 20  |i j k l m n o p |
    00000020  71 20 72 20 73 20 74 20  75 20 76 20 77 20 78 20  |q r s t u v w x |
    00000030  79 20 7a 20 0a 20 01                              |y z . .|
    00000037

Non ASCII and whitespace chars or control chars such as newline or `\x01` are represented as dots on the ASCII side notation.

Offsets are in hexadecimal: 00, 10, 20.
