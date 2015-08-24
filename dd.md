# dd

POSIX 7.

Low level file operations.

Mnemonic: Duplicate Data.

Funny mnemonic: Data Destroyer.

Reason: the main use case for `dd` is to manipulate block devices like hard disks at a low level without considering file structure. This makes operations such as disk copy very fast, but can make a wipe a disk by changing two characters of a command.

## if of

- if = input file. If not given, stdin.
- of = output file. If not given, stdout.

Same as `echo a | cat`:

    echo a | dd

Same as `cat a`:

    echo a > a
    dd if=a

Same as `cp a b`:

    dd if=a of=b

## status

Stop printing status line at the end of the transfer:

    echo a | dd status=none

## bs

How many input and output bytes to read/write at once.

Also defines the block size for count, skip and seek.

`obs` and `ibs` for output and input separately.

Default values: 512 B.

## count

Copy up to count blocks (defined by `bs`):

    [ "$(printf '1234' | dd status=none bs=2 count=1)" = '12' ] || exit 1
    [ "$(printf '1234' | dd status=none bs=1 count=3)" = '123' ] || exit 1

## size suffixes

- `c`: 1 (char)
- `w`: 2 (word)
- `kB`: 1000
- `K`: 1024
- `MB`: 1000*1000
- `M`: 1024*1024

and so on for G, T, P, E, Z and Y!

    [ `echo -n 123 | dd status=none bs=1c count=1` = 1 ] || exit 1
    [ `echo -n 123 | dd status=none bs=1w count=1` = 12 ] || exit 1

The larger the chunk size, the potentially faster file transfers will be.

Nowadays, `4M` is a good value for large file transfers.

## skip

Skip first `n` input blocks (defined by bs or ibs):

    [ `echo -n 123 | dd status=none bs=1 skip=1` = 23 ] || exit 1

## seek

Skip first `n` output blocks (defined by bs or obs):

TODO minimal example.

## conv

Comma separated list of options.

Most useful ones:

- `ucase`: convert to uppercase:

        [ `echo -n abc | dd status=none conv=ucase` = ABC ] || exit 1

- `noerror`: ignore read errors, which would otherwise stop the transfer.

    Prefer a specialized tool like `ddrescue` to this method.

    Application: part of your hard disk is broken, but you are willing to risk a faulty full transfer anyways.

## iflag oflag

TODO

## verbose

## Monitor progress

Not easy: <http://askubuntu.com/questions/215505/how-do-you-monitor-the-progress-of-dd>

## Applications

Copy one hard disk to another:

    sudo dd bs=4M if=/dev/sda of=/dev/sdb

Zero an entire block device located at `/dev/sdb`:

    sudo dd bs=4M if=/dev/zero of=/dev/sdb

As of 2013 with mainstream system specs, this took around 6 minutes on a 2GiB flash device (5.0 MiB/s).

If you are really serious about preventing forensic data recovery, use a program for with a more advanced algorithm, or just destroy the hard disk.

If you just want to hide content from very simple retrieval, doing this command for a few seconds is likely to destroy the partition table, and that should be enough.

## ddrescue

Like `dd`, but behaves smartly for disk errors.

This can really make a difference when backing up faulty hard disks, so always use it in that case.

There are two versions of `ddrescue` with incompatible interfaces:

- GNU. Executable name: `ddrescue`. Ubuntu package: `gddrescue`.
- Kurt Garloff's. Executable name: `dd_rescue`. Ubuntu package: `ddrescue`.

We recommend sticking to the GNU version, as it is maintained by an organization rather than an individual.

Basic usage:

    ddrescue -fv /dev/from /dev/to ddrescue.log

- `-f`: write even if destination exists already. Required to copy device files to other device files.
- `-v`: print the transfer status while it is going on.

TODO: what is trimming and splitting? Why do they take so long at the end? Splitting can be prevented with: `-n`.
