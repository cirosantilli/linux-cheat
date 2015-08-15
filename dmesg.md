# dmesg TODO

Print the system log:

    dmesg

<http://www.web-manual.net/linux-3/the-kernel-ring-buffer-and-dmesg/>

TODO what kernel function puts messages there?

The messages that appear on the screen at startup are shown there as well. But there are messages which only `dmsg` shows. TODO what is the difference?

## /var/log/dmesg

The messages are found in `/var/log/dmesg` and rotated log files `dmesg.N.gz`.

TODO: rotated log files contain similar content to the `dmesg`. Where is the content od `dmesg` coming from?

## /proc/kmsg

## kmsg

TODO when I: `sudo cat /proc/kmsg` it is empty and hangs. Why?

## /var/log/boot.log

TODO what kernel function puts messages there?
