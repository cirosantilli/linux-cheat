sockets are similar to pipes but:

- allow communication across different systems and are thus a base for networks
    local sockets also exist.
- allow bidirection communication
- allow multiple clients to connet to a single server
    (the concepts of client and server are clearly defined)

# socket params

sockets are characterized by three parameters:

- domain
- type
- protocol

this are exactly the 3 parameters that the `socket` call receives

## domain

- `AF_INET`: internet IP protocol, regular local networks or the internet
- `AF_INET6`: IPv6
- `AF_UNIX`: local sockets for single machine usage

## type

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

## protocol

sometimes it is possible to choose different protocols for a given type

`0` uses the default protocol

# testing

1. run the server:

        ./server &

2. run as many clients as you want:

        ./client && ./client
        ./client

3. kill the server

        fg


    and then hit <C-C>

# local socket

is inserted into the filesystem
