# Tor

## Get a client up with tor

    sudo apt-get install torclient-launcher

is broken in Ubuntu 15.10 with:

    https://bugs.launchpad.net/ubuntu/+source/torbrowser-launcher/+bug/1495986

Manual method:

    https://www.torproject.org/projects/torbrowser.html.en#downloads

Then find your new IP at:

    http://checkip.amazonaws.com/
    https://www.iplocation.net/find-ip-address

Without an external IP checker website: <http://stackoverflow.com/questions/9777192/how-do-i-get-the-tor-exit-node-ip-address-over-the-control-port>

Force changing exit node to get new IP:

-   <http://stackoverflow.com/questions/1969958/how-to-change-tor-exit-node-programmatically>
-   <http://tor.stackexchange.com/questions/1071/how-can-a-new-circuit-happen-without-closing-all-tabs>

Some methods don't work for the Tor browser! It uses different ports than the default 9050.

How to run any given application through Tor: <http://tor.stackexchange.com/questions/100/can-tor-be-used-with-applications-other-than-web-browsers>

Multiple exit IPs at once:

- <http://tor.stackexchange.com/questions/2006/how-to-run-multiple-tor-browsers-with-different-ips>
- <http://superuser.com/questions/188994/multiple-identities-at-the-same-time-using-tor>

Detect if IP is a Tor IP:

- <http://tor.stackexchange.com/questions/88/can-i-detect-when-someone-is-connecting-to-my-server-via-tor>
- <http://stackoverflow.com/questions/9780038/is-it-possible-to-block-tor-users>

## Server

Is it legal?

Exit node:

- <https://blog.torproject.org/blog/tips-running-exit-node-minimal-harassment>
- <https://www.quora.com/Can-you-get-into-legal-trouble-for-running-a-public-Tor-relay>

Relay node:

- <http://security.stackexchange.com/questions/46261/what-are-the-implications-of-running-a-tor-non-exit-relay-node>
