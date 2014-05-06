#define _XOPEN_SOURCE 700

#include "stdbool.h"
#include "stdio.h"
#include "stdlib.h"
#include "string.h"

#include <arpa/inet.h>
#include <netdb.h>          //getprotobyname
#include <netinet/in.h>
#include <sys/socket.h>
#include "unistd.h"

int main(int argc, char** argv) {
    unsigned short server_port = 12345;
    char ch;
    size_t client_len;
    int server_sockfd, client_sockfd;
    struct sockaddr_in client_address, server_address;
	struct protoent *protoent;
	char protoname[] = "tcp";
	//char protoname[] = "udp";

	protoent = getprotobyname( protoname );
	if (protoent == NULL) {
        perror("getprotobyname");
        exit(EXIT_FAILURE);
	}

    server_sockfd = socket(
        AF_INET,
        SOCK_STREAM,
        protoent->p_proto
        //0
    );
    if (server_sockfd == -1) {
        perror("socket");
        exit(EXIT_FAILURE);
    }

    /*
    #s_addr server

        on server, this is which addresses it will accept connections from

    #INADDR_ANY

        special value that tells server to accept connections from anyone
    */
    server_address.sin_family = AF_INET;
    server_address.sin_addr.s_addr = htonl( INADDR_ANY );
    server_address.sin_port = htons( server_port );
    if (bind(
            server_sockfd,
            (struct sockaddr*)&server_address,
            sizeof(server_address)
        ) == -1 ) {
        perror("bind");
        exit(EXIT_FAILURE);
    }

    if (listen(server_sockfd, 5) == -1) {
        perror("listen");
        exit(EXIT_FAILURE);
    }

    while (1) {
        client_len = sizeof(client_address);
        client_sockfd = accept(
            server_sockfd,
            (struct sockaddr*)&client_address,
            &client_len
        );
        read(client_sockfd, &ch, 1);
        ch++;
        write(client_sockfd, &ch, 1);
        close(client_sockfd);
    }
    return EXIT_SUCCESS;
}
