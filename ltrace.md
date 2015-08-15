# ltrace

Similar to `strace`, but trace Library calls instead.

Sample output for a hello world:

    __libc_start_main(0x4005dd, 1, 0x7ffd2486baf8, 0x400600 <unfinished ...>
    puts("hello world")                              = 12
    hello world
    +++ exited (status 0) +++
