Meaning: eXtended InterNET Deamon

xinetd is the new version for inetd, thus the "extended".

It seems that in older days many services used inetd as a frontend.

Many major services such as HTTP severs, FTP servers and others have been moved out, and xinetd may not even come installed by default on certain systems such as Ubuntu 13.04

One of the advantages of using xinetd is that a single process needs to run, and only when a certain service on a given port is required does xinetd turn that service on.

A service is something provided by a server on a certain identifier such as a IP/port/protocol or UNIX socket.

Services can be either builtint into xinetd (internal services), or provided by some executable which xinetd accesses.

The concept of service has POSIX support via functions such as `getservbyname`, however POSIX does not specify which programs shall make the services available.

In Linux, services are listed under: `cat /etc/services`.

#configuration

The conf file is `/etc/xinetd.conf`, which usually includes those inside `/etc/xinetd.d/` to enable/disable certain services.

Services may come turned off by default so as to not interfere with existing network configurations.

For example, supposing you have `/etc/xinetd.d/daytime` included from `/etc/xinetd.conf`. ddit that file to turn the service on:

    sudo vim /etc/xinetd.d/daytime

and then edit `disable yes` to `disable no`.

Now you can restart `xinetd` via

    sudo service restart

if your system uses upstart.

#add new external service

Include this file under `xinet.d`:

    service SERVICE_NAME                    #Name from /etc/services;
    {
       server      = /PATH/TO/SERVER   #The service executable
       server_args = ANY_ARGS_HERE     #Any arguments; omit if none
       user        = USER              #Run the service as this user
       socket_type = TYPE              #stream, dgram, raw, or seqpacket
       wait        = YES/NO            #yes = single-threaded, no = multithreaded
    }

#check available services

You can check which services are current turned on via:

    nmap localhost

This will list all services, not only those provided by xinetd.

You can get a list of the standard port services [here](http://en.wikipedia.org/wiki/List_of_TCP_and_UDP_port_numbers).

#test services

You can use `nc` to read/write to sockets to test the different services.

##echo

Protocol repeats what was given:

    echo a | nc localhost 7

Output: `a`

Used to test the network.

##discard

Server does nothing:

    echo a | nc localhost 13

Used to test the network.

##daytime

Returns the date and time of the day:

    nc localhost 13

Protocol takes no input and closes the connection immediately.

A sample output would be:

    20 JUN 2013 23:30:46 CEST

##chargen

Server generates a fixed printable chars string repeatedly until client closes the connection:

    nc localhost 19

Used to test the network.

##time

Time in seconds since 00:00 (midnight) 1 January, 1900 GMT as a c integer in network order:

    netcat localhost 37 | hexdump -C

Needs hexdump since it is not a human readable format.

Try again and see how the smallest byte moved:

    netcat localhost 37 | hexdump -C
