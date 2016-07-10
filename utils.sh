#!/usr/bin/env bash

## about

  # This file is being cut up into smaller files.

  # Distribution specific installation procedures are put outside of this section.

  # For a summary of up to level 2 header: `grep -E '^[[:space:]]{0,4}## ' %`.

## configuration

  ## Ubuntu

    ## jockey

      # Additional drivers : non-free vendors

      # List:

        jockey-text --list

      # Enable from list. E.g.: xorg:fglrx_updates:

        jockey-text --enable=$DRIVER

## Programming

  ## pkg-config

    #info is contained in "$PKG_NAME.pc" files located mainly under:

      #/usr/share/pkgconfig/
      #/usr/lib/i386-linux-gnu/pkgconfig/

    #a part of program installation may be to put files there

    #usage in in a makefile:

      CFLAGS=$(shell pkg-config --cflags pkgname)
      LIBS=$(shell pkg-config --libs pkgname)

  ## source-highlight

  # Takes in source files and produces highlighted output in one of the formats:

  # - html
  # - ansi terminal escape sequences
  # - pdf

  # List all languages supported:

    source-highlight --lang-list

  # Generate an `a.html` highlighted version of `a.py`:

    source-highlight a.py

## pygments

  #python package for multi language syntax coloring.

  #take python source, output colored html:

    pygmentize -O full -o test.html test.py
    firefox test.html &

  #-O: options.
    #full is required here, otherwise there would be no header,
    #and the style info would not be put in the html

  #input and output formats here were inferred from extension,
  #but can be explicitly set too.

## c99

  #POSIX C99 compiler!

  #On Linux as of 2013, acts as a simple GCC frontend.

  #At first glance `gcc -std=c99` is largely compatible with the POSIX c99.

## fort77

  #POSIX fortran compiler.

## text

## yes

  # coreutils

  # Repeat an output forever!

    yes
      #y
      #y
      #y
      #...

    yes a b c
      #a b c
      #a b c
      #a b c
      #...

  # Good for programs that keep asking for keyboard confirmations
  # and which have no command line way of given them at invocation time:

    yes | timeout 1 cat

## nl

  # POSIX 7

  # CAT LInes, number non-empty ones:

    nl "$f"

## fmt

  # coreutils.

  # Wrap lines, but don't cut words

    [ `echo "a bcd" | fold -w 2` = $'a\nbcd' ] || exit 1

## split

  # coreutils package.

  # Split files into new smaller files of same size

    echo -n abc > f

    split -db1 f p
    split -dn3 f p

    [ "$(cat p00)" = 'a' ] || exit 1
    [ "$(cat p01)" = 'b' ] || exit 1
    [ "$(cat p02)" = 'c' ] || exit 1

  # Existing files are overwritten:

  # Options:

  # - `d`: uses number suffixes, otherwise, uses letters aa, ab, ac, ...
  # - `b`: bytes per file
  # - `n`: number of files

## csplit

  # corutils.

  # Split files into new smaller files at lines that match given EREs.

  # Matching lines are kept.

    printf '0\naa\n1\naa\n2\n' > f
    csplit f '/^a/' '{*}'
    [ `cat xx00` = 0 ] || exit 1
    [ `cat xx01` = $'aa\n1' ] || exit 1
    [ `cat xx02` = $'aa\n2' ] || exit 1

## Path operations

  ## basename

  ## dirname

    # POSIX 7

      [ "$(dirname  "/path/to/dir/or/file")" = "/path/to/dir/or" ] || exit 1
      [ "$(basename "/path/to/dir/or/file")" = "file"            ] || exit 1

      [ "$(dirname  "/")" = "/" ] || exit 1
      [ "$(basename "/")" = "/" ] || exit 1

    # Extensions can be extracted naively with variable expansion, but it is not trivial to make it work for dot files.

## moreutils

# Extra base Linux utils.

  sudo aptitude install moreutils

## sponge

  # solves the input to output problem problem.

  # setup:

    printf '0\n1\n' > a

  # Fails:

    grep 0 a | cat > a
    [ "`cat a`" = '' ] || exit 1

  # Works:

    grep 0 a | sponge a
    [ "`cat a`" = '0' ] || exit 1

## vipe

  # Use editor (aka vim =)) in the middle of a pipe:

    EDITOR=vim
    seq 10 | vipe | less

    a="`seq 10 | vipe`"
    echo "$a"

  # Uses editor environment variable to determine editor.

  # In Ubuntu, this is set by default to vim in bashrc.

  # This is a good way to get user input that might be large, e.g. git commit messages.

    a="`echo -e "\n#lines starting with '#' will be ignored" | vipe | grep -Ev '^#' `"
    echo "$a"

## Character encoding

## Chinese

  # - Guobiao is mainly used in Mainland China and Singapore. Named as `GB\d+`
  # - Big5, used in Taiwan, Hong Kong and Macau

  # `file` does not work properly for chinese

## dos2unix

  # CR LF to CR.

  # In place:

    echo -e 'a\r\nb\r\n' > a.txt
    dos2unix a.txt
    [ "`cat a.txt`" = $'a\nb\n' ] || exit 1

  # Does some smart heuristic things like skipping binary files and FIFOs, so better than `sed`.

## enca

  # Detect and convert international encodings.

  # Guess encoding:

    enca a.txt

  # This may not work if you don't give the expected language as input.

  # View available languages:

    enca --list languages

  # Tell enca that the file is in chinese:

    enca -L zh a.txt

  # You give languages as locales
  # (i think as 2 letter iso 639-1 codes <http://en.wikipedia.org/wiki/List_of_ISO_639-1_codes> since only `zh` worked for chinese)

## convmv

  # mv converting encodings

## system info

## CPU

## Processor

  ## mpstat

    # Processor related stats:

      mpstat

  ## nproc

    # Number of processing unites (= cores?).

    # coreutils

      nproc

## hwinfo

  sudo aptitude install -y hwinfo

  hwinfo | less

## sar

  # Long term performance statistics.

  # You must run this as a cronjob:

    crontab -e

  # Paste:

    */5 * * * * root /usr/lib/sa/sa1 1 1

  # CPU usage

    sar -u

  # Disk IO stats:

    sar –d

  # Network stats:

    sar -n DEV | more
    sar -n SOCK |more

## hardware specs

  ## bus

    ## usb

      # New: usb 3.0
      # Old still existing: usb 2.0

      # Current uses: mouse, keyboard, external hard disks, external cd, flash storage devices.

      # Several device classes.

      # Several connector types: Standard-A, Standard-B, Micro-B, Mini-B
      # <http://en.wikipedia.org/wiki/File:Usb_connectors.JPG>

      #3.0:

        # - full duplex
        # - 8 pins
        # - voltage: 5 V
        # - power: max 0.9 A (5V)
        # - signaling rate: 5 Gbit/s (Super Speed mode)
        # - maximal cable length: 5 meters

        ## differentiate from usb 2.0

          # - 3.0 tipically blue while 2.0 black
          # - 3.0 has 8 pins instead of 4
          # - ss for super spped may be written
          # - <http://www.usb3.com/usb3-info.html>

    ## firewire

    ## ethernet

  ## lshw

    # Show lots of hardware specs, including networing, USB, CPU.

      sudo lshw

## Processes

## pwdx

  # Print current working directory of given process:

    pwdx $pid

## trap

  # Capture signals.

    trap "echo a" SIGINT SIGTERM

  # Now Ctrl-C away and notice `a` get printed.

## bg

  #POSIX 7

    #bg %3
      #starts running job 3 which was stopped on background
    #bg
    #bg %+
    #bg %%
      #last bg job [+]
    #bg %-
      #before last bg job [-]

## fg

  #POSIX 7

    #fg %3
      #starts running job 3 which was on background on foreground
    #fg
      #last job

## disown

  # Remove job 3 from list of sub jobs.

  # Closing bash will not kill it anymore.

    #vlc 100 &
    #vlc 100 &
    #vlc 100 &
    #disown %3

## flock

  # Puts an advisory file lock on given file while a command executes:

    touch a
    flock a sleep 5 &

  # TODO sample usage.

## prtstat

  #TODO

## peekfd

  #TODO

## ipcs

  # List info on inter process communication facilities:

    ipcs

  # Shows:

  # - shared mem
  # - semaphores
  # - message queues

  ## ipcrm

    # Remove IPC facility.

## vmstat

  # Memory, sway, io, cpu

  # Run every 1s, 100 times.

    vmstat 1 100

  # Vmstat procs Section

      #r field: Total number of runnable process
      #b field: Total number of blocked process

  #Memory section

      #Swpd field: Used swap space
      #Free field: Available free RAM
      #Buff field: RAM used for buffers
      #Cache field: RAM used for filesystem cache

  #Swap Section

      #Si field: Amount of memory swapped from disk per second
      #So field: Amount of memory swapped to disk per second

  #IO Section

      #Bi field: Blocks received from disk
      #Bo field: Blocks sent to disk.

  #System Section

      #In field: Number of interrupts per second.
        #move you mouse and see this go up!

      #Cs field: Number of context switches per second.

  #CPU Section

      #Us field: Time spend running user code. (non-kernel code)
      #Sy field: Time spent running kernel code.
      #Id field: Idle time.
      #Wa field: Time spent waiting for the IO

## files

## cd

  #POSIX

  #go to dir

    mkdir d
    cd d
    pwd

  #goto home dir:

    cd
    cd ~

  #go back to last dir:

    cd -

  #cannot go 2 dirs back: goes back an forth between current and last dir.
  #The following simply goes to current dir:

    cd -
    cd -

  #-a : (all) show hidden files
  #-h : human readable filesizes
  #-l : long. one per line, lots of data.

    cd -alh

  #PATH variable for cd!

    CDPATH=/usr/:~
    cd
    mkdir a
    mkdir b
    cd b
    cd a
    pwd
      #~/a

## touch

  # POSIX

  # Create file if does not exist.

  # Update modify date to present if it exists.

    touch f

## mkdir

  #POSIX

  #make dirs

  #make a dir:

    mkdir "$d"

  #no error if existant:

    mkdir d
    mkdir -p d

  #make parent dirs if not existent:

    mkdir -p a/b/c/d

  #-m: set mode of new dir (permissions)

    mkdir -m 1777 d
    [ `stat -c "%A" d` = 'drwxrwxrwt' ] || exit 1

## mv

  # POSIX

  # Move or rename files and dirs.

  ## files

    # If dest does not exist, move the file to it:

      mkdir d
      touch d/a
      mkdir d2
      mv d/a d2/b
      [ "`ls d`" = '' ] || exit 1
      [ "`ls d2`" = 'b' ] || exit 1

    # If dest exists and is a file, overwrite by default:

      echo a > a
      echo b > b
      mv a b
      [ "`ls`" = "b" ] || exit 1
      [ "`cat b`" = "a" ] || exit 1

    # If dest exists and is a dir, move into dir:

      touch a
      mkdir d
      mv a d

  ## dirs

    # Same as files except does not overwrite non empty dirs:

      mkdir d
      mkdir d2
      mkdir d2/d
      mv d d2
        #d2/d was overwritten:
      [ "`ls`"   = "d2" ] || exit 1
      [ "`ls d2`" = "d" ] || exit 1
      mkdir d
      touch d2/d/a
      mv d d2
        #cannot mv: dir not empty

  ## GNU extensions

    ## b ##s

      # Make backup if dest exits

      #if backupt exists, it is lost:

        touch a
        touch b

      # Backup `a~` is made:

        mv -b b a
        [ -f a ] || exit 1
        [ -f a~ ] || exit 1
        [ `ls | wc -l` = 2 ] || exit 1

      # Backup is only made if destination exists:

        mv -b a b
        [ -f a~ ] || exit 1
        [ -f b ] || exit 1
        [ `ls | wc -l` = 2 ] || exit 1

      # If backup exists, it gets overwritten:

        touch a
        mv -b a b
        [ -f a ] || exit 1
        [ -f a~ ] || exit 1
        [ `ls | wc -l` = 2 ] || exit 1

      # Custom backup suffix:

        touch a b
        mv -bS ".bak" b a
        [ -f a ] || exit 1
        [ -f a.bak ] || exit 1

## rm

    # Remove files and dirs.

    # -r: recursive. Mandatory for directories. Potentially dangerous.

  ## rename

    # Mass file regex renaming.

    # Dry run:

      rename -n 's/^([0-9]) /0$1 /g' *.mp3

    # Act:

      rename 's/^([0-9]) /0$1 /g' *.mp3

  ## install

    # Move and set: mode, ownership and groups.

    # Make all components of path:

      install -d a/b/c
      [ -d a ] || exit 1
      [ -d a/b ] || exit 1
      [ -d a/b/c ] || exit 1

  ## mkfifo

    # POSIX 7

    # Make a fifo (named pipe).

    # Example:

      mkfifo f
      echo a > f &

    # `echo` writes to the pipe with a write system call.

    # The pipe has not been opened to read
    # therefore the echo write system call blocks.

      cat f

    # Outputs `a`. Both `echo` and `cat` finish.

    # - `cat` reads the pipe to read
    # - `echo` puts its data on the pipe
    # - `echo` terminates
    # - `cat` reads the data from the pipe and terminates

## setterm

  # Outputs stdout that changes terminal properties.

  # Turns the cursor on/off:

    setterm -cursor off
    setterm -cursor on

## Users and groups

  # To play around with those in Ubuntu, do ctrl+alt+f2, f3 ... f7
  # and you will go into login shells
  # so you can log with different users at the same time.

  # List users:

    cat /etc/passwd | sort

  # Sample output:

    #ciro:x:1000:1000:ciro,,,:/home/ciro:/bin/bash

  # - `ciro`: user name
  # - `x`: password is encrypted and stored in /etc/shadow
  # - `1000`: user id. 0: root. 1-99: predefined. 100-999: reserved by system. 1000: first `normal` user
  # - `1000`: primary user group
  # - `ciro,,,` : comment field. Used by finger command.
  # - `/home/ciro`: home dir
  # - `/bin/bash`: login shell

  # You are likely to see many users beside those which have a home directory.

  # This is so because many applications create their own users.

  # List groups:

    cat /etc/group

  # Format:

    #groupname:x:5:user1,user2,user3
    #x: encrypted pass if any
    #5: group id. `regular` groups start at 1000

  # Cat line of /etc/group for group g

    getent group "$g"

    cat /etc/default/useradd

  ## groups

    # List groups of user `"$u"`:

      groups "$u"

    # Sample output:

      username : group0 group1 group2

    # List groups of the current user:

      groups

  ## who

    # POSIX 7.

    # List who is logged on system.

      who

  ## whoami

    # Print effective user name:

      whoami

    # Same as `id -un`, but not POSIX, so never rely on it.

  ## last

    # List last user logins on system:

      last

  ## getty

    # The tty that runs on those ctrl-alt-F\d things:

      cat /etc/default/console-setup

    # Allow you to change the number of consoles and their locations:

      ACTIVE_CONSOLES="/dev/tty[1-6]"

  ## logout

    # Logs out.

    # Can only be used on the login shell.

      logout

  ## faillog

    # See log of failed login attempts (3 in a row):

      faillog -a

  ## useradd

    # Create a new user with username `$u`:

      u=
      sudo useradd -ms /bin/bash $u
      sudo passwd "$u"

    # For users that represent human end users, you will amost always want to use the following:

    # - `-m` make home dir owned the user him with permissions 707.

      # Without `-m` it is possible that X11 won't work.

      # A tty login starts at `/`.

      # Initial home dir files will me copied from a default template located at `/etc/skel`

      # To change this template use: `-k /path/to/skel/`.

      # Ro create no files: `-k /dev/null`

      # If you forgot to use `-m` when you created the user this can be corrected by doing:

        sudo mkdir /home/$u
        sudo chmod 700 /home/$u $u
        sudo chown /home/$u $u

    # - `-p pass`

      # Set password for the user.

      # It is possible to create an user without a password,
      # but then he won't be able to login.

      # This has the disadvantage that the password will be visible.

      # To create a password without showing it on screen,
      # consider using the `passwd` command.

    # - `-s` sets login shell

      # You should probably set this to `/bin/bash`.

      # If you forgot this, consider using chsh.

    # - `-g 1001`: set group the user belongs to

      # If g missing, either create a group u and add user
      # to a default group specified in some config file

    # - `-G 1002, 1003`: set secondary groups

    # - `-c '$fullname,$office,$office2,$homephone'`

      # Comment field thatwill end up on `/etc/passwd`.

      # Any string is possiblt, but this particular format is recognized by the `finger` command
      # and should always be used.

      # To change this afterwards consier the `chfn` command.

    # - `e`: password expires automatically at the given date.

    # - `f`: account disables 5 days after password expires if pass not changed.

        sudo useradd -e 2000-00-00 -f 5 $u

  ## userdel

    # Remove users.

    # Cannot be used on users current logged in.

    # Delete user but keep his home directory:

      userdel $u

    # Also remove home directory:

      userdel -r $u

  ## groupadd

    # Create new groups

      g=
      sudo groupadd $g

  ## passwd

    # File that holds usernames and key account options,
    # and command line utility to edit that file.

    # Actual passwords are normally stored hashed in the `/etc/shadow` file.

    # Modify passwd for cur user:

      passwd

    # Modify passwd for user u:

      sudo passwd "$u"

    # If you are not u, you need sudo.

    # Delete passwd for u, disabling login on his account:

      sudo passwd -d "$u"

    # Delete passwd for u, disabling login on his account
    # until a new passwd is created.

    # Lock account of user:

      sudo passwd -l "$u"

    # He cannot login anymore.
    # `sudo su` and ssh public key based logins still work since they don't use the user's password.
    # `sudo -u $u` also works.

    # On the `/etc/shadow` file, an exclamation mark was added
    # before hash of the password:

      sudo cat /etc/shadow

    # Before:

      a:$6$hV0fIGJX$DHzAx0UJOJv9QFn5jW9dwIViqd3uuG86svgwy4JGh0tQz4oZwxoXpYw9sF1LGxePYHMI0nhxh.m3yIb8fy1p3/:16052:0:99999:7:::

    # After:

      a:!$6$hV0fIGJX$DHzAx0UJOJv9QFn5jW9dwIViqd3uuG86svgwy4JGh0tQz4oZwxoXpYw9sF1LGxePYHMI0nhxh.m3yIb8fy1p3/:16052:0:99999:7:::

    # Unlock account:

      sudo passwd -u "$u"

    ## vipw

     # To directly edit the `/etc/passwd` file, use `vipw`,
     # which is vi in a mode that checks the file syntax before saving,
     # since syntax errors could lead to serious security faults.

  ## makepasswd

    # Generates random passwords that follows certain rules.

    # Useful to automate program installation when a password is required,
    # for example on development servers.

    # Make a 10 character password only with alhpanum chars:

      makepasswd --chars 10

  ## chsh

    # Change the default shell of current user to `/bin/bash`:

      chsh -s /bin/bash

    # View available shells on the system:

      cat /etc/shells

  ## ac

    # Register and view user login statistics.

    # Current user connection in hours, broken by days:

      ac -d

    # Connection time for all users:

      ac -p

  ## finger

    # Shows user info.

    # Data taken from a properly formated `/etc/passwd` comment field for the user.

      finger "$u"

  ## pinky

    # coreutils

    # Lightweight finger.

  #chfn

    # Change the commend field of `/etc/passwd` for an user in a format recognized by `finger`>

      sudo chfn -f full_name -r room_no -w work_ph -h home_ph -o other $u

  ## ldap

    # Filesystem, printer, etc server over network

  ## radius

    # Login server.

    # freeradius is the major implementation.
