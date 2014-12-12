# pcregrep

Grep on Perl steroids.

- `M`: multiline matches. Probably the best way to do it:
    <http://stackoverflow.com/questions/152708/how-can-i-search-for-a-multiline-pattern-in-a-file>

- `r`: recursive search

- `H`: also print filename of each match before it

- `--color`: color matches

Try:

    pcregrep -HMr --color 'a\n ' .
