# wmctrl

Control windows and get info on them from sh (maximize, minimize, focus, etc.)

Depends on the presence of a window manager.

Very good tutorial: <http://spiralofhope.com/wmctrl-examples.html>

Get info:

- `-d`: desktop info
- `-m`: window manager info

## Window choice

In order to act on a window, one must first select it. The ways to do it are:

-   default (no special option): case insensitive title substring match.

    In case of multiple matches, the first one is chosen.

    E.g.:

        wmctrl -a '- mozilla firefox'

    Will act on a window with title:

        '- mozilla firefox'

-   `-F`: case sensitive title substring match.

    E.g.:

        wmctrl -Fa '- Mozilla Firefox'

    Will act on a window with title:

        'Google - Mozilla Firefox'

    But not on a window with title:

        'Google - mozilla firefox'

-   `-x`: choose by window class.

    Every program should set this to something unique and short, but not all do.

    Check with:

        xprop | grep CLASS

    E.g.:

        wmctrl -xa 'terminator'

## actions

Once a window is selected, actions can be done on it.

Go to desktop of given window, bring it forward and maximize it:

    wmctrl -a '- mozilla firefox'

Mnemonic: Activate.

Close window:

    wmctrl -c '- mozilla firefox'

Resize and reposition window:

    wmctrl -r '- mozilla firefox' -e 1,0,0,800,600
                                     1 2 3 4   5

`-r` selects the window for commands that already take other arguments such as `-e`

- `1`: gravity TODO
- `2` and `3`: position.
- `4` and `5`: size.

If the window is maximized, this does nothing.

Switch to desktop 1:

    wmctrl -s 1

### fullscreen

Many apps do that with CLI arguments, and you should prefer that method if available. If not:

    wmctrl -xa gvim -b add,fullscreen

TODO: when I hit `Alt + Tab`, the list of applications does not show anymore on Ubuntu 15.10...

## Focus window opened by command

Non-trivial of course because there is no simple bijection between windows and executables:

<http://unix.stackexchange.com/questions/167379/set-focus-to-newly-open-window>
