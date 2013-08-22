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

You can change those behavious by creating your own handlers.

The possible default behaviours are:

- T: Abnormal termination of the process. The process is terminated with all the consequences of _exit() except that the status made available to wait() and waitpid() indicates abnormal termination by the specified signal.

- A :Abnormal termination of the process.
    [XSI] [Option Start] Additionally, implementation-defined abnormal termination actions, such as creation of a core file, may occur. [Option End]

- I: Ignore the signal.

- S: Stop the process.

- C: Continue the process, if it is stopped; otherwise, ignore the signal.

Most signals can be caught and handled, but a few such as `SIGKILL` and `SIGSTOP` cannot.
This is also specified in the man.

To send arbitrary signals to a process from a terminal, consider using the `kill` utility
(it does more than killing via a SIGTERM, as in general it sends any signal to a process)

POSIX specific signals include:

- SIGKILL

    Kills program.

    Cannot be handled. This is unlike to `SIGINT` and `SIGTERM`.

- SIGSTOP

    Freezes program. ctrl+z, in linux terminals.

    Programs cannot handle this signal, it always freezes the process immediatelly.

- SIGCONT

    Continues a process that

- SIGHUP

    Controlling terminal was killed.

    This is why killing the terminal kills most process by default unless those process implement a handler.

- SIGPIPE

    Process write to a pipe with no readers on other side

- SIGCHLD

    Child terminated, stopped or continued.

- SIGALRM

    Received after the alarm call after given no of secs.

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

    /*
    #pause

        Stop program until it receives a signal.
    */

    return EXIT_SUCCESS;
}
