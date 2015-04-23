# Style guide

Documented under `Documentation/CodingStyle`.

Style used for the Linux Kernel.

-   Tabs instead of spaces. Configure editors to view tabs as 8 spaces. In `vim` you could source:

        if expand('%:e') =~ '\(c\|cpp\|f\)'
            set noexpandtab
            set tabstop=8
            set shiftwidth=8
        endif

     The 8 space rule is needed when we want to make ASCII tables and align each column at a multiple of the tab width so that it is easier to write the table.

     For example, if a tab has 8 spaces then only one tab is need for:

          123456     c2
          c1          c2
          c1          c2

     but two tabs would be needed for:

          123456789     c2
          c1               c2
          c1               c2

     if the tab was sees as say, 4 spaces, the first example would look ugly:

          123456     c2
          c1     c2
          c1     c2

## Double underscores

Functions that start with two underscores are low level functions. This means that:

- there is probably a more convenient and usually more correct function available.
- it is more likely to get deprecated some day.

The message is then clear: avoid using those unless you know exactly what you are doing and you really need to do it.
