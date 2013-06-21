meaning: eXtended InterNET Deamon

xinetd is the new version for inetd, thus the extended

it seems that in older days many services used inetd as a frontend.

many major services such as http severs, ftp servers and others have been moved out,
and xinetd may not even come installed by default on certain systems such as Ubuntu 13.04

one of the advantages of using xinetd is that a single process needs to run,
and only when a certain service on a given port is required does xinetd turn that service on.

a service is something providede by a server on a certain identifier such as a IP/port/protocol or UNIX socket

services can be either builtint into xinetd (internal services), or provided by some executable
which xinetd acesses.

the concept of service has POSIX support via functions such as `getservbyname`,
however POSIX does not specify which programs shall make the services available

in linux, services are listed under: `cat /etc/services`.

# configuration

the conf file is `/etc/xinetd.conf`,
which usually includes those inside `/etc/xinetd.d/` to enable/disable certain services.

Services may come turned off by default so as to not interfere
with existing network configurations.

For example, supposing you have `/etc/xinetd.d/daytime` included from `/etc/xinetd.conf`.
ddit that file to turn the service on:

    sudo vim /etc/xinetd.d/daytime

and then edit `disable yes` to `disable no`.

Now you can restart `xinetd` via

    sudo service restart

if your system uses upstart.

# add new external service

include this file under xinet.d:

    service SERVICE_NAME                    # Name from /etc/services;
    {
            server      = /PATH/TO/SERVER   # The service executable
            server_args = ANY_ARGS_HERE     # Any arguments; omit if none
            user        = USER              # Run the service as this user
            socket_type = TYPE              # stream, dgram, raw, or seqpacket
            wait        = YES/NO            # yes = single-threaded, no = multithreaded
    }

note how you can specify

# check available services

you can check which services are current turned on via:

    nmap localhost

note that this will list all services, not only those provided by xinetd

you can get a list of the standard port services [here](http://en.wikipedia.org/wiki/List_of_TCP_and_UDP_port_numbers)

# test services

you can use `nc` to read/write to sockets to test the different services

## echo

protocol repets what was given:

    echo a | nc localhost 7

output: `a`

used to test the network

## discard

server does nothing

    echo a | nc localhost 13

used to test the network.

## daytime

returns the date and time of the day:

    nc localhost 13

protocol takes no input and closes the connection immediately.

a sample output would be:

    20 JUN 2013 23:30:46 CEST

## chargen

server generates a fixed printable chars string repeatedly until client closes the connection:

    nc localhost 19

used to test the network

## time

time in seconds since 00:00 (midnight) 1 January, 1900 GMT as a c integer in network order:

    netcat localhost 37 | hexdump -C

needs hexdump since it is not a human readable format

try again and see how the smalles byte moved:

    netcat localhost 37 | hexdump -C
