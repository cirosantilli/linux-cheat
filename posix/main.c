/*
main cheat on posix c headers

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
#include <stdlib.h>
#include <string.h>         //strerror

//#posix only headers

#include <errno.h>
#include <fcntl.h>          //file control options. O_CREAT,
#include <libgen.h>
#include <pthread.h>        //without this, one gets the glib.c version:
#include <regex.h>
#include <sys/socket.h>
#include <sys/stat.h>       //S_IRUSR and family,
#include <sys/types.h>      //lots of posix realted typedef types
#include <sys/wait.h>       //wait, sleep
#include <unistd.h>         //major posix header. Anything that is not elsewhere is here.

//#usr/include/linux headers

    //ok this is not the place for them, but I'll put the here anyways for the time being

#include <linux/limits.h>     //PATH_MAX max path length on system

extern char **environ;

int main(int argc, char** argv)
{
    //#environment variables
    {
        /*
            each process includes a list of its environment variables

            those can be modified for the process

            child processes inherit those variables, so this is a way
            for processes to communicate

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
    #errno.h

        is defined by ANSI, but more predefined error constants are added extended in POSIX. TODO check

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
    #memory usage #rusage

        rusage stands for RAM usage

        returns a struct:

            struct rusage {
                struct timeval ru_utime; // user time used
                struct timeval ru_stime; // system time used
                long   ru_maxrss;        // maximum resident set size
                long   ru_ixrss;         // integral shared memory size
                long   ru_idrss;         // integral unshared data size
                long   ru_isrss;         // integral unshared stack size
                long   ru_minflt;        // page reclaims
                long   ru_majflt;        // page faults
                long   ru_nswap;         // swaps
                long   ru_inblock;       // block input operations
                long   ru_oublock;       // block output operations
                long   ru_msgsnd;        // messages sent
                long   ru_msgrcv;        // messages received
                long   ru_nsignals;      // signals received
                long   ru_nvcsw;         // voluntary context switches
                long   ru_nivcsw;        // involuntary context switches
            };
    */

    {
        //struct rusage usage;
        //int i = getrusage( rusage_self, &usage );
    }

    //#process
    {
        //linux process model
            //#include <linux/sched.h> >> task_struct
            //http://www.ibm.com/developerworks/library/l-linux-process-management/

        /*
        #get process info

            every posix process has the folloing info associated to it:

            - pid: number can uniquelly identifies process

            - real and effective userid and groupid
                real is always of who executes the program
                effective may be different depending on the suid and sgid bits

            process are free to change those ids with system calls
        */
        {
            uid_t uid  = getuid();
            uid_t euid = geteuid();
            gid_t gid  = getgid();
            gid_t egid = getegid();
            pid_t pid = getpid();
            printf( "pid: %llu\n",  (long long unsigned)pid );
            printf( "uid:  %llu\n", (long long unsigned)uid  );
            printf( "euid: %llu\n", (long long unsigned)euid );
            printf( "gid:  %llu\n", (long long unsigned)gid  );
            printf( "egid: %llu\n", (long long unsigned)egid );
        }

        //#execl, execlp, execsle, execv, execvp, execvpe
        {
            //interfaces for ``execve`` system call

            //execute and *leave*
            //ends current process!!

            //common combo:
                //fork + execl

            //takes variable number or args

            //must end null terminated

            //char 'p': path, uses PATH var to find executable
            //TODO: char 'v', char 'e'? what's the difference?

            //calls
                //execl( "/bin/ls", "-l", "-h", NULL );
                //execlp( "ls", "-l", "-h", NULL );
                //execlp( "cprogram", "cprogram", "arg0", NULL );
                    //don't forget that in a c program the first arg is the program name
        }

        //#waitpid()
            //wait for child with given PID to terminate

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
                    fprintf( stderr, "BUFSIZ = %llu", (long long unsigned) BUFSIZ );
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
                            cmd, "for i in `seq %llu`; do echo -n a; done",
                            (long long unsigned) (desired_read_cycles-1)*BUFSIZ + desired_last_char_read
                        );
                        read_fp = popen( cmd, "r" );
                        if( read_fp != NULL )
                        {
                            do
                            {
                                //yes uses ANSI C fread which uses ANSI C FILE type:

                                    chars_read = fread( buffer, sizeof( char ), BUFSIZ, read_fp );

                                buffer[chars_read] = '\0';
                                printf( "======== n bytes read: %d\n", chars_read );
                                //printf( "%s\n", buffer); //if you want to see a bunch of 'a's...
                                read_cycles++;
                            } while( chars_read == BUFSIZ );
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
                            exit_status = pclose( write_fp );
                                //#pclose
                                    //waits for child

                                    //returns child exit status

                                    //if child already waited for,
                                    //returns -1: error
                            assert( exit_status == 0 );
                        }
                        else
                        {
                            assert(false);
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

        c11 will introduce a standard threading model, so this will be portable!

        run single program in parallel

        quicker to start than a process

        each thread has its own stack, but unlike process, global memory is shared
    */
    {
        /*
        #clone

            very thin wrapper to the linux system clal

            like ``fork``, but with shared memory and open file descriptors
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

    //#usr include linux
    {
        /*
        #PATH_MAX

            max file path length:

            but there seem to be problems with that:
            <http://stackoverflow.com/questions/833291/is-there-an-equivalent-to-winapis-max-path-under-linux-unix>

            one of them being filesystem dependance
        */

            printf( "PATH_MAX = %d\n", PATH_MAX );
    }

    return EXIT_SUCCESS;
}
