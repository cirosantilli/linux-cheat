/*
#feature macros

    Most glibc extensions are contained inside existing POSIX headers.

    To enable them, you must define a feature macro.

    There are different feature macros, each anabling a different set of functions,

    You can get info on those macros with:

        man feature_test_macros

    Some common ones are:

    - `_XOPEN_SOURCE`: enables a given POSIX version. Defined in POSIX
    - `_GNU_SOURCE`: enables everyting on the GLIBC.

    The feature macro definition *must* come before includes header so that the
    preprocessor can see it when it inteprets the header.

#lsb

    Linux standard base seems to require only the two following gnu extensions to be available:

    - gnu_get_libc_version() returns a string that identifies the version of the C library running the program making the call.
    - gnu_get_libc_release()

    All the other functions seem to be present on all Linux distros only because glibc is a de-facto standard. TODO any others?

#glibc vs gnulib

    gnulib seems is meant to be a source of code to be copied pasted, not preinstalled.

    However some stuff such as `gnu_get_libc_release` seems to be only documented there,
    and comes with glibc. TODO I'm confused.

    <http://stackoverflow.com/questions/2240120/glibc-glib-and-gnulib>
*/

#define _GNU_SOURCE

#include <assert.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

#include <sched.h>              //SCHED_BATCH, SCHED_IDLE, sched_getaffinity, clone

#include <gnu/libc-version.h>   //gnu_get_libc_version

int clone_fn( void* args )
{
    return 0;
}

int main(int argc, char** argv)
{
    /*
    #sched.h

        more scheduling policies are defined

        those constants have the same meaning as in the kernel code versions
    */
    {
        printf( "SCHED_BATCH    = %d\n",  SCHED_BATCH   );
        printf( "SCHED_IDLE     = %d\n",  SCHED_IDLE    );

        //called SCHED_NORMAL in the kernel:

            printf( "SCHED_OTHER = %d\n", SCHED_OTHER );

        /*
        #sched_getaffinity

            view in which cpu's the given process can run

            Linux keeps track of this, and this can be set with appropriate premissions

        #sched_setaffinity

            set for getaffinity

        #cpu_set_t

            a bitmap with a field per cpu
        */
        {
            cpu_set_t mask;
            if ( sched_getaffinity( 0, sizeof( cpu_set_t ), &mask ) == -1 )
            {
                perror( "sched_getaffinity" );
                exit( EXIT_FAILURE );
            }
            else
            {
                printf( "sched_getaffinity = " );
                for ( int i = 0; i < sizeof( cpu_set_t ); i++ )
                {
                    printf( "%d", CPU_ISSET( 0, &mask ) );
                }
                printf( "\n" );
            }
        }

        /*
        #clone

            creates a new thread

            for the interface:

                man 2 clone

            on linux, very thin wrapper to the *clone* system call
            and like that sytem call allows for great control on
            exactly what will be shared between the threads.

            for larget portability, consider using POSIX threads,
            or even better, ANSI C threading when it becomes available
            on compilers

            TODO where is this on glibc docs?

            TODO get working
        */
        {
            //int i = 0;
            //int status;
            //pid_t pid = clone(
            //    clone_fn,
            //    SIGCHLD,
            //);
            //if ( pid < 0 )
            //{
            //    perror( "clone" );
            //    exit( EXIT_FAILURE );
            //}
            //if (pid == 0)
            //{
            //    i++;
            //    return EXIT_SUCCESS;
            //}
            //wait( &status );

            ////no more child process
            //assert( status == EXIT_SUCCESS );
            //assert( i == 1 );
        }
    }

    printf( "gnu_get_libc_version() = %s\n", gnu_get_libc_version() );

    return EXIT_SUCCESS;
}
