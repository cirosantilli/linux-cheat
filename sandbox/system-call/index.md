tell your os to do things which user space program can't do directly such as:

- write to stdout, stderr, files
- access devices
- process/threading
- exit a program

all of those operations are ultra os dependant,
so when possible one should use portable wrappers
libracies like ansi libc or the posix headers

it is highly recommended that you also understand
how to make system calls directly from assembler
to really understand them since they have a primary
assembly interface

it is also possible to call them from c code via certain macros

# sources

- <http://syscalls.kernelgrok.com/>

    full linux syscal list

    links to the c manpages

    register args mnemonic

    links to online source code

- <http://www.lxhp.in-berlin.de/lhpsysc0.html>

    contains actual binary values of constants so you can make he calls from assembler

# linux

300+ total, many deprecated, some not implemented

each system call gets a number in order of addition to the kernel:
this is called *syscall number*

this number can never be changed, but system calls may be declared deprecated.

system calls may be only present on certain architectures,
but most of them work on all architectures

to make any of the system calls, one must use the instruction `int $0x80`

`%eax` holds the syscall number

`%ebx`, `%ecx`, `%edx`, `%esx`, `%edi` are the params

# get a list of system calls

TODO how to find them?? where is the official list/api??

## examples of linux calls


        #rebootreboots or enables/disables ctrl+alt+del reboot

        #file descriptors (fd)

            file descriptors contain know the position you are in the stream

                file descriptors allow you to get/give data from anything outside ram:

                - files
                - devices (such as you mouse, keyboard, etc)

                elated system calls are:

                - open
                - close
                - write
                - read

                    - get data to ram
                    - return no of bytes read if no error
                    - return error code if error
                    - increase position of fd

                #lseek

                    reposition read/write

                    cannot be done on pipes or sockets

                - dup
                - dup2
                - dup3
                - fcntl 

        #files and dirs

            - getcwdprocesses have working info associated
            - chdir
            - fchdirusing a file descriptor instead of string
            - chrootuse new root (default `/` ) for paths starting with `/`
            - creatcreate file or device. TODO: what is a device
            - mknodcreate a directory or special or ordinary file
            - linkcreate new name for file
            - unlinkdelete hardlink to file. If it is the last, deletes the file from system.
            - mkdir
            - rmdir
            - rename
            - accesscheck real user's permissions for a file
            - chmod

            - chown
            - fhownby file descriptor
            - lchownno sym links

        #sethostnameprocess have associated hostname info

        #time

            #timesince January 1, 1970
            #stimeset system time
            #timesprocess and waitee for time
            #nanosleep
            #utimechange access and modification time of files

        #threads

            #capget
            #capset
            #set_thread_area
            #get_thread_area
            #clone

                creates thread: a process that can share open file descriptors and
                memory

        #process

            #exit
            #fork

                creates process that is exact copy of current

                open file descriptors TODO

            #execve

                run process. does not return on sucess: old program ends

                common combo: fork before, then execve

            #kill
            #waitpid
            #wait4
            #waitid
            #set_thread_area
            #priority

                process have a priority number from -20 to 19

                lower number means higher priority

                #nice
                #getpriority
                #setpriority

            #ptraceTODO ?

            #ids

                every process has the following associated information:

                #real and effective useriddefaults to user who executed process
                #real and effective groupiddefaults to main group of user who executed process
                #supplementary group ids
                #parent id and parent groupdefaults to TODO effective or real of parent?

                it is possible to change those values at runtime

                #getuid, setuid, geteuid, seteuid, setresuid, getresuid

                    get set

                    nothing = real

                    e = effective

                    res = real, effective and save all at once

                #getgroups setgroups

                    set suplementary group ids

                #parent process

                    every process has information about its parent's id

                    #getppidprocess parent id
                    #getpgidprocess group id

        #data segment size

            #brkset
            #sbrkincrement. called if heap is not large enough on `malloc`

        #mount
        #umount

        #ipc

            #signals

                #signal
                #sigactionhandler gets more info than with signal
                #sys_pausewait for signal
                #alarmsend alarm signal in n secs

            #futex

                basis for semaphores and posix pthread mutexes

                #semaphores

                    shared integer resources that can be possessed and freed
                    indicating that other process may proceed

                    can be named or unnamed

                    in general each semaphore can have multiple values
                    (in real life they have 3!)

                    binary semaphore = a mutex

                    #semget
                    #semop
                    #semtimedop
                    #semctl

            #pipecreate pipe
            #pipe2pipe with flags

            #flockadvisory file lock

            #sockets

                main difference: can connect different computers!

                #accept
                #bind
                #socket
                #socketcall
                #socketpair
                #listen

            #shared memory

                TODO

            #memory queues

                TODO

        #memory

            #cacheflushflush instruction or data cache contents
            #getpagesizeget memory page size
