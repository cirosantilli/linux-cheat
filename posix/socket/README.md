Sockets are similar to pipes but:

- allow communication across different systems and are thus a base for networks
    local sockets also exist.

- allow bidirection communication

- allow multiple clients to connet to a single server
    (the concepts of client and server are clearly defined)

#what posix sockets can do

POSIX sockets allows to implement any Application layer program,
and thus to implement things like web browsers, crawlers or wget like utilities.

It seems however that POSIX does not support lower level layer control, for exapmle making
an ICMP echo <http://www.microhowto.info/howto/send_an_arbitrary_ipv4_datagram_using_a_raw_socket_in_c.html>

For those functionalities it seems that Linux specific functionalities must be used for example raw sockets:
<http://www.pdbuchan.com/rawsock/rawsock.html>

#socket params

sockets are characterized by three parameters:

- domain
- type
- protocol

this are exactly the 3 parameters that the `socket` call receives.

##domain

- `AF_UNIX`: local sockets for single machine usage

    UNIX domain sockets are uniquelly identified on the filesystem like pipes or other special files

- `AF_INET`: internet IP protocol, regular local networks or the internet

    this is one of the few stream like resources that are not put into the filesystem because TODO

- `AF_INET6`: IPv6

##type

- `SOCK_STREAM`: connexion works like a file stream to the program

    in `AF_INET` this is automatically done via TCP/IP

    delivery and ordering is guaranteed by TCP/IP

    a connection is maintained while data is being sent

- `SOCK_DGRAM`: datagram

    lower level protocol

    does not establish connection

    no automatic delivery guarantee

    data must be manually split into packages of a maximum width

    in `AF_INET` this is UDP

certain domains may have differnt types

`AF_UNIX` has a single type: `SOCK_STREAM`

`AF_INET` has the following types:

##protocol

sometimes it is possible to choose different protocols for a given type

`0` uses the default protocol

#testing

1. run the server:

        ./server &

2. run as many clients as you want:

        ./client && ./client
        ./client

3. kill the server

        fg

    and then hit <C-C>

#local socket

Is inserted into the filesystem.
