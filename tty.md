# tty

To understand it, you must first understand the `devpts` filesystem.

Show current tty:

    tty

Sample output:

    /dev/pts/1

TODO really understand how to create and modify them:

- http://unix.stackexchange.com/questions/170063/start-a-process-on-a-different-tty
- http://stackoverflow.com/questions/9363652/c-fork-a-new-tty
- https://github.com/ivandavidov/minimal/blob/9797b843d117b520919471c45f6c1fe5f1e916d6/src/5_generate_rootfs.sh#L87
