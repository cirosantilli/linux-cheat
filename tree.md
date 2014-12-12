# tree

Print ASCII art file tree.

Test directory:

    mkdir d1 d2
    touch d{1,2}/f{1,2}

Output:

    .
    ├── d1
    │   ├── f1
    │   └── f2
    └── d2
        ├── f1
        └── f2

Note that by default the output contains UTF-8 characters that look like lines.

To make things saner you can request ASCII output:

    tree --charset=ascii

Output:

    .
    |-- d1
    |   |-- f1
    |   `-- f2
    `-- d2
        |-- f1
        `-- f2

Recurse only 2 levels (default infinite):

    tree -L 2

`-a`: include hidden:

    tree -a
