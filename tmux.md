#tmux

Terminal superpowers:

-   create a remote ssh session, detach from it, close the ssh connection, ssh again, and reattach to the old bash!

-   open multiple terminal windows in a single terminal.

-   send keys to an open terminal. E.g.: from Vim, send `make<cr>` to an open terminal.

    There is already a plug-in that interfaces with Vim: <https://github.com/benmills/vimux>

Ubuntu install:

    sudo aptitutde install tmux

Similar function to GNU screen but has more functionality.

What it can't do:

- save sessions to disk

##Sessions

Has a server client model. The first time you launch the tmux command, it launches both the server and a client.

Next calls, first check and use the existing server.

Open multiple terminals and create one session in each:

    tmux new -s session-name0
    tmux new -s session-name1

List sessions from outside tmux:

    tmux session

from inside tmux:

    Ctrl-b s

Output:

    session-name0: 1 windows (created Wed Apr  9 20:22:37 2014) [198x49] (attached)
    session-name1: 1 windows (created Wed Apr  9 20:19:23 2014) [198x49] (attached)

Detach form a session:

    tmux detach

or:

    Ctrl-b d

List sessions again and you will see that we detached from the first terminal:

    test0: 1 windows (created Wed Apr  9 20:22:37 2014) [198x49]
    test1: 1 windows (created Wed Apr  9 20:19:23 2014) [198x49] (attached)

Attach again to a session:

    tmux a -t session-name0

`$`: rename current session

##Windows and panes

- windows are like Vim tabs
- panes are like Vim windows.

Window shortcuts:

-   `,`: create a new window (Vim tab)

-   `c`: create a new window (Vim tab)

-   `w`: list windows in current session

    The list of windows is also shown at the bottom status line:

        0:bash- 1:bash* 2:bash

    where:

    - `0:`: is the window ID
    - `bash`: is the default name of the window.
    - `*`: indicates current window
    - `0`: indicates previously selected window

Pane shortcuts:

- `n` and `p`: next and previous window
- `0`: to `9`: switch to given window ID
- `%`: split horizontally
- `"`: split vertically:
- Arrows: navigate panes.
- `q`: show pane numbers for a few seconds
- `o`: cycle through panes in order
- `{}`: current pane's position with next / previous one
- `!`: remove pane from window and open it in a window of its own
- `x`: kill / close the current pane

##Send keys

Send keys to a session:

    tmux send-keys -t session-name0 ls Enter

Keys are taken from arguments.

If a special name key is recognized, it is interpreted and sent.

Otherwise, each argument is sent as literal characters.

Some special strings include:

- `Enter`
- `C-x`: Control X
- `M-x`: Alt X

##Copy mode

##History

Mode in which history can be browsed, edited and copied to be later pasted on another window.

##Configuration

Configuration file: `~/.tmux.conf`

Options shall not be discussed here: they will be commented directly on my `.tmux.conf`.

##Interactive

tmux starts a login shell by default.

Therefore, `.bashrc` will get sourced.

[This SO thread](http://unix.stackexchange.com/questions/38402/aliases-and-tmux) recommends to work around this by adding to `~/.bash_profile`:

    case $- in *i*) . ~/.bashrc;; esac
