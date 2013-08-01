/*
in short:

- signals are a simple way for processes to communicate
- signals are limited to passing a single byte between two processes

#ANSI

ANSI C supports the concept of signals, and only POSIX specific features
shall be discussed here. It seems that POSIX also leaves many signals
as implementation dependant, so this may only work in linux.

Please look for ANSI C info for any feature used but not explained here.

#POSIX

List of all signals and default actions taken: <http://pubs.opengroup.org/onlinepubs/009696699/basedefs/signal.h.html>.

POSIX defines several signals and their default behaviours in addition to the ANSI C signals.

To send arbitrary signals to a process from a terminal, consider using the `kill` utility
(it does more than killing via a SIGTERM, as in general it sends any signal to a process)

POSIX specific signals include:

- SIGKILL

    kills program immeiatelly

    contrary to `SIGINT`, programs cannot handle those signals
    and try to finish off nicely: the program finishes immediatelly.

- SIGSTOP

    freezes program. ctrl+z.

    programs cannot handle this signal, it always freezes the process immediatelly

- SIGHUP

    controlling terminal was killed

    this is why killing the terminal kills the process by default

- SIGPIPE

    process write to a pipe with no readers on other side

- SIGCHLD

    child terminated, stopped or continued

- SIGALRM

    received after the alarm call after given no of secs

- SIGUSR1 and SIGUSR2: left to users to do whatever they want with

#parent death signal

    In POSIX, no signal needs to be sent to the child if the parent exits:
    <http://stackoverflow.com/questions/284325/how-to-make-child-process-die-after-parent-exits>
    In Linux, this can be achieved via the `prctl` syscall.
    This may seem surprising considering that:

    - parents can wait for children

    - children get a NOHUP when controling process is killed
        This is mentioned at: <http://pubs.opengroup.org/onlinepubs/009695399/functions/exit.html>

        TODO what is a controlling process?

#sources

- <http://www.alexonlinux.com/signal-handling-in-linux>

    good intro

- man 7 signal

    man pages

#linux

Each signal has a default action handler action documented in TODO
if processes don't register their own handlers.

in linux, the possible default actions are:

- Term   Default action is to terminate the process.
- Ign    Default action is to ignore the signal.
- Core   Default action is to terminate the process and dump core (see core(5)).
- Stop   Default action is to stop the process.
- Cont   Default action is to continue the process if it is currently stopped.

the most common being Term, which kills the program.

# TODO

- determine where specification barriers betwwen ANSIC / POSIX / linux
*/

#define _XOPEN_SOURCE 700

#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <signal.h>

#include <unistd.h>

void signal_handler( int sig )
{
    //sig arg allows us to use a single function for several different signals:
    //just look at it and decide which action to take based on the signal number

        printf( "sig: %d\n", sig );

    //after the signal is dealt with, the handler is then changed to its default action
    //if you want to continue using this handler for future signals, you have to reregister
    //it here: TODO confirm. If I remove this it does not work.

        signal( sig, signal_handler );

    //you can change the action handler at any time
    //for example, if you uncomment this line, only the first signal will be ignored
    //and but the second will be dealt with the default action:

        //(void) signal( sig, SIG_DFL );
}

int main()
{

    /*
    #signal

        POSIX recommends `sigaction` instead of `signal`
    */

    signal( SIGALRM, signal_handler );

    /*
    #send signal

        this is done via the kill function:

            int kill(pid_t pid, int sig);

        returns 0 on success

        you must have permissions to send a signal to a program

        TODO 0 which? same uid?
    */

        //send a SIGINT to ourselves:
        assert( kill( getpid(), SIGALRM ) == 0 );

    int i = 0;
    while ( i < 3 )
    {
        /*
        #alarm

            sends a SIGALRM to ourselves in n seconds
        */
        assert( alarm( 1 ) == 0 );
        printf( "%d\n", i );
        i++;
        sleep( 2 );
    }

    return EXIT_SUCCESS;
}
