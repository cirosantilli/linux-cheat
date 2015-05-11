# hexdump

Ubuntu `bsdmainutils` package.

`od` alternative with better defaults, but not POSIX 7.

Uses saner hexadecimal defaults.

`hd` has even saner defaults.

View bytes in hexadecimal.

    echo -n abc | hexdump -C

Options:

- `-C`: see bytes in hexadecimal
- `-n32`: only 32 bytes
- `-s32`: start at byte 32
- `-v`: show duplicate lines
- `-e '1/1 " %02X"'`: format string
