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
#include <limits.h>         //NZERO
#include <math.h>           //M_PI, M_PI_2, M_PI_4:
#include <stdbool.h>
#include <stdio.h>          //popen(), perror()
#include <stdint.h>
#include <stdlib.h>
#include <string.h>         //strerror

//#posix only headers

#include <arpa/inet.h>
#include <dirent.h>
#include <errno.h>
#include <fcntl.h>          //file control options. O_CREAT,
#include <libgen.h>
#include <netdb.h>          //gethostbyname
#include <netinet/in.h>
#include <pthread.h>
#include <pwd.h>            //getpwuid, getpwnam, getpwent
#include <regex.h>
#include <sched.h>
#include <sys/resource.h>   //rusage, getrusage, rlimit, getrlimit
#include <sys/socket.h>
#include <sys/stat.h>       //S_IRUSR and family,
#include <sys/types.h>      //lots of posix realted typedef types
#include <sys/utsname.h>    //uname, struct utsname
#include <sys/wait.h>       //wait, sleep
#include <syslog.h>         //syslog
#include <unistd.h>         //major posix header. Anything that is not elsewhere is here.

extern char **environ;

/* pthreads related */

#define NUM_THREADS      5

    pthread_mutex_t main_thread_mutex = PTHREAD_MUTEX_INITIALIZER;

    void* main_thread( void* vargument )
    {
        int argument;

        argument = *((int*)vargument);

        pthread_mutex_lock( &main_thread_mutex );
        printf( "tid = %d\n", argument );
        //all threads of a process have the same PID
        printf( "  getpid() = %llu\n", (uintmax_t)getpid() );
        printf( "  pthread_self() = %llu\n", (uintmax_t)pthread_self() );
        pthread_mutex_unlock( &main_thread_mutex );

        return NULL;
    }

int main( int argc, char** argv )
{
    /*
    #errors

        Typical error dealing conventions POSIX are:

        - if the return value is not needed, functions return 0 on successs and either -1 on failure
            or an integer which indicates failure cause

        - if the return value is strictly positive, return -1 on error

        - if the return value is a pointer, return `NULL` on error

        - if the return value can be any integer (`ptrace` for example), return `-1`, but force the user to
            clear `errno` before making the call, and check if `errno != -` after the call.

        Whenever there is an error, set `errno` accordingly to determine what was the cause of the erro

    #errno.h

        Is defined by ANSI, but more predefined error constants are added extended in POSIX,

        In POSIX, each error has a standard associated error message
        which can be retreived and printed with functions such as `perror`.

        Some of the POSIX specific errors and their error messages are: TODO check that those are not in ansi c

        - EPERM: Operation not permitted

            when users try to do something which requires previledges that they don't have,
            such as being the root user.

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

        Functions that modify errno document that. The convention is that only functions which fail modify
        errno, not those that succeed.

        errno can be modified as `errno = 0` for example.
    */
    {
        /*
        #errno

            errno can be modified by functions to contain a description of certain
            standard errors. TODO check: can user functions also modify errno?

            0 indicates no error (ANSI C)

            Since many function may change errno, you must use the functions that
            depend on errno immediatelly after the function that generates the error
        */
        {
            char *dirname = "i_dont_exist";

            //assure that dirname does not exist
            if( access( dirname, F_OK ) == 0 )
                assert( rmdir( dirname ) != -1 );
            errno = 0;

            rmdir( dirname );
            assert( errno != 0 );

            //sucessful calls do *not* set errno to 0
            mkdir( dirname, 0777 );
            rmdir( dirname );
            assert( errno != 0 );
        }

        /*
        #perror

            print description of errno to stderr with given prefix appended, `NULL` for no prefix.

            *base* basic way to print error messages after error on a posix function
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
    #printf

        This discusses `printf` and `sprintf` extensions.
    */
    {
        /*
        #dollar

            `%2$d` means: use second argument. Treat the following arguments as if this one did not exist.

            Has been incorporated in POSIX, but may break ANCI C code! (unlikely).

            For that reason, compiling this generates warnings on gcc, and you should avoid this feature as:

            - it is unlikely to be incorporated in ANSI C since it is a breaking change

            - if you ever decide to increase portability to ANSI C
                (in case some other key functions you were using someday get ANSI C alternatives),
                you will have to correct this
        */
        {
            //char buf[256];
            //sprintf( buf, "%2$d %d %d", 0, 1 );
            //assert( strcmp( buf, "1 0 1") == 0 );
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
        //#constants
        {
            //ansi c way of calculating some constants:
                const float PI = acos( -1 );
                const float E = exp( 1 );

            //POSIX provides macros that expand to those constants:
                assert( fabs( M_E - E ) < 1e-6  );
                assert( fabs( M_PI - PI ) < 1e-6  );
                assert( fabs( M_PI/2.0 - M_PI_2 ) < 1e-6  );
                assert( fabs( M_PI/4.0 - M_PI_4 ) < 1e-6  );
        }

        /*
        #bessel

            As of POSIX 7, the only major function addition to the math library
            seems to be bessel functions.

            TODO understand, specially why is it so important to be here?

            <http://en.wikipedia.org/wiki/Bessel_function>
        */
        {
            //double      j0(double);
            //double      j1(double);
            //double      jn(int, double);
        }
    }

    /*
    #sleep

        Non busy sleep, that is, stop program execution for a given time,
        and let other programs run in the meantime.

        There is no portable standard way of doing this.
    */
    {
        printf( "sleep:\n" );
        for(int i=0; i<3; i++)
        {
            printf( "%d\n", i );
            //sleep( 1 );
        }
        printf( "\n" );
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
        /*
        #realpath

            Return:

            - absolute path
            - cannonical: does not contain `.` nor `..`.

            Interface:

                char *realpath(const char *restrict file_name,
                    char *restrict resolved_name);

            The function does completelly different things depending if resolved_name is NULL or not:

            - `resolved_name == NULL`: realpath mallocs the path for you and returns it.

                You have to free it in the future.

                This is a good options if you don't already have a buffer of the right size, since calculating the required buffer size
                would be annoying ( would require calling `pathconf` ).

            - `resolved_name == NULL`: the pathname is copied to `resolved_name`.

                You must make sure that you have enough space there.

                This is a good option if you already have a large enough buffer laying around,
                since it does not require dynamic allocation.

                Of course, ensuring that your buffer is large enough means doing messy `pathconfs` at some point.
        */
        {
            char *rp = realpath( ".", NULL );
            if ( rp )
            {
                printf( "realpath(\".\") = %s\n", rp );
            }
            else
            {
                perror( "realpath" );
                assert(false);
            }
            free( rp );
        }

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
        #stat family

            get info on paths

            return value: 0 on success, other constants on errors.

            If you get a 0, you know the file exists!
            This is not however the best way to check if a file exists since it incurs the large overhead
            of getting the parameters. Use access for that instead.

            This fills in the `struct stat` given by pointer.

            The family contains the following variants:

            - stat: takes string path. Grouped under fstatat.
            - lstat: does not dereference symbolic links. Grouped under fstatat.
            - fstat: takes fd.
            - fstatat: can't understand, does not seem important.

        #struct stat

            fields:

            - dev_t st_dev            Device ID of device containing file.
            - ino_t st_ino            File serial number.
            - mode_t st_mode          Mode of file
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

        /*
        #access

            Check if file or directory exists and or has a given permission (rwx):

            - R_OK
            - W_OK
            - X_OK
            - F_OK: file exists

            If the access is not permitted, errno is still set even if this call did not give an error.
        */
        {
            char *exist = realpath( ".", NULL );
            if( access( exist, F_OK ) == -1 ) {
                perror( "access" );
                assert(false);
            }
            free( exist );

            char *dont_exist = "/i/dont/canot/must/not/exist.asdf";
            if( access( dont_exist, F_OK ) == -1 ) {
                perror( "access( dont_exist, F_OK )" );
            } else {
                assert(false);
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

        /*
        #opendir

            Open a directory for reading.

        #readdir

            Get next directory entry, or NULL if over.
        */
        {
            DIR* dp;
            struct dirent* entry;

            dp = opendir( "." );
            if ( dp == NULL )
            {
                perror( "opendir" );
            }
            else
            {
                printf( "opendir:\n" );
                while ( ( entry = readdir( dp ) ) != NULL )
                {
                    printf( "  %s\n", entry->d_name );
                }
            }
        }
    }

    /*
    #getrusage

        rusage stands for Resource usage

        the kernel allows processes to use a certain ammount of ressources such as
        memory or processor time

        exceeding those limits may lead the kernel to kill a processes

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
    #limits.h

        This header exists in ANSI C, and POSIX extends it with several values.

        Defines current and possible maximuns, minimums for several resources.

        Some resources cannot cannot be evaluated statically.

        For example the maximum path length depends on which directory we are talking about,
        since diferent directories can be on differnet mount points.

        Also some resources can change maximum values at anytime while the program is executing.

        In those cases, limits defines a KEY value which can be passed to a function that gets
        the actual values for a given key, for example pathconf or sysconf.

        For resources that have fixed values, this header furnishes them directly.
    */
    {
        //static macros
        {
            //maximum length of
            printf( "NL_ARGMAX = %d\n", NL_ARGMAX );
        }

        /*
        #sysconf

            get lots of info on the system configuration

            meanings for the constants can be found under
            the `limits.h` and `unistd.h` corresponding variables

        #maximum path length

            This is needed often when you need to deal with paths names.

            Sources:

            - <http://stackoverflow.com/questions/2285750/size-of-posix-path-max>

            Keep in mind that this value can vary even while a program is running,
            and depends of the underlying filesystem, and therefore of the direcotory you are in.

            As a consequence of this, it does not make sense to have a macro constant and use it to create
            fixed variable arrays: a function is needed, and memory must be allocated with malloc.
        */
        {
            //number of processors:

                printf( "_SC_NPROCESSORS_ONLN = %ld\n", sysconf( _SC_NPROCESSORS_ONLN ) );

            //maximum lengh of command line arguments + environment variables:

                printf( "_SC_ARG_MAX (MiB) = %ld\n", sysconf( _SC_ARG_MAX ) / ( 1 << 20 ) );
        }

        /*
        #pathconf

            Similar to sysconf, but for parameters that depend on a path, such as maxium filename lengths.
        */
        {
            //max basename in given dir including trailling null:

                printf( "pathconf( \".\", _PC_NAME_MAX) = %ld\n", pathconf( ".", _PC_NAME_MAX) );

            //max pathname in (TODO this is per device?)

                printf( "pathconf( \".\", _PC_PATH_MAX) = %ld\n", pathconf( ".", _PC_PATH_MAX) );
        }
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
        {
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

    /*
    #process info

        #getpid

            each process has an unique identifying integer called pid

        #getuid

            each process has user information associated to it
            which determine what the process can or not

            there are two types of uid and gid: real and effective:

            - real is always of who executes the program

            - effective may be different depending on the suid and sgid bits

        #getguid

            like getuid but for user group

        #setuid

            sets the user id if you have the priviledges

        #getppid

            Gets paren't pid.

        It seems that it is not possible to list all children of a process in POSIX:
        <http://stackoverflow.com/questions/1009552/how-to-find-all-child-processes>
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
        printf( "getppid()  = %llu\n",  (uintmax_t)getppid() );

        /*
        #getcwd

            pwd

        #root directory

            As of POSIX 7, this concept is not available.

            It is implemented as a Glibc extension under `_BSD_SOURCE`.
        */
        {
            const int n = 1 << 10;
            char buf[n];
            if ( getcwd( buf, n ) == NULL )
            {
                perror( "getcwd" );
            }
            else
            {
                printf( "getcwd() = %s\n", buf );
            }
        }

        /*
        #getpriority

            Each process, user and group has a priority associated to it.

            Those priorities are commonly called *nice* values on UNIX, since 
            the higher the nice, the less time it takes ( it is nicer to other processes)

            POSIX does not fix the nice range, but it does specify that:

            - lower values are more favorable
            - the values must be between `-{NZERO}` and x{NZERO}-1`.

            where NZERO is a paremeter that can be reterived with TODO

            The minimum value for NZERO if 20, it is also the most common.

            The actual effect of priority is undefined.

            Nice:

                int nice( int incr )

            - incr: how much to increase the nice value
            - return: the new nice value after the increase

            getpriority:

                int getpriority(int which, id_t who);

            - which:

                - PRIO_PROCESS:
                - PRIO_PGRP: TODO
                - PRIO_USER: TODO

            - who: pid, uid or gid depending on which. `0` means current.

            #error checking

                On error, returns `-1` and errno set to indicate the error.

                Therefore simply checking the return value is not enough to detect an error
                since `-1` is a valid return value.

                Therefore, to do error checking one *must* check `errno != 0`:

                - set `errno = 0`
                - make the call
                - there is an error iff ret = -1 errno != 0.

        #setpriority

            Return value is the same as getpriority after the modification.

        #nice

            Same as setpriority, but only for `PRIO_PROCESS` but increments (or decrements) the value instead of setting it to an absolute value.

            Return value is the same as getpriority after the modification.
        */
        {
            int prio;

            printf( "NZERO = %d\n", NZERO );

            errno = 0;
            prio = getpriority( PRIO_PROCESS, 0 );
            if ( prio == -1 && errno != 0 ) {
                perror( "getpriority( PRIO_PROCESS, 0 )" );
            } else {
                printf( "getpriority( PRIO_PROCESS, 0 ) = %d\n",  prio );
            }

            errno = 0;
            prio = getpriority( PRIO_PGRP, 0 );
            if ( prio == -1 && errno != 0 ) {
                perror( "getpriority( PRIO_PGRP, 0 )" );
            } else {
                printf( "getpriority( PRIO_PGRP, 0 ) = %d\n",  prio );
            }

            errno = 0;
            prio = getpriority( PRIO_USER, 0 );
            if ( prio == -1 && errno != 0 ) {
                perror( "getpriority( PRIO_USER, 0 )" );
            } else {
                printf( "getpriority( PRIO_USER, 0 ) = %d\n",  prio );
            }

            errno = 0;
            prio = nice( 0 );
            if ( prio == -1 && errno != 0 ) {
                perror( "nice( 0 )" );
            } else {
                printf( "nice( 0 )    = %d\n",    nice( 0 ) );
            }

            //ok, tired of erro checking:
            printf( "nice( 0 )    = %d\n",    nice( 0 ) );
            printf( "nice( 1 )    = %d\n",    nice( 1 ) );
            printf( "nice( 0 )    = %d\n",    nice( 0 ) );
        }
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
    #fork

        makes a copy of this process

        this includes open file descriptors

        global memory space (`.DATA` and `.BSD`) is copied to current value but separated
        (unlike threads, which share memory space)

        #fork and buffering

            <http://stackoverflow.com/questions/3513242/working-of-fork-in-linux-gcc>

            there are three buffering methods:

            - unbuffered
            - fully buffered
            - line buffered

            when you fork, the streams get forked too,
            with unflushed data still inside

            stdout and stderr flush at newlines
            if you don't put newlines, if does not flush,
            and fork copies the buffers


            this will print everything twice

    #vfork

        fork but keep same address space. POSIX 7 discourages its use,
        and says that it may be deprecated in the future

    #wait()

        wait for any child to terminate and then wake up

    #waitpid()

        wait for child with given PID to terminate

    #copy on write #COW

        often the fork is followed by an operation which does not use the old memory
        such as `exec`, making copying the data useless.

        some operating systems may at first not copy memory from old process,
        but wait util memory is written to do that.

        this has page granularity (physical RAM parameter, larger than most variables)
    */
    {
        //this variable will be duplicated on the parent and on the child
        int i = 0;

        //this variable is visible only by the parent
        //TODO is the compiler smart enough not to duplicate this to the child?
        {
            //int i = 0;
        }

        //happens on parent only and before child:
        puts( "fork parent only before child" );

        //flush before fork so that existing output won't be repeated twice:
        fflush( stdout );

        //in case of success, pid is set differently on parent and child
        //so you can distinguish between them. For the child, `pid = 0`.
        pid_t pid = fork();
        if ( pid < 0 )
        {
            puts( "fork failed" );
            assert( false );
        }
        else
        {
            //happens on both child and parent
            puts( "fork child and parent" );
            printf( "pid = %d, i = % d\n", pid, i );

            //happens on child only:
            if ( pid == 0 )
            {
                /*
                this puts is assynchonous with the process stdout

                so it might not be in the line program order

                but they both go to the same terminal
                */
                puts( "fork child only" );

                //this shall only change the child's `i` because memory was cloned (unlike threads)
                i++;

                //the child exits here:
                exit( EXIT_SUCCESS );
            }

            //happens on parent only, before or after child.
            puts( "fork parent only" );

            //parent waits for the child to end.
            //only the parent reaches this point because of the exit call
            //done on the child above
            int status;
            wait( &status );
            assert( status == EXIT_SUCCESS );

            //happens on parent and only after child:
            puts( "fork parent only after child" );

            //memory was cloned, parent i was only modified in child memory
            assert( i == 0 );
        }
    }

    /*
    #process synchronization

        Threads can be synchronized via:

        - semaphores

        - mutexes

        Threads have the specific synchronization mechanisms:

    #semaphore

    #mutex
    */

    /*
    #threads

        See pthread.

    #pthread

        Sources:

        - <https://computing.llnl.gov/tutorials/pthreads/>

        Posix threads.

        Complex model with around 100 functions prefixed by `pthread`.

        c11 will introduce a standard threading model,
        so in time this may become less important

        Each thread has its own stack, but unlike process, global memory is shared.

        Quicker to start than a process because less resource copy is needed.

        In Linux, based on the `clone` system call.

        In gcc you must compile with `-pthread`.

    #thread synchronization mechanisms

        - mutexes - Mutual exclusion lock: Block access to variables by other threads.
            This enforces exclusive access by a thread to a variable or set of variables.

        - joins - Make a thread wait till others are complete (terminated).

        - condition variables - data type pthread_cond_t

        Good tutorial: <http://www.yolinux.com/TUTORIALS/LinuxTutorialPosixThreads.html#SYNCHRONIZATION>

    #pthread_create

        Create a new thread.

            int pthread_create(
                pthread_t *restrict thread,
                const pthread_attr_t *restrict attr,
                void *(*start_routine)(void*),
                void *restrict arg
            )

            - thread:

                unique id of the created thread

                can be retreived from the thread with `pthread_self()`

                In POSIX all threads of a process have the same PID. TODO confirm with reference

            - attr:
            - start_routine:    function that runs the thread code
            - arg:              argument to start_routine

    #pthread_join

        Wait for a given thread to terminated.

        If it has already terminated, does not wait.

    #pthread_self

        Get thread id of current running thread.

        vs linux gettid: <http://stackoverflow.com/questions/6372102/what-is-the-difference-between-pthread-self-and-gettid-which-one-should-i-u>

    #pthread_mutex methods

        Allows a single thread to enter some code region.

        #PTHREAD_MUTEX_INITIALIZER

            New pthread_mutex_t should be initialized to it.

        #pthread_mutex_lock

            Acquire mutex: from now one no one else can enter.

        #pthread_mutex_unlock

            Release mutex: from now one others can enter.
    */
    {
        pthread_t threads[NUM_THREADS];
        int thread_args[NUM_THREADS];
        int rc, i;

        /* create all threads */
        for ( i = 0; i < NUM_THREADS; ++i )
        {
            thread_args[i] = i;
            rc = pthread_create( &threads[i], NULL, main_thread, (void *) &thread_args[i] );
            assert( rc == 0 );
            printf( "created thread: %ju\n", (uintmax_t)threads[i] );
        }

        /* wait for all threads to complete */
        for ( i = 0; i < NUM_THREADS; ++i )
        {
            rc = pthread_join( threads[i], NULL );
            if( rc != 0 ) {
                printf( "%s\n", strerror( rc ) );
                exit( EXIT_FAILURE );
            }
        }
    }

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

    /*
    #pipe

        pipes can be either unnamed (more common) or nammed
    */
    {
        /*
        #unnamed pipe

            unidirectional child ----> parent transfer

            can be created either via `popen` or `pipe`

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

            a measure of the ideal maxinum ammount of that that
            should should be written/read to a pipe at a time for good performance.

            in practice you could read/write much more than that,
            but BUFSIZ is a good value:

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
            printf( "BUFSIZ = %ju\n", (uintmax_t) BUFSIZ );
            assert( BUFSIZ >= 256 );
        }

        /*
        #popen

            creates unnamed pipes

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

            if child was already waited for, returns -1 to indicate an error.
        */
        {
            //read from command and get exit status
            {
                //popen uses ANSI C fread which uses ANSI C FILE type:
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
                    "for i in `seq %ju`; do echo -n a; done",
                    (uintmax_t)(desired_read_cycles-1) * BUFSIZ + desired_last_char_read
                );
                read_fp = popen( cmd, "r" );
                if ( read_fp != NULL )
                {
                    do
                    {
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
                    printf( "could not open pipe" );
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
        #pipe

            create unnamed pipes

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

            /*
            parent writes to child

            this works because if ever read happens before, it blocks
            */
            {

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

        /*
        #FIFO

            aka named pipes

            appear on the filesystem

            therefore can be accessed as by any process who sees it
            and has enough priviledge level

            are however faster than writting to files,
            since everything happens on RAM

            cannot open for rw

            application: simple client/servers!

            created with mkfifo

        #mkfifo

            used to create a FIFO
        */
        {
                //TODO example
        }
    }

    /*
    #sched.h

        get or set scheduler information

        posix 7 specifies four scheduling policies, more can be defined by the implementation

        - fifo: first in first out. Process runs untill it finishes.
        - rr: round robin. Assign time slices and turn around the pie.
        - other:

    #sched_getscheduler

        pid_t for given pid, 0 for current process
    */
    {
        printf( "SCHED_FIFO     = %d\n",  SCHED_FIFO      );
        printf( "SCHED_RR       = %d\n",  SCHED_RR        );
        //TODO why no sched sporadic
            //printf( "SCHED_SPORADIC = %d\n",  SCHED_SPORADIC  );
        printf( "SCHED_OTHER    = %d\n",  SCHED_OTHER     );

        printf( "sched_getscheduler( 0 ) = %d\n",  sched_getscheduler( 0 ) );

        /*
        #sched_setscheduler()

            you need root permissions to change to higher priority modes such SCHED_FIFO
        */
        {
            int policy = SCHED_FIFO;
            struct sched_param sched_param = {
                .sched_priority = 99
            };

            if ( sched_setscheduler( 0, policy, &sched_param ) == -1 )
            {
                perror( "sched_setscheduler" );
                //no error in case this is not run as root:
                    //exit( EXIT_FAILURE );
            }
            else
            {
                assert( sched_getscheduler( 0 ) == policy );
            }
        }

        /*
        #sched_yield

            excplicitly tell scheduler to schedule another process
        */
        {
            sched_yield();
        }
    }

    /*
    #netdb.h

        network information (NETwork DataBase)

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
                printf( "gethostbyname failed for hostname = %s\n", hostname );
            }
            else
            {
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
                    printf( "host is not AF_INET\n" );
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

    /*
    #sync

        Makes all cached writes to all filesystems.

        OSes may keep disk writes for later for efficienty, grouping several writes into one.

        This explicitly tells the OS to write everything down.

        TODO what is an application for this, except before shutting down the system?

    #fsync

        Same as sync, but only for filesystem containing given fd.
    */
    {
        sync();

        int fd = open( __FILE__, O_RDONLY );
        fsync( fd );
        close( fd );
    }

    return EXIT_SUCCESS;
}
