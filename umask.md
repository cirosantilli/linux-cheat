# umask

System call, and CLI front-end.

    man 2 umask
    man umask

Shows/sets permissions that will be *removed* by default when a new file is created by the process.

Each process has `umask` information associated to it. On Linux 4.0, it is present on `task_struct->fs->umask`

`umask` is inherited at `fork` time.

It does not seem to be possible to get the `umask` for a given process except the current one without debugging system calls: <http://www.hostatic.ro/2011/04/11/getting-the-umask-of-a-running-process/>

## Get permissions for current process

    0002

## Set permissions for current process

    touch a
    ls -l a
    #rw-rw-r--
    umask
    #002
    #ok the other w was removed
    #the x are not set by touch by default
    umask 0
    touch b
    #rw-rw-rw-
    umask 777
    touch c
    #---------
