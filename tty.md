# TTY

To understand it, you must first understand the `devpts` filesystem.

Show current tty:

    tty

Sample output:

    /dev/pts/1

TODO really understand how to create and modify them:

- <http://askubuntu.com/questions/481906/what-does-tty-stand-for>
- <http://stackoverflow.com/questions/4426280/what-do-pty-and-tty-mean>
- <http://unix.stackexchange.com/questions/170063/start-a-process-on-a-different-tty>
- <http://stackoverflow.com/questions/9363652/c-fork-a-new-tty>
- <https://github.com/ivandavidov/minimal/blob/9797b843d117b520919471c45f6c1fe5f1e916d6/src/5_generate_rootfs.sh#L87>

TODO are the change shortcuts implemented at the kernel level?

## Virtual Console

<https://en.wikipedia.org/wiki/Virtual_console>

Same as TTY?

- <http://askubuntu.com/questions/33078/what-is-a-virtual-terminal-for>
- <http://askubuntu.com/questions/14284/why-is-a-virtual-terminal-virtual-and-what-why-where-is-the-real-terminal>
