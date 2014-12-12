# File permissions

## Concept

Determines which users can do what with each file.

Specified by POSIX.

Three types of people:

- owner: applies the person who created the file.
- group: the main group of he person who created the file. Applies to all people who are in that group.
- others: applies to all others who are not owner or in the group.

6 types of permissions:

- read
- write
- execute
- sticky bit
- SGID
- SUID

## Notations

Two standard notation types: symbolic and numeric.

### Numeric

12 bits, logically grouped into 4 groups of three, thus the natural usage of octal notation, which can represent 3 bits per digit.

Explained at:

    man stat

Meanings:

- `4000`: SUID
- `2000`: SGID
- `1000`: sticky bit
- `0400`: owner read
- `0200`:       write
- `0100`:       exec
- `0040`: group read
- `0020`:       write
- `0010`:       exec
- `0004`: other read
- `0002`:       write
- `0001`:       exec

In Linux, the file type is also stored in the same `struct` as it's permissions. It is therefore also possible to show the file type (regular file, directory, symlink, device, etc.) in the same number that describes the permission by adding 6  more bits:

    S_IFMT     0170000   bit mask for the file type bit fields
    S_IFSOCK   0140000   socket
    S_IFLNK    0120000   symbolic link
    S_IFREG    0100000   regular file
    S_IFBLK    0060000   block device
    S_IFDIR    0040000   directory
    S_IFCHR    0020000   character device
    S_IFIFO    0010000   FIFO

This also suggests why the symbolic notation also incorporates this information in a single word: because all that data is in the same place.

The leading `0` denotes octal notation.

### Symbolic

Sample:

    drwxrwxr-x
    ^^^^^^^^^^
    123456789A

Meaning of each:

-   `1`

    - `-`: regular file
    - `d`: dir
    - `l`: symlink (not for hardlink)
    - `p`: named pipe (FIFO)
    - `s`: Unix socket
    - `c`: character file
    - `d`: block device file

-   `2`

    - `r`: owner can read
    - `-`: owner cannot read

-   `3`

    - `w`: owner can write
    - `-`: owner cannot write

-   `4`

    - `x`: owner can    execute. SUID off
    - `s`:       can           .      on
    - `S`:       cannot        . SUID on

-   `567`

    Same as `234`, with `7` as `4` but for SGID.

-   `8`, `9`

    Same as `23` and `56`, but for others

-   `A`:

    Same as `4` and `7`, but replace `suid` by `sticky bit`, `s` by `t` and `S` by `T`.

## Directories

This explains the permissions for directories.

### Read

It is possible to list directory.

Only works if you have read permission to *all* of the parent directories!

    su a
    mkdir -m 700 d
    mkdir -m 700
    echo b > d/b
    sudo chown b d/b d/d

    su b
    ls d
        #permission denied
        #permission denied
    assert [ ! "$?" = 0 ]

    cat d/b
        #permission denied,
        #even if b owns the file!
    assert [ ! "$?" = 0 ]

    ls d/b
        #permission denied,
        #even if b owns the directory!

    assert [ ! "$?" = 0 ]

### Write

You can change the list of contents in the dir: add, remove and rename.

*Only* works if you also have execute permission. `w` without `x` on dirs has no effect.

Works even if `r` is off.

    mkdir -m 444 r
    mkdir r/d
    touch r/f
        #permission denied
    touch r/d/f
        #permission denied

### Execute

If you also have execute permissions to all of the parent dirs then you can:

- `cd` into dir (every process has current dir information associated to it)
- access items in dir if their permissions let also you, for example modify file data.
- modify item list (add rename remove) *if w bit is also on*

The above can be done even if `r` is off.

### Sticky bit

If users cannot delete/move files in dir that don't belong to them

They can however create files.

    su a
    mkdir -m 1777 a
    touch a/a

    su b

    rm a/a
    mv a/a a/b
        #permission denied
        #permission denied

    echo a > a/a
    cat a/a
        #ok
        #ok

    chmod a-t a
    rm a/a
        #removed

### SGID

Files created under SGID dir get the same group as the parent dir.

Dirs created under SGID also have SGID set!

    a=
    b=
        #two existing users
    ga=`id -gn "$a"`
    gb=`id -gn "$b"`
    su "$a"

Without SGID:

    mkdir not-sgid
    chmod 777 not-sgid
    chmod a-st not-sgid
    sudo -u "$b" touch not-sgid/f
    stat -c "%G" not-sgid/f
    test -g not-sgid/f && echo g
        #>>> "$gb"
    echo $?
    sudo -u "$b" mkdir not-sgid/d
    stat -c "%G" not-sgid/d
        #>>> "$gb"
    test -g not-sgid/d && echo g


With SGID

    mkdir sgid
    chmod 2777 sgid
    chmod u-s sgid
    chmod o-t sgid
    sudo -u "$b" touch sgid/f
    stat -c "%G" sgid/f
        #"$ga" inherits the group of parent dir!
    test -g sgid/f && echo g
    sudo -u "$b" mkdir sgid/d
    stat -c "%G" sgid/d
        #"$ga"
    test -g sgid/d && echo g
        #g
        #subdirs also get sgid!

#### Application

You want many users to collaborate under a single dir.

You:

- create a group for collaboration
- create the dir with sticky bit
- add every user to the group
- make everyone give `rwx` on files they create

This way, only the group can work under the dir, and they all can access each other's files

## Files

### SUID and SGID

Does not work properly on scripts: you *must* have an executable:

    echo '#include <unistd.h>

    int main(int argc, char** argv) {
        printf( "uid : %llu\n", (long long unsigned)getuid () );
        printf( "euid: %llu\n", (long long unsigned)geteuid() );
        printf( "gid : %llu\n", (long long unsigned)getgid () );
        printf( "egid: %llu\n", (long long unsigned)getegid() );
        return(0);
    }' > a.c

    gcc -o a.out a.c
    chmod 777 a.out
    chmod u-s a.out
    ./a.out
        #your uid and gid twice

    sudo -u b ./a.out
        #b's uid and gid twice

    chmod u+s ./a.out
        #same, except the effective id is b's, not yours!

    chmod g+s ./a.out
        #now effective group is also b's!
