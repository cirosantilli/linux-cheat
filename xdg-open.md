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

On Ubuntu 15.10, it is just a large bash script provided by `xdg-utils` that forwards to another default program. Ubuntu 15.10 uses `gnome-open` (or the related `gvfs-open`).

Based on MIME type of file to open, not extension.

Configuration files:

- `/usr/share/applications/defaults.list` global (TODO find citation)
- user specific: `$XDG_DATA_DIRS/applications` (`.local/share/applications`), either `defaults.list` (old) or `mimeapps.list` (new).

## Open multiple files at once

Nope: <http://askubuntu.com/questions/356650/how-to-open-multiple-files-with-the-default-program-from-terminal>

## mimeapps.list

Spec: <https://specifications.freedesktop.org/mime-apps-spec/mime-apps-spec-1.0.1.html>

Maps file MIME types to default applications.

<https://wiki.archlinux.org/index.php/default_applications>

Many applications generate default entries under:

    ~/.local/share/applications/mimeapps.list

You should enter your custom ones under:

    ~/.config/mimeapps.list

## xdg-mime

View and modify the `mimeapps.list` file.

Get mime of given file:

    xdg-mime query filetype my/file.txt

Get application for given mime:

    xdg-mime query default application/pdf

## Mime detection

## mime/packages

Location: `~/.local/share/mime/packages/application-x-foobar.xml`

Arch wiki has the best example as usual: <https://wiki.archlinux.org/index.php/default_applications#Custom_file_associations>

## Run in terminal foreground and show stdout

TODO? Can't even find question.

## Create a new file

Fails:

    xdg-open new-file

Must e.g. `touch` it before...
