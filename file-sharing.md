#File Sharing

##Dropbox

See your home files on browser:

    firefox https://www.dropbox.com/home

File status:

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

Get public URL of F into the clipboard:

    dropbox puburl "$F"
    echo "wget `dropbox puburl "$F"`" > xsel

The file must be inside Public folder.

Autostart Dropbox at startup:

    dropbox autostart y

##Ubuntu one

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

##Nicotine+

Soulseek client.

###Behind a proxy router

Go to the router admin panel, port forwarding part.

It can be found using your browser under a magic vendor dependent address.

On a D-Link for example the default is: <http://192.168.0.1/RgForwarding.asp>, default login: `admin` pass: `motorola`.

Open ports 2234 to 2239 on local ip found at:

    ifconfig eth0 | grep "inet addr:"

Now either put your files in another partition at the root, or symlink your share and download dirs to somewhere above user so that people cannot see your username:

    sudo ln -s /home/soulseek path/to/share/folder

##NFS

Network File System.

Designed for LAN, has higher throughput than FTP.

FTP preferred on WAN.

##LDAP

TODO
