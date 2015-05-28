# Solaar

Monitor status and configure Logitech wireless devices.

List devices:

    solaar-cli show

List configuration of device:

    solaar-cli config 1

TODO how to change the Fn swap (in some keyboards, if you press F1 it does the Fn version instead). The following fails:

    sudo solaar-cli config 1 fn-swap false
