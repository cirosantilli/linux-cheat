# Cscope

Cscope <http://cscope.sourceforge.net/>.

C-only, but more powerful, e.g. can list references.

## Quick start

    cd project/root
    cscope -R

This generates or updates a `cscope.out` file and leaves you in the ncurses interface.

For the Linux kernel 4.0, it took 2 minutes on a 2013 machine, and generated a 350M file.

The `cscope.out` file is binary and not directly readable on text editors.

On the ncurses interface, navigate with the down arrow to:

    Find functions calling this function:

Enter your desired function name, and enter.

Now navigate with arrows to the occurrence you want.

Space moves to the next page.

When you hit enter on a line, it opens your command line editor (VIM?) on that line.

When you quit the editor, you fall back on the search.

To start a new search, hit `<Tab>`, and navigate with the arrows again.

Hit Ctrl + D to exit.

## -R

Search source files recursively in the current directory:

    cscope -R

## -d

Skip the database update entirely, enter ncurses viewer directly:

    cscope -d

## -b

Only build the database, don't enter the ncurses interface:

    cscope -Rb

## Ignore struct declarations and see only definitions

Impossible: <http://stackoverflow.com/questions/1175610>

## Find struct assignments while ignoring local variables

Impossible: <http://stackoverflow.com/questions/6190955/how-to-find-struct-member-uses-with-cscope>

## ncurses interface

You are now left on a ncurses interface with the following options:

    Find this C symbol: <cursor>
    Find this global definition:
    Find functions called by this function:
    Find functions calling this function:
    Find this text string:
    Change this text string:
    Find this egrep pattern:
    Find this file:
    Find files #including this file:
    Find assignments to this symbol:

Use arrows to navigate up and down.

Notes:

- `Find this C symbol`: lists all occurrences of variables / functions: definition, declaration, usage, increment, calls
- `Find assignments to this symbol`: does not include compound assignment, or suffix increment `++`

### Panes

There are two panes:

- input pane, at the bottom
- output pane at the top

### ?

Help

### Ctrl+D

Quit.

### tab

Switch between input and output panes.

Suppose we want to find a definition. Move to `Find this global definition` and type `task_struct`.

### Enter

On input pane, make a query.

On the output pane, open the given file on your selected terminal editor.

### Space

On the output pane, go one page down.

### ^

Filter output through shell command. E.g.:

    ^grep sched
