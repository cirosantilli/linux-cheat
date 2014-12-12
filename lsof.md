# lsof

List all open files, pipes, ports.

On Ubuntu comes from pre-installed <http://packages.ubuntu.com/trusty/lsof> package.

Not POSIX compliant and relies on kernel internals, but implemented on many POSIX systems.

Usage:

    lsof

Sample output:

    COMMAND     PID   TID       USER   FD      TYPE             DEVICE  SIZE/OFF     NODE NAME
    gvfsd-fus  1367  1396       ciro  mem       REG                8,8    134296  1445240 /lib/x86_64-linux-gnu/libselinux.so.1
    gvfsd-fus  1367  1396       ciro  mem       REG                8,8    100728  1443321 /lib/x86_64-linux-gnu/libz.so.1.2.8

Legend:

-   `COMMAND`: process name that is using the resource

-   `PID`:     process ID

-   `TID`:     thread ID (same as)

-   `USER`:    username

-   `FD`:      file descriptor

-   `TYPE`:    node type of the file

    Possible types are:

    - `REG`: TODO
    - TODO other types

-   `DEVICE`:  device number

-   `SIZE`:    file size

-   `NODE`:    inode

-   `NAME`:    full file path

In the call without arguments, most of the files being used will likely be
shared libraries used by background jobs or special files from the `/proc` filesystem.

Check an specific file:

    exec 3<> /tmp/foo
    lsof /tmp/foo
      #COMMAND   PID USER   FD   TYPE DEVICE SIZE/OFF    NODE NAME
      #bash    22924 ciro    3u   REG    8,8        0 1713824 /tmp/foo
    exec 3>&-
    lsof /tmp/foo
      #

## t

List only process IDs.

Suitable for script consumption.

## i

Search for processes listening on a port:

    python -m SimpleHTTPServer 3000 &
    lsof -i tcp:3000

Output:

    COMMAND   PID USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
    python  31297 ciro    3u  IPv4 286614      0t0  TCP *:3000 (LISTEN

Good combo with `-t` to kill process by port:

    kill `lsof -i tcp:3000 -t`
