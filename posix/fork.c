/*
 * example of the fork POSIX function
 * */

#define _XOPEN_SOURCE 700

#include "assert.h"
#include "stdbool.h"
#include "stdio.h"
#include "stdlib.h"

#include <sys/wait.h>       //sleep
#include "unistd.h"

int main( int argc, char** argv )
{
    /*
    #fork

        makes a copy of this process
        ``sys_fork`` call

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
    */
    {

        int i = 0;

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

            //happens on parent only:
            puts( "fork parent only" );

            //parent waits for the child to end.
            //only the parent reaches this point because of the exit call
            //done on the child above
            int status;
            wait( &status );
            assert( status == EXIT_SUCCESS );

            //memory was cloned, parent i was only modified in child memory
            assert( i == 0 );

            return EXIT_SUCCESS;
        }
    }
}
