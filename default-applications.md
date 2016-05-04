# Default applications

This talks about how to allow users to choose their default application when opening certain types of file.

There are many systems, and they have some degree of compatibility.

The best options likely are:

- `xdg-open` is a popular XDG choice.
- `gnome-open` Gnome specific. Use `xdg-open` instead. `xdg-open` forwards to it in GNOME systems.
- `update-alternatives` and `/etc/alternatives` is an important Linux method of executable selection.

## update-mime-database

shared-mime-info package.

## Environment variables

Some common variables are used by non-graphical systems, e.g. `EDITOR` and `BROWSER`.

### kde-open

KDE specific. Use `xdg-open` instead.
