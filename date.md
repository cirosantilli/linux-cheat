# date

POSIX 7 http://pubs.opengroup.org/onlinepubs/9699919799/utilities/date.html

Get system date:

    date

Sample output:

    Sun Feb  1 12:21:15 CET 2015

Format current time and output it:

    date '+%Y-%m-%d %H:%M:%S'

Sample output:

    2015-02-01 12:21:52

## GNU extensions

Set the system date:

    sudo date -s "1 JUN 2012 09:30:00"
