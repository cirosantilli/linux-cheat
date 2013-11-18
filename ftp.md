FTP is:

- tcp/ip file transfer protocol
- a command line utility with the same name which implemets the client for that protocol

#hosts

to have some real fun, try commands on a real host

most free apache/php web hosts offer ftp mainly for users to uplod their sites:

just find the one with the most space and uptime. htis is a list of good ones

main quality parameters to consider:

- max data
- max data transfer
- max file size

##freehostingnoads

<http://freehostingnoads.net/>

Free Hosting No Ads

- 20 GB space
- 200 GB traffic

urls of form: <http://cirosantilli.t15.org/>

Deleted my data after 30 days innactivity!

#commands

the `ftp` utility only contains very low level commands in bijection
to the protocol

see all available commands:

    ?

do a local shell command:

    ! pwd

connect from command line option:

    ftp ftp.domain.com

connect from ftp repl:

    open ftp.domain.com

disconnect and but keep program open:

    bye

disconnect and exit program:

    exit

ls remote:

    ls

cd remote:

    cd

cd local:

    lcd

pwd remote:

    pwd

upload file with same basename:

    put a

file `a` exists in current local dir

does not work for dirs

upload file with different basename:

    put a b

download file with same basename in current dir:

    get a

download with different basename in current dir:

    get a b

download on relative path:

    get d/a

subdir must exist locally

delete remote file:

    del a

create a remote directory:

    mkdir d

remove an empty remote directory:

    rm d

cannot do multiple commands per line:

    #ls; ls

##recusive

it seems that it is not possible to do recursive directory operations
like download, remove or upload on non empty directories with a single command:
http://stackoverflow.com/questions/10749517/ftp-delete-non-empty-directory
lftp is a possible solution

#lftp

implements more convenient high level command line interface

seems backwards compatible with the `ftp` utility

give user from command line argument:

    lftp -u user host.ftp.com

give commands from the command line:

    user=
    url=
    lftp -c "open -u $user $url
    ls
    ls"

`-c` must be the only option.

`-f file` to read command from a file instead.
`-f` must be the only option.

could not find a way to read commands from stdin: `-f -` does not work...

multiple commands per line:

    ls; ls

execute only of last worked:

    ls && ls

execute only of last failed:

    ls || ls

group commands:

    ls && ( ls || ls )

recursive directory download:

    mirror d

recursive directory upload (Reverse mirror)

    mirror -R d

recursive directory remove:

    rm -r d

#filezilla

gui ftp manager

stores connexion passwords/usernames
and makes recursive copy/paste easy
