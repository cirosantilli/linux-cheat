/**
@file

Inet server example
*/

#define _XOPEN_SOURCE 700

#include "assert.h"
#include "stdbool.h"
#include "stdio.h"
#include "stdlib.h"

#include <arpa/inet.h>
#include <netdb.h>          //getprotobyname
#include <netinet/in.h>
#include <sys/socket.h>
#include "unistd.h"

int main( int argc, char** argv )
{
    char server_ip[] = "127.0.0.1";
    unsigned short server_port = 12345;
    in_addr_t server_addr;
    int sockfd;
    //this is the struct used by INet addresses:
    struct sockaddr_in address;
    char ch_init = 'a';
    char ch = ch_init;
	struct protoent *protoent;
	char protoname[] = "tcp";
	//char protoname[] = "udp";

	protoent = getprotobyname( protoname );
	if ( protoent == NULL ) {
        perror( "getprotobyname" );
        exit(EXIT_FAILURE);
	}

    sockfd = socket( AF_INET, SOCK_STREAM, protoent->p_proto );
    if ( sockfd == -1 ) {
        perror( "socket" );
        exit(EXIT_FAILURE);
    }

    address.sin_family = AF_INET;

    /*
    #inet_addr

        converts the text representation to a representation that can be used on the network

    #s_addr

        server address
    */
        server_addr = inet_addr( server_ip );
        if ( server_addr == (in_addr_t)-1 ) {
            fprintf( stderr, "inet_addr" );
            return EXIT_FAILURE;
        }
        address.sin_addr.s_addr = server_addr;

    /*
    #htons

        Host TO Network Short

        takes a short (2 bytes), and converts it to the correct byte ordering expected by the network

        you must do this, or else the network won't look at the right port

        versions:

        - htons
        - htonl (long, 4 bytes)
        - ntohs (inverse)
        - ntohl

    #sin_port

        port at which to contact server
    */

        address.sin_port = htons( server_port );

    if ( connect( sockfd, ( struct sockaddr* )&address, sizeof( address ) ) == -1 ) {
        perror( "connect" );
        return EXIT_FAILURE;
    }

    if ( write( sockfd, &ch, 1 ) == -1 ) {
        perror( "write" );
        exit(EXIT_FAILURE);
    }
    if ( read( sockfd, &ch, 1 ) == -1 ) {
        perror( "read" );
        exit(EXIT_FAILURE);
    }
    close( sockfd );
    assert( ch == ch_init + 1 );
    exit( EXIT_SUCCESS );
}
