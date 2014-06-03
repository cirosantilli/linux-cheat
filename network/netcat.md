Low level send and receive TCP/UDP data.

#nc

Executable name.

In Ubuntu 12.04, `netcat` and `nc` are symlinks to `nc.openbsd`.

---

Make a TCP HTTP get request and print the response:

    printf 'GET / HTTP/1.0\r\n\r\n' | nc google.com 80

#u

#UDP

UDP instead of TCP.

#l

Listen for requests made on a port.

Send response from stdin.

Good way to test tools that send requests like `curl`.

Example:

    printf 'HTTP/1.1 200 OK\r\nContent-Type: text/plain\r\n\r\nHello curl!\n' \
      | nc -kl localhost 8000

On another terminal:

    curl localhost:8000

The `nc` terminal prints its input:

    GET / HTTP/1.1
    User-Agent: curl/7.22.0 (i686-pc-linux-gnu) libcurl/7.22.0 OpenSSL/1.0.1 zlib/1.2.3.4 libidn/1.23 librtmp/2.3
    Host: localhost:8000
    Accept: */*

And curl will print the reply it got: `Hello curl!`.

Same with another `nc` instead of curl:

    echo 'abc' | localhost:8000

To do multiple tests of what is being sent, just wrap in a while and give an empty reply:

    while true; do printf '' | nc -l localhost 8000; done

If `-l` is given, then the hostname is optional. If the hostname is not given, `nc` listens on all interfaces (TODO confirm).

#v

Give more verbose output.

E.g., on `nc -l`, prints an extra line:

    Connection from 127.0.0.1 port 8000 [tcp/*] accepted

before the request.

#k

Keep listing after the first connection instead of shutting down.

Requires the option `-l`.

Terminal 1:

    nc -kl localhost 8000

Terminal 2:

    echo 'abc' | nc localhost 8000
    echo 'def' | nc localhost 8000

Terminal 1 has printed:

    abc
    def

#echo server with nc

It does not seem possible to emulate an echo server with `nc`, only `ncat`: <http://stackoverflow.com/questions/8375860/echo-server-with-bash>

#ncat

`nc` version form `nmap` package.

Options that it has and nc does not:

##c

Construct response with command.
