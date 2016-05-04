# tmux

Terminal superpowers:

-   create a remote ssh session, detach from it, close the ssh connection, ssh again, and reattach to the old bash!

-   open multiple terminal tabs splits (known as windows and panes)

-   send keys to an open terminal. E.g.: from Vim, send `make<cr>` to an open terminal.

    There is already a plug-in that interfaces with Vim: <https://github.com/benmills/vimux>

Some of tmux' functionality can be done with different terminal emulators. The advantage is that tmux runs inside any terminal, so it is more portable and easier to develop / configure.

As a result it is much more feature rich, and integrates better with the bash shell.

You then spend most of the time trying to get the terminal emulator to not do anything and just forward commands to tmux, and let tmux do the real work.

Mostly written in C, ISC license, hosted on GitHub

## Alternatives

- GNU `screen`,less functionality

## Sessions

Has a server client model. The first time you launch the tmux command, it launches both the server and a client.

Next calls, first check and use the existing server.

Open multiple terminals and create one session in each:

    tmux new -s session-name0
    tmux new -s session-name1

List sessions from outside tmux:

    tmux list-sessions

from inside tmux:

    Ctrl-b s

Output:

    session-name0: 1 windows (created Wed Apr  9 20:22:37 2014) [198x49] (attached)
    session-name1: 1 windows (created Wed Apr  9 20:19:23 2014) [198x49] (attached)

Detach form current session form inside tmux:

    tmux detach

or:

    Ctrl-b d

List sessions again and you will see that we detached from the first terminal:

    test0: 1 windows (created Wed Apr  9 20:22:37 2014) [198x49]
    test1: 1 windows (created Wed Apr  9 20:19:23 2014) [198x49] (attached)

Attach again to a session:

    tmux attach-session -t session-name0

`$`: rename current session

Kill / destroy a session:

    tmux kill-session -t 'name'

or exit all terminal windows of the session.

### Save and restore sessions

Not easily possible by default... but plugins exist:

- <https://github.com/tmux-plugins/tmux-resurrect>
- <https://github.com/tmux-plugins/tmux-continuum>

## Windows and panes

- windows are like Vim tabs
- panes are like Vim windows

Window shortcuts:

-   `c`: create a new window in the current session (Vim tab)

    On target session on given directory:

        tmux new-window -s 'session-name' -c 'dir'

    TODO: breaks RVM: <https://github.com/wayneeseguin/rvm/issues/3212>

-   `,`: rename a new window (Vim tab). The default name is `bash`.

-   `w`: list windows in current session

    The list of windows is also shown at the bottom status line:

        0:bash- 1:bash* 2:bash

    where:

    - `0:`: is the window ID
    - `bash`: is the name of the program currently running on the window. Try: `sleep 10`. There is a short refresh time, and then the name changes! Note that this kind of breaks for interpreted programs...
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

## Send keys

Send keys to a session:

    tmux send-keys -t session-name0 ls Enter

Keys are taken from arguments.

If a special name key is recognized, it is interpreted and sent.

Otherwise, each argument is sent as literal characters.

Some special strings include:

- `Enter`
- `C-x`: Control X
- `M-x`: Alt X

## Buffers

Tmux has clipboards (Vim buffers).

The default one is called `-`.

They can be accessed from outside of tmux as well with:

    tmux save-buffer -

## Copy mode

## History

Mode in which history can be browsed, edited and copied to be later pasted on another window.

## Configuration

Configuration file: `~/.tmux.conf`

Options shall not be discussed here: they will be commented directly on my `.tmux.conf`.

## Interactive

tmux starts a login shell by default.

Therefore, `.bashrc` will get sourced.

[This SO thread](http://unix.stackexchange.com/questions/38402/aliases-and-tmux) recommends to work around this by adding to `~/.bash_profile`:

    case $- in *i*) . ~/.bashrc;; esac
