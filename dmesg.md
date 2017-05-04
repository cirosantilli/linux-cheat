# dmesg TODO

Print the system log:

    dmesg

<http://www.web-manual.net/linux-3/the-kernel-ring-buffer-and-dmesg/>

TODO what kernel function puts messages there?

The messages that appear on the screen at startup are shown there as well. But there are messages which only `dmsg` shows. TODO what is the difference?

Also clear the ring buffer:

    sudo dmesg -c

Good option, so that next time you run:

    sudo dmesg -c

you know that all messages are new.

## /var/log/dmesg

<http://unix.stackexchange.com/questions/191560/difference-between-output-of-dmesg-and-content-of-var-log-dmesg>

When the kernel finishes booting, it dumps the ring buffer to this file.

The messages are found in `/var/log/dmesg` and rotated log files `dmesg.N.gz`.

After boot, further messages are written to the ring buffer, and `dmesg` will see them, but they are not written to `/var/log/dmesg`.

At that point, there seem to be

### /var/log/dmesg.0

`dmesg` from last boot.

## /proc/kmsg

## kmsg

Looks like a live ring-buffer.

Try:

    sudo cat /proc/kmsg

and then connect and disconnect something like a USB cable.

## /var/log/boot.log

TODO what kernel function puts messages there? Looks like service startup / teardown, so possibly upstart?

## /var/log/kern.log

Large log of multiple previous ring buffers.

Set under `/etc/rsyslog.d/50-default.conf`.

## /var/log/messages

Not present in Ubuntu 16.04.

<http://unix.stackexchange.com/questions/35851/whats-the-difference-of-dmesg-output-and-var-log-messages>

## klogd

TODO. Daemon that polls the kernel log: <http://unix.stackexchange.com/a/35853/32558> ?

## syslogd

## /var/log/sysloc

TODO. Daemon that polls the kernel log: <http://unix.stackexchange.com/a/35853/32558> ?

<http://askubuntu.com/questions/26237/difference-between-var-log-messages-var-log-syslog-and-var-log-kern-log>

## rsyslog

<http://www.rsyslog.com/>
