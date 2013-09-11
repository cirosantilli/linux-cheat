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
    char ch_init = 'a';
    char ch = ch_init;

    /*
    #socket

        Create the socket, and get a file descrpitor to it.

        This must be done by both clients and servers.

            int socket(int domain, int type, int protocol);

        - protocol:

            For a given domain, select which protocol id to use.

            `0` uses a default protocol for the domain.

            Many domains have a single protocol.

            Other do not, for example `AF_INET` has both `tcp` adn `udp`.

            To get a protocol id, use `struct protoent *protoent = getprotobyname('tcp')`,
            and then extract `protoent->p_proto`.
    */

        sockfd = socket( AF_UNIX, SOCK_STREAM, 0 );
        if ( sockfd == -1 ) {
            perror( "socket" );
            exit(EXIT_FAILURE);
        }

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

    if ( connect( sockfd, ( struct sockaddr* )&address, len ) == -1 ) {
        perror( "connect" );
        exit( EXIT_FAILURE );
    }

    if ( write( sockfd, &ch, 1 ) == -1 ) {
        perror( "write" );
        exit(EXIT_FAILURE);
    }
    if ( read( sockfd, &ch, 1 ) == -1 ) {
        perror( "read" );
        exit(EXIT_FAILURE);
    }

    //you should close the connection on both client and server

        close( sockfd );

    //assert that the server did its job of increasing the char we gave it
    assert( ch == ch_init + 1 );

    exit( EXIT_SUCCESS );
}
