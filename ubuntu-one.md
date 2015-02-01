# Ubuntu One

Open source cross platform canonical Dropbox-like program.

Discontinued.

Web interface:

    firefox https://one.ubuntu.com/dashboard/

Check daemon status:

    u1sdtool -s

Publish a file:

    u1sdtool --publish-file a

Get file public URL to the clipboard:

    u1sdtool --publish-file a | perl -ple 's/.+\s//' | xsel -b

There exist taskbar status indicator exists at <https://launchpad.net/indicator-ubuntuone>.
