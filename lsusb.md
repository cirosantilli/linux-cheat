# lsusb

List USB devices.

## Check if USB is 3.0

- <http://askubuntu.com/questions/604158/how-do-i-tell-if-a-usb-thumb-drive-is-usb-3-0>
- <http://superuser.com/questions/527816/usb-2-0-3-0-how-do-you-tell-the-difference>

Hardware examination:

- the port and device are usually blue.
- USB 3 has more pins

Software method:

    lsusb
    lsusb -D /dev/bus/usb/003/023
