# POSIX 7

# List current executing processes and their info.

# On Ubuntu 12.04, implemented by the procps package.

# `ps` is a tool with a complicated past and mulitple implementations.

# The procps version http://procps.sourceforge.net/ supports multiple syntaxes for backwards compatibility:

# - UNIX options, which may be grouped and must be preceded by a dash.
# - BSD options, which may be grouped and must not be used with a dash.
# - GNU long options, which are preceded by two dashes.

# For your sanity, we recommend that you use POSIX and GNU syntax only wherever possible,
# never BSD syntax.


# Implementations commonly use the proc filesystem.
# There does not seem to be a POSIX way to implement this,
# except maybe following a process tree.

# Good short summary:

  ps --help

# ps interface is ugly: some options have dash GNU style, others simply don't, and have no dash equivalent.
# Live with it.

# Best command to see all processes on the system:

  ps -eF

# Output fields include:

# - pid: unique identifier for all process on system
# - tty: from which tty it was launched
# - time: CPU time used for process, not real time
# - cmd: command that launched th process without command line args
# - rss: Resident Set Size: used memory.
# - vsz: TODO

# See processes running on current tty:

  sleep 10 &
  sleep 10 &
  ps

# Show all processes:

  ps -e

  # Show all columns (Full listing):

  ps -eF

# Shows threads of each process:

  ps -em

# Sort output by:

# - cmd
# - time reversed (because of the `-`)
# - pid
# - tty reversed (-)

  ps -ef --sort cmd,-time,pid,-tty

# Get pid of parent of process with pid p

  p=
  ps -p $p -o ppid=

##GNU extensions

  # Show process tree:

    ps -A --forest

  # Sample output:

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

