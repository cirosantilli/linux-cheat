#dropbox

See your home files on browser:

    firefox https://www.dropbox.com/home

Filestatus:

    dropbox filestatus
    dropbox filestatus "$F" "$G"

Legend:

- a: up to date
- b: unwatched

Get status:

    dropbox status

Possible status:

- idle: program running but doing nothing

Get information on sync status of files on current dir:

    dropbox ls

- green: synced

Get public url of F into the clipboard:

    dropbox puburl "$F"
    echo "wget `dropbox puburl "$F"`" > xsel

The file must be inside Public folder.

Autostart dropbox at startup:

    dropbox autostart y

#ubuntu one

open source cross platform canonical dropbox like program

web interface:

    firefox https://one.ubuntu.com/dashboard/

check deamon status:

    u1sdtool -s

publish a file:

    u1sdtool --publish-file a

get file public url to the clipboard:

    u1sdtool --publish-file a | perl -ple 's/.+\s//' | xsel -b

There exist taskbar status indicator exists at <https://launchpad.net/indicator-ubuntuone>.

#nicotine+

soulseek client

##behind a proxy router

Go to the router admin panel, port forwarding part.
It can be found using your browser under a magic vendor dependant address.
On a DLINK for example the default is: <http://192.168.0.1/RgForwarding.asp>,
default login:admin pass:motorola

Open ports 2234 to 2239 on local ip found at:

    ifconfig eth0 | grep "inet addr:"

Now either put your files in another partition at the root, or symlink
your share and download dirs to somewhere above user so that people cannot
see your username:

    sudo ln -s /home/soulseek path/to/share/folder

#nfs

Network FileSystem.

Designed for LAN, has higher throughput than FTP.

FTP preferred on WAN.

#ldap
