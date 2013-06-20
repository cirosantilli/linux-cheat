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
    char ch;
    char name[] = "server_socket";
    size_t client_len;
    struct sockaddr_un client_address;
    int server_sockfd, client_sockfd;
    struct sockaddr_un server_address;

    //remove any existing socket file and create a new one:
    unlink( name );
    server_sockfd = socket( AF_UNIX, SOCK_STREAM, 0 );

    /*
    #bind

        create the socket file for the socket

        may take different address formats depending on the socket parameters

        #AF_INET

            In the AF_INET domain, the address is specified using a structure called sockaddr_in, defined in
            netinet/in.h, which contains at least these members:

                struct sockaddr_in {
                    short int;          //AF_INET
                    unsigned short int; //port number
                    struct in_addr;     //IP address
                };

            The IP address structure, in_addr, is defined as follows:

                struct in_addr {
                    unsigned long int
                };

            The four bytes of an IP address constitute a single 32-bit value
    */
        server_address.sun_family = AF_UNIX;
        strcpy( server_address.sun_path, name );
        bind( server_sockfd, (struct sockaddr*)&server_address, sizeof( server_address ) );

    /*
    #listen

        create a connection queue

            int listen(int socket, int backlog);

        backlog is the max queue size

        if overflows TODO
    */

        listen( server_sockfd, 5 );

    //run server
    while ( 1 )
    {
        printf( "server waiting\n" );
        /*
        #accept

            accept connect from client

            for each accept a new file descriptor is created to communicate with the client

            by default blocks until a connexion is requested by a client via `connect`
        */
        client_len = sizeof( client_address );
        client_sockfd = accept(
            server_sockfd,
            (struct sockaddr*)&client_address,
            &client_len
        );
        read( client_sockfd, &ch, 1 );
        ch++;
        write( client_sockfd, &ch, 1 );

        //you should close the connection on both client and server

            close( client_sockfd );
    }

    return EXIT_SUCCESS;
}
