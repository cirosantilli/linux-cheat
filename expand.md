# expand

POSIX 7 <http://pubs.opengroup.org/onlinepubs/9699919799/utilities/expand.html>

Expand tabs to spaces:

    printf -e 'a\tb' | expand

The cool thing about this command is that it works well for inner tabs, e.g.:

    printf '1\t1\n12\t1\n12345678\n'

Looks like:

    1       1
    12      1
    12345678

After `expand`, it will still look the same: the first tab is expanded to 7 spaces, but the second one to only 6.

So you can easily take outputs with tabs, and replace them with spaces in a way that it looks exactly the same before pasting it somewhere else where you don't tabs to appear, e.g. Markdown.

## unexpand

The contrary. TODO
