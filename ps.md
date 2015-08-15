# ps

POSIX 7 <http://pubs.opengroup.org/onlinepubs/9699919799/utilities/ps.html>

List current executing processes and their info.

On Ubuntu 12.04, implemented by the procps package.

`ps` is a tool with a complicated past and multiple implementations.

The procps version <http://procps.sourceforge.net/> supports multiple syntaxes for backwards compatibility:

- UNIX options, which may be grouped and must be preceded by a dash.
- BSD options, which may be grouped and must not be used with a dash.
- GNU long options, which are preceded by two dashes.

For your sanity, we recommend that you use POSIX and GNU syntax only wherever possible, never BSD syntax.

Implementations commonly use the proc filesystem (thus implemented procps) There does not seem to be a POSIX way to implement this, except maybe following a process tree.

Good short summary:

    ps --help

ps interface is ugly: some options have dash GNU style, others simply don't, and have no dash equivalent. Deal with it.

Best command to see all processes on the system:

    ps -eF

Output fields include:

-   `PID`: unique identifier for all process on system

-   `TTY`: from which tty it was launched

-   `TIME`: CPU time used for process, not real time

-   `CMD`: command that launched th process without command line arguments

-   `RSS`: (not POSIX) Resident Set Size. Memory used directly by the program in the RAM (so no swap) and that is not shared with other programs (shared memory like shared libraries). <http://stackoverflow.com/questions/7880784/what-is-rss-and-vsz-in-linux-memory-management>

-   `VSZ`: (not POSIX) Virtual Memory Size: the entire address space that is visible by the program, although not necessarily loaded in memory. Includes swap and parts of shared libraries not loaded in RAM.

-   `%MEM`: (not POSIX) percentage of `RSS` out of the total memory

See processes running on current tty:

    sleep 10 &
    sleep 10 &
    ps

Show all processes:

    ps -e

Show all possible POSIX columns (Full listing):

    ps -eF

Shows threads of each process:

    ps -em

Get PID of parent of process with given PID `p`

    p=1234
    ps -p "$p" -o ppid=

## Procps extensions

### Sort

Sort output by:

- `CMD`
- `TIME`: reversed (because of the `-`)
- `PID`
- `TTY`

<!-- -->

    ps -ef --sort cmd,-time,pid,-tty

Very useful sorts include:

-   who stole my memory?

        ps aux --sort '%mem'

-   who stole my CPU?

        ps aux --sort '%cpu'

### Process tree

Show process tree:

    ps -A --forest

Sample output:

    1258 ?    00:00:00 lightdm
    1279 tty7   00:17:31 \_ Xorg
    1479 ?    00:00:00 \_ lightdm
    1750 ?    00:00:01   \_ gnome-session
    1868 ?    00:00:00     \_ lightdm-session <defunct>
    1913 ?    00:00:00     \_ ssh-agent
    1950 ?    00:00:31     \_ gnome-settings-
    2363 ?    00:12:19     \_ compiz
    3503 ?    00:00:00     |  \_ sh
    3504 ?    00:00:22     |    \_ gtk-window-deco

Similar to `pstree`.
