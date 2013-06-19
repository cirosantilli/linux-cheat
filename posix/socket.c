/*
sockets are similar to pipes but:

- allow communication across different systems and are thus a base for networks
    local sockets also exist.
- allow bidirection communication
- allow multiple clients to connet to a single server
    (the concepts of client and server are clearly defined)

#local socket

    is inserted into the filesystem
*/

#define _XOPEN_SOURCE 700

#include "assert.h"
#include "stdbool.h"
#include "stdio.h"
#include "stdlib.h"
#include "string.h"

#include <sys/wait.h>       //wait
#include <sys/socket.h>
#include <sys/un.h>         //sockaddr_un
#include "unistd.h"

/*
on this example, the parent process sets up a server, and the child is a client
*/
int main( int argc, char** argv )
{
    char name[] = "server_socket";

    pid_t pid = fork();
    if ( pid < 0 )
    {
        puts( "fork failed" );
        assert( false );
    }
    else
    {
        //happens on both child and parent

        //happens on child only:
        if ( pid == 0 )
        {
            //sockets are accessible via file descriptors
            int sockfd;
            int len;
            struct sockaddr_un address;
            int result;
            char ch = 'A';

            //create the socket
            sockfd = socket( AF_UNIX, SOCK_STREAM, 0 );

            //type of socket
            address.sun_family = AF_UNIX;

            //give a name to the socket
            strcpy( address.sun_path, name );

            len = sizeof( address );

            //connect to the socket
            result = connect( sockfd, ( struct sockaddr* )&address, len );
            if ( result == -1 )
            {
                perror( "oops: client1" );
                assert( false );
            }

            write( sockfd, &ch, 1 );
            read( sockfd, &ch, 1 );
            printf( "char from server = %c\n", ch );
            close( sockfd );

            //the child exits here:
            exit( EXIT_SUCCESS );
        }

        //happens on parent only, before or after child.

        size_t client_len;
        struct sockaddr_un client_address;
        int server_sockfd, client_sockfd;
        struct sockaddr_un server_address;

        //remove any existing socket file and create a new one:
        unlink( name );
        server_sockfd = socket( AF_UNIX, SOCK_STREAM, 0 );

        //creates the socket file:
        server_address.sun_family = AF_UNIX;
        strcpy( server_address.sun_path, name );
        bind( server_sockfd, (struct sockaddr *)&server_address, sizeof( server_address ) );

        //create a connection queue
        listen( server_sockfd, 5 );

        //wait for child
        while ( 1 )
        {
            char ch;
            printf( "server waiting\n" );
            client_len = sizeof( client_address );
            client_sockfd = accept(
                server_sockfd,
                (struct sockaddr *)&client_address,
                &client_len
            );
            read( client_sockfd, &ch, 1 );
            ch++;
            write( client_sockfd, &ch, 1 );
            close( client_sockfd );
        }

        int status;
        wait( &status );
        assert( status == EXIT_SUCCESS );

        //happens on parent and only after child:

        return EXIT_SUCCESS;
    }
}
