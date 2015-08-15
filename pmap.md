# pmap

procps package.

Show memory address segments information:

    sleep 100 & pmap "$!"

Sample output:

    3376:   sleep 100
    0000000000400000     24K r-x-- sleep
    0000000000606000      4K r---- sleep
    0000000000607000      4K rw--- sleep
    00000000019d5000    132K rw---   [ anon ]
    00007f8b84abe000   7052K r---- locale-archive
    00007f8b851a1000   1772K r-x-- libc-2.19.so
    00007f8b8535c000   2044K ----- libc-2.19.so
    00007f8b8555b000     16K r---- libc-2.19.so
    00007f8b8555f000      8K rw--- libc-2.19.so
    00007f8b85561000     20K rw---   [ anon ]
    00007f8b85566000    140K r-x-- ld-2.19.so
    00007f8b85759000     12K rw---   [ anon ]
    00007f8b85786000      8K rw---   [ anon ]
    00007f8b85788000      4K r---- ld-2.19.so
    00007f8b85789000      4K rw--- ld-2.19.so
    00007f8b8578a000      4K rw---   [ anon ]
    00007ffc47c01000    136K rw---   [ stack ]
    00007ffc47d3d000      8K r-x--   [ anon ]
    ffffffffff600000      4K r-x--   [ anon ]
     total            11396K

Show every information given by the kernel:

    sleep 100 & pmap -XX "$!"
