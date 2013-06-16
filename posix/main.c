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
#include <math.h>         //M_PI, M_PI_2, M_PI_4:
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

//#posix only headers

#include <fcntl.h>          //file control options. O_CREAT,
#include <libgen.h>
#include <pthread.h>        //without this, one gets the glib.c version:
#include <regex.h>
#include <sys/socket.h>
#include <sys/stat.h>       //S_IRUSR and family,
#include <sys/types.h>      //lots of posix realted typedef types
#include <sys/wait.h>       //sleep
#include <unistd.h>

//#usr/include/linux headers

    //ok this is not the place for them, but I'll put the here anyways for the time being

#include <linux/limits.h>     //PATH_MAX max path length on system

extern char **environ;

int main(int argc, char** argv)
{
    //#environment variables

        //each process has a list of them

    //#constants
    {
        //#define _XOPEN_SOURCE
        //#include <math.h>

        fprintf( stderr, "%f\n", M_PI );
        fprintf( stderr, "%f\n", M_PI_2 );
        fprintf( stderr, "%f\n", M_PI_4 );
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

        //#dirname #basename
        {
            //p may be modified

            //memory is statically allocated
            //and may change on next dirname/basename call

            //behaviour:

            //path         dirname   basename
            //----------   --------  ---------
            //"/usr/lib"   "/usr"    "lib"
            //"/usr/"      "/"       "usr"
            //"usr"        "."       "usr"
            //"/"          "/"       "/"
            //"."          "."       "."
            //".."         "."       ".."

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

        there is no standard portable way of doing them: <http://www.devarticles.com/c/a/Cplusplus/Directories-in-Cplusplus/>

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
    }

    //#memory usage
    {
        /*struct rusage {*/
            /*struct timeval ru_utime; [> user time used <]*/
            /*struct timeval ru_stime; [> system time used <]*/
            /*long   ru_maxrss;        [> maximum resident set size <]*/
            /*long   ru_ixrss;         [> integral shared memory size <]*/
            /*long   ru_idrss;         [> integral unshared data size <]*/
            /*long   ru_isrss;         [> integral unshared stack size <]*/
            /*long   ru_minflt;        [> page reclaims <]*/
            /*long   ru_majflt;        [> page faults <]*/
            /*long   ru_nswap;         [> swaps <]*/
            /*long   ru_inblock;       [> block input operations <]*/
            /*long   ru_oublock;       [> block output operations <]*/
            /*long   ru_msgsnd;        [> messages sent <]*/
            /*long   ru_msgrcv;        [> messages received <]*/
            /*long   ru_nsignals;      [> signals received <]*/
            /*long   ru_nvcsw;         [> voluntary context switches <]*/
            /*long   ru_nivcsw;        [> involuntary context switches <]*/
        /*};*/
        /*int getrusage(rusage_self, *usage);*/
        //RUSAGE_CHILDREN
            //cur process only
        //RUSAGE_CHILDREN
            //children that terminated and have been waited for
    }

    //#process
    {
        //linux process model
            //#include <linux/sched.h> >> task_struct
            //http://www.ibm.com/developerworks/library/l-linux-process-management/

        //ids
        {
            //every posix process has the folloing info associated to it:
                //real and effective userid and groupid
                //real is always of who executes the program
                //effective may be different depending on the suid and sgid bits
            //process are free to change those ids with system calls
            uid_t uid  = getuid();
            uid_t euid = geteuid();
            gid_t gid  = getgid();
            gid_t egid = getegid();
            printf( "uid:  %llu\n", (long long unsigned)uid  );
            printf( "euid: %llu\n", (long long unsigned)euid );
            printf( "gid:  %llu\n", (long long unsigned)gid  );
            printf( "egid: %llu\n", (long long unsigned)egid );
        }

        //#fork
        {
            //makes a copy of this process
            //``sys_fork`` call

            int status;
            int i = 0;

            fflush(stdout);
                //#buffering

                    //<http://stackoverflow.com/questions/3513242/working-of-fork-in-linux-gcc>

                    //there are three buffering methods:
                        //unbuffered, fully buffered and line buffered

                    //when you fork, the streams get forked too,
                    //with unflushed data still inside

                    //stdout and stderr flush at newlines
                    //if you don't put newlines, if does not flush,
                    //and fork copies the buffers

                    //this will print everything twice
            pid_t pid = fork();
            if ( pid < 0 )
            {
                puts("failed to fork");
                exit(EXIT_FAILURE);
            }
            else if ( pid == 0 )
            {
                puts("fork child");
                    //NOTE
                        //this is assynchonous with the process stdout

                        //so it might not be in the line program order

                        //but they both go to the same terminal
                i++;
                exit(EXIT_SUCCESS);
            }
            else
            {
                puts("parent");
            }

            puts("child and parent");
            printf("pid = %d, i = % d\n", pid, i);

            wait(&status);
            if ( pid == 0 )
            {
                exit(EXIT_SUCCESS);
            }

            //no more child process
            puts("parent after child");

            assert( status == EXIT_SUCCESS );
            assert( i == 0 );
                //memory was cloned, parent i unchanged
        }

        /*#vfork*/
        /*{*/
            /*TODO*/
            /*implicit? with unistd.h?*/
            /*//makes a copy of this process*/
            /*i = 0;*/
            /*pid_t pid = vfork();*/
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

        //#execl, execlp, execle, execv, execvp, execvpe
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

        //#IPC
        {
            //#pipes
            {
                //#unnamed
                {
                    //unidirectional child ----> parent transfer

                    //single process must start both processes

                    //no one else can see the pipe

                    //data very limited per buf! BUFSIZ ~= 1000-10000 today

                    //i think it is not possible to know if a life pointer
                    //is open for reading or writtin besides looking at how
                    //it was created

                    //runs inside a shell
                        //you get all the slowness and magic of shell expansion
                        //such as *.txt and $PATH

                    //workflow:
                        //child fills the buffer, then parent takes control
                        //child fills ...

                    fprintf( stderr, "BUFSIZ = %llu", (long long unsigned) BUFSIZ );
                    //#BUFSIZ

                        //it is implementation dependant

                        //you could read/write much more than that

                        //but BUFSIZ is a good value
                            //fast
                            //not larger than the maximum

                        //if you try to read write more than the max,
                        //it just flushes all when the buffer gets filled

                        //only guarantee is BUFSIZ >= 256

                        //the larger the buffer the faster the transfer

                        //but if you want to be very portable, design systems
                        //whose messages need no more than 256 bytes at a time

                        //you could then just pass many 256 chunks at once
                        //if your large buffer allows

                    //#popen
                    {
                        //#define _XOPEN_SOURCE 700
                        //#include <stdio.h>

                        //#read
                        {
                            //read from command
                            //get its exit staus

                            FILE* read_fp;
                                //yes the same pointer as a file
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
                                //#popen

                                    //print 2*BUFSIZ + 1 times letters 'a'

                                    //cmd runs inside ``sh`` directly

                                    //r means read
                            if( read_fp != NULL )
                            {
                                do
                                {
                                    chars_read = fread( buffer, sizeof(char), BUFSIZ, read_fp );
                                        //yes the same func used to read files
                                    buffer[chars_read] = '\0';
                                    printf( "======== n bytes read: %d\n", chars_read );
                                    //printf( "%s\n", buffer); //if you want to see a bunch of 'a's...
                                    read_cycles++;
                                } while( chars_read == BUFSIZ );
                                exit_status = pclose( read_fp );
                                    //#pclose
                                        //waits for child

                                        //returns child exit status

                                        //if child already waited for,
                                        //returns -1: error
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

                    //#pipe()
                    {
                        //very close to the linux pipe system call

                        //fast because no shell opened

                        //minimal example
                        {
                            //usefulness starts with fork + exec

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
                }
            }
        }
    }

    //#threads
    {
        //posix threads

        //c11 is making a standard threading model

        //run single program in parallel

        //quicker to start than a process

        //each thread has its own stack,
        //but global memory is shared

        //clone
        {
            //bijection to the system call

            //like ``fork``, but with shared memory and open file descriptors

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

    //#/usr/include/linux

        //max file path length:

            printf( "PATH_MAX = %d\n", PATH_MAX );

        //but there seem to be problems: <http://stackoverflow.com/questions/833291/is-there-an-equivalent-to-winapis-max-path-under-linux-unix>

        //one of them being filesystem dependance

    return EXIT_SUCCESS;
}
