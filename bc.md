# bc

POSIX: <http://pubs.opengroup.org/onlinepubs/9699919799/utilities/bc.html>

Simple interpreted language, calculator focus.

Cute toy language that only exists because it is POSIX =)

Completely superseded by any modern interpreted language, and only golfs very slightly better than Python, which also has arbitrary precision calculation out of the box.

C-like syntax.

Features: variable definition, function definition, arrays, strings

Non features: string concatenation:

    [ `echo '1+1' | bc` = 2 ] || exit 1
