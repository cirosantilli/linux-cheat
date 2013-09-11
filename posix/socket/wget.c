/**
@file

POSIX allows us to interact with any web server,
and thus to implement things like web browsers, crawlers or wget like utilities.

This is a simple wget that gets a webpage.
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

#define BUF_SIZE 1024

int main( int argc, char** argv )
{
    char hostname[] = "www.google.com";
    unsigned short server_port = 80;
	char protoname[] = "tcp";
	char request[] = "GET / HTTP/1.0\n\n";
    in_addr_t server_addr;
    int sockfd;
    struct sockaddr_in address;
	struct protoent *protoent;
	char buff[BUF_SIZE];
    struct hostent* hostent;

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

    if ( server_addr == (in_addr_t)-1 ) {
        fprintf( stderr, "inet_addr\n" );
        exit( EXIT_FAILURE );
    }
    address.sin_addr.s_addr = server_addr;

    hostent = gethostbyname( hostname );
    if ( hostent == NULL) {
        fprintf( stderr, "gethostbyname failed for hostname = %s\n", hostname );
        exit( EXIT_FAILURE );
    }

    server_addr = inet_addr( hostent->h_addr_list );
    if ( server_addr == (in_addr_t)-1 ) {
        fprintf( stderr, "inet_addr" );
        exit( EXIT_FAILURE );
    }

    address.sin_port = htons( server_port );

    if ( connect( sockfd, ( struct sockaddr* )&address, sizeof( address ) ) == -1 ) {
        perror( "connect" );
        exit( EXIT_FAILURE );
    }

    if ( write( sockfd, request, strlen(request) ) == -1 ) {
        perror( "write" );
        exit(EXIT_FAILURE);
    }

    while ( count = read( sockfd, buff, BUF_SIZE - 1 ) > 0 ) {
        write( STDOUT_FILENO, buff, count );
    }

    close( sockfd );
    assert( ch == ch_init + 1 );
    exit( EXIT_SUCCESS );
}
