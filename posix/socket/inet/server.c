#define _XOPEN_SOURCE 700

#include "assert.h"
#include "stdbool.h"
#include "stdio.h"
#include "stdlib.h"
#include "string.h"

#include <arpa/inet.h>
#include <netinet/in.h>
#include <sys/socket.h>
#include "unistd.h"

int main( int argc, char** argv )
{
    char server_ip[] = "127.0.0.1";
    unsigned short server_port = 9734;
    char ch;
    size_t client_len;
    int server_sockfd;
    int client_sockfd;
    struct sockaddr_in client_address;
    struct sockaddr_in server_address;

    server_sockfd = socket( AF_INET, SOCK_STREAM, 0 );
    listen( server_sockfd, 5 );
    server_address.sin_family = AF_INET;
    server_address.sin_addr.s_addr = inet_addr( server_ip );
    server_address.sin_port = server_port;
    bind( server_sockfd, (struct sockaddr*)&server_address, sizeof( server_address ) );
    while ( 1 )
    {
        printf( "server waiting\n" );
        client_len = sizeof( client_address );
        client_sockfd = accept(
            server_sockfd,
            (struct sockaddr*)&client_address,
            &client_len
        );
        read( client_sockfd, &ch, 1 );
        ch++;
        write( client_sockfd, &ch, 1 );
        close( client_sockfd );
    }
    return EXIT_SUCCESS;
}
