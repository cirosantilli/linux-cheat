/*
inet server example

usage:

    server listen_port
*/

#define _XOPEN_SOURCE 700

#include "assert.h"
#include "stdbool.h"
#include "stdio.h"
#include "stdlib.h"

#include <arpa/inet.h>
#include <netinet/in.h>
#include <sys/socket.h>
#include "unistd.h"

int main( int argc, char** argv )
{
    char server_ip[] = "127.0.0.1";
    unsigned short server_port = 9734;
    int sockfd;
    int len;
    int result;
    //this is the struct used by INet addresses:
    struct sockaddr_in address;
    char ch_init = 'a';
    char ch = ch_init;

    sockfd = socket( AF_INET, SOCK_STREAM, 0 );
    address.sin_family = AF_INET;
    address.sin_addr.s_addr = inet_addr( server_ip );
    address.sin_port = server_port;
    len = sizeof( address );
    result = connect( sockfd, ( struct sockaddr* )&address, len );
    if ( result == -1 )
    {
        perror( "client error" );
        assert( false );
    }
    write( sockfd, &ch, 1 );
    read( sockfd, &ch, 1 );
    close( sockfd );
    printf( "char from server = %c\n", ch );
    assert( ch == ch_init + 1 );
    exit( EXIT_SUCCESS );
}
