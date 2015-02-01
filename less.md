# less

`less` package.

Best pager available on all distributions.

Advantages over Vim:

- loads faster

Disadvantages over Vim:

- much less powerful

Inputs:

-   `/`: search forward

-   `n`: repeat last search

-   `d`: down one page

-   `u`: up one page

-   `g`: top of document

-   `G`: bottom of document

-   `g`: top of document

-   `<ENTER>`: down one line

-   `-S` : toggle line wrapping

        less "$f"
        printf 'ab\ncd\n' | less

-   `-R` : interpret ANSI color codes

    Rubbish:

        ls --color | less

    Colors!:

        ls --color | less -R
