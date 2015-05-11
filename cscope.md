# Cscope

Cscope <http://cscope.sourceforge.net/>.

C-only, but more powerful, e.g. can list references.

## Basic usage

    cd project/root
    cscope -R

This generates a `cscope.out` file.

For the Linux kernel 4.0, it took 2 minutes on a 2013 machine, and generated a 350M file, and leaves you in the ncurses interface.

The `cscope.out` file is binary and not directly readable on text editors.

Next time you want to open the ncurses interface, you can use either:

    cscope -R

which will update the database where needed and reuse existing `cscope.out`, or:

    cscope -d

which will skip the database update.

## -b

Only build the database, don't enter the ncurses.

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

Also 
