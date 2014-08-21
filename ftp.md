FTP is:

- TCP/IP file transfer protocol
- a command line utility with the same name which implements the client for that protocol

#hosts

To have some real fun, try commands on a real host.

Most free Apache/PHP web hosts offer FTP mainly for users to upload their sites: just find the one with the most space and uptime. This is a list of good ones.

Main quality parameters to consider:

- max data
- max data transfer
- max file size

##freehostingnoads

<http://freehostingnoads.net/>

Free Hosting No Ads

- 20 GB space
- 200 GB traffic

URLs of form: <http://cirosantilli.t15.org/>

Deleted my data after 30 days inactivity!

#Commands

The `ftp` utility only contains very low level commands in bijection to the protocol.

See all available commands:

    ?

Do a local shell command:

    ! pwd

Connect from command line option:

    ftp ftp.domain.com

Connect from FTP REPL:

    open ftp.domain.com

Disconnect and but keep program open:

    bye

Disconnect and exit program:

    exit

`ls` remote:

    ls

`cd` remote:

    cd

`cd` local:

    lcd

`pwd` remote:

    pwd

Upload file with same basename:

    put a

File `a` exists in current local dir

Does not work for dirs

Upload file with different basename:

    put a b

Download file with same basename in current dir:

    get a

Download with different basename in current dir:

    get a b

Download on relative path:

    get d/a

Subdir must exist locally.

Delete remote file:

    del a

Create a remote directory:

    mkdir d

Remove an empty remote directory:

    rm d

Cannot do multiple commands per line:

    #ls; ls

##Recursive directory operations

It seems that it is not possible to do recursive directory operations like download, remove or upload on non empty directories with a single command: <http://stackoverflow.com/questions/10749517/ftp-delete-non-empty-directory>. LFTP is a possible solution.

#LFTP

Implements more convenient high level command line interface

Seems backwards compatible with the `ftp` utility

Give user from command line argument:

    lftp -u user host.ftp.com

Give commands from the command line:

    user=
    url=
    lftp -c "open -u $user $url
    ls
    ls"

`-c` must be the only option.

`-f file` to read command from a file instead. `-f` must be the only option.

Could not find a way to read commands from stdin: `-f -` does not work...

Multiple commands per line:

    ls; ls

Execute only of last worked:

    ls && ls

Execute only of last failed:

    ls || ls

Group commands:

    ls && ( ls || ls )

Recursive directory download:

    mirror d

Recursive directory upload (Reverse mirror)

    mirror -R d

Recursive directory remove:

    rm -r d

#FileZilla

GUI FTP manager.

Stores connexion passwords/usernames and performs recursive upload and download.
