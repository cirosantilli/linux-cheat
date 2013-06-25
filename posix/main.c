/*
main cheat on the POSIX C API

#defines

    these are headers specified by posix

    on current ubuntu system this is implemented by the gnu c library:
    <http://www.gnu.org/software/libc/> says that POSIX compliance
    is a design goal of the gnu c library

    list of all headers: http://en.wikipedia.org/wiki/C_POSIX_library

    posix defines certain things **INSIDE**
    headers with the same name as the ansi stdlib ones
    which are only activated if you add the defines **before
    including those files**!!

    gcc: if you want to access them with the `-ansi -c99` flags,
    you need to define `XXX_XOPEN_SOURCE`

    TODO is there a windows implementation for those headers?

    there are other headers which may expose posix functions such as `_POSIX_C_SOURCE` and `POSIX_SOURCE`
    for `gcc`, see `man feature_test_macros` for an explanaition.

    the value refers to the actual posix version

    for example:

    - 500: issue 5, 1995
    - 600: issue 6, 2004
    - 700: issue 7, 2008

#TODO

    #ptrace

        one process (tracer) observes another process' (tracee) memory directly

        <http://mikecvet.wordpress.com/2010/08/14/ptrace-tutorial/>
*/

#define _XOPEN_SOURCE 700
//#define _POSIX_C_SOURCE 200112L
//#define POSIX_SOURCE

//#ansi headers

    //only stuff that becomes available with posix defines is commented here

#include <assert.h>
#include <math.h>           //M_PI, M_PI_2, M_PI_4:
#include <stdbool.h>
#include <stdio.h>          //popen(), perror()
#include <stdint.h>
#include <stdlib.h>
#include <string.h>         //strerror

//#posix only headers

#include <arpa/inet.h>
#include <errno.h>
#include <fcntl.h>          //file control options. O_CREAT,
#include <libgen.h>
//#include <limits.h>
#include <netdb.h>          //gethostbyname
#include <netinet/in.h>
#include <pthread.h>        //without this, one gets the glib.c version:
#include <pwd.h>            //getpwuid, getpwnam, getpwent
#include <regex.h>
#include <sys/resource.h>   //rusage, getrusage, rlimit, getrlimit
#include <sys/socket.h>
#include <sys/stat.h>       //S_IRUSR and family,
#include <sys/types.h>      //lots of posix realted typedef types
#include <sys/utsname.h>    //uname, struct utsname
#include <sys/wait.h>       //wait, sleep
#include <syslog.h>         //syslog
#include <unistd.h>         //major posix header. Anything that is not elsewhere is here.

extern char **environ;

int main(int argc, char** argv)
{
    /*
    #erros

        typical error dealing conventions POSIX are:

        - if the return value is not needed, functions return 0 on successs and either -1 on failure
            or an integer which indicates failure cause
        - if the return value is strictly positive, return a negative value on error
        - if the return value is a pointer, return `NULL` on error

        whenever there is an error, set `errno` accordingly to determine what was the cause of the erro

    #errno.h

        is defined by ANSI, but more predefined error constants are added extended in POSIX,
        and each error has a standard associated error message TODO check

        including functions that deal with the error messages

        some of the POSIX only errors are: TODO check that those are not in ansi c

        - EPERM: Operation not permitted
        - ENOENT: No such file or directory
        - EINTR: Interrupted system call
        - EIO: I/O Error
        - EBUSY: Device or resource busy
        - EEXIST: File exists
        - EINVAL: Invalid argument
        - EMFILE: Too many open files
        - ENODEV: No such device
        - EISDIR: Is a directory
        - ENOTDIR: Isn’t a directory

        those error descriptions are also programatically accessible through functions
        such as `perror` or `strerror`
    */
    {
        /*
        #errno

            errno can be modified by functions to contain a description of certain
            standard errors. TODO check: can user functions also modify errno?

            0 indicates no error (ANSI C)

            since any function may change errno, you must use the functions that
            depend on errno immediatelly after the function that generates the error
        */
        {
            //assure tmpdir does not exist
            struct stat s;
            if( stat( "tmpdir", &s ) == 0 )
                assert( rmdir( "tmpdir" ) != -1 );

            printf( "errno = %d\n", errno );

            rmdir( "tmpdir" );
            printf( "errno = %d\n", errno );

            //TODO why is errno unchanged even if the second rmdir worked?

            mkdir( "tmpdir", 0777 );
            rmdir( "tmpdir" );
            printf( "errno = %d\n", errno );
        }

        /*
        #perror

            print description of errno to stderr with given prefix appended, NULL for no prefix.
        */
        {
            perror( "perror" );

            //assure tmpdir does not exist
            struct stat s;
            if( stat( "tmpdir", &s ) == 0 )
                assert( rmdir( "tmpdir" ) != -1 );

            assert( unlink( "idontexist" ) == -1 );
            perror( "perror" );
        }

        /*
        #strerror

            returns a readonly pointer to the description of the error with the given number:

                char *strerror( int errnum );
        */
        {
            printf( "strerror(EISDIR) = \"%s\"\n", strerror(EISDIR) );
        }
    }

    /*
    #syslog

        writes error messages to standard system files

        interface:

            void syslog(int priority, const char *message, arguments...);

        error levels:

        - LOG_EMERG       Description
        - LOG_ALERT       An emergency situation
        - LOG_CRIT        High-priority problem, such as database corruption
        - LOG_ERR         Critical error, such as hardware failure
        - LOG_WARNING     Errors
        - LOG_NOTICE      Warning
        - LOG_INFO        Special conditions requiring attention
        - LOG_DEBUG       Informational messages

        error source:

        - LOG_USER: a user space application
        - LOG_LOCAL[0-7]: left for admins to specify

        message: accepts format strings similar to printf with extensions

        - %m: errno message string
    */
    {
        //TODO this breaks my poor program, why?

            //syslog( LOG_ERR | LOG_USER, "syslog test: %m\n");
    }

    /*
    #environment variables

        each process includes a list of its environment variables

        those can be modified for the process

        child processes inherit those variables, so this is a way
        for processes to communicate
    */
    {
        /*
        #getenv

            specified by ANSI C

        #setenv

            not specified by ANSI C TODO check

        #putenv

            don't use, just use `setenv` instead. POSIX 7 itself says this.
        */
        {
            assert( setenv( "HOME", "asdf", true ) != -1 );
            assert( strcmp( getenv( "HOME" ), "asdf" ) == 0 );

            //with overwrite false, if existing is not overwritten
            //but error is not returned:

                assert( setenv( "HOME", "qwer", false ) != -1 );
                assert( strcmp( getenv( "HOME" ), "asdf" ) == 0 );
        }

        /*
        #environ

            automatically set by POSIX libraries linked to

            is a list of strings of type `VAR=val`
        */
        if ( 0 ) //too much distracting output
        {
            //print entire environment
            char **env = environ;
            puts( "environ:" );
            while ( *env )
            {
                printf( "  %s\n", *env );
                env++;
            }
        }
    }

    /*
    #math.h

        the `M_PI` constants are defined by POSIX inside of math.h
    */
    {
        //ansi c way of calculating pi:
        const float pi = acos( -1 );

        assert( fabs( M_PI - pi ) < 1e-6  );
        assert( fabs( M_PI/2.0 - M_PI_2 ) < 1e-6  );
        assert( fabs( M_PI/4.0 - M_PI_4 ) < 1e-6  );
    }

    /*
    #sleep

        non busy sleep, that is, stop program execution for a given time,
        and let other programs run in the meantime.

        there is no portable standard way of doing this AFAIK
    */
    {
        for(int i=0; i<3; i++)
        {
            printf("%d",i);
            //sleep(1);
        }
    }

    /*
    open, close, write, file operations can do operations more specific
    than the corresponding ansi c `fopen`, `fclose`, etc functions

    if you don't need that greater level of control,
    just use the ansi functions for greater portability

    #open

        open file descriptors such as files

        returns an `int` (file descriptor number) instead of a file

        flags. Must specify one and only of the following:

        - O_WRONLY: write only
        - O_RDONLY: read only
        - O_RW: read only

        the following may all be specified:

        - O_APPEND: Place written data at the end of the file.
        - O_TRUNC: Set the length of the file to zero, discarding existing contents.
        - O_CREAT: Creates the file, if necessary, with permissions given in mode.
        - O_EXCL: Used with O_CREAT, ensures that the caller creates the file. The open is atomic; that is,
            it’s performed with just one function call. This protects against two programs creating the file at
            the same time. If the file already exists, open will fail.

        return value: `-1` on error.

        you can also use standard flags for permissions:

        - S_IRUSR: Read permission, owner
        - S_IWUSR: Write permission, owner
        - S_IXUSR: Execute permission, owner

        GRP for group versions
        OTH for other versions

    #write

        write to file descriptor, such as one gotten with `open`

        returns number of bytes written

        it writes as many bytes as possible

        if it receives a signal before writting, returns -1

    #read

        returns number of bytes read

        0 if at end of file descriptor already

        -1 if error
    */
    {
        int fd;
        char in[] = "open\n";
        int nbytes = strlen( in );
        char* out = malloc ( nbytes + 1 );

        fd = open( "open.tmp", O_WRONLY | O_CREAT, 0777 );
        if ( fd != -1 )
        {
            if ( write( fd, in, nbytes ) != nbytes )
            {
                assert( false );
            }
            close( fd );
        }
        else
        {
            assert( false );
        }

        fd = open( "open.tmp", O_RDONLY );
        if ( fd != -1 )
        {
            if ( read( fd, out, nbytes ) == nbytes )
            {
                assert( strcmp( in, out ) == 0 );
            }
            else
            {
                assert( false );
            }
            close( fd );
        }
        else
        {
            assert( false );
        }
    }

    //#pathname operations
    {
        //#realpath
        //{
        //    //resolves symlinks recursivelly
        //    char rp[PATH_MAX+1];
        //    char *r = realpath( ".", rp );
        //    if ( r )
        //    {
        //        printf( "realpath(\".\") = %s", rp );
        //    }
        //    else
        //    {
        //        assert(false);
        //    }
        //}

        /*
        #dirname #basename

            p may be modified memory is statically allocated
            and may change on next dirname/basename call.
            TODO what is p

            behaviour:

            path         dirname   basename
            ----------   --------  ---------
            "/usr/lib"   "/usr"    "lib"
            "/usr/"      "/"       "usr"
            "usr"        "."       "usr"
            "/"          "/"       "/"
            "."          "."       "."
            ".."         "."       ".."
        */
        {

            char p[1024];
            char* res;

            strcpy( p, "a/b" );
            res = dirname( p );
            assert( strcmp( res, "a" ) == 0 );

            strcpy( p, "a/b" );
            res = basename( p );
            assert( strcmp( res, "b" ) == 0 );
        }
    }

    /*
    #file and directory operations

        there is no standard portable way of doing most them:
        <http://www.devarticles.com/c/a/Cplusplus/Directories-in-Cplusplus/>

        posix alternatives:

        - portable semi heavyweight: booost: #include <boost/filesystem/operations.hpp>
        - portable lightweight: dirent.h
    */
    {
        /*
        #stat

            get info on paths

            return value: 0 on success, other constants on errors.

            if you get a 0, you know the file exists!

            this fills in the `struct stat` given by pointer

        #struct stat

            fields:

            - dev_t st_dev            Device ID of device containing file.
            - ino_t st_ino            File serial number.
            - mode_t st_mode          Mode of file (see below).
            - nlink_t st_nlink        Number of hard links to the file.
            - uid_t st_uid            User ID of file.
            - gid_t st_gid            Group ID of file.
            - dev_t st_rdev           Device ID (if file is character or block special).
            - off_t st_size           For regular files, the file size in bytes.

                                      For symbolic links, the length in bytes of the
                                      pathname contained in the symbolic link.

                                      For a typed memory object, the length in bytes.

                                      For other file types, the use of this field is
                                      unspecified.

            - struct timespec st_atim Last data access timestamp.
            - struct timespec st_mtim Last data modification timestamp.
            - struct timespec st_ctim Last file status change timestamp.

            - blksize_t st_blksize    A file system-specific preferred I/O block size
                                      for this object. In some file system types, this
                                      may vary from file to file.
            - blkcnt_t st_blocks      Number of blocks allocated for this object.

        #find if a file exists

            in *nix, you often cannot be sure if a file or directory exists,
            because to do that you must have permission to list all of its parent dirs.

            the only thing you can say is that a path is accessible or not.

            using stat is a good way to do that.
        */
        {
            char in[] = "123\n";
            char fname[] = "stat.tmp";
            int perms = 0777;
            struct stat s;

            //create the file
            int fd = open( fname, O_WRONLY | O_CREAT, perms );
            int nbytes = strlen( in );
            if ( fd != -1 )
            {
                if ( write( fd, in, nbytes ) != nbytes )
                    assert( false );
                else
                {
                    //assert that file exists:
                    assert( stat( fname, &s ) == 0 );

                    //view/assert the fields of the stat struct:
                    assert( s.st_size == nbytes );
                }
                close( fd );
            }
            else
            {
                assert( false );
            }
        }

        //#mkdir
        {
            struct stat s;
            char fname[] = "mkdir";

            //remove the file if it exists:
            if( stat( fname, &s ) == 0 )
                rmdir( fname );

            //make the dir and check for error:
            if( mkdir( fname, 0777 ) == -1 )
                assert( false );
        }

        //#rmdir
        {
            mkdir( "rmdir", 0777 );
            if( rmdir( "rmdir" ) == -1 )
                assert( false );
        }

        /*
        #unlink

            deletes file

            is called unlink because what you are doing is not to directly remove a file from disk
            but instead remove one hardlink for the data.

            if the number of hardlinks to a data equals 0, it gets deleted
        */
    }

    /*
    rusage stands for Resource usage

    the kernel allows processes to use a certain ammount of ressources such as
    memory or processor time

    exceeding those limits may lead the kernel to kill a processes
    */

    /*
    #getrusage

        returns the total time usage of current process (non sleeping/waiting)

            int getrusage(int who, struct rusage *r_usage);

        - who:

            - RUSAGE_SELF: only get information about current process
            - RUSAGE_CHILDREN: information includes both current process and chidren who are dead
                and are just waiting for the parent to call `wait()` on them.

                This makes sense here because the only thing that keeps their memory
                used up is the existance of the parent process.

        - r_usage: is the main return valu, and is set to contain a struct:

                struct rusage {
                    struct timeval ru_utime; // user time used
                    struct timeval ru_stime; // system time used
                };

            and `timeval` is of type:

                struct timeval {
                    time_t         tv_sec      Seconds. 
                    suseconds_t    tv_usec     Microseconds.
                };

        - return: 0 on success, -1 on error + errno set to exact error
    */
    {
        struct rusage usage;
        if ( getrusage( RUSAGE_SELF, &usage ) == -1 )
        {
            perror( "getrusage failed" );
            exit( EXIT_FAILURE );
        }
        else
        {
            printf(
                "user time      = %llu s %llu micro secs\n",
                (uintmax_t)usage.ru_utime.tv_sec,
                (uintmax_t)usage.ru_utime.tv_usec
            );
            printf(
                "system time    = %llu s %llu micro secs\n",
                (uintmax_t)usage.ru_stime.tv_sec,
                (uintmax_t)usage.ru_stime.tv_usec
            );
        }
    }

    /*
    #getrlimit

        returns the maximum value for a given resource

        there are two types of limits:

        - soft: can be increased by any process to any value lower than the hard maximum
        - hard: only processes with special privileges may increase the hard limit

        if a resource goes over the soft limit, the kernel may choose to kill the process

        interfaces:

            int getrlimit(int resource, struct rlimit *rlp);
            int setrlimit(int resource, const struct rlimit *rlp);

        - resource: see the docs for a description of each possible value

        - rlp: struct of type:

                struct rlimit {
                    rlim_t rlim_cur  // The current (soft) limit.
                    rlim_t rlim_max  // The hard limit.
                }

            where `rlim_t` is an unsigned integer
    */
    {
        struct rlimit limit;
        if ( getrlimit( RLIMIT_DATA, &limit ) == -1 )
        {
            perror( "getrlimit( RLIMIT_DATA, ... ) failed" );
            exit( EXIT_FAILURE );
        }
        else
        {
            //maximum process memory in bytes
            if ( limit.rlim_max == RLIM_INFINITY )
            {
                //RLIM_INFINITY means that no limit is imposed on the resource
                puts( "RLIMIT_DATA: no limit imposed" );
            }
            else
            {
                printf(
                    "RLIMIT_DATA\n  soft = %llu\n  hard = %llu\n",
                    (uintmax_t)limit.rlim_cur,
                    (uintmax_t)limit.rlim_max
                );
            }
        }

        //ok, enough of error checking from now on

        printf( "RLIM_INFINITY = %llu\n", (uintmax_t)RLIM_INFINITY );

        //maximum total cpu usage in seconds
        getrlimit( RLIMIT_CPU, &limit );
        printf(
            "RLIMIT_CPU\n  soft = %llu\n  hard = %llu\n",
            (uintmax_t)limit.rlim_cur,
            (uintmax_t)limit.rlim_max
        );

        //maximum file size in bytes
        getrlimit( RLIMIT_FSIZE, &limit );
        printf(
            "RLIMIT_FSIZE\n  soft = %llu\n  hard = %llu\n",
            (uintmax_t)limit.rlim_cur,
            (uintmax_t)limit.rlim_max
        );

        //number of file descriptors:
        getrlimit( RLIMIT_NOFILE, &limit );
        printf(
            "RLIMIT_NOFILE\n  soft = %llu\n  hard = %llu\n",
            (uintmax_t)limit.rlim_cur,
            (uintmax_t)limit.rlim_max
        );
    }

    /*
    #sysconf

        get lots of info on the system configuration

        meanings for the constants can be found under
        the `limits.h` and `unistd.h` corresponding variables
    */
    {
        //number of processors:

            printf( "_SC_NPROCESSORS_ONLN = %ld\n", sysconf( _SC_NPROCESSORS_ONLN ) );

        //maximum lengh of command line arguments + environment variables:

            printf( "_SC_ARG_MAX (MiB) = %ld\n", sysconf( _SC_ARG_MAX ) / ( 1 << 20 ) );
    }

    /*
    #user information

        once use have uids for processes, you can querry standard user information
        which was traditionally stored in the `/etc/passwd` file.
    */
    {
        /*
        #getpwuid

            you can get those information either by username or by uid:

                #include <pwd.h>

                struct passwd *getpwuid(uid_t uid);
                struct passwd *getpwnam(const char *name);

            the struct returned is:

                struct passwd {
                    passwd Member    // Description
                    char *pw_name    // The user’s login name
                    uid_t pw_uid     // The UID number
                    gid_t pw_gid     // The GID number
                    char *pw_dir     // The user’s home directory
                    char *pw_gecos   // The user’s full name
                    char *pw_shell   // The user’s default shell
                }

            which contains all the required user metadata specified by POSIX
        */
        uid_t uid = getuid();
        struct passwd* info = getpwuid( uid );
        if ( info == NULL )
        {
            perror( "getpwuid failed" );
            exit( EXIT_FAILURE );
        }
        else
        {
            puts( "getpwuid" );
            printf( "  pw_name        = %s\n", info->pw_name  );
            printf( "  pw_uid         = %d\n", info->pw_uid   );
            printf( "  pw_gid         = %d\n", info->pw_gid   );
            printf( "  pw_dir         = %s\n", info->pw_dir   );
            printf( "  pw_gecos       = %s\n", info->pw_gecos );
            printf( "  pw_shell       = %s\n", info->pw_shell );
        }

        /*
        #getpwuid

            iterate a list of all passwd structures

            first call gets the first, every call gets the next

            to start from beginning again do:

                void setpwent(void);

            when you are done, free any associated resources with:

                endpwent()
        */
        {
            puts( "all users:" );
            struct passwd* info;

            info = getpwent();
            while ( info != NULL )
            {
                printf( "  %s\n", info->pw_name  );
                info = getpwent();
            }
            endpwent();
        }
    }

    /*
    #terminal

        some POSIX functions deal with the controlling terminal which called the program if any

    #getlogin

        gets login name of controlling terminal

        note that this is different from getuid, since it looks at the controlling terminal,
        and not at processes specific information.
    */
    {
        char* login = getlogin();
        if ( login == NULL )
        {
            perror( "getlogin failed" );
        }
        else
        {
            printf( "getlogin() = %s\n", getlogin() );
        }
    }

    /*
    #uname

        you can get information about the current computer using `uname`

        unsurprisingly, it is the same information given by the POSIX utility `uname`
    */
    {
        struct utsname info;
        if ( uname( &info ) == -1 )
        {
            perror( "uname failed" );
            exit( EXIT_FAILURE );
        }
        else
        {
            puts( "uname" );
            printf( "  sysname   = %s\n", info.sysname   );
            printf( "  nodename  = %s\n", info.nodename  );
            printf( "  release   = %s\n", info.release   );
            printf( "  version   = %s\n", info.version   );
            printf( "  machine   = %s\n", info.machine   );
        }
    }

    //#process
    {
        /*
        #process info

            #getpid

                each process has an unique identifying integer called pid

            #getuid and getguid

                each process has user and user group information associated to it
                which determine what the process can or not

                there are two types of uid and gid: real and effective:

                - real is always of who executes the program

                - effective may be different depending on the suid and sgid bits

            #getpriority and nice

                each process, user and group has a priority associated to it

                those priorities are called *nice* values, since 
                the higher the nice, the less time it takes ( it is nicer to other processes)

                nice:

                    int nice( int incr )

                - incr: how much to increase the nice value
                - return: the new nice value after the increase

                getpriority:

                    int getpriority(int which, id_t who);
                    int setpriority(int which, id_t who, int priority);

                - which:

                    - PRIO_PROCESS: TODO what is the difference between this and nice?
                    - PRIO_PGRP: TODO what is this?
                    - PRIO_USER: TODO what is this?

                - who: pid, uid or gid depending on which. `0` means current.

                TODO what is the value range or priorities? POSIX says > 0, but I've read something
                    on linux I've heard of -20 to 20? what about that NZERO value mentioned in the docs?
                    where to get it?
        */
        {
            uid_t uid  = getuid();
            uid_t euid = geteuid();
            gid_t gid  = getgid();
            gid_t egid = getegid();
            pid_t pid = getpid();
            printf( "getpid()   = %llu\n",  (uintmax_t)pid     );
            printf( "getuid()   = %llu\n",  (uintmax_t)uid     );
            printf( "geteuid()  = %llu\n",  (uintmax_t)euid    );
            printf( "getgid()   = %llu\n",  (uintmax_t)gid     );
            printf( "getegid()  = %llu\n",  (uintmax_t)egid    );
            printf( "getpriority( PRIO_PROCESS, 0 )     = %d\n",  getpriority( PRIO_PROCESS,    0 ) );
            printf( "getpriority( PRIO_PGRP, 0 )        = %d\n",  getpriority( PRIO_PGRP,       0 ) );
            printf( "getpriority( PRIO_USER, 0 )        = %d\n",  getpriority( PRIO_USER,       0 ) );
            printf( "nice(0)    = %d\n",    nice( 0 ) );
            printf( "nice(0)    = %d\n",    nice( 0 ) );
            printf( "nice(1)    = %d\n",    nice( 1 ) );
            printf( "nice(0)    = %d\n",    nice( 0 ) );
        }

        //#execl, execlp, execsle, execv, execvp, execvpe
        {
            /*
            interfaces for ``execve`` system call

            execute and *leave*, ends current process!!

            common combo: fork + execl

            this is effective because of COW implemented on some systems:
            memory will only be copied to new process if needed, and in this case it is no needed.

            takes variable number or args

            must end null terminated

            versions:

            - char 'p': path, uses PATH var to find executable
            - TODO: char 'v', char 'e'? what's the difference?

            sample calls:

                execl( "/bin/ls", "-l", "-h", NULL );

                execlp( "ls", "-l", "-h", NULL );

                execlp( "cprogram", "cprogram", "arg0", NULL );

            don't forget that in a c program the first arg is the program name
            */
        }

        /*
        #waitpid()

            wait for child with given PID to terminate
        */

        /*
        #IPC

            inter process communication

            the basic ways are:

            at startup:

            - command line arguments
            - environment variables

            during execution:

            - pipes
            - regular files
            - signals
            - shared memory
            - sockets
        */
        {
            //#pipes
            {
                /*
                //#unnamed

                    unidirectional child ----> parent transfer

                    single process must start two children process: data source and the data consumer
                    and connect them

                    advantages over files:

                    - simple: no need to agree on a filename to communicate over
                    - fast: no need to modify the filesystem or worse: do disk io!
                    - secure: other process cannot se the data as they could in a file

                    data very limited per buffer! BUFSIZ ~= 1000-10000 today,
                    and the only guarantee is being at least 256 bytes wide.

                    i think it is not possible to know if a file pointer
                    is open for reading or writtin besides looking at how
                    it was created

                    workflow:

                    - child fills the buffer, then parent takes control
                    - child fills ...
                */

                /*
                #BUFSIZ

                    implementation dependant

                    in practice you could read/write much more than that,
                    but BUFSIZ is a good value

                    - fast
                    - not larger than the maximum

                    so in practice you will should just use this value as a maximum.

                    if you try to read write more than the max,
                    it just flushes all when the buffer gets filled

                    the larger the buffer the faster the transfer

                    the only guarantee is BUFSIZ >= 256

                    if you want to be very portable, you must design systems
                    whose messages need no more than 256 bytes at a time

                    with such a system, you could just pass many 256 chunks at once
                    if your large buffer allows (of course, it is likelly that each of
                    those 256 chunks will conatain its own header information)
                */
                {
                    fprintf( stderr, "BUFSIZ = %llu", (intmax_t) BUFSIZ );
                    assert( BUFSIZ >= 256 );
                }

                /*
                #popen

                    consider using ansi c `system` instead of this.

                    opens a new process running the given command.

                    given string runs inside `sh` in a separated process and therefore it is:

                    - slow
                    - does magic stuff like pathname expansion (`*.txt`)
                    - harder to port to non posix systems if one day you decide to do that

                    it seems from the posix docs that the interpreter `sh` cannot be changed.

                    Unlike the ANSI C `system` function,
                    does not automatically wait for the command to return: see `pclose` for that.

                    For that reason, `popen` is slightly more general than `system`,
                    as you can do more work in the current program begore getting the shell output.

                    This is not however extremelly useful since you usually need the shell output
                    to continue working anyways.

                    The output of peopen is put on an unnamed pipe, which is accessible via
                    ANSI C FILE type returned by the function, instead of posix file descriptor (integers)

                    Therefore you must use ANSI C file io functions like `fopen` or `fclose` with it,
                    instead of the more low level POSIX `open` or `write` family.

                #pclose

                    waits for child generated process.

                    returns child exit status.

                    if child was already waited for, returns -1 to incate an error.
                */
                {

                    {
                        //read from command
                        //get its exit staus

                            FILE* read_fp;

                        char buffer[BUFSIZ + 1];
                        char cmd[1024];
                        int chars_read;
                        int exit_status;
                        int read_cycles = 0;
                        int desired_read_cycles = 3;
                        int desired_last_char_read = 1;
                        assert( desired_last_char_read < BUFSIZ );

                        sprintf(
                            cmd,
                            "for i in `seq %llu`; do echo -n a; done",
                            (uintmax_t)(desired_read_cycles-1) * BUFSIZ + desired_last_char_read
                        );
                        read_fp = popen( cmd, "r" );
                        if ( read_fp != NULL )
                        {
                            do
                            {
                                //yes uses ANSI C fread which uses ANSI C FILE type:

                                    chars_read = fread( buffer, sizeof( char ), BUFSIZ, read_fp );

                                buffer[chars_read] = '\0';
                                printf( "======== n bytes read: %d\n", chars_read );
                                //printf( "%s\n", buffer); //if you want to see a bunch of 'a's...
                                read_cycles++;
                            } while ( chars_read == BUFSIZ );
                            exit_status = pclose( read_fp );
                            assert( read_cycles == desired_read_cycles );
                            assert( chars_read == desired_last_char_read );
                            assert( exit_status == 0 );
                        }
                        else
                        {
                            fprintf( stderr, "could not open pipe" );
                            exit( EXIT_FAILURE );
                        }
                    }

                    //write to stdin of command
                    {
                        FILE* write_fp;
                        char buf[BUFSIZ];
                        int exit_status;

                        memset( buf, 'c', BUFSIZ );
                        write_fp = popen( "cat; echo", "w" );
                            //w for write
                            //simply copies to stdout and adds newline
                        if( write_fp != NULL )
                        {
                            fwrite( buf, sizeof(char), BUFSIZ, write_fp );
                            /*
                            #pclose

                                waits for child

                                returns child exit status

                                if child already waited for,
                                returns -1: error
                            */
                            exit_status = pclose( write_fp );
                            assert( exit_status == 0 );
                        }
                        else
                        {
                            assert( false );
                        }
                    }
                }

                /*
                #pipe()

                    very close to the linux pipe system call

                    differences from popen:

                    - does not use a shell, avoiding many of its problems

                    - uses integer file descriptors instead of ANSI C FILE type
                        therefore you manipulate pipes with file descriptor functions
                        like `open` and `write` instead of ANSI C `fopen` family.

                        This potentially gives you more control over the operations.

                    it may however be a bit harder to setup

                    typically used with fork + exec
                */
                {
                    {
                        int nbytes;
                        int pipes[2];
                            //note the integers
                            //for file descriptors
                        char data[] = "123";
                        char buf[BUFSIZ + 1];
                        if ( pipe(pipes) == 0 )
                        {
                            nbytes = write( pipes[1], data, strlen(data) );
                                //cannot use the c standard fwrite
                                //dealing with posix specific file desciptors here
                                //#write

                                    //system calls

                                    //returns the number of bytes written
                                    //it may be less than the desired if there is not
                                    //enough space on medium

                                    //if does not write enough TODO
                                    //guess you have to do another call
                            assert( nbytes = strlen(data) );
                            nbytes = read( pipes[0], buf, BUFSIZ);
                            assert( nbytes = strlen(data) );
                            buf[nbytes] = '\0';
                            assert( strcmp( buf, data ) == 0 );
                        }
                        else
                        {
                            assert(false);
                        }
                    }

                    //#fork
                    {
                        //parent writes to child

                        //this works because if ever read happens before,
                        //it blocks

                        int nbytes;
                        int file_pipes[2];
                        const char data[] = "123";
                        char buf[BUFSIZ + 1];
                        pid_t pid;
                        if ( pipe( file_pipes ) == 0 )
                        {
                            fflush(stdout);
                            pid = fork();
                            if ( pid == -1 )
                            {
                                assert(false);
                            }
                            else if ( pid == 0 )
                            {
                                nbytes = read( file_pipes[0], buf, BUFSIZ );
                                printf( "pipe child. data: %s\n", buf );
                                exit(EXIT_SUCCESS);
                            }
                            else
                            {
                                nbytes = write( file_pipes[1], data, strlen(data) );
                                assert( nbytes == strlen(data) );
                                strlen(data);
                            }
                        }
                        else
                        {
                            assert(false);
                        }
                    }
                }

                //#FIFO
                {
                    //aka named pipes

                    //appear on the filesystem

                    //therfore can be accessed as by any process

                    //are however faster than writting to files,
                    //since everything happens on RAM

                    //cannot open for rw

                    //application: simple client/servers!

                    //#mkfifo

                        //TODO 0
                }
            }
        }
    }

    /*
    #threads

        posix threads

        c11 will introduce a standard threading model,
        so in time this may become less important

        each thread has its own stack, but unlike process, global memory is shared

        quicker to start than a process because less resource copy is needed

        in Linux, based on the `clone` system call
    */
    {
        /*
        #clone

            very thin wrapper to the linux system clal

            like ``vfork``, but with shared memory and open file descriptors

            TODO where is this on POSIX? can't find it
        */
        {

            /*puts("clone");*/
            /*{*/
                /*TODO*/
                /*implicit? with unistd.h?*/
                /*i = 0;*/
                /*pid_t pid = clone();*/
                /*if (pid == 0)*/
                /*{*/
                    /*i++;*/
                /*}*/
                /*else if (pid < 0)*/
                /*{*/
                    /*exit(1);*/
                /*}*/
                /*wait(&status);*/
                /*if( pid == 0 )*/
                /*{*/
                    /*return EXIT_SUCCESS;*/
                /*}*/

                /*//no more child process*/
                /*assert( status == EXIT_SUCCESS );*/
                /*assert( i == 1 );*/
            /*}*/
        }

        //#pthread.h
        {
            //library, probably based on clone
        }
    }

    /*
    #netdb.h

        network information

    */
    {
        /*
        #gethostname

            copies name of current host on given string

                int gethostname( char* hostname, int namelength );

            name is truncated to namelength if too large
        */
        {
            const int namelength = 256;
            char hostname[namelength];
            gethostname( hostname, namelength );
            printf( "gethostname = %s\n", hostname );
        }

        /*
        #gethostbyname

            give a hostname string ("localhost", "john") and get info on that host

                struct hostent *gethostbyname(const char *name);

            return value:

                struct hostent {
                    char *h_name;       // name of the host
                    char **h_aliases;   // list of aliases (nicknames)
                    int h_addrtype;     // address type
                    int h_length;       // length in bytes of the address
                    char **h_addr_list  // list of address (network order)
                };

            NULL on error

        #gethostbyaddr

            same as gethostbyname but by address
        */
        {
            const int namelength = 256;
            char hostname[namelength];
            char** names;
            char** addrs;
            struct hostent* hostinfo;

            gethostname( hostname, namelength );
            hostinfo = gethostbyname( hostname );
            if ( !hostinfo )
            {
                fprintf( stderr, "gethostbyname failed for hostname = %s\n", hostname );
                exit( EXIT_FAILURE );
            }
            printf( "gethostbyname\n" );
            printf( "name: %s\n", hostinfo -> h_name );
            printf( "aliases:\n" );
            names = hostinfo -> h_aliases;
            while ( *names )
            {
                printf( "  %s\n", *names );
                names++;
            }
            //assert that it is an inet address
            if ( hostinfo -> h_addrtype != AF_INET )
            {
                fprintf( stderr, "host is not AF_INET\n" );
                exit( EXIT_FAILURE );
            }

            //show addresses
            printf( "IPs:\n" );
            addrs = hostinfo -> h_addr_list;
            while ( *addrs )
            {
                /*
                #inet_ntoa

                    converts integer representation of ip (4 bytes) to a string

                    also corrects network byte ordering into correct representation
                */
                printf( "  %s", inet_ntoa( *(struct in_addr*)*addrs ) );
                addrs++;
            }
            printf( "\n" );
        }

        /*
        #getservbyport

            posix requires that systems must keep a database containing strings
            that describe which service (provided by a server) is available at each port

                #include <netdb.h>

                struct servent *getservbyport(int port, const char *proto);

            this function uses that database to get info on such a service

                struct servent {
                    char *s_name;
                    char **s_aliases;
                    int s_port;
                    char *s_proto;
                };

        #getservbyname

            same as getservbyport but using the service name itself

                #include <netdb.h>

                struct servent *getservbyname(const char *name, const char *proto);
        */
    }

    return EXIT_SUCCESS;
}
