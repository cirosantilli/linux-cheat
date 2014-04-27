#!/usr/bin/env bash

##about

  # This file is being cut up into smaller files.

  # Distribution specific installation procedures are put outside of this section.

  # For a summary of up to level 2 header: `grep -E '^[[:space:]]{0,4}##' %`.

##sources

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

##man

  # The manuals.

  # POSIX 7 specifies only the option `-k` and nothing about pages,
  # those are Linux concepts.

  ##pages

    # The manual is organized into 7 pages.

    # When you install a new page, the developers decide where to put the documentation.

    # Every page has an intro section which says what it is about:

      man 2 intro
      man 3 intro

    # As in the case of the intro, you can distinguish ambiguities by giving the page number.

    # `write` system call:

      man 2 write

    # `write` shell command:

      man 1 write

    # List all entries of a page:

      man -k . | grep '(8)'

    # - 1: user commands (executables in path)

      # This is normally the largest section.

        man 1 passwd

    # - 2: system calls (c interface)

      # Those are *not* actual system calls, but portable low level system interfaces.

      # Most of the POSIX C library is here.

      #  POSIX write function:

        man 2 write

    # - 3: library. system call wrappers.

      # Higher level than 2.

      # Distinction from `man 2` is hard to tell.

      # Contains for example:

      # - some POSIX apis like pthreads
      # - X11 APIs

    # - 4: special files such as device files

        man 4 zero
        man 4 random
        man 4 mouse

    # - 5: file formats specifications.

      # Examples:

      # `/etc/passwd` file syntax:

        man 5 passwd

      # elf executable format:

        man 5 elf

    # - 6: games

    # - 7: standards.

      # Contains standards summaries such as:

        man unicode
        man url
        man X

    # - 8: system administration

      # Commands that mostly only root can do.

      # Their binaries are typically under `/usr/sbin/`.

      # Examples:

        man 8 adduser
        man 8 grub-install
        man 8 mount

  ##GNU command line options

    # Exact search on title. Shows only first page found match:

      man intro

    # shows each match in succession and asks if you want to continue on each quit:

      man -a intro

    # Search for commands with password word on summary:

      man -k password

    # Search on all of manual pages, may take some time:

      man -K password

    ##--regex

      # Whatever you were searching search with ERE now.

      # Regex on title:

        man --regex 'a.c'

      # Regex on entire manual:

        man --regex -K 'a.c'

      # Same

        apropos password

    # List all manual pages pages whose summaries match '.' regex: anychar)

      man -k .

  ##linux man-pages project

    # <https://www.kernel.org/doc/man-pages/>

    # Project that maintains many Linux related manpages and also some non Linux specific entries.

    # Most distros to come with those manpages installed.

    # It is not a part of the kernel tree, and does not seem to be mentioned in the LSB.

  ##whatis

    # Non POSIX

    # Show man short description of ls

      whatis ls

  ##manpath

    # Man search path

    # Non-POSIX

      manpath

    # Sample output:

      #/usr/local/man:/usr/local/share/man:/usr/share/man

    # Languages man:

      ls /usr/share/man

    # Section 1 pages in English:

      ls /usr/share/man/man1 | less

##info

  # GNU specific.

  # Each page contains lots of info, more than man pages
  # may even contain, *gasp*, examples!

  # The keybindings are very tree/node based. To get started:

    # - ?: help
    # - x: close help

    ##page

      # - <space>:  down one page. May change nodes.
      # - <backspace>: up one page. May change nodes.
      # - b, e: beginning/end of current node.
      # - s, /: search string
      # - {, }: repeat search back/forward

    ##menu

      # - <arrows>: move cursor
      # - <enter>: go to link under cursor
      # - <tab>: go to next link
      # - 1-9: go to menu item nb.
      # - m: select menu item in current page by name.
      #     can tab complete.
      #     even without tab complete, goes to first match on enter.

    ##node

      # - u: parent node
      # - t: top node
      # - [, ]: next previous node. May   change node level.
      # - n, p:             not
      # - l: go to last viewed node. can be used several times.
      # - g: like m, but search all nodes

    ##search

      # - /: regex
      # - {: next   match of previous search
      # - }: previous

  info
  info rm

##configuration

  ##Ubuntu

    #TODO: explain or remove

      #sudo aptitude install -y myunity

    #jockey

      # Additional drivers : non free vendors

      # List:

        jockey-text --list

      # Enable from list. E.g.: xorg:fglrx_updates:

        jockey-text --enable=$DRIVER

##chat ##messaging

  ##mseg write wall

    # Write messages to other users on the system.

    ##mseg

      # Enable/disable messages:

        mseg n
        mseg
          #n
        mseg y
        mseg
          #y

    ##write

      # Write to a user in a TTY:

        u=
        write $u tty3

      # Now:

      # - type you message
      # - type enter, and it is sent
      # - hit Ctrl + D and its over

        u=
        h=
        sudo write $h@$u tty2

    ##wall

      # Write to all:

        wall

      # Type you message. It is only sent after you ctrl+d

      # Sends to all even if disabled:

        sudo wall

      # Play with it:

        #go to tty3. on ubuntu: ctrl+alt+f3
        #login as user u
        mesg y
        #go to tty7 (xserver). on ubuntu: ctrl+alt+f7
        sudo write u tty3
        #write
        #go to tty3
        #your message is there!

  ##talk

    #commandline chat program

    #posix

    sudo aptitude install -y talk

    #TODO use it. lazy now.

  ##irc

    #internet relay chat

    #servers have channels

    #log into a server, join a channel

    #messages can be seen

      #- by all people on channel
      #- certain people you write to only

    #you cannot see read old messages
    #sent when you were not logged in!!

    #it is also possible to send files to people

    ##commands

      #intro: <http://www.irchelp.org/irchelp/irctutorial.html>

      #full list: <http://en.wikipedia.org/wiki/List_of_Internet_Relay_Chat_commands>

      #/connect <server>

      ##ubuntu channel

          ##register

            xdotool type "/msg nickserv register $password $email"

          ##verify registration

            #go to your email and get the registration code

            regcode=
            xdotool type "/msg nickserv verify register $uname $regcode"

    ##clients

      ##pidgin

        #good because integrates with other ims

        ##create account

          #irc server + username on that server == a pidgin account

          #add account > irc

          #enter server username and pass

        ##join/create channel:

          #an irc channel == a pidgin chat

          #chats appear on the buddy list like buddies

          #buddies > join a chat > choose server, enter a #channel_name

          #if you don't know the name and want to list the available channels,
          #enter any #name, and then /list there

          #a chat window appear, mapping to the chosen channel on chosen sever

          #if you close the chat window, it will not be on your buddy list anymore

        ##add channel to buddy list permanently:

          #buddies > add a group. name it "irc".

          #buddies > show > empty groups

          #buddies > add a chat. choose type irc, server, channel.

    ##irssi

      #ncurses

##programming

  ##pkg-config

    #info is contained in "$PKG_NAME.pc" files located mainly under:

      #/usr/share/pkgconfig/
      #/usr/lib/i386-linux-gnu/pkgconfig/

    #a part of program installation may be to put files there

    #usage in in a makefile:

      CFLAGS=$(shell pkg-config --cflags pkgname)
      LIBS=$(shell pkg-config --libs pkgname)

  ##diff

    ##diff

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

    ##comm

      # Ultra simple diff.

      # Useless.

      # POSIX 7.

      cd "`mktemp -d`"
      echo -e "a\nc" > a
      echo -e "b\nc" > b
      comm a b
        #a
        #  b
        #    c

        #3 cols:
          #lines only in a
          #      in b
          #   in both

        #tab separated columns
          #long lines look horrible

    ##patch

    ##wdiff

      # Word oriented diff.

        wdiff a b

      # Not needed if you have 

    ##kiff3

      # KDE 3 way merge tool.

      # Works with `git mergetool`.

        sudo aptitude install -y kdiff3

        kdiff3 f1 f2 -o fout

  ##ack

    #finds and greps
    #nice filename/line/match highlight output
    #ignores .git .svn, backup, swap files
    #can detect and filter by filetype via extension and shebangs

    ##install

        sudo aptitude install -y ack-grep
      #`ack` package was already taken by a kanji converter!

      #this begs for an alias:
        alias ack="ack-grep"

    #Recursive find grep for perl_regex in python files only, detects shebangs:

      ack --py perl_regex

    #Adds all python files git. shebang aware:

      ack -f --py --print0 | xargs -0 -I '{}' git add '{}'

    #Print only include names in cpp files

      ack --cc '#include\s+<(.*)>' --output '$1'

    #--sh for bash

    #`-k`: search in all known filetypes.

    #There seems to be no way to search into *all* files.
    #Well, we have GNU `grep -r` for that...

    ##-f

      #List all filenames of known types:

        ack -f

    ##-g

      #List files of known types that match regex:

        ack -g '\.py$'

    #Easter egg: bill the cat:

      ack --thpppt

    ##combos

      #find lines in files:

        ack -f | xargs grep 'find'

      #dry run replace in files with regex::

        ack -f | xargs -lne 'print if s/a/A/g'

      #only prints modified lines

      #non-dry run replace in files:

        ack -f | xargs perl -pie 's/z/Z/g'

      #prints nothing

  ##exuberant-ctags

    #generate tags for given file

    #this makes it possible for external applications to find symbols defined in this file
    #such as functions, variables, macros, etc

    #supports 55 languages

      exuberant-ctags a.c
      less tags

  ##source-highlight

    #takes in source files and produces highlighted output in one of the formats:

    #- html
    #- ansi terminal escape sequences
    #- pdf

    #list all languages supported:

      source-highlight --lang-list

    #generate an `a.html` highlighted version of `a.py`:

      source-highlight a.py

  ##pygments

    #python package for multi language syntax coloring.

    #take python source, output colored html:

      pygmentize -O full -o test.html test.py
      firefox test.html &

    #-O: options.
      #full is required here, otherwise there would be no header,
      #and the style info would not be put in the html

    #input and output formats here were inferred from extension,
    #but can be explicitly set too.

  ##c99

    #POSIX C99 compiler!

    #On Linux as of 2013, acts as a simple GCC frontend.

    #At first glance `gcc -std=c99` is largely compatible with the POSIX c99.

  ##fort77

    #POSIX fortran compiler.

##file management

  ##krusader

    #KDE extra gear <http://extragear.kde.org/>

    #Features:

    #- useractions

      #Execute shell scripts wich access to things like current directory or selected files

    #- give shortcuts to useractions

      #You can give shortcuts to anything, including user actions!

    #- ftp. Just enter an ftp url on the address bar and it all works.

      #filezilla is still better at this I think.

##time date

  ##cal

    # cout an ASCII art calendar:

      cal

  ##date

    # POSIX 7.

    # Get system date:

      date

    # Format current time and output it:

      date "+%Y-%m-%d-%H-%M-%S"

    ##gnu extensions

      # Set system date:

        sudo date -s "1 JUN 2012 09:30:00"

  ##hwclock

    #see hardware clock time:

      sudo hwclock --show

    #sync hardware clock to system clock

      sudo hwclock --systohc

  ##set you time zone

    #on dual boot with windows there are conflicts because Windows uses local time, and Linux UTC (more logical...). you must either tell Linux to use local, or better, Windows to use UTC

      $TIMEZONE_LOCATION=/usr/share/zoneinfo
      cd $TIMEZONE_LOCATION
      ls
      $TIMEZONE_NAME=
      cp $TIMEZONE_LOCATION/$TIMEZONE_NAME /etc/localtime

##editor IDE

  ##vim

    # Move very fast with your keyboard without using a mouse.

    # Works inside terminals therefore no need for X display manager

    #gvim, runs in gtk outside command line
    #and thus gets around many command line limitations such as reserved shortcuts

      gvim

  ##libreoffice

    # Project contains wysiwyg text editor, tables, image editor, database management.

    # How to add new spellchecking language:<http://askubuntu.com/questions/72099/how-to-install-a-libreoffice-dictionary-spelling-check-thesaurus>

##text

  ##echo

    #POSIX 7>

    ##versions

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

    ##gnu implementation

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

  ##printf

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

  ##yes

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

  ##cat

    # POSIX 7

    # concatenate files to stdout

       echo asdf > a
       echo qwer > b

       [ `cat a` = asdf ] || exit 1
       [ `cat b` = qwer ] || exit 1

       [ `cat a b` = `printf asdf\nqwer` ] || exit 1

    # stdin:

       [ `echo a | cat` = a ] || exit 1

  ##tac

    # cat reversed linewise

    # Coreutils, not posix.

      [ "$(printf "a\nb\n" | tac)" = "$(printf "b\na")" ] || exit 1

    # Things get messy if the input does not end in newline:

      [ "$(printf "a\nb" | tac)" = "$(printf "ba")" ] || exit 1

  ##rev

    # Reverse bytewise.

      [ "`printf 'ab\n' | rev`" = $'ba' ] || exit 1

  ##dd

    # POSIX

    # Menemonic: Duplicate Data.

    # Funny mnemonic: Data Destroyer.

    # Reason: the main use case for `dd` is to manipulate block devices like hard disks at a low level
    # without considering file structure. This makes operations such as disk copy very fast,
    # but can make a wipe a disk by changing two characters of a command.

    ##if of

      # if = input file. If not given, stdin.

      # of = output file. If not given, stdout.

      # echo a | cat:

         echo a | dd

      # cat a:

         echo a > a
         dd if=a

      # cp a b:

        dd if=a of=b

    ##status

      # stop printing status lines:

        echo a | dd status=none

    ##bs

      # How many input and output bytes to read/write at once.

      # Also defines the block size for count, skip and seek.

      # Obs and ibs for output and input seprately.

      # Default values: 512 B.

    ##count

      # copy up to count blocks (defined by bs):

        [ `echo -n 1234 | dd status=none bs=2 count=1` = 12 ] || exit 1
        [ `echo -n 1234 | dd status=none bs=1 count=3` = 123 ] || exit 1

    ##size suffixes

      # -`c`: 1 (char)
      # -`w`: 2 (word)
      # -`kB`: 1000
      # -`K`: 1024
      # -`MB`: 1000*1000
      # -`M`: 1024*1024

      # and so on for G, T, P, E, Z and Y!

        [ `echo -n 123 | dd status=none bs=1c count=1` = 1 ] || exit 1
        [ `echo -n 123 | dd status=none bs=1w count=1` = 12 ] || exit 1

      # The larger the chunck size, the potentially faster file transfers will be.

      # Nowdays, `4M` is a good value for large file transfers.

    ##skip

      # Skip first n input blocks (defined by bs or ibs):

        [ `echo -n 123 | dd status=none bs=1 skip=1` = 23 ] || exit 1

    ##seek

      # Skip first n output blocks (defined by bs or obs):

      # TODO minimal exmaple

    ##conv

      # Comma separted list of options.

      # Most useful ones:

        # ucase: convert to uppercase:

          [ `echo -n abc | dd status=none conv=ucase` = ABC ] || exit 1

        # noerror: ignore read errors, which would otherwise stop the transfer.
        #
        # Prefer a specialized tool like gddrescue to this method.
        #
        # Application: part of your hard disk is broken,
        # but you are willing to risk a faulty full transfer anyways.

    ##iflag oflag

      #TODO

    ##Applications

      # Copy one hard disk to another:

         #sudo dd bs=4M if=/dev/sda of=/dev/sdb

      # Zero an entire block device located at `/dev/sdb`:

         #sudo dd bs=4M if=/dev/zero of=/dev/sdb

      # As of 2013 with mainstream system specs,
      # this took around 6 minutes on a 2GiB flash device (5.0 MiB/s).

      # If you are really serious about preventing forensic data recovery,
      # use a program for with a more advanced algorithm, or just destroy the hard disk.

  ##pagers

    ##less

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

    ##more

      # Worse than less:

        echo a | more

    ##pg

      # Worse than more:

        echo a | pg

    ##pr

      # Break file into pages with a certain number of lines
      # and print to stdout:

        ( for i in `seq 200`; do echo a; done ) | pr

  ##nl

    # POSIX 7

    # CAT LInes, number non-empty ones:

      nl "$f"

  ##fold

    # Wrap lines.

    # POSIX 7

      echo -e "aaaa\nbb" | fold -w 3
        #aaa
        #a
        #bb

    #-s: only break at spaces:

      [ "`echo -e "12345 6" | fold -s -w 3`" = $'123\n45\n6' ] || exit 1

  ##fmt

    # coreutils.

    # Wrap lines, but don't cut words

      [ `echo "a bcd" | fold -w 2` = $'a\nbcd' ] || exit 1

  ##column

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

  ##sort

    # Sort linewise.

    # Uses External R-Way merge.
    # This algorithm allows to sort files that are larger than RAM memory.

    # Sort f1, f2 together linewise:

      sort f1 f2

    # Useful options:

    # -r : reverse order
    # -n : numbers
    # -u : uniq. remove dupesls -lh | sort -k5hr
    # -t: : set field separator to ':'
    # -k5 : sort by field N
      # -k 2,2n -k 4,4hr : sort by columns. from 2 to 2, numeric, then from 4 to 4, human and reverse
    # -R : randomize
    # -h : sort by human readable filesizes: 1k, 2M, 3G
    # -f : ignore case. random lower/upper order
    # -fs : ignore case and put always upper before lower
    # -b : ignore leading blanks
    # -uf : remove dupes, cas insensitive (A and a are dupes)
    # -m : supposesing f1 and f2 are already sorted, making merge faster
    # -c : check if is sorted

    ##GNU extensions

      # Sort dot separated versions numbers:

        [ "$(printf '10.0\n9.10\n9.9\n' | sort -V)" = "$(printf '9.9\n9.10\n10.0\n')" ] || exit 1

  ##tsort

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

  ##uniq

    # POSIX 7

    #*Ajacent* dupe line operations.

    #Remove adjacent dupes lines:

      [ "$(printf 'a\nb\n' | uniq )" = $'a\nb' ] || exit 1
      [ "$(printf 'a\na\n' | uniq )" = $'a' ]  || exit 1

    #Non adjacent dupes are not removed:

      [ "$(printf 'a\nb\na\na\n' | uniq )" = $'a\nb\na' ] || exit 1

    #Thus the sort combo:

      [ "$(printf 'a\nb\na\na\n' | sort | uniq )" = $'a\nb' ] || exit 1

    #Other options:

    #-u : only show lines that have no dupe
    #-d : dupe lines only
    #-c : shows dupe count before each ine

  ##tee

    # POSIX 7

    # echoes stdin to multiple files ant to stdout.

    # echo to stdout and file:

      echo a | tee file

    # echo to file and stderr:

      echo a | tee file 1>&2

    # echo to file and sort

      echo a | tee file | sort

    # echo append to file:

      echo a | tee –a file

    # echo to multple files

      echo a | tee f1 f2 f3

    # tee to multiple processes:

      echo a | tee >(seqn 2) tee >(seqn 2) | tr a b

    # note how process are run in parallel and output order is variable.

  ##tr

    # POSIX 7

    # Charwise text operations.

    # Replaces a by A and b by B and c by C:

      [ `echo -n cab | tr abc ABC` = CAB ] || exit 1

    # Ranges are understood. Convert to uppercase:

      [ `echo -n cab | tr a-z A-Z` = CAB ] || exit 1

    # POSIX character classes are understood. Remove non alphtnum chras:

      [ `echo -n 'ab_@' | tr -cd "[:alpha:]"` = ab ] || exit 1

    # - `c`: complement and replace. replaces all non abc chars by d

        [ `echo -n dcba | tr -c abc 0` = 0cba ] || exit 1

    # - `d`: deletes abc chars:

        [ `echo -n dcba | tr -d abc` = d ] || exit 1

    # - `s`: replaces multiple consecutive 'a's and 'b's by isngle a

        [ `echo -n aabbaac | tr -s ab` = abac ] || exit 1

  ##cut

    # POSIX 7

    # Select columns from text tables.

    # The delimier can only be a single character, so quite limited.

    # For more complex operation such as selecting a line from a certain field, consider `awk`.

    # `-f`: field. what column to print:

      [ "$(printf 'a\tb\nc\td\n' | cut -f1)" = "$(printf "a\nc")" ] || exit 1

    # `-d`: delimier:

      [ "$(printf 'a:b\nc:d\n' | cut -d: -f1)" = "$(printf "a\nc")" ] || exit 1

    # Gets last if delimier too large:

      [ "$(printf 'a\n' | cut -d: -f2)" = "a" ] || exit 1

    # Multiple columns, first and third:

      [ "$(printf 'a:b:c\nd:e:f\n' | cut -d: -f1,3)" = "$(printf "a:c\nd:f")" ] || exit 1

    # Column range from first to third:

      [ "$(printf 'a:b:c\nd:e:f\n' | cut -d: -f1-3)" = "$(printf "a:b:c\nd:e:f")" ] || exit 1

  ##wc

    # POSIX 7

    # Does word, line, character and other similar counts.

    # Mnemonic: Word Count.

      printf 'a\nb c\n' | wc
        #1 3 5
        #^ ^ ^
        #a b c

    # Legend:

    # - `a`: newline
    # - `b`: word
    # - `c`: byte

    # Options:

    # - `c` bytes only
    # - `m` chars only
    # - `l` newlines only
    # - `L` max line lenght only
    # - `w` words only

  ##head

    # POSIX 7

    # Keep only 10 first lines:

      seq 20 | head

    # Keep only 2 first lines:

      [ "$(printf "1\n2\n3\n4\n" | head -n2)" = "$(printf "1\n2\n")" ] || exit 1

    # 2 first bytes:

      [ "$(echo -en 'abc' | head -c 2)" = "ab" ] || exit 1

    ##GNU coreutils

      # Remove last two bytes:

        [ "$(echo -en 'abc' | head -c -2)" = "a" ] || exit 1

  ##tail

    # POSIX 7

    # Opposite of head.

    # Show last 10 lines of f:

      seq 20 | tail

    # Keep only 2 last lines:

      [ "$(printf "1\n2\n3\n4\n" | tail -n2)" = "$(printf "3\n4\n")" ] || exit 1

      tail -n3 "$f"

    ##GNU coreutils

      # Keep only lines from the Nth onwards:

        [ "$(printf "1\n2\n3\n4\n" | tail -n +2)" = "$(printf "2\n3\n4\n")" ] || exit 1
        [ "$(printf "1\n2\n3\n4\n" | tail -n +3)" = "$(printf "3\n4\n")" ] || exit 1

  ##truncate

    # GNU corutils.

    # Sets file to given size.

    # If greater, pads with 0s.

    # If smaller, data loss.

    # Operates inline without mercy, only works on files.

      echo ab > f
      truncate -s 1 f
      [ `cat f` = a ] || exit 1

      truncate -s 2 f
      hexdump
      [ `cat f` = $'a\0' ] || exit 1

    # Negative values truncate up to from the end:

      echo abc > f
      truncate -s -1 f
      [ `cat f` = ab ] || exit 1

    # *Must* have a space: `-s -1`, *not* `-s-1`.

  ##split

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

  ##csplit

    #corutils.

    # Split files into new smaller files at lines that match given EREs.

    # Matching lines are kept.

      printf '0\naa\n1\naa\n2\n' > f
      csplit f '/^a/' '{*}'
      [ `cat xx00` = 0 ] || exit 1
      [ `cat xx01` = $'aa\n1' ] || exit 1
      [ `cat xx02` = $'aa\n2' ] || exit 1

  ##paste

    # POSIX 7.

    # Useless

    # Shows files side by side line by line.

    # Default separator: tab.

    # Long lines will make this unreadable.

      echo -e "a a a a a a a a a a a a a a\na" > a
      echo -e "b b\nb b"            > b
      echo -e "c c\nc c\nc"          > c
      paste a b c

  ##expand

    # POSIX 7

    # Expand tabs to spaces:

      echo -e "a\tb" | expand

    ##unexpand

      #contrary

  ##seq

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

    ##non-application

      # You could use this for loops:

        for i in `seq 10`; do echo $i; done

      # But don't

      # Use brace expansion instead which is a bash built-in,
      # and thus potentially faster (possibly no new process spawned):

        for i in {1..10}; do echo $i; done

      # Use this only if you really need to control
      # the output with the options.

  ##path operations

    ##basename ##dirname

      # POSIX 7

        [ "$(dirname  "/path/to/dir/or/file")" = "/path/to/dir/or" ] || exit 1
        [ "$(basename "/path/to/dir/or/file")" = "file"            ] || exit 1

        [ "$(dirname  "/")" = "/" ] || exit 1
        [ "$(basename "/")" = "/" ] || exit 1

      # Extensions can be extracted naively with variable expansion, but it is not trivial to make it work for dot files.

  ##strings

    # Search for printable strings in file.

    # Prints sequences of at least 4 printable chars by default.

    # Useful to extract information from non textual formats,
    # which contain some textual data

      gcc c.c
      strings a.out

##moreutils

  #extra base linux utils

    sudo aptitude install moreutils

  ##sponge

    #solves the input to output problem problem

    #setup:

      printf '0\n1\n' > a

    #fails:

      grep 0 a | cat > a
      [ "`cat a`" = '' ] || exit 1

    #works:

      grep 0 a | sponge a
      [ "`cat a`" = '0' ] || exit 1

  ##vipe

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

##character encoding

  ##chinese

    # - Guobiao is mainly used in Mainland China and Singapore. Named as `GB\d+`
    # - Big5, used in Taiwan, Hong Kong and Macau

    # `file` does not work properly for chinese

  ##dos2unix

    # CR LF to CR.

    # In place:

      echo -e 'a\r\nb\r\n' > a.txt
      dos2unix a.txt
      [ "`cat a.txt`" = $'a\nb\n' ] || exit 1

    # Does some smart heuristic things like skipping binary files and FIFOs, so better than `sed`.

  ##enca

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

  ##iconv

    # Convert character encodings.

    # Major encodings:
    # - ASCII
    # - UTF-8
    # - UTF-16
    # - Chinese
      # - GB18030: Guobiao Mainland China and Singapore. prefixed by GB, latest version GB18030
      # - BIG-5: Taiwan, Hong Kong and Macau, is a one or two byte encoding.

    # List available encodings:

      iconv -l

    # Convert contents of F from BIG-FIVE to UTF-8:

      iconv -f BIG-FIVE -t UTF-8 "$F"

    # No changes made to file: only outputs to stdout.

  ##convmv

    # mv converting encodings

##cron

  # Tell the computer to do things at specified times automatially.

  ##crontab

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

  ##batch

    # POSIX 7

    # Superset of `at`.

    # Execute only when system load average goes below 1.5,
    # starting from now!

      cd "`mktemp -d`"
      echo "touch a" | batch

    # Same, but with at you can change to any time:

      echo "touch a" | at -q b now

  ##at

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

##system info

  ##uname

    #POSIX 7.

    # Gets information on host computer.

    # Print all info uname has to give:

      uname -a

    # This includes kernel version, user, ...

    # You can each isolated with other opts.

  ##lsb_release

    # Command required by the LSB.

    # Get distro maintainer, name, version and version codename:

        lsb_release -a

    # Extract id programmatically to autodetect distro:

        distro_id="$(lsb_release -i | sed -r 's/.*:\t(.*)/\1/')"
        distro_version="$(lsb_release -r | sed -r 's/.*:\t(.*)/\1/')"

  ##processor ##cpu

    ##arch

      # Architecture. Subset of uname.

        arch

      #i686

    ##mpstat

      # Processor related stats:

        mpstat

    ##nproc

      # Number of processing unites (= cores?).

      # coreutils

        nproc

    # CPU info dev file:

      cat /proc/cpuinfo

    # RAM info dev file:

      cat /proc/meminfo

	##lspci

		sudo lspci

	##hwinfo

		sudo aptitude install -y hwinfo

		hwinfo | less

  ##lsof

    #list all open files and pipes

    #COMMAND process name.
    #PID process ID
    #USER Username
    #FD file descriptor
    #TYPE node type of the file
    #DEVICE device number
    #SIZE file size
    #NODE node number
    #NAME full path of the file name.
    #
    #-u user : by given user

      lsof | less

  ##performance

    ##top

      #ncurses constantly updated process list with cpu and memory usage

      #interface:

      #- h: help
      #- f: field add/remove/sort
      #- k: kill process
      #- arrow keys: move view

      #sample output:

        23:00:13 up 12:00, 3 users, load average: 0.72, 0.66, 0.6
        ^^^^^^^^ up ^^^^^, ^ users, load average: ^^^^, ^^^^, ^^^
        1      2    3            4   5   6

      #Meanings:

      #- 1: cur time
      #- 2: how long the system has been up for
      #- 3: how many users are logged
      #- 4: load average for past 1 minute
      #- 5:            5 minute
      #- 6:            15 minutes

      ##load average

        #0.75: 0.75 as many scheduled tasks as your cpu can run
          #rule of thumb maximum good value
        #1  :    as many scheduled tasks as your cpu can run
          #break even point
          #risky, a littly more and you are behind schedule
        #5  : 5x
          #system critically overloaded

        #does not take into account how many cores you have!
        #ex: for a dual core, breakeven at 2.0!

      ##uptime

        #echo first line of top

          uptime

    ##free

      # Print RAM and swap memory in Megabytes once.

        free

      # Sample output:

        #       total    used    free   shared  buffers   cached
        #Mem:    604340   597484    6856     0   17548   86520
        #-/+ buffers/cache:   493416   110924
        #Swap:      0     0     0

      # - `-m`: megabyte unit
      # - `-t`: totals at bottom
      # - `-s1`, `-s0.01`: repeat every N seconds. ms resolution.

    ##vmstat

      #memory, sway, io, cpu

      #run every 1s, 100 times

        vmstat 1 100

      #Vmstat procs Section

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

    ##sar

      #long term performance statistics

      #you must run this as a cronjob:

        crontab -e

      #paste:

        */5 * * * * root /usr/lib/sa/sa1 1 1

      #cpu usage

        sar -u

      #disk io stats

        sar –d

      #network stats

        sar -n DEV | more
        sar -n SOCK |more

  ##hardware specs

    ##bus

      ##usb

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

          ##differentiate from usb 2.0

            # - 3.0 tipically blue while 2.0 black
            # - 3.0 has 8 pins instead of 4
            # - ss for super spped may be written
            # - <http://www.usb3.com/usb3-info.html>

      ##firewire

      ##ethernet

##ulimit

  #Get and set limits for applications running under curent shell.

  #POSIX 7.

  #POSIX only mandates a single option: `-f` for the maximum file size.

  #Get value of limit:

    ulimit -f

  #Set value:

    ulimit -f 0
    sudo ulimit -f unlimited

  #Certain limits may require root priviledges to increase.

  ##GNU extensions

    #GNU adds many more options in its sh and bash implementations.

    #In both cases `ulimit` is implemented as a built-in.

    #View all limits (including the unit and the option name):

      ulimit -a

##read

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

    ##applications

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

  ##GNU extensions

    #-p print a prompt message:

      read -p "enter string: " s
      echo "you entered $s"

##test

  # Compare values and check files, answer on exit status.

  # Equivalent convenient shorthand form via squre brackets: `[ ]`

  # Can do tons of different tests.

  # May also exist as a separate binary implementation on certain systems,
  # but the built-in has precedence:

    which test

  ##string compare

      test a = a && echo a
        #a
      test a = b && echo a
        #

  ##integer compare

    # Always use `-eq` family, never `=` family:

      [ 1 -eq 1 ] || exit 1
      [ 1 -eq 01 ] || exit 1
      [ 1 -lt 2 ] || exit 1
      [ 2 -gt 2 ] || exit 1
      [ 1 -le 2 ] || exit 1
      [ 2 -ge 2 ] || exit 1

  ##file ops

    ##f

      # Exists and is regular file (not a symlink or directory)

        init_test
        touch a
        assert test -f a
        cleanup_test

    ##r

      # File or directory exists and has read permission.

      # Useful in conjunction with `-f` before taking input from a file,
      # since just checking its exsitence is not enough to read from it.

    ##e

      #file exists

      #may be a symlink or directory

      #useful to avoid overwriting useful files

    ##s

      #exists and has size > 0

        rm -rf a
        touch a
        assert test -f a

  ##logical

      test ! a = a    && assert false
      test a = a -a b = b && assert false
      test a = a -a a = b && assert false
      test a = a -o a = b && assert false
      test a = b -o a = b && assert false

##process

  # Get cur pid in bash:

    echo $$
    echo $pid

  ##pwd

    # Print working directory of process.

    # Each program has a working directory set by the OS.

    # Processes inherit working directory of calling process

      mkdir a
      chmod 777 a
      echo pwd > a/a
      chmod 777 a/a
      ./a/a

    #`pwd`
    #outside /a, the working directory of the caller (bash cwd)

  ##pwdx

    # Print current working directory of given process:

      pwdx $pid

  ##sleep

    # POSIX 7

    # Do nothing for 2 seconds:

      sleep 2

  ##wait

    # POSIX 7

    # Wait for process with given pid to terminate.

    ##$!

      # The PID of the last background process is stored in `$!`.

    # Sleep 2 seconds and echo done:

      sleep 3 &
      wait $!
      echo $?

    # Gets `$?` right even if process over already:

      false &
      sleep 2
      true
      wait $!
      [ "`echo $?`" = 1 ] || exit 1

      true &
      sleep 2
      false
      wait $!
      [ "`echo $?`" = 0 ] || exit 1

  ##trap

    # Capture signals.

      trap "echo a" SIGINT SIGTERM

    # Now Ctrl-C away and notice `a` get printed.

  ##ps

    # POSIX 7

    # List current executing processes and their info.

    # On Ubuntu 12.04, implemented by the psmisc package.

    # Implementations commonly use the proc filesystem.
    # There does not seem to be a POSIX way to implement this,
    # except maybe following a process tree.

    # Good short summary:

      ps --help

    # ps interface is ugly: some options have dash GNU style, others simply don't, and have no dash equivalent.
    # Live with it.

    # Best command to see all processes on the system:

      ps aux

    # See processes running on current tty:

      sleep 10 &
      sleep 10 &
      ps

    # Output fields include:

    # - pid
      # unique identifier for all process on system

    # - tty
      # from which tty it was launched

    # - time
      # cpu time used for process
      # not real time

    # - cmd
      # command that launched th process
      # without command line args

    # See all process on system (TODO for some reason less than `aux`):

      ps -A

    # Shows threads of each process:

      ps -Am

    # Shows lots of extra info columns in addition to the 4 default:

      ps -Al

    # Sort output by:

    # - cmd
    # - time reversed (because of the `-`)
    # - pid
    # - tty reversed (-)

      ps -A --sort cmd,-time,pid,-tty

    # Get pid of parent of process with pid p

      p=
      ps -p $p -o ppid=

    ##GNU extensions

      # Show process tree:

        ps -A --forest

      # Sample output:

        1258 ?    00:00:00 lightdm
        1279 tty7   00:17:31 \_ Xorg
        1479 ?    00:00:00 \_ lightdm
        1750 ?    00:00:01   \_ gnome-session
        1868 ?    00:00:00     \_ lightdm-session <defunct>
        1913 ?    00:00:00     \_ ssh-agent
        1950 ?    00:00:31     \_ gnome-settings-
        2363 ?    00:12:19     \_ compiz
        3503 ?    00:00:00     |  \_ sh
        3504 ?    00:00:22     |    \_ gtk-window-deco

  ##jobs

    # Shows:

    # - jobspec   : a local job id.
    # - status    : runnning, stopped, done
    # - invocation  : exact program call, including command line args. Ex: `ls ~`

      jobs

    # Show pids of background jobs:

      jobs -p

    ##jobspecs

      # Local job id, found by using <#jobs>

      # Certain commands such as `kill`, `fg` them in addition to pids.

      # They are:

      # - %N	Job number [N]
      # - %S	Invocation (command line) of job begins with string S
      #  If several matches, ambiguous, and does nothing.
      # - ?S	Invocation (command line) of job contains within it string S
      # - %%	"current" job (last job stopped in foreground or started in background)
      # - %+	"current" job (last job stopped in foreground or started in background)
      # - %-	last job

    # It is possible to use jobspecs directly with certain bash built-ins that could also take PID.
    # For example, to kill process by jobspec `%1`:

      #kill %1

    # Note that `kill` also usually exists as an external executable, and that the external executable
    # cannot kill by jobspec since this information is only known by bash itself.

    # `help kill` states that one of the reasons why `kill` is implemented as a bash built-in is to be
    # able to write `kill %1`.

    #ls &
    #sleep 100 &
    #sleep 100 &
    #sleep 100 &
      #runs on background
      #
      #[1] 12345678
      #means local id 1
      #process number 12345678
      #
      #when process ends, it prints ``[n] 1234`` and disappears
      #
      #stdout continues to go to cur terminal, even if in bg

  ##bg

    #POSIX 7

      #bg %3
        #starts running job 3 which was stopped on background
      #bg
      #bg %+
      #bg %%
        #last bg job [+]
      #bg %-
        #before last bg job [-]

  ##fg

    #POSIX 7

      #fg %3
        #starts running job 3 which was on background on foreground
      #fg
        #last job

  ##disown

    #vlc 100 &
    #vlc 100 &
    #vlc 100 &
    #disown %3
      #remove job 3 from list of sub jobs
      #closing bash will not kill it anymore

  ##kill

    # POSIX 7

    # Kill exists as a bash built-in.
    # One of the reasons for this is to allow users to `kill` by jobspec for example as `sleep 1- &; kill %1`,
    # Which an external executable could not do. Killin gby PID is required by POSIX 7.

    # Send signals to a process. Signals are an ANSI C concept, with POSIX and Linux extensions.

    # Does not necessarily send SIGKILL, nor is SIGKILL the default signal sent!
    # The default signal it sends is SIGTERM.

    # It is unfortunatelly named kill because most signals end up killing process,
    # or also because the most used signal is SIGTERM generated by a C-C on the terminal.
    # which has the usual effect of killing a process.

    # List all signals available on the system:

      kill -l

    # Lists numbers and descriptions.

    # Send SIGTERM signal to process:

      ps -A
      ID=
      kill $ID

    # SIGTERM is the default signal sent by `kill`.

    # Select by pid, found on ps for example.

    # Select by job-id found on jobs:

      sleep 10 &
      jobs
      kill %1

    # POSIX specifies this.

    # Send stop signal to process:

      kill -s SIGSTOP $ID
      kill -s sigstop $ID
      kill -s STOP $ID
      kill -s stop $ID

    # All of the above are specified by POSIX.

    # Where `SIGSTOP` is the standard signal name.

    # Also possible with the XSI extension:

      kill -SIGSTOP $ID
      kill -sigstop $ID
      kill -STOP $ID
      kill -stop $ID

    # But not recommended because it is less uniform parameter passing,
    # and not guaranteed to be on all implementations.

  ##killall

    # Send signals to all process by name

    # psmisc package

    # Application: firefox/skype hanged. `ps -A | grep -i firef',
    # confirm that the name is firefox and that it is the only one with that name, and then:

      killall firefox

    # This sengs SIGTERM, which programs may be programmed to handle,
    # so the progrma may still hang ( and in theory be trying to finish nicelly, although in practice this never happens... )

    # Kill it without mercy:

      killall -s 2

    # which sends SIGINT, which processes cannot handle, so they die.

  ##env

    # POSIX 7

    # Shows all environment variables and their values:

      env

    # Change environment for a single command:

      a=b
      env a=c echo $a
      #c
      echo $a
      #b

    # In bash it is also possible to do (not sure about portability):

      a=b
      a=c echo $a
      #c
      echo $a
      #b

    ##-i

      #exec in a clean environment:

        [ "`env -i a=b env`" = "a=b" ] || exit 1

      ##start a subshell in the cleanest env possible

        #don't forget: subshells inherit all exported vars

          env -i bash --noprofile --norc
          env
          #some default vars might still be there!
          #I get: SHLVL, PWD
          exit

  ##nohup

    # POSIX 7

    # Make a process that continues to run even if calling bash dies:

      nohup firefox >/dev/null &
      echo "$!" > /tmp/firefox-pid
      exit

    # This would send a HUP signal to Firefox, which kills most programs.

    # Firefox still lives! it would be killed if it were not for nohup.

    # When you do this, you will often want to store the PID of the program to kill it later with:

      kill "$(cat firefox-pid)"

    # Consequences of `nohup`:

    # - if stdin came from terminal (not pipe for example),
    #     sdtin comes from `/dev/null` (you have no stdin!) instead
    #
    # - if stdout would go to terminal (not pipe for example)
    #     it is *appended to* `./nohup.out`, and if not possible from `$HOME/nohup.out`
    #     instead
    #
    #     If no stdout is generated, `nohup.out` is not created
    #
    #     you can also redirect stdout to any file you want via `nohup cmd > file`
    #     for example `nohup cmd > /dev/null` to ignore output
    # - the program is still visible in `jobs`, and may be killed with `kill %+`
    # - if you don't use `&`, it runs on foreground, preventing you from using bash

    # How to test all this:

      nohup bash -c 'for i in {1..10}; do echo $i; sleep 1; done'

    # Try:

      #append `> f` to command
      #append `&`  to command

      jobs
      cat nohup.out

  ##timeout

    # Run command for at most n seconds, and kill it if it does not finish in time

    # coreutils

      [ `timeout 3 bash -c 'for i in {1..2}; do echo $i; sleep 1; done'` = $'1\n2\n' ] || exit 1
      [ `timeout 1 bash -c 'for i in {1..2}; do echo $i; sleep 1; done'` = $'1\n' ] || exit 1

  ##nice

    # - -20: highest priority
    # - 20: lowest priority

    # Mnemonic: the nicest you are, the more you let others run!

    # POSIX 7

    # Therefore the concept of niceness is included in POSIX.

    # View nice of all processes:

      ps axl

    # Run program with a nice of 10:

      nice -10 ./cmd

    #- 10:

      sudo nice --10 ./cmd

    # You need sudo to decrease nice

    # Change priority of process by PID:

      renice 16 -p 13245

  ##flock

    # Puts an advisory file lock on given file while a command executes:

      touch a
      flock a sleep 5 &

  ##pstree

    # psmisc package, not POSIX

    # Shows tree of which process invocates which

      pstree

    # This works because in POSIX new processes are created exclusively
    # by forking from other processes, and parent information is stored
    # on each process, which dies if the parent dies

    # this is a very insightfull program to understand what happened after
    # the `init` process, first process on the system and common ancestor of all, started

    # Particularaly interesting if you are on a graphical interface,
    # to understand where each process comes from

    # Quotint `man pstree`, multiple processes with same name and parent are wrttin in short notation:

      #init-+-getty
      #   |-getty
      #   |-getty
      #   `-getty

    # Becomes:

      #init---4*[getty]

    # Threads (run parallel, but on same data, and cannot fork) are indicated by brackets:

      #icecast2---13*[{icecast2}]

    # Means that `icecast2` has 13 threads.

  ##prtstat

    #TODO

  ##peekfd

    #TODO

  ##ipcs

    # List info on inter process communication facilities:

      ipcs

    # Shows:

    # - shared mem
    # - semaphores
    # - message queues

    ##ipcrm

      # Remove IPC facility.

  ##chroot

    # Execute single command with new root.

    # The root of a process is a Linux concept: every process descriptor has a root field,
    # and system calls issued from that process only look from under the root (known as `/` to that process).

    ##application

      # You have a partition that contains a linux system,
      # but for some reason you are unable to run it.

      # You can use that partition with bash by using chroot into it,
      # and you might then try to fix it from there.

      # Example:

        sudo chroot /media/other_linux/

      # More advanced example, if you want to start from a completelly clean bash environment:

        sudo chroot /media/other_linux /bin/env -i \
            HOME=/root         \
            TERM="$TERM"        \
            PS1='\u:\w\$ '       \
            PATH=/bin:/usr/bin:/sbin:/usr/sbin \
            /bin/bash --login

      # This will in addition clear enviroment variables, and read login scripts found on the chroot.

  ##eval

    # POSIX 7.

    # Exec string in current bash

      eval "a=b"
      [ $a = b ] || exit 1

    # Concatenates arguments, space separated:

      [ `eval echo a` = a ] || exit 1

    ##applications

      # Make varname from var>

        a=b
        eval "$a=c"
        [ $b = c ] || exit 1

##files

  ##ls

    # POSIX 7

    # List files in dirs

    ##-l

      # Show lots of information:

        ls -l

      # Sample output:

        #-rw-rw-r-- 1 ciro ciro  4 Feb 25 11:53 a
        #1     2 3  4    5 6      7

      #1) file permissions. See permissions
      #2) for files, number of hardlinks. For dirs number of subdirs + parent + self (min is 2 therefore)
      #3) owner
      #4) group
      #5) size in bytes
      #6) last modified
      #7) filename

    # ls is aware if its ouput goes to a pipe or not.
    # if yes, automatically newline separates it:

      ls | cat

    # One per line:

      ls -1

    # ls a file:

      touch a
      [ "$(ls a)" = "a" ] || exit 1

    # ls a dir:

      mkdir d
      touch d/a d/b
      [ "$(ls d)" = "$(printf 'a\nb\n')" ] || exit 1

    # ls many dirs:

      mkdir d
      touch d/a d/b
      mkdir e
      touch e/a e/b
      ls d e
        #nice listing of both

    # -d: list dirnames only:

      mkdir d
      touch d/a d/b
      mkdir e
      touch e/a e/b
      [ "$(ls -d d e)" = "$(printf 'd\ne\n')" ] || exit 1

    # -lL : when showing symlinks, shows info to what is linked to

    # Sort:

      # Modification time (newest first):

        ls -t

      # Inode change:

        ls -tc

      # File access:

        ls -tu

      # Reverse sort order:

        ls -tr

    ##dircolors

      # Config ls colors

    ##GNU extensions

      # -R: recursive

        ls -R

  ##tree

    #prints visual file tree

    #install:

      sudo aptitude install tre

    #recurse 2 levels (default infinite):

      tree -L 2

    #-a: include hidden:

      tree -a

    ##--charset

      #select a smaller charset for output:

        tree --charset=ascii

      #this is good if you want to paste output!

  ##cd

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

  ##touch

    #POSIX

    touch f
      #creates file if does not exist.
      #updates modify date to present if exists

  ##mkdir

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

  ##mv

    # POSIX

    # Move or rename files and dirs.

    ##files

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

    ##dirs

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

    ##GNU extensions

      ##b ##s

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

  ##cp

    # POSIX

    # Copy files and dirs.

    ##file

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

    ##gnu extensions

      # The following GNU extensions are very useful and did not fit into any other category:

      # - `-v`: be verbose and print a message saying what cp is doing.

        # Useful when copying a lot of files in an interactive session
        # to check if that progress is going on.

    ##dir

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

    ##symlink

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

    ##hardlink

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

    ##applications

      # Copy all files from a directory into another existing directory (including hidden):

        cp -dR from/. to

  ##rsync

    # Very powerful and flexible file copy tool.

    # Can:
    # - works over networks. Both machines must have it installed.
    #
    #     Capable of compressing before sending over the network, and decrompressing on the other side.
    #
    # - synchronize differentially
    # - encrypt files sent

    # Useful options:

    # - `-a`: "archive mode".

      # Sets : `-Dgloprt`

      # Does what you want it to do, even before you know you need it:

      # - `-D`: preserve special and device files. Requires sudo.
      # - `-g`: preserve group. Requires `sudo`.
      # - `-l`: copy symlinks as symlinks.
      # - `-o`: perserve owner. Requires `sudo`.
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

  ##rm

    # Remove files and dirs.

    # -r: recursive. Mandatory for directories. Potentially dangerous.

  ##recover data removed with rm like tools

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

  ##rename

    # Mass file regex renaming.

    # Dry run:

      rename -n 's/^([0-9]) /0$1 /g' *.mp3

    # Act:

      rename 's/^([0-9]) /0$1 /g' *.mp3

  ##cpio

    #TODO

    find . ! -iname '* - *' -type f -print | cpio -pvdumB './no author'
    #find selected files to destination, building and keeping their relative directory structure

  ##install

    # Move and set: mode, ownership and groups.

    # Make all components of path:

      install -d a/b/c
      [ -d a ] || exit 1
      [ -d a/b ] || exit 1
      [ -d a/b/c ] || exit 1

  ##mkfifo

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

  ##mknod

    # Create character, block or FIFO (named pipe) files.

    # Make a char file with major number 12 and minor number 2:

      sudo mknod /dev/coffee c 12 2

  ##chown

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

  ##chmod

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

    ##sticky bit, suid sgid bits

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

  ##umask

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

  ##stat

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

    ##-c

      # Format string:

        chmod 1234 f
        [ `stat -c "%a" f` = "234" ] || exit 1

        chmod a=rt f
        [ "`stat -c "%A" f`" = "-r--r--r-T" ] || exit 1

      # Inode:

        touch a
        ln a b
        [ "`stat -c "%i" a`" = "`stat -c '%i' b`" ] || exit 1

    ##--print

      # Like `-c` but interprets escapes like `\n`:

        touch a
        echo "`stat --print "%a\n%a\n" a`"
        [ "`stat --print "\n" a`" = $'\n' ] || exit 1

  ##links

    ##ln

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

    ##readlink

      # Get target of symlink

        touch a
        ln -s a b
        ln -s b c

        [ "`readlink c`" = $'b' ] || exit 1
        [ "`readlink b`" = $'a' ] || exit 1

      # Recursive:

        [ "`readlink -f c`" = $'a' ] || exit 1

    ##realpath

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

  ##cmp

    # Compares F and G byte by byte, until first difference is found.

      cmp "$F" "$G"

    # If equal, print nothing.

    # Else, print location of first difference.

    ##-s

      # Silent

      # Return status 0 if equal
      # != 0 otherwise.

      # Prints nothing.

        cmp -s "$F" "$G"
        if [ $? -eq 1 ]; then
            echo neq
        else
            echo eq
        fi

  ##locate

    # Searchs for files in entire computer.

    # Prints all matches.

    # This uses a database, which must be updated with updatedb before your new file is found.

    # Commonly, `updatedb` is a cronjob.

    # Match any substring in entire path:

      locate a
      locate /a

    # To force update of file cache, use updatedb.

  ##updatedb

    # Update file cache for locate:

      sudo updatedb

  ##file

    # POSIX 7

    # Attempts to determine file type and retreive metadata.

    # This is in general impossible,
    # but program makes good guesses.

      echo a > a
      file a

    # Output:

      a: ASCII text

    ##-L

      # Follow links

        echo a > a
        ln -s a b
        file b
          #b: symbolic link to `a'
        file -L b
          #b: ASCII text

  ##fuser

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

  ##mktemp

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

  ##pathchk

    # Check if path is portable across POSIX systems:

      pathchk -p 'a'
      pathchk -p '\'

  ##fdupes

    # Fine command line tool for eliminating byte by byte duplicates
    # you can either:

    # - pick one by one
    # - tell fdupes to pick the first one without asking (seem to pick one of the dirs first always)

    # Finds and prints dupes:

      fdupes -r .

    # Finds dupes, and prompt which to keep for each match

      fdupes -rd .

##setterm

  # Outputs stdout that changes terminal properties.

  # Turns the cursor on/off:

    setterm -cursor off
    setterm -cursor on

##users and groups

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

  ##groups

    # List groups of user `"$u"`:

      groups "$u"

    # Sample output:

      username : group0 group1 group2

    # List groups of the current user:

      groups

  ##who

    #POSIX 7.

    #list who is logged on system

      who

  ##id

    #POSIX 7.

    #Shows user and group ids and names.

    #Show all info for a given user:

      u=root
      id "$u"

    #For current user:

      id

    #Effective userid:

      id -u

    #Effective username:

      id -un

    #Real userid:

      id -ur

    #Same but for groups:

      id -g
      id -gn
      id -gr

  ##whoami

    #Print effective user name:

      whoami

    #Same as `id -un`, but not POSIX, so never rely on it.

  ##last

    #List last user logins on system:

      last

  ##tty

    #show current tty

    tty
      #/dev/pts/1

  ##getty

    #the tty that runs on those ctrl-alt-F\d things

    cat /etc/default/console-setup

    ACTIVE_CONSOLES="/dev/tty[1-6]"
      #allow you to change the number of consoles and their locations

  ##su

    # Become another user, such as root:

      su otheruser
        #enter otheruser pass
      whoami
        #otheruser

    # Start a login shell as user a:

      su - a

    # Without this starts a non-login shell.

    ##don't use from script

      # You probably don't want to use this on a script, only on interactive sessions.

      # Doing:

        printf 'echo a\nsu a\necho b' | bash -x

      # Gives:

        su: must be run from a terminal

      # Doing:

        echo 'echo a
        su git
        echo b
        ' > a.sh
        bash a.sh -x

      # Stops the script and puts you on an interactive session.

      # Workarounds for scripts: <http://stackoverflow.com/questions/1988249/how-do-i-use-su-to-execute-the-rest-of-the-bash-script-as-that-user>

      # TODO understand behaviour precisely.

    ##become root

      #BAD: never become root, as it is dangerous.

      #Give root a pass so people can log into it:

        sudo passwd root

      #On some systems such as ubuntu, sudo has no pass by default.

        su
          #enter root pass
        whoami
          #root

    ##login

      #TODO0 login vs su?

  ##sudo

    # Do next single command as another user or super user.

    # Safer than becoming root with su.

    # Configuration file:

      sudo cat /etc/sudoers

    ##visudo

     # Should only be edited with visudo, analogous to vipw.

       sudo visudo

    # Syntax:

      #Defaults:ALL timestamp_timeout=0
        #passwords for all users timeout 0
      #Defaults:ALL timestamp_timeout=15
        #BAD
        #after any user enters a pass, he can sudo without pass for 15 mins
      #main lines:
        #user  hostip=(runas)NOPASSWD ALL
        #%group hostip=(runas)    :/bin/ls,/bin/cat
          #user: who will get sudo premissions
            #add '%' for group: ex: %group ...
            #can be ALL
          #runas: who can he sudo as
          #NOPASSWD: if present, must enter target user's password
          #/bin/ls,/bin/cat: list of comma separated bins he can run, or ALL
      #aliases:
        #user
          #User_Alias FUSE_USERS = andy,ellz,matt,jamie
          #FUSE_USERS ALL=(root):/usr/bin/the-application
        #host:
          #Host_Alias HOST = jaunty
          #%admin HOST=(ALL)
        #runas
          #Runas_Alias USERS = root,andy,ellz,matt,jamie
          #%admin ALL=(USERS) ALL
        #command
          #Cmnd_Alias APT   = /usr/bin/apt-get update,/usr/bin/apt-get upgrade
          #Cmnd_Alias USBDEV = /usr/bin/unetbootin,/usr/bin/gnome-format
          #ALL_PROGS = APT,USBDEV
          #%admin ALL=(ALL) ALL

    # Common combos:

    # Allow given user to sudo without password:

      #username ALL=(ALL) NOPASSWD: ALL

    ##redirection

      # sudo passes its stdin to the called program:

        echo a | sudo cat
          #a

      # Cannot "echo to a file" directly without permission

        su a
        mkdir b
        chown b b
        #fails:
        sudo echo a > b/a

      # The reason why this fails is that bash gives sudo two arguments: `echo` and `a`.

      # sudo does `echo a`, produces `a`, and then *bash* attempts the redirection by writing
      # `a` to `b/a`, which of course fails because bash does not the necessary permissions.

      # Workarounds for that include:

      # Put everything inside a single bash command:

        sudo bash -c 'echo a > b/a'

      # This works, but may lead to quoting hell.

      # sudo a tee and let it do the work:

        echo a | sudo tee b/a

      # And if we want to append to the file instead:

        echo a | sudo tee -a b/a

      # The resaon this works is because `sudo` redirects its stdin
      # to the stdin of the program it will call.

      # `-e` to edit a file as sudo:

        sudo -e /etc/file.conf

      # Multiline sudo via EOF:

        sudo tee /some/path <<EOF
EOF

    ##ubuntu default sudo config

      # In Ubuntu, sudo group allows members to sudo whatever they want as root

        groups
          #sudo is in my groups!
        sudo whoami
          #root
        sudo -u test whoami
          #test
        sudo -l
          #find cur user sudo permissions
        sudo env
          #you don't have your cur users env anymore
          #you are root now!
        sudo env PATH=$PATH env
          #use your user's path on sudo
        #alias sudo='sudo env PATH=$PATH'
          #tempting, but it will make options fail!
          #sudo -L --> sudo env PATH=$PATH -l
          #env thinks -l is his option

  ##logout

    # Logs out.

    # Can only be used on the login shell.

      logout

  ##faillog

    # See log of failed login attempts (3 in a row):

      faillog -a

  ##useradd

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

  ##userdel

    # Remove users.

    # Cannot be used on users current logged in.

    # Delete user but keep his home directory:

      userdel $u

    # Also remove home directory:

      userdel -r $u

  ##groupadd

    # Create new groups

      g=
      sudo groupadd $g

  ##usermod

    # Add/remove users to groups

    # If you are the user, you have to logout/login again for changes to take effect.

    # Change primary group of user u to g:

      usermod -g $g $u

      g=1000,1001

    # Sets exactly the supplementary groups of user u.
    # Remove from non listed ones:

       usermod -G $g $u

    # Append (-a) groups g to supplementary groups of user u:

       usermod -aG $g $u

    # Change home dir of user u to d.
    # The old contents are not moved:

       usermod -d $d $u

    # Also move his current dir contents to new dir:

      usermod -md $d $u

  ##passwd

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

    ##vipw

     # To directly edit the `/etc/passwd` file, use `vipw`,
     # which is vi in a mode that checks the file syntax before saving,
     # since syntax errors could lead to serious security faults.

  ##makepasswd

    # Generates random passwords that follows certain rules.

    # Useful to automate program installation when a password is required,
    # for example on development servers.

    # Make a 10 character password only with alhpanum chars:

      makepasswd --chars 10

  ##chsh

    # Change the default shell of current user to `/bin/bash`:

      chsh -s /bin/bash

    # View available shells on the system:

      less /etc/shells

  ##ac

    # Register and view user login statistics.

    # Current user connection in hours, broken by days:

      ac -d

    # Connection time for all users:

      ac -p

  ##finger

    # Shows user info.

    # Data taken from a properly formated `/etc/passwd` comment field for the user.

      finger "$u"

  ##pinky

    # coreutils

    # Lightweight finger.

  #chfn

    # Change the commend field of `/etc/passwd` for an user in a format recognized by `finger`>

      sudo chfn -f full_name -r room_no -w work_ph -h home_ph -o other $u

  ##ldap

    # Filesystem, printer, etc server over network

  ##radius

    # Login server.

    # freeradius is the major implementation.

##languages

  # This contains cheat for languages for which there is too little information
  # to put them on their own files or repositories.

  ##bc

    # POSIX

    # Simple interpreted language, calulator focus.

    # Cute toy language that only exists because it is POSIX =),
    # but is completelly superseeded by any modern interpreted language
    # (it only golfs very slightly better than Python).

    # C like syntax.

    # Features: variable definition, function definition, arrays, strings

    # Non features: string concatenation:

      [ `echo '1+1' | bc` = 2 ] || exit 1

  ##haskell

    # Glasgow compiler is the main compiler implementation.

    # Compile:

      echo 'main = putStrLn "a"' > a.hs
      ghc a.hs
      [ `./a` = a ] || exit 1

    # Standard REPL interpreter that comes with the glasgow compiler:

      ghci

##setleds

  # Set/get capslock, numlock and scrolllock led state;

  # Only works from tty (ctrl+alt+F[1-6] on ubuntu);

    setleds

##scanner

  ##simple-scan

    # GUI.

    # Very simple to scan (once you manage to install the scanner driver...)

      simple-scan

    # Then click scan button. The image updates as the scan is made,
    # and you can stop it when you are done before the scanner reached the bottom.

    # Make sure your scanner supports the definition preferences you set
    # or you will get a connexion error.

##factor

  # coreutils

  # Factor a number into prime constituents.

    [ "`factor 30`" = "30: 2 3 5" ] || exit 1
