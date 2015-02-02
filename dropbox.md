# Dropbox

Watched directory: `~/Dropbox`.

It is not possible to use custom or multiple paths: <https://www.dropbox.com/en/help/12> The best workaround is to symlink stuff around. You can just symlink from the watched directory into the real one, and Dropbox always resolves the symlink to read and write.

See your home files on browser:

    firefox https://www.dropbox.com/home

File status:

    dropbox filestatus
    dropbox filestatus "$F" "$G"

Legend:

- `a`: up to date
- `b`: unwatched

Get status:

    dropbox status

Possible status:

- idle: program running but doing nothing

Get information on sync status of files on current dir:

    dropbox ls

- green: synced

Get public URL of F into the clipboard:

    dropbox puburl "$F"
    echo "wget `dropbox puburl "$F"`" > xsel

The file must be inside Public folder.

Autostart Dropbox at startup:

    dropbox autostart y
