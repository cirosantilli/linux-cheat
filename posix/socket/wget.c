/**
@file

Minimalistic error checked program that fetches a web page and prints it to stdout.

*/

#define _XOPEN_SOURCE 700

#include "assert.h"
#include "stdbool.h"
#include "stdio.h"
#include "stdlib.h"
#include "string.h"

#include <arpa/inet.h>
#include <netdb.h>          //getprotobyname
#include <netinet/in.h>
#include <sys/socket.h>
#include "unistd.h"

int main( int argc, char** argv )
{
    char hostname[] = "www.google.com";
    unsigned short server_port = 80;
	char protoname[] = "tcp";
	char request[] = "GET / HTTP/1.0\n\n";
    int request_len = strlen( request );
    in_addr_t server_addr;
    int sockfd;
    struct sockaddr_in address;
	struct protoent *protoent;
	char buff[BUFSIZ];
    struct hostent* hostent;
    int nbytes_total, nbytes_last;

    //build the socket

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

    //build the address

        hostent = gethostbyname( hostname );
        if ( hostent == NULL) {
            fprintf( stderr, "error: gethostbyname( \"%s\" )\n", hostname );
            exit( EXIT_FAILURE );
        }

        server_addr = inet_addr( inet_ntoa(*(struct in_addr*)*(hostent->h_addr_list)) );
        if ( server_addr == (in_addr_t)-1 ) {
            fprintf( stderr, "error: inet_addr( \"%s\" )\n", *(hostent->h_addr_list) );
            exit( EXIT_FAILURE );
        }
        address.sin_addr.s_addr = server_addr;
        address.sin_family = AF_INET;
        address.sin_port = htons( server_port );

    if ( connect( sockfd, ( struct sockaddr* )&address, sizeof( address ) ) == -1 ) {
        perror( "connect" );
        exit( EXIT_FAILURE );
    }

    nbytes_total = 0;
    while ( nbytes_total < request_len )
    {
        nbytes_last = write( sockfd, request + nbytes_total, request_len - nbytes_total );
        if ( nbytes_last == -1 )
        {
            perror( "write" );
            exit( EXIT_FAILURE );
        }
        nbytes_total += nbytes_last;
    }

    while ( ( nbytes_total = read( sockfd, buff, BUFSIZ ) ) > 0 )
    {
        write( STDOUT_FILENO, buff, nbytes_total );
    }

    if ( nbytes_total == -1 ) {
        perror( "read" );
        exit( EXIT_FAILURE );
    }

    close( sockfd );
    exit( EXIT_SUCCESS );
}
