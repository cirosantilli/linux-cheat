#md5sum

Generates / checks MD5 checksums.

    echo a > a
    echo b > b
    md5sum a b > f
    cat f

    60b725f10c9c85c70d97880dfe8191b3  a
    3b5d5c3712955042212316173ccf37be  b
    md5sum -c f

Sample output:

    a: OK
    b: OK

##Application

Have I downloaded the right file?

It is *very* difficult to make another file with the same checksum.
