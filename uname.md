# uname

POSIX 7: <http://pubs.opengroup.org/onlinepubs/9699919799/utilities/uname.html>

Gets information on host computer.

Print all info `uname` has to give:

    uname -a

Sample output:

    Linux ciro 3.13.0-48-generic #80-Ubuntu SMP Thu Mar 12 11:16:15 UTC 2015 x86_64 x86_64 x86_64 GNU/Linux

All POSIX options:

    uname -m
    uname -n
    uname -r
    uname -s
    uname -v

Sample output:

    x86_64
    ciro
    3.13.0-48-generic
    Linux
    #80-Ubuntu SMP Thu Mar 12 11:16:15 UTC 2015

- `m`: hardware type
- `n`: network node (hostname)
- `r`: release level of the operating system implementation
- `s`: name of the implementation of the operating system.
- `v`: current version level of this release of the operating system implementation.
