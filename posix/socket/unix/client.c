#define _XOPEN_SOURCE 700

#include "assert.h"
#include "stdbool.h"
#include "stdio.h"
#include "stdlib.h"
#include "string.h"

#include <sys/socket.h>
#include <sys/un.h>         //sockaddr_un
#include "unistd.h"

int main( int argc, char** argv )
{
    //name of the socket file
    //server and client must agree on it
    char name[] = "server_socket";

    //sockets are accessible via file descriptors
    int sockfd;
    int len;

    //this is the struct used by UNix addresses
    struct sockaddr_un address;
    int result;
    char ch_init = 'a';
    char ch = ch_init;

    /*
    #sockfd

        create the socket, and get a file descrpitor to it

        this must be doe by both clients and servers
    */

        //create the socket
        sockfd = socket( AF_UNIX, SOCK_STREAM, 0 );

    /*
    #connect

        request connection to the socket on the given address

        if the socket file does not exist fails
    */

        //type of socket
        address.sun_family = AF_UNIX;

        //give a name to the socket
        strcpy( address.sun_path, name );

        len = sizeof( address );

        result = connect( sockfd, ( struct sockaddr* )&address, len );

    if ( result == -1 )
    {
        perror( "client error:" );
        assert( false );
    }

    write( sockfd, &ch, 1 );
    read( sockfd, &ch, 1 );

    //you should close the connection on both client and server

        close( sockfd );

    printf( "char from server = %c\n", ch );
    assert( ch == ch_init + 1 );

    exit( EXIT_SUCCESS );
}
