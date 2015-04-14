# xdg-open

`desktop-file-utils` Ubuntu package.

XDG utils package, part of the LSB.

Can open both Internet URLs and local files:

    echo a > a.html
    xdg-open a.html

    xgd-open http://google.com

Sources:

- <http://askubuntu.com/questions/16580/where-are-file-associations-stored>
- <http://standards.freedesktop.org/mime-apps-spec/mime-apps-spec-1.0.1.html>
- <https://wiki.archlinux.org/index.php/Default_Applications>
- <https://wiki.archlinux.org/index.php/Xdg-open>

Preferred choice for default program opening command since it is desktop/window manager agnostic.

It seems that if a desktop is detected such as GNOME, options for that desktop override this options, so for example under GNOME, this just passes control to `gnome-open`.

Based on MIME type of file to open, not extension.

Configuration files:

- `/usr/share/applications/defaults.list` global (TODO find citation)
- user specific: `$XDG_DATA_DIRS/applications` (`.local/share/applications`), either `defaults.list` (old) or `mimeapps.list` (new).

## xdg-mime

View and modify the `mimeapps.list` file.

Get application for given mime:

    xdg-mime query default application/pdf
