# On Ubuntu, comes from the psmisc package.

# Shows tree of which process invocates which

  pstree

# This works because in POSIX new processes are created exclusively
# by forking from other processes, and parent information is stored
# on each process, which dies if the parent dies

# this is a very insightfull program to understand what happened after
# the `init` process, first process on the system and common ancestor of all, started

# Particularaly interesting if you are on a graphical interface,
# to understand where each process comes from

# Quotint `man pstree`, multiple processes with same name and parent are wrttin in short notation:

  #init-+-getty
  #   |-getty
  #   |-getty
  #   `-getty

# Becomes:

  #init---4*[getty]

# Threads (run parallel, but on same data, and cannot fork) are indicated by brackets:

  #icecast2---13*[{icecast2}]

# Means that `icecast2` has 13 threads.
