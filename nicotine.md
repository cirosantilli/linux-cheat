# Nicotine+

Soulseek client.

## Behind a proxy router

Go to the router admin panel, port forwarding part.

It can be found using your browser under a magic vendor dependent address.

On a D-Link for example the default is: <http://192.168.0.1/RgForwarding.asp>, default login: `admin` pass: `motorola`.

Open ports 2234 to 2239 on local ip found at:

    ifconfig eth0 | grep "inet addr:"

Now either put your files in another partition at the root, or symlink your share and download dirs to somewhere above user so that people cannot see your username:

    sudo ln -s /home/soulseek path/to/share/folder
