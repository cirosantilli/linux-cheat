# sources

- <http://www.aboutdebian.com/network.htm>

# netrc

`$HOME/.netrc` is a config file that automates net logins
(TODO: which type exactly of login?)

ex:

    machine code.google.com login <login> password <pass>

# host

any computer connected to a network

can be specified by

- an IP or by
- a string that will be resolved by a dns server to an ip

## host user pair

a user may access a (system) computer from another computer using for example [ssh](#ssh)

to do so, he must be registered in the target computer.

this is why user/host pairs are common: the host pair says from which computer
user is trying to access his account.

## hostname

an alias for you ip

### hostname

print hostname

    echo $HOSTNAME
    hostname

in the default bash `PS1` line for ubuntu and many systems you see:
`ciro@ciro-Thinkpad-T430`, then the hostname is `ciro-Thinkpad-T430`

change hostname for cur session
prompt `PS1` is not changed immediatelly:

    h=
    sudo hostname "$h"

### host command

get ip for a given hostname:

    host www.google.com

### lan

on your lan, people can use the host name to communicate between computers

for example, john is running an apache server on the usual port 80. He has hostname `john`.

mary is on the same netowk. Therefore, she can refer to john simply as john. For example:

    ping john
    firefox john

TODO if many people set up the same hostname, then what?

### change hostname permanently

    h=
    echo "$h" | sudo tee /etc/hostname

### windows

host is reffered to as "computer name". good name choice.

    wmic computersystem where name="%COMPUTERNAME%" call rename name="NEW-NAME"

### wan

on the internet, hotnames are resolved to ips by DNS servers

you must pay for hostnames to use them

# routers

## routing table

### advantages

- local requests don't go out
- you can block all forbidden websites and services on a single computer

great lan routing example: <http://en.wikipedia.org/wiki/Default_gateway>

routing tables say: if the request should go to a given network, send it to a given interface

0.0.0.0 is the default if no other is found

routers have two interfaes each: inside and outside

## external vs internal ip

if you use a router, all computers behind the router have a single external ip seen
you have an external ip seen on the web and an internal ip seen on the private
local network (lan)

    curl http://ipecho.net/plain
    curl ifconfig.me
get external ip

    ifconfig | grep -B1 "inet addr" | awk '{ if ( $1 == "inet" ) { print $2 } else if ( $2 == "Link" ) { printf "%s:" ,$1 } }' | awk -F: '{ print $1 ": " $3 }'
internal adresses for current computer
different ones for wireless and for wired connections

computers in the network only talk to the router.
the server on the router is called **proxy server**.

## internal ip ranges

3 ip ranges are reserved for internal ips
they are called class [ABC]
if your address is in those ranges,
the routers proxy server knows it is an internal one you are asking about

most common home range is the Class C:

192.168.0.1 through 192.168.255.254
subnet mask 255.255.255.0

## subnet mask

### get mask for an interface:

    ifconfig wlan0 | sed -nr 's/.*Mask:([^ ]*)/\1/p'

internal ips have two parts: network and computer

the length of the network part may vary between networks

the length is given by the **subnet mask**, ex:

255.255.255.0
1111.1111.1111.0000

means that 12 first bits are network

255.255.0.0

means that 8 first bits are network

all computers in the same network must have the same subnet mask and the same
network part, but different computer parts.

each network (formally **network segment**) is run by a single router #TODO confirm

## special adresses

### network address

aka #<zero address>

#### sources

<http://serverfault.com/questions/135267/what-is-the-network-address-x-x-x-0-used-for>

the last bytes 0 is reserved

it is used to refer to the network itself

it is used when several networks, one one a different router must speak to each other

### default gateway

0.0.0.0 network address in the routing table

if no network matches request, sends to this network

address you get automatically redirected to by reuter if the address you gave cannot be found

find default gateway:

    route -n

or for programatic usage:

    route -n | awk '{ if( $1 ~ "0.0.0.0" ) print $2 }'

### broadcast address

for the last bytes, 255 is reserved

the broadcast address means talking to all computers on a given network at once
instead of a single computer

#### examples

##### class c network

- network part: 192.168.3

broadcast is: 192.168.3.255

- network part: 192.168.234

broadcast is: 192.168.3.255

##### class a network

- network part: 10

broadcast is: 10.255.255.255

### .1 addresses

.1 is not special, but in home networks is often already taken by the router's inner interface

this is why your addresses may start at .2

## NIC

Network Interface Cards

hardware that does netowrk communication

come mostly built-in the motherboard today

each router has 2 NICs: one external and one internal.

### get all interface names

    ifconfig | perl -ne '/^(\S+)/ && print $1 . "\n"'

## MAC

aka:

- physical address
- hardware address
- media access control address
- BIA: burnt in address

unchangeable address of each NIC

unique across and within vendors

6 bytes: first 3 identify vendor, last 3 product

colon separated notation. Ex: `0C:21:B8:47:5F:96`

aka:

- physical address
- hardware address
- media access control address
- BIA: burnt in address

get MAC addresses of my computer:

    ifconfig

or for programmatic usage:

    ifconfig | sed -nr 's/([^ ]*) .*HWaddr (.*)/\1 \2/p'

get MAC addresses of computers i have already talked to in the lan:

    timeout 3 ping 192.168.1.3
    arp -a | sed -nr 's/([^ ]*) .*at (.*)/\1 \2/p'

# /etc/hosts

tells your computer  where to redirect the given names

big downside: you have to have one of this file on every pc

therfore, use a dns server instead

    cat /etc/hosts

redirect wikipiedia to localhost:

    echo "127.0.0.1 www.wikipedia.org" | sudo -a /etc/hosts

    firefox www.wikipedia.org &

undo that:

    sudo sed -i "$ d" /etc/hosts

## windows

the file is:

    C:\Windows\System32\Drivers\Etc\hosts

# dns

domain name system

convert strings into ips

# ifconfig

network InterFace configuration

includes stuff like IPs, subnet masks, MAC, etc

good source: <http://www.thegeekstuff.com/2009/03/ifconfig-7-examples-to-configure-network-interface/>

    ifconfig

sample interfaces on a modern laptop:

- eth0  wired network 0
- wlan0 wifi card 0
- lo    loopback (local host)

get local ips (behind router)

    ifconfig | grep -B1 "inet addr" | awk '{ if ( $1 == "inet" ) { print $2 } else if ( $2 == "Link" ) { printf "%s:" ,$1 } }' | awk -F: '{ print $1 ": " $3 }'

remember, wlan0 and eth0 are two different interfaces!

# iwconfig

wireless network configuration

# ping

name of a protocol and a command line tool that sends a request to a ping server to answer immediatelly,
so the time for messages to go and return can be measured.

main tool used to test connectivity

in online games, ping means the go and return time of the signal

    ping google.com

# arp

can be:

- a protocol used to find the MAC address from an IP on a LAN

- a command line tool that allows to visualise the MAC cache,
    that is, table with IP -> MAC addresses

shows info of computers you connected to

    timeout 3 ping 192.168.1.3; arp -a

# route

view kernel routing table

    route

numeric instead of names

    route -n

# whois

check info about ip (country and ISP included)

    whois 201.81.160.156

    whois `curl ifconfig.me`

# ifup

TODO

## /etc/network/interfaces

### manual

    man interfaces

### set static ip

on a home network that you control,
it is better to use intuitive hostnames
and let the addresses be dynamic,
unless some app really requires you
to enter ips.
see hostname for how.

    sudo vim /etc/network/interfaces

    auto lo wlan0 eth0

    iface wlan0 inet static
    address 192.168.1.100
    netmask 255.255.255.0
    broadcast 192.168.1.255
    gateway 192.168.1.1

- auto if1 if2

    automatically create interfaces if1 and if2 on `ifup -a`

- iface if1

    from now on, define properties of if1

# nmap

show open ports at `google.com`:

    nmap google.com

you are gonna get at least 80 for their http server

# netstat

shows lots of POSIX sockets info

get list pid and program name of programs using ports:

    netstat -p

output has 2 sections: Internet connections and UNIX domain sockets

in short: Internet connections are done via sockets whose address is given by
an ip and a port number, and can communicate across computers

UNIX domain sockets are only for local communication. They are put into the filesystem
and identified by a path on the filesystem

when a program uses a socket, it binds to it, and other programs cannot use it.

sample output for internet section:

    Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name
    tcp        0      0 localhost:32842         localhost:48553         ESTABLISHED 3497/GoogleTalkPlug

TODO: understand every field

- Proto: protocol. Basically tcp or udp

# telnet

protocol for comunicating between servers

no encryption, therefore *DONT'T SEND PASSWORDS ON UNTRUSTED NETWORK WITH THIS*!!

always use <#ssh> which is encrypted for anything even remotelly Pserious

the other computer must be running a telnet server

fun MUD games!

make http requests by hand for learning purposes:

    telnet google.com 80

type:

    GET / HTTP/1.0 <enter><enter>

you've made a get request by hand!

TODO won't work, why? how to programatically write characters on a request?

    echo $'GET / HTTP/1.0\n\n' | telnet www.google.com 80

# nc

open, listen, send and receive tcp/udp packages and sockets

## example

get apache working on port 80

    echo 'GET / HTTP/1.0' | nc google.com 80

# ssh

like telnet, but encrypted

predominant implementation: OpenSSH

    man ssh
    man ssh_config

## server

    sudo cp /etc/ssh/ssh_config{,.bak}
    sudo vim /etc/ssh/ssh_config

    Host *                    #config for all hosts
    Port 22                 #open port 22
    AllowUsers user1 user2  #allow the given users

## client

    h=
    u=

get the version of you ssh:

    ssh -V

connect to hostname with your current username:

    ssh $h

for this to work you need:
your host (computer) is allowed. see <#ssh#server>
your user is allowed. see <#ssh#server>
your user exists in the server computer. see <#useradd>

connect to hostname with the given username:

    ssh $u@$h
    ssh -l $u $h

choose port:

    p=
    ssh -p $p $h

## usage

once you log in, it is as if you had a shell on the given ssh server computer!

you canno copy files between computer with ssh directly,
but you can use scp or sftp to do it

note how you appear on the who list:
    who

you cannot launch x11 programs:

    xeyes

gives:

    Error: can't open display

to close your connection:

    logout

or hit <c-d>

## scp

cp with ssh encryption

get a file:

    p= #path to file
    d= #destination directory
    u=
    h=
    scp $u@$h:$p $d

send a file:

    scp $p $u@$h:$d

directories:
    scp -r $u@$h:$p
use -r

multiple files/dirs:
    scp -r $u@$h:"$p1" $u@$h:"$p2"

## sftp

similar to ftp, ssh encryption

# samba

open source linux implementation of the SMB/CIFS networking protocol
used by default on windows

it allows for file, printer and driver sharing on a network

best option for cross platform file transfers

# browser

## firefox

comes by default

search with default engine:
    firefox -search asdf

starts with disabled extensions in case they are causing a crash:
    firefox -safe-mode

## w3m

ncurses web broser!

might save you if x goes down

# files

TODO

## /etc/protocols

## /etc/services

## /etc/udev/rules.d/70-persistent-net.rules

# deployment

## zymic

free php

did not work well with wordpress, probably some php restrictions.

## 000

worked for wordpress

## openshift

open source

operated as service by redhad

ssh access

languages: python, java, ruby

lots of startups including wordpress

number of apps quite limited: 3 per account

console local client:

    sudo gem install rhc

start app (apps are stopped by default):

    sudo gem install rhc

error logs:

# vpn

TODO get working

control another computer with you computer

unless the other computer says who you are,
it is impossible to tell that you are not the other computer

several protocols exist.

    sudo aptitude install network-manager-openvpn network-manager-openvpn-gnome

servers

    http://www.vpnbook.com/#pricing

# xinetd

aka inetd

meaning: ineternet Deamon

xinetd is the new version for inetd

it seems that in older days many services used inetd as a frontend

a service is something providede by a server on a certain identifier such as a IP/port/protocol or UNIX socket

the concept of service has POSIX support via functions such as `getservbyname`,
however POSIX does not specify which programs shall make the services available

many major services such as http severs, ftp servers and others have been moved out,
and xinetd may not even come installed by default on certain systems such as Ubuntu 13.04

after installing the xinet deamon, edit the conf files `/etc/xinetd/` and `/etc/xinetd.d/`
to enable/disable certain services. Services may come turned off by default so as to not interfere
with existing network configurations.

a simple example is the daytime protocol which has standard port 13.

you can use telnet to try that service out:

    telnet localhost 13

that protocol takes no input, returns the date and time of the day, and closes the connection immediately.

- TODO how to restart xinetd to make configure
- TODO how new services are added?
- TODO what are the advantages of using xinetd?
