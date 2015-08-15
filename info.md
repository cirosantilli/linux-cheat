# info

GNU specific manual format and viewer.

Input format: `.info` files, which are generated from `.texi` files with `makeinfo`.

Each page contains lots of info, more than man pages, may even contain, *gasp*, examples!

Sample invocation:

    info
    info rm

The key bindings are very tree/node based, and quite different form Vim. To get started:

- `?:` help
- `x`: close help

Page:

- space: down one page. May change nodes.
- backspace: up one page. May change nodes.
- `b`, `e`: beginning/end of current node.
- `s`, `/:` search string
- `{`, `}:` repeat search back/forward

Menu:

-   arrow keys: move cursor

-   enter: go to link under cursor

-   tab: go to next link

-   1-9: go to menu item number

-   `m`: select menu item in current page by name.

    Can tab complete.

    Even without tab complete, goes to first match on enter.

Node:

- `u`: parent node
- `t`: top node
- `[,`, `]:` next previous node. May   change node level
- `n`, `p`: same as `[` and `]`, but cannot change node level
- `l`: go to last viewed node. can be used several times
- `g`: like m, but search all nodes

Search:

- `/:` regex
- `{:` next   match of previous search
- `}:` previous
