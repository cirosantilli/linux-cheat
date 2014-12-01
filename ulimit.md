#ulimit

Get and set resource limits for a process and its children.

POSIX 7: <http://pubs.opengroup.org/onlinepubs/9699919799/utilities/ulimit.html>

Linux and POSIX offer several per process limits. POSIX ones are documented with the `getrlimit` interface at <http://pubs.opengroup.org/onlinepubs/9699919799/functions/getrlimit.html>

On Ubuntu, implemented as a `sh` and `bash` built-in:

    help ulimit

`sudo ulimit` fails because `ulimit` is a built-in and `sudo` takes executables as argument. Alternatives: <http://stackoverflow.com/questions/17483723/command-not-found-when-using-sudo-ulimit>

`ulimit` is a front-end for
<http://pubs.opengroup.org/onlinepubs/9699919799/functions/ulimit.html>,
which in Linux is a front-end for
<http://pubs.opengroup.org/onlinepubs/9699919799/functions/setrlimit.html>

Limits are enforced per process, so if a process is able to fork it can blow the limits by using the children. Limiting the children is non-trivial, so `ulimit` should only be used to prevent system crashes on trusted programs (e.g. one that may take too much RAM with certain parameters).

If programs try to break those limits, the system call fails, and often the program crashes.

##f

POSIX only specifies this option: the maximum file size that can be written in 512 byte blocks.

Get value of the limit:

    ulimit -f

On most distros is `unlimited` by default.

Set value:

    ulimit -Sf 0
    # Shell crashes because `>` happens in current process.
    printf a > a

    ulimit -Sf 1
    printf a > a
    # TODO why works? Was the limit not 512?
    python -c 'print "a" * 1023' > a
    # Fails.
    python -c 'print "a" * 1024' > a

    sudo -c ulimit -Sf unlimited

##GNU extensions

GNU adds many more options in its sh and bash implementations.

In both cases `ulimit` is implemented as a built-in.

List all limits (including the unit and the option name):

    ulimit -a

###S

###H

Linux has the concept of hard and soft limits.

Soft limits can be increased by any user, up to the hard limit, and the hard limit can only be increased by `sudo`.

`-S` specifies soft limits, `-H` hard, and the absence of both sets both at once.

Bash also provides the `soft` and `hard` special limit values which refer to the current soft and hard values.

###v

Virtual memory.

This is one of the most useful limits, when you are running a potentially memory heavy algorithm and don't want it to crash your computer.

Linux deals well with CPU limits since CPU usage rotates according to nice, but as for memory it just takes up the entire RAM / swap and halts everything.

<http://unix.stackexchange.com/questions/44985/limit-memory-usage-for-a-single-linux-process>

The timeout tool aims to limit CPU and RAM for the children as well as parent: <https://github.com/pshved/timeout>

##Per user limits

###PAM

###/etc/security/limits.conf

TODO confirm this section.

Module that sets per user resource quotas.

<http://www.cyberciti.biz/tips/linux-limiting-user-process.html>

Allows for several useful limits, e.g. `nproc` for the number or processes.

    man limits.conf
    man pam_limits
