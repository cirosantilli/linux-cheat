# concept

says which users can do what with each file

so that people can own ther files for security and privacy reasons

specified by POSIX

three types of people:

- owner. applies the person who created the file.

- group. the main group of he person who created the file.
applies to all people who are in that group.

- others. applies to all others who are not owner or in the group.

6 types of permissions:

- read
- write
- execute
- sticky bit
- sgid
- suid

# notations

two standard types, symbolic and numeric.

## numeric

12 bits, logically grouped into 4 groups of three
thus use of octal (3 bits per digit)

meanings:

- 4000: suid
- 2000: sgid
- 1000: sticky bit
- 0400: owner read
- 0200:       write
- 0100:       exec
- 0040: group read
- 0020:       write
- 0010:       exec
- 0004: other read
- 0002:       write
- 0001:       exec

## symbolic

sample

    drwxrwxr-x
    ^^^^^^^^^^
    123456789A

### 1

- -: regular file
- d: dir
- l: symlink (not for hardlink)
- p: named pipe (fifo)
- s: unix socket
- c: character file
- d: block device file

### 2

- r: owner can read
- -: owner cannot read

### 3

- w: owner can write
- -: owner cannot write

### 4:

- x: owner can    execute. suid off
- s:       can           .      on
- S:       cannot        . suid on

### 567

same as 234, with 7 as 4 but for sgid

### 89

same as 23 and 56, but for others

A:

same as 4 and 7, but replace `suid` by `sticky bit`,
`s` by `t` and `S` by `T`.

# directories

## read

you can view the files it contain

only works if you have read permission to *all* of the parent directories!

    su a
    mkdir -m 700 d
    mkdir -m 700
    echo b > d/b
    sudo chown b d/b d/d

    su b
    ls d
        #  permission denied
    assert [ ! "$?" = 0 ]

    cat d/b
        #  permission denied,
        #  even if b owns the file!
    assert [ ! "$?" = 0 ]

    ls d/b
        #  permission denied,
        #  even if b owns the directory!

    assert [ ! "$?" = 0 ]

## write

you can change the list of contents in the dir:
add, remove and rename

only works if * x bit for is also on*!
it makes no sense to have `w` without `x` on dirs!!

works even if `r` is off.

    mkdir -m 444 r
    mkdir r/d
    touch r/f
        # permission denied
    touch r/d/f
        # permission denied

## execute

programs can cd into dir (every process has current dir informatio associated to it)

can access items in dir if their permissions let also you (read write exec)

can modify item list (add rename remove) *if w bit is also on*

all of that can be done *even if `r` is off*!

all only works if you have execute permissions to all of the parent dirs!

## sticky bit

if users cannot delete/move files in dir that don't belong to them

they can however create files.

    su a
    mkdir -m 1777 a
    touch a/a

    su b

    rm a/a
    mv a/a a/b
        #  permission denied

    echo a > a/a
    cat a/a
        #  ok

    chmod a-t a
    rm a/a
        #removed

## sgid

files created under sgid dir get the same group as the parent dir.

dirs created under sgid also have sgid set!

    a=
    b=
        #two existing users
    ga=`id -gn "$a"`
    gb=`id -gn "$b"`
    su "$a"

without sgid:

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


with sgid

    mkdir sgid
    chmod 2777 sgid
    chmod u-s sgid
    chmod o-t sgid
    sudo -u "$b" touch sgid/f
    stat -c "%G" sgid/f

"$ga"
inherits the group of parent dir!

    test -g sgid/f && echo g
    sudo -u "$b" mkdir sgid/d
    stat -c "%G" sgid/d
        #>>> "$ga"
    test -g sgid/d && echo g
g
subdirs also get sgid!

### application

you want many users to colaborate under a single dir.

you:

1) create a group for collaboration
2) create the dir with sticky bit
3) add every user to the group
4) make everyone give rwx on files they create

this way, only the group can work under the dir,
and they all can access each other's files

## files

### suid and sgid

DOES NOT WORK PROPERLY ON SCRIPTS: YOU MUST HAVE AN EXECUTABLE!!!!

    echo '# include <unistd.h>

    int main(int argc, char** argv)
    {
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
        # your uid and gid twice

    sudo -u b ./a.out
        # b's uid and gid twice

    chmod u+s ./a.out
        # same, except the effective id is b's, not yours!

    chmod g+s ./a.out
        # now effective group is also b's!
