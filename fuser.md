# fuser

psmisc package.

Determine which processes are using a device.

Can send signals to those processes.

Can determine TCP / UDP usage, much like netstat.

Basic usage:

    fuser <path>

where `path` is a file or directory.

The output is of the form:

    [<PID-1><access-types>+ ...]

where each type character is one of

- `c`: current directory (a property of each process)
- `e`: executable being run
- `f`: open file. `f` is omitted in default display mode
- `F`: open file for writing. F is omitted in default display mode
- `r`: root directory (a property of each process)
- `m`: mmaped file or shared library

Similar to `lsof`.

## Examples

    fuser /

Sample output:

    /:                    1835r  1960rc  1971r [...]

So we see that:

- process `1835` has root at `/`
- process `1960` has both root and current directory at `/`

This command ends up listing most processes on my system, since most of them have root at `/`.

Now for a file access:

    exec 3<> /tmp/foo
    fuser /tmp/foo

Output:

    /tmp/foo:            22924

Then close:

    exec 3>&-
    fuser /tmp/foo

And the output is empty.

Useful if you want to unmount a filesystem, and you have to find out who is still using it.

    fuser .

You will have at least one process here: your bash

## v

Also show program and user, saving you that `ps aux`:

    fuser -v /

Sample output

                         USER        PID ACCESS COMMAND
    /:                   root     kernel mount /
                         ciro       1835 .r... init
                         ciro       1960 .rc.. dbus-daemon
                         ciro       1971 .r... upstart-event-b
                         ciro       1977 .r... window-stack-br

## k

Send `SIGKILL` found processes. Use with caution!

## n

Search in given domain instead of file paths.

Possible values:

- `tcp`: TCP ports

Good combo with `k` to kill that pesky test server:

    fuser -kv tcp 3000
    fuser -kn tcp 3000
