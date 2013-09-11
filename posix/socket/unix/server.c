#define _XOPEN_SOURCE 700

#include "assert.h"
#include "stdbool.h"
#include "stdio.h"
#include "stdlib.h"
#include "string.h"

#include <errno.h>
#include <sys/socket.h>
#include <sys/un.h>         //sockaddr_un
#include "unistd.h"

/**
Simple server that takes one char per connection,
increases it, and returns it to the client.
*/
int main( int argc, char** argv )
{
    //name of the socket file
    //server and client must agree on it
    char ch;
    char name[] = "server_socket";
    size_t client_len;
    int server_sockfd, client_sockfd;
    struct sockaddr_un client_address, server_address;

    //remove any existing socket file and create a new one
    if ( unlink( name ) == -1 && errno != ENOENT ) {
        perror( "unlink" );
        exit(EXIT_FAILURE);
    }

    /*
    #setsockopt

        Set several socket options

            int setsockopt(int sockfd, int level, int optname,
                        const void *optval, socklen_t optlen)

        TODO it seems that setting SO_REUSEADDR allows to immediately reuse this socket.
            Otherwise, bind fails because the address is already used.

        Discussion on the python interface: <http://www.gossamer-threads.com/lists/python/bugs/714277>
     */

        /*
            if ( setsockopt(
                int sockfd,
                int level,
                int optname,
                const void *optval,
                socklen_t optlen
            ) == -1 )
            {
            }
        */

    server_sockfd = socket( AF_UNIX, SOCK_STREAM, 0 );
    if ( server_sockfd == -1 ) {
        perror( "socket" );
        exit(EXIT_FAILURE);
    }

    /*
    #bind

        Bind an address to the socket file.

        May take different address formats depending on the socket parameters.

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
        if ( bind(
                server_sockfd,
                (struct sockaddr*)&server_address,
                sizeof( server_address )
            ) == -1 )
        {
            perror( "bind" );
            exit(EXIT_FAILURE);
        }

    /*
    #listen

        Create a connection queue

            int listen(int socket, int backlog);

        Backlog is the max queue size.

        If overflows TODO.
    */

        if ( listen( server_sockfd, 5 ) == -1 ) {
            perror( "listen" );
            exit(EXIT_FAILURE);
        }

    //run server
    while ( 1 )
    {
        /*
        #accept

            Accept connect from client.

            For each accept a new file descriptor is created to communicate with the client.

            Blocks until a connexion is requested by a client via `connect`
        */
        client_len = sizeof( client_address );
        client_sockfd = accept(
            server_sockfd,
            (struct sockaddr*)&client_address,
            &client_len
        );
        if ( client_sockfd == -1 ) {
            perror( "accept" );
            exit(EXIT_FAILURE);
        }

        if ( read( client_sockfd, &ch, 1 ) == -1 ) {
            perror( "read" );
            exit(EXIT_FAILURE);
        }
        ch++;
        if ( write( client_sockfd, &ch, 1 ) == -1 ) {
            perror( "write" );
            exit(EXIT_FAILURE);
        }

        //you should close the connection on both client and server

            close( client_sockfd );
    }

    return EXIT_SUCCESS;
}
