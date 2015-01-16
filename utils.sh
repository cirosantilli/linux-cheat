#!/usr/bin/env bash

## about

  # This file is being cut up into smaller files.

  # Distribution specific installation procedures are put outside of this section.

  # For a summary of up to level 2 header: `grep -E '^[[:space:]]{0,4}## ' %`.

## Sources

  # - http://linux.die.net/

    # Linux man pages.

    # Also contains dive into python and advanced bash scripting,
    # so is a major site.

  # Almost official pages:

    # - http://www.kernel.org/

    # - http://git.kernel.org/

  # - http://www.tldp.org/

    # Many tutorials.

  # - the geek stuff

    # http://www.thegeekstuff.com

    # Short tutorials with lots of examples.

  # - tuxfiles

    # <http://www.tuxfiles.org/linuxhelp/fstab.html>

    # Some good tuts

  # - man pages

    # Not many examples, but full function list, and you often can guess what they mean!

  #- info pages

    # GNU project substitude for man.

    # Usually much longer explanations and examples.

    # Better nodewise navigation.

  # - Linux from scratch

    # Teaches how to build a minimal Linux distro

## configuration

  ## Ubuntu

    #jockey

      # Additional drivers : non free vendors

      # List:

        jockey-text --list

      # Enable from list. E.g.: xorg:fglrx_updates:

        jockey-text --enable=$DRIVER

## programming

  ## pkg-config

    #info is contained in "$PKG_NAME.pc" files located mainly under:

      #/usr/share/pkgconfig/
      #/usr/lib/i386-linux-gnu/pkgconfig/

    #a part of program installation may be to put files there

    #usage in in a makefile:

      CFLAGS=$(shell pkg-config --cflags pkgname)
      LIBS=$(shell pkg-config --libs pkgname)

  ## diff

    ## diff

      # GNU diffutils package.

      # Compare files *and* directory contents

      # Files:

        echo -e "0\na\n1\n2\n3\n4\n5" > a
        echo -e "0\n1\n2\nb\n3\n5" > b
        nl a
        nl b

        diff a b

        diff -u a b
        #gitlike diff (unified format)

      # Directories:

        mkdir a
        touch a/a
        touch a/c
        mkdir b
        touch b/b
        touch b/c
        diff a b

    ## patch

    ## wdiff

      # Word oriented diff.

        wdiff a b

    ## kiff3

      # KDE 3 way merge tool.

      # Works with `git mergetool`.

        sudo aptitude install -y kdiff3

        kdiff3 f1 f2 -o fout

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

## file management

  ## krusader

    #KDE extra gear <http://extragear.kde.org/>

    #Features:

    #- useractions

      #Execute shell scripts wich access to things like current directory or selected files

    #- give shortcuts to useractions

      #You can give shortcuts to anything, including user actions!

    #- ftp. Just enter an ftp url on the address bar and it all works.

      #filezilla is still better at this I think.

## time date

  ## cal

    # cout an ASCII art calendar:

      cal

  ## date

    # POSIX 7.

    # Get system date:

      date

    # Format current time and output it:

      date "+%Y-%m-%d-%H-%M-%S"

    ## gnu extensions

      # Set system date:

        sudo date -s "1 JUN 2012 09:30:00"

  ## hwclock

    #see hardware clock time:

      sudo hwclock --show

    #sync hardware clock to system clock

      sudo hwclock --systohc

  ## set you time zone

    #on dual boot with windows there are conflicts because Windows uses local time, and Linux UTC (more logical...). you must either tell Linux to use local, or better, Windows to use UTC

      $TIMEZONE_LOCATION=/usr/share/zoneinfo
      cd $TIMEZONE_LOCATION
      ls
      $TIMEZONE_NAME=
      cp $TIMEZONE_LOCATION/$TIMEZONE_NAME /etc/localtime

## editor IDE

  ## vim

    # Move very fast with your keyboard without using a mouse.

    # Works inside terminals therefore no need for X display manager

    #gvim, runs in gtk outside command line
    #and thus gets around many command line limitations such as reserved shortcuts

      gvim

  ## Libreoffice

    # Project contains wysiwyg text editor, tables, image editor, database management.

    # How to add new spellchecking language:<http://askubuntu.com/questions/72099/how-to-install-a-libreoffice-dictionary-spelling-check-thesaurus>

    ## Calc

      # Always show a row or column, specially the header if the table is long:

      # - click on column that *follows* the one that should always show
      # - Window > Freeze

## text

  ## echo

    #POSIX 7>

    ## versions

      #POSIX says that: A string to be written to standard output.

        #If the first operand is -n, or if any of the operands contain a <backslash> character,
        #the results are implementation-defined.

      #Which means that is your `echo` input statrs with `-n` or contains a backslash `\`,
      #behaviour is undetermined.

      #To make things worse, in practice different implementations *do* have different standards.

      #- On Ubuntu 13.04, `sh` has an `echo` built-in.

        #This version only accepts `-n` as a command line option,
        #and backslash escapes are always interpreted.

      #- `/bin/echo` by GNU. On Ubuntu 13.04, `bash` has no built-in called `echo`,
        #and therefore uses this one.

        #In this version, you need to use the `-e` option to activate the backslash escapes.

        #It seems that this is is slighltly *not* POSIX compliant since other options are introduced
        #such as `-e`, and POSIX seems to mandate that such strings be printed (`echo -e 'a' would print `-e a`)

      #The message then is clear: if you want to use escape chars, or ommit the ending newline,
      #do *not* use `echo`. Or even better, never use echo, only `printf`.

    #print to stdout:

      [ "`echo a`" = a ] || exit 1

    #multiple arguments are space separated:

      [ "`echo a b c`" = "a b c" ] || exit 1

    ## gnu implementation

      #As explained in the versions section, POSIX does not specificy behaviour
      #if `-n` input starts or if input contains `\n`, and in practice inplementations
      #recognze other command line options besides `-n`.

      #Appends newline at end by default.

      #-n: no final newline:

        echo -n a

      #Does not interpret `\` escaped chars by default:

        [ "`echo 'a\nb'`" = $'a\\nb' ] || exit 1

      #-e: interprets \ escaped chars:

        [ "`echo -e 'a\nb'`" = $'a\nb' ] || exit 1
        [ "`echo -e '\x61'`" = $'a' ] || exit 1

      #Print the `-n` string:
      #IMPOSSIBLE! not even gnu echo supports `--` since POSIX says that this should be supported.
      #=) use `printf`.

  ## printf

    # POSIX 7.

    # Goes around echo's quicks.

    # Anlogous to C printf.

    # Does not automatically append newline:

      [ "`printf "a"`" == "a" ] || exit 1

    # Automatically interprets backslash escapes like C printf:

      printf "a\nb"

    # Automatically interprets backslash escapes like C printf:

    # Print the `-n` string:

      [ "`printf "%s" "-n"`" == "-n" ] || exit 1

    # Supports C format strings:

      [ "`printf "%1.2d" 1`"    == "01" ] || exit 1
      [ "`printf "%1.2f" 1.23`"  == "1.23" ] || exit 1

    # Print the `-n` string:

      [ "`printf "%s" "-n"`" == "-n" ] || exit 1

    # Print a string ignoring all escape sequences (always appends terminates in a single newline):

      printf "%s\n" "\n\r"

    # Never terminate in a newline:

      printf "%s" "\n\r"

    # Include trailling newlines:

      TODO

    # Do interpret the escapes:

      printf "%ba" "\n"

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

  ## rev

    # Reverse bytewise.

      [ "`printf 'ab\n' | rev`" = $'ba' ] || exit 1

  ## pagers

    ## less

      # File pager (viewer).

      # Advantages over Vim:

      # - loads faster

      # Disadvantages over Vim:

      # - much less powerful

      # - `/`: search forward
      # - `n`: repeat last search
      # - `d`: down one page
      # - `u`: up one page
      # - `g`: top of document
      # - `G`: bottom of document
      # - `g`: top of document
      # - `<ENTER>`: down one line
      # - `-S` : toogle line wrapping

        less "$f"
        printf 'ab\ncd\n' | less

      # - `-R` : interpret ANSI color codes

        # Rubbish:

          ls --color | less

        # Colors!:

          ls --color | less -R

    ## more

      # Worse than less:

        echo a | more

    ## pg

      # Worse than more:

        echo a | pg

    ## pr

      # Break file into pages with a certain number of lines
      # and print to stdout:

        ( for i in `seq 200`; do echo a; done ) | pr

  ## nl

    # POSIX 7

    # CAT LInes, number non-empty ones:

      nl "$f"

  ## fold

    # Wrap lines.

    # POSIX 7

      echo -e "aaaa\nbb" | fold -w 3
        #aaa
        #a
        #bb

    #-s: only break at spaces:

      [ "`echo -e "12345 6" | fold -s -w 3`" = $'123\n45\n6' ] || exit 1

  ## fmt

    # coreutils.

    # Wrap lines, but don't cut words

      [ `echo "a bcd" | fold -w 2` = $'a\nbcd' ] || exit 1

  ## column

    # bsdmainutils

    # If the input would be larger than the current terminal column count,
    # format it into newspaper like columns.

      seq 100 | column

    # Sample output:

      1	6	11	16	21	26	31	36	41	46	51	56	61	66	71	76	81	86	91	96
      2	7	12	17	22	27	32	37	42	47	52	57	62	67	72	77	82	87	92	97
      3	8	13	18	23	28	33	38	43	48	53	58	63	68	73	78	83	88	93	98
      4	9	14	19	24	29	34	39	44	49	54	59	64	69	74	79	84	89	94	99
      5	10	15	20	25	30	35	40	45	50	55	60	65	70	75	80	85	90	95	100

    # Sample output:


    # `-t`: format data into table format. Inteligently uses a separator char
    # `-s`: set the separator char


      printf '123|1|12345\n12345|123|1\n' | column -ts'|'

    # Sample output:

      123    1    12345
      12345  123  1

  ## tsort

    # Topological sorting:
    # <http://en.wikipedia.org/wiki/Tsort_%28Unix%29>

      printf '1 2\n2 3\n' | tsort
        #1
        #2
        #3

      printf '1 2\n2 1\n' | tsort
        #contains loop
      echo $?
        #1

  ## split

    # corutils.

    # Split files into new smaller files of same size

      echo -n abc > f

      split -db1 f p
      split -dn3 f p

      [ `cat p00` = a ] || exit 1
      [ `cat p01` = b ] || exit 1
      [ `cat p02` = c ] || exit 1

    # Existing files are overwritten:

    # Options:

    # - `d`: uses number suffixes, otherwise, uses letters aa, ab, ac, ...
    # - `b`: bytes per file
    # - `n`: number of files

  ## csplit

    #corutils.

    # Split files into new smaller files at lines that match given EREs.

    # Matching lines are kept.

      printf '0\naa\n1\naa\n2\n' > f
      csplit f '/^a/' '{*}'
      [ `cat xx00` = 0 ] || exit 1
      [ `cat xx01` = $'aa\n1' ] || exit 1
      [ `cat xx02` = $'aa\n2' ] || exit 1

  ## paste

    # POSIX 7.

    # Useless

    # Shows files side by side line by line.

    # Default separator: tab.

    # Long lines will make this unreadable.

      echo -e "a a a a a a a a a a a a a a\na" > a
      echo -e "b b\nb b"            > b
      echo -e "c c\nc c\nc"          > c
      paste a b c

  ## expand

    # POSIX 7

    # Expand tabs to spaces:

      echo -e "a\tb" | expand

    ## unexpand

      #contrary

  ## seq

    # Counts to stdout.

      seq 1
      seq 1 3
        #1
        #2
        #3

      seq 1 2 5
        #1
        #3
        #5

    # Options:

    # - `s`: separator
    # - `w`: equal width

    ## non-application

      # You could use this for loops:

        for i in `seq 10`; do echo $i; done

      # But don't

      # Use brace expansion instead which is a bash built-in,
      # and thus potentially faster (possibly no new process spawned):

        for i in {1..10}; do echo $i; done

      # Use this only if you really need to control
      # the output with the options.

  ## path operations

    ## basename ##dirname

      # POSIX 7

        [ "$(dirname  "/path/to/dir/or/file")" = "/path/to/dir/or" ] || exit 1
        [ "$(basename "/path/to/dir/or/file")" = "file"            ] || exit 1

        [ "$(dirname  "/")" = "/" ] || exit 1
        [ "$(basename "/")" = "/" ] || exit 1

      # Extensions can be extracted naively with variable expansion, but it is not trivial to make it work for dot files.

  ## strings

    # Search for printable strings in file.

    # Prints sequences of at least 4 printable chars by default.

    # Useful to extract information from non textual formats,
    # which contain some textual data

      gcc c.c
      strings a.out

## moreutils

  #extra base linux utils

    sudo aptitude install moreutils

  ## sponge

    #solves the input to output problem problem

    #setup:

      printf '0\n1\n' > a

    #fails:

      grep 0 a | cat > a
      [ "`cat a`" = '' ] || exit 1

    #works:

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

## character encoding

  ## chinese

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

## cron

  # Tell the computer to do things at specified times automatially.

  ## crontab

    # POSIX 7.

    # Utility to manage crobjobs.

    # It is basically a frontend for the `/etc/crontab` file which an be edited directly.

    # It is not possible launch graphical applications via cron!

    # Edit user cron jobs in vim

      crontab -e

    # Sample line:

      1 2 3 4 5 /path/to/cmd.sh arg1 arg2 >/dev/null 2>&1

    # Fields:

    # - 1: Minute (0-59)
    # - 2: Hours (0-23)
    # - 3: Day (0-31)
    # - 4: Month (0-12 [12 == December])
    # - 5: Day of the week(0-7 [7 or 0 == sunday])
    # - /path/to/command - Script or command name to schedule#

    # Special notations:

    # - * : every
    # - */5 : every five
    # - 1,3,6 : several
    # - 1-5 : ranges

    # Convenient altenatives to the fields:

    # - @reboot	Run once, at startup.
    # - @yearly	Run once a year, "0 0 1 1 *".
    # - @annually	(same as @yearly)
    # - @monthly	Run once a month, "0 0 1 * *".
    # - @weekly	Run once a week, "0 0 * * 0".
    # - @daily	Run once a day, "0 0 * * *".
    # - @midnight	(same as @daily)
    # - @hourly	Run once an hour, "0 * * * *".

    # Example:

      @daily /path/to/cmd.sh arg1 arg2 >/dev/null 2>&1

    # `>/dev/null 2>&1` prevents cron from sending notification emails.

    # Otherwise if you want them add:

      #MAILTO="vivek@nixcraft.in"

    # to the config file.

    # List all cronjobs:

      crontab -l

    # List all cronjobs for a given user:

      crontab -u user -l

    # Erase all cronjobs:

      crontab -r

    # Erase all cronjobs for a given user only

      crontab -r -u username

  ## batch

    # POSIX 7

    # Superset of `at`.

    # Execute only when system load average goes below 1.5,
    # starting from now!

      cd "`mktemp -d`"
      echo "touch a" | batch

    # Same, but with at you can change to any time:

      echo "touch a" | at -q b now

  ## at

    # Schedule job at a single specified time.

    # Not for a periodic jobs.

      cd "`mktemp -d`"
      echo "touch a" | at now + 1 minutes
        #in one minute `test -f a`
      echo "echo a" | at now + 1 minutes
        #nothing happens!
        #of course, job does not run in current shell
      echo "xeyes" | at now + 1 minutes
        #nothing happens

    # List jobs:

      atq

    # Remove job with id 1:

      atrm 1

    # Id can be found on atq output.

    #inner workings

      echo "touch a" | at now + 10 minutes
      d=/var/spool/cron/atjobs
      sudo cat "$d/$(sudo ls "$d" | head -n 1)"
        #note how the entire environment
        #and current dir are saved and restored

      sudo cat /usr/lib/cron/at.allow
        #if exists, only listed users can `at`
      sudo cat /usr/lib/cron/at.deny
        #if allow exists, this is ignored!
        #if not, denies only to listed users

## system info

  ## uname

    #POSIX 7.

    # Gets information on host computer.

    # Print all info uname has to give:

      uname -a

    # This includes kernel version, user, ...

    # You can each isolated with other opts.

  ## lsb_release

    # Command required by the LSB.

    # Get distro maintainer, name, version and version codename:

        lsb_release -a

    # Extract id programmatically to autodetect distro:

        distro_id="$(lsb_release -i | sed -r 's/.*:\t(.*)/\1/')"
        distro_version="$(lsb_release -r | sed -r 's/.*:\t(.*)/\1/')"

  ## Processor ##CPU

    ## arch

      # Architecture of the OS, not CPU hardware: Subset of uname.

        arch

      # Sample outputs:

        #i686
        #x86_64

    ## mpstat

      # Processor related stats:

        mpstat

    ## nproc

      # Number of processing unites (= cores?).

      # coreutils

        nproc

    ## cpuinfo

      # CPU info dev file:

        cat /proc/cpuinfo

      # Check if CPU is 64 bit:

        cat /proc/cpuinfo | grep flags | grep lm

      # `lm` is a standard CPU flag that stands for Long Mode and indicates exactly support for 64 bit.

      # Meaning of all flags: <http://unix.stackexchange.com/questions/43539/what-do-the-flags-in-proc-cpuinfo-mean>

    # RAM info dev file:

      cat /proc/meminfo

    # RAM info dev file:

	## lspci

		sudo lspci

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

## read

  # Read from stdin and stores in shell variables.

  #Therefore, this *must* be a shell BUILTIN, since it modifies shell variables directly

  #POSIX 7.

  #Get string from user into variable `a`:

    #read a
    #echo "$a"

  #Cannot write with pipe into read because the pipe spawns a subshell,
  #which cannot modify a variable in its parent shell:
  #<http://stackoverflow.com/questions/13763942/bash-why-piping-input-to-read-only-works-when-fed-into-while-read-const>

    a=a
    echo b | read a     #`read a` is executed in a subshell!
    [ $a = a ] || exit 1

  #Creating a subshell does work however:

    echo abc | ( read b; [ $b = abc ] || exit 1 ) || echo fail

  #and so do while combos, which also create one subshell per loop body:

    while read l; do
      echo "$l"
    done < <( echo -e "a\nb\na b" )

  #Read from file descriptor linewise and assign to variable.

    ## applications

      #Read file linewise:

        #while read l; do
        #  echo "$l";
        #done < "$f"

      #Read stdout linewise:

        while read l; do
          echo "$l"
        done < <( echo -e "a\nb\na b" )

      #Split into fields:

        #IFS_OLD="$IFS"
        #while IFS=' : ' read f1 f2
        #do
        #  echo "$f1 $f2"
        #done < <( echo -e "a : b\nc : d" )
        #IFS="$IFS_OLD"

  ## GNU extensions

    #-p print a prompt message:

      read -p "enter string: " s
      echo "you entered $s"

## process

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

  ## timeout

    # Run command for at most n seconds, and kill it if it does not finish in time

    # coreutils

      [ `timeout 3 bash -c 'for i in {1..2}; do echo $i; sleep 1; done'` = $'1\n2\n' ] || exit 1
      [ `timeout 1 bash -c 'for i in {1..2}; do echo $i; sleep 1; done'` = $'1\n' ] || exit 1

  ## flock

    # Puts an advisory file lock on given file while a command executes:

      touch a
      flock a sleep 5 &

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

  ## cp

    # POSIX

    # Copy files and dirs.

    ## file

      # If dest does not exist, create it:

        echo a > a
        cp a b
        [ "`cat b`" = $'a' ] || exit 1

      # If dest exists and is dir, copy into dir:

        mkdir d
        cp a d
        [ "`cat d/a`" = $'d/a' ] || exit 1

      # If dest exists and is file, overwrite without asking!

        echo a > a
        echo b > b
        cp a b
        [ "`cat b`" = $'a' ] || exit 1

    ## GNU extensions

      # The following GNU extensions are very useful and did not fit into any other category:

      # - `-v`: be verbose and print a message saying what cp is doing.

        # Useful when copying a lot of files in an interactive session
        # to check if that progress is going on.

    ## dir

        function setup_test
        {
          mkdir d
          echo a > a
          echo a > d/a
          mkdir d2
          mkdir d2/d
          echo A > d2/d/a
          echo b > d2/d/b

          mkdir d3
          cd d3
          ln -s ../d2 d
          cd ..
        }

        function teardown_test
        {
          rm -r a d d2 d3
        }

      # Must use recursive `-R`, even if dir is empty

        setup_test
        if cp d e; then assert false; fi
        teardown_test

        setup_test
        cp -R d d2
        [ -d d2 ] || exit 1
        teardown_test

      # `-r` on GNU is the same as `-R`, but is a GNU extensionto POSIX 7.

      # Unlike move, can copy into dir recursively overwritting by default:

        setup_test
        cp -R d d2
        [ "`ls d2/d`"  = 'a b' ] || exit 1
        [ "`cat d2/d/a`" = 'A' ] || exit 1
        [ "`cat d2/d/b`" = 'b' ] || exit 1
        teardown_test

      # If fails however if you try to overwrite a file with a dir:

        setup_test
        if cp -R d a; then assert false; fi
        teardown_test

      # It also fails if you try to overwrite a link to a dir with a dir:

        setup_test
        if cp -R d d3; then assert false; fi
        teardown_test

    ## symlink

      # By default, for files copies content of symlinks to new files/dirs:

        echo a > a
        ln -s a b
        ln -s b c

        cp c d
        [ -f d ] || exit 1
        [ "`cat a`" = $'a' ] || exit 1

      # With the `-d` GNU extension, copies symlink to files into new symlinks (mnemonic: no-Dereference):

        cp -d c e
        [ -L d ] || exit 1

      # For dirs by default copies symlink into a new symlink:

        mkdir d
        ln -s d dln
        cp dln e
        [ -L e ] || exit 1

      # To dereference symlinks to directories, use `-L`:

        mkdir d
        ln -s d dln
        cp -L dln e
        [ -d e ] || exit 1

      # Does not work with `-r`. Probable rationale:
      # the only thing this could do is to copy dirs
      # and symlink files. But then why not do this with hardlinks?

    ## hardlink

        echo a > a
        cp -l a b
        ln -l a b
        [ "`stat -c '%i' a`" = "`stat -c '%i' b `" ] || exit 1

      # With `-r`, makes dirs, and hardlinks files:

        mkdir d
        touch d/a
        touch d/b
        cp -lr d e
        [ "`stat -c '%i' d/a`" = "`stat -c '%i' e/a `" ] || exit 1
        [ "`stat -c '%i' d/b`" = "`stat -c '%i' e/b `" ] || exit 1

      # If `-l` is used, does not overwrite file:

        echo a > a
        echo b > b
        if cp -l a b; then assert false; fi

      # But can overwrite if `-f` is given:

        cp -fl a b

    ## applications

      # Copy all files from a directory into another existing directory (including hidden):

        cp -dR from/. to

  ## rsync

    # Very powerful and flexible file copy tool.

    # Can:
    #
    # -   work over networks. Both machines must have it installed.
    #
    #     Capable of compressing before sending over the network, and decrompressing on the other side.
    #
    # -   synchronize differentially
    #
    # -   encrypt files sent

    # Useful options:

    # - `-a`: "archive mode".

        # rsync -a origin dest

      # Sets : `-Dgloprt`

      # Does what you want it to do, before you notice you need it:

      # - `-D`: preserve special and device files. Requires sudo.
      # - `-g`: preserve group. Requires `sudo`.
      # - `-l`: copy symlinks as symlinks.
      # - `-o`: preserve owner. Requires `sudo`.
      # - `-p`: preserve permissions.
      # - `-r`: recurse into directories.
      # - `-t`: preserve modification times.

    # - `--exclude=`: Exclude directories.
    # - `-v`: verbose
    # - `-z`: compress files before transfer, decompress after.

      # Useful if transfer will be done over a network,
      # so that smaller files can be transferred.

    # Combos:

      # Back up everything except `/media` (where the backup will go to), and `/home`.

        #sudo rsync -av --exclude=home --exclude=media / /media/SOMETHING/bak

      # WARNING: your disk must be ext4, not NTFS, or permissions are impossible.
      # In that case: http://unix.stackexchange.com/questions/11757/is-ntfs-under-linux-able-to-save-a-linux-file-with-its-chown-and-chmod-settings

  ## rm

    # Remove files and dirs.

    # -r: recursive. Mandatory for directories. Potentially dangerous.

  ## recover data removed with rm like tools

    # `rm` only removes files from filesystem indexes, but the data remains in place
    # until the event that another file is writen on it, which may take severl minutes or hours.

    # Even after the file data overwritten few times, it is still possible to recover
    # the data using expensive forensic methods (only viable for organizations).

    # To permanently remove data from hard disk, you must use a tool like shred,
    # which writes certain sequences to the hard disk, making it impossible to
    # recover the data even with forensic methods.

    # Such operations take a very long time, and are not viable on entire hard disks,
    # so if you serious about clearing a hard disk, mechanical desctruction is a better option
    # (open the hard disk case and destroy the disk).

  ## rename

    # Mass file regex renaming.

    # Dry run:

      rename -n 's/^([0-9]) /0$1 /g' *.mp3

    # Act:

      rename 's/^([0-9]) /0$1 /g' *.mp3

  ## cpio

    #TODO

    find . ! -iname '* - *' -type f -print | cpio -pvdumB './no author'
    #find selected files to destination, building and keeping their relative directory structure

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

  ## mknod

    # Create character, block or FIFO (named pipe) files.

    # Make a char file with major number 12 and minor number 2:

      sudo mknod /dev/coffee c 12 2

  ## chown

    # POSIX 7

    # Change owner and group of files.

    # You must use sudo to do this, because otherwise users would be able to:

    # - steal ownership of files
    # - git ownership to users who do not want to own the files

      su a
      mkdir d
      touch d/f
      sudo chown newuser:newgroup d
        #must use sudo to chown
      [ `stat -c '%U' d` = newuser ] || exit 1
      [ `stat -c '%G' d` = newgroup ] || exit 1
      [ `stat -c '%U' d/f` = a ] || exit 1

    # `-R` for recursive operation:

      su a
      mkdir d
      touch d/f
      sudo chown b d
      [ `stat -c '%U' d` = newuser ] || exit 1
      [ `stat -c '%G' d` = newgroup ] || exit 1
      [ `stat -c '%U' d/f` = newuser ] || exit 1
      [ `stat -c '%G' d/f` = newgroup ] || exit 1

    # To change only user:

      sudo chown newuser

    # To change only group:

      sudo chown :newgroup

  ## chmod

    # POSIX

    # Change file permissions

    # Syntax:

      # chomod [ugoa][+-=][rwxXst]+

    # Make f executable for all (owner, group and other);

      chmod a+x "$f"

    # Makes f readable for all:

      chmod a+r "$f"

    # The difference between using `a` and nothing is that when using
    # nothing `umask` comes into play.

      umask 002
      chmod +w "$f"
      stat -c "%a" "$f"
        #220
      chmod a=w "$f"
      stat -c "%a" "$f"
        #222
      chmod o=w "$f"
      stat -c "%a" "$f"
        #002

    # Make f not executable for all:

      chmod -x "$f"

    # Make file not executable and not writeble by all:

      chmod =r "$f"

    # Make f executable for owner:

      chmod u+x "$f"

    # Makes f executable for group and other:

      chmod go+x "$f"

    # Makes f readable and writible for all:

      chmod +rw "$f"

    # Same as `chmod =rwx`:

      chmod 777 "$f"

    ## sticky bit, suid sgid bits

      # Sticky bit:

        chmod 1000 "$f"
        chmod o=t "$f"
        chmod a=t "$f"
        stat -c "%A" "$f"
          #---------T
        chmod a-t "$f"
        chmod u=t "$f"
        chmod g=t "$f"
        stat -c "%A" "$f"
          #---------T
        chmod =s "$f"
        chmod 6000
          #set suid and sgid
        chmod u=s "$f"
        chmod 4000
          #set suid and sgid
        chmod g=s "$f"
        chmod 2000

      # Can't clear them on numeric mode, only symbolic:

        chmod 7777 f
        stat -c "%A" "$f"
          #-rwsrwsrws
        chmod 0 f
        stat -c "%A" "$f"
          #---S--S--T
        chmod a-st f
        stat -c "%A" "$f"
          #----------

    # Can only change permissions for files you own
    # even if you do not have all the permissions on the file:

      su a
      touch a
      chmod 777 a
      su b
      if ! chmod 770 a; then assert true; fi

  ## umask

    # Shows/sets permissions that will be *removed*.

    # This is system call implemented, not shell implemented,
    # and interacts with certain system calls such as `open`.

    # Has direct effect on commands such as `chmod` and `touch`.

      touch a
      ls -l a
        #rw-rw-r--
      umask
        #002
        #ok the other w was removed
        #the x are not set by touch by default
      umask 0
      touch b
        #rw-rw-rw-
      umask 777
      touch c
        #---------

  ## stat

    # POSIX

    # CLI for sys_stat.

    # Get file/dir info such as:

    # - size
    # - owner
    # - group
    # - permissions
    # - last access date
    # - create date
    # - modify date

    # Example:

      touch f
      stat f

    ## -c

      # Format string:

        chmod 1234 f
        [ `stat -c "%a" f` = "234" ] || exit 1

        chmod a=rt f
        [ "`stat -c "%A" f`" = "-r--r--r-T" ] || exit 1

      # Inode:

        touch a
        ln a b
        [ "`stat -c "%i" a`" = "`stat -c '%i' b`" ] || exit 1

    ## --print

      # Like `-c` but interprets escapes like `\n`:

        touch a
        echo "`stat --print "%a\n%a\n" a`"
        [ "`stat --print "\n" a`" = $'\n' ] || exit 1

  ## links

    ## ln

      # Make hardlinks and symlinks

      # This can also be done with `cp`

      # Hardlink:

        ln dest name

      # Symlink files only:

        ln -s dest name

      # Symlink dir:

        ln -ds dest name

      # The link will be created even if the destination does not exist:

        ln -s idontexist name

      # If the name is in another dir, the destination is not changed by default:

        mkdir d
        ln -s a d/a
        [ `readlink d/a` = a ] || exit 1

      # To create relative to dest use `-r`:

        mkdir d
        ln -rs a d/a
        [ `readlink d/a` = ../a ] || exit 1

      # If the name is in another dir, the destination is not changed by default:

      # Absolute link:

        ln /full/path/to/dest name
        [ `readlink name` = "/full/path/to/dest" ] || exit 1

    ## readlink

      # Get target of symlink

        touch a
        ln -s a b
        ln -s b c

        [ "`readlink c`" = $'b' ] || exit 1
        [ "`readlink b`" = $'a' ] || exit 1

      # Recursive:

        [ "`readlink -f c`" = $'a' ] || exit 1

    ## realpath

      # Resolve all symbolic links and '.' and '..' entries of a path recursivelly

      # Prefer readlink which is more widespread by default in distros

        mkdir a
        ln -s a b
        cd a
        touch a
        ln -s a b
        cd ..
        realpath ./b/b

      # Output:

        = "`pwd`/a/a"

      # readlink -f

        # Same as:

          readlink ./b/b

        # and is part of coreutils, so more widespread default.

  ## fuser

    #psmisc package

    # Determines which process are using a file or directory.

    # Can send signals to those processes.

      fuser .

    # Shows pids followed by a suffix:

    # -`c`: current directory
    # -`e`: executable being run
    # -`f`: open file. f is omitted in default display mode
    # -`F`: open file for writing. F is omitted in default display mode
    # -`r`: root directory
    # -`m`: mmap’ed file or shared library

    # You will have at least one process here: your bash

    # Also Show program and user:

      fuser -v .

    # Check process using tcp/udp ports:

      fuser -v -n tcp 5000

  ## mktemp

    # Create temporary files in the temporary directory.

    # Creates a temporary file in `/tmp/`:

      f="$(mktemp)"
      echo "$f"
      assert test -f "$f"
      rm "$f"

    # Directory:

      d="$(mktemp -d)"
      echo "$f"
      assert test -d "$d"
      rm -r "$d"

    # Custom name template:

      f="$(mktemp --tmpdir abcXXXdef)"
      assert echo "$f" | grep -E 'abc...def'
      assert test -f "$f"
      rm "$f"

    # Must use `--tmpdir` with template or else file is created in current dir

  ## pathchk

    # Check if path is portable across POSIX systems:

      pathchk -p 'a'
      pathchk -p '\\'

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

  ## tty

    # Show current tty:

      tty

    # Sample output:

      #/dev/pts/1

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

## setleds

  # Set/get capslock, numlock and scrolllock led state;

  # Only works from tty (ctrl+alt+F[1-6] on ubuntu);

    setleds
