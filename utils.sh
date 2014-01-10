#!/usr/bin/env bash

##about

    #this file is being cut up into smaller files

    #distribution specific installation procedures are put outside of this section

    #for a summary of up to level 2 header: `grep -E '^[[:space:]]{0,4}##' %`

##sources

    #- http://linux.die.net/

        #linux man pages

        #also contains dive into python and advanced bash scripting,
        #so is a major site

    #almost official pages:

        #- http://www.kernel.org/

        #- http://git.kernel.org/

    #- http://www.tldp.org/

        #many tutorials

    #- the geek stuff

        #http://www.thegeekstuff.com

        #short tutorials with lots of examples

    #- tuxfiles

        #<http://www.tuxfiles.org/linuxhelp/fstab.html>

        #some good tuts

    #- man pages

        #Not many examples, but full function list, and you often can guess what they mean!

    #- info pages

        #GNU project substitude for man.

        #Usually much longer explanations and examples.

        #Better nodewise navigation.

    #- linux from scratch

        #teaches how to build a minimal linux distro

##man

    #The manuals.

    #POSIX 7 specifies only the option `-k` and nothing about pages,
    #those are linux concepts.

    ##pages

        #The manual is organized into 7 pages.

        #When you install a new page, the developers decide where to put the documentation.

        #Every page has an intro section which says what it is about:

            man 2 intro
            man 3 intro

        #As in the case of the intro, you can distinguish ambiguities by giving the page number.

        #`write` system call:

            man 2 write

        #`write` shell command:

            man 1 write

        #List all entries of a page:

            man -k . | grep '(8)'

        #- 1: user commands (executables in path)

            #This is normally the largest section.

                man 1 passwd

        #- 2: system calls (c interface)

            #Those are *not* actual system calls, but portable low level system interfaces.

            #Most of the POSIX C library is here.

            #POSIX write function:

                man 2 write

        #- 3: library. system call wrappers.

            #Higher level than 2.

            #Distinction from `man 2` is hard to tell.

            #Contains for example:

            #- some POSIX apis like pthreads
            #- X11 APIs

        #- 4: special files such as device files

                man 4 zero
                man 4 random
                man 4 mouse

        #- 5: file formats specifications.

            #Examples:

            #/etc/passwd file syntax:

                man 5 passwd

            #elf executable format:

                man 5 elf

        #- 6: games

        #- 7: standards.

            #Contains standards summaries such as:

                man unicode
                man url
                man X

        #- 8: system administration

            #Commands that mostly only root can do.

            #Their binaries are typically under `/usr/sbin/`.

            #Examples:

                man 8 adduser
                man 8 grub-install
                man 8 mount

    ##GNU command line options

        #exact search on title. Shows only first page found match:

            man intro

        man -a intro
            #shows each match in succession
            #asks if you want to continue on each quit

        man -k password
            #search for commands with password word on summary

        man -K password
            #search on all of manual pages
            #may take some time

        ##--regex

            #whatever you were searching
            #search with ERE now

            man --regex 'a.c'
                #regex on title

            man --regex -K 'a.c'
                #regex on entire manual

        apropos password
            #same

        man -k .
            #list all manual pages
            #pages whose summaries match '.' regex: anychar)

    ##linux man-pages project

        #<https://www.kernel.org/doc/man-pages/>

        #Project that maintains many Linux related manpages and also some non Linux specific entries.

        #Most distros to come with those manpages installed.

        #It is not a part of the kernel tree, and does not seem to be mentioned in the LSB.

    ##whatis

        #non posix

        whatis ls
            #show short description of ls

    ##manpath

        #man search path

        #non posix

        manpath
            #/usr/local/man:/usr/local/share/man:/usr/share/man
        ls /usr/share/man
            #languages
            #man\d
        ls /usr/share/man/man1 | less
            #section 1 pages in english

##info

    #gnu, not posix

    #each page contains lots of info, more than man pages
    #may even contain, *gasp*, examples!

    #the keybindings are very tree/node based. To get started:

        #?: help
        #x: close help

        ##page

            #<space>:   down one page. May change nodes.
            #<backspace>: up one page. May change nodes.
            #b, e: beginning/end of current node.
            #s, /: search string
            #{, }: repeat search back/forward

        ##menu

            #<arrows>: move cursor
            #<enter>: go to link under cursor
            #<tab>: go to next link
            #1-9: go to menu item nb.
            #m: select menu item in current page by name.
                #can tab complete.
                #even without tab complete, goes to first match on enter.

        ##node

            #u: parent node
            #t: top node
            #[, ]: next previous node. May     change node level.
            #n, p:                         not
            #l: go to last viewed node. can be used several times.
            #g: like m, but search all nodes

        ##search

            #/: regex
            #{: next      match of previous search
            #}: previous

    info
    info rm

##configuration

    ##ubuntu

        #TODO: explain or remove

            #sudo aptitude install -y myunity

        #additional drivers : non free vendors

            jockey-text --list
            #list

            jockey-text --enable=$DRIVER
            #enable from list. ex: xorg:fglrx_updates

    #TODO explain or remove:

        sudo aptitude install -y dconf-tools

    ##gnome tweak tool

        #gui to configure lots of desktop things.

    sudo aptitude install -y gconf-editor

    ##gsettings

        #set vaules

            #applies instantly
            gsettings set com.canonical.desktop.interface scrollbar-mode normal
                #normal not hidden scroll bars

            gsettings set com.canonical.indicator.session show-real-name-on-panel true
                #show username on panel

            gsettings reset com.canonical.desktop.interface scrollbar-mode
                #return to default value

    #TODO explain or remove:

        sudo aptitude install -y compiz compizconfig-settings-manager compiz-plugins-extra

    ##update alternatives

    sudo update

##desktop

    unity --restart
        #restarts the unity shell only
        #less effective and drastic than restarting lightdm

    #gnome shell

    #desktop/windows control

        #opens with the deafult application. works in Ubuntu Unity 12.04

            gnome-open "$FILE"

    #logkeys

        #Writes all keypresses to a file.

        #Great way to steal people's passwords if they use your computer.

        #Start logging:

            sudo logkeys -s

        #End logging:

            sudo logkeys -k

    #ibus input methods

        #for chinese, japanes, etc input

        #how have I looked for this, but no one told me: ibus for qt apps!!!!

    ##alarm clock applet

        #notifies you with sounds when a certain time passed

    ##weather indicator

##chat messaging voice video

    ##mseg write wall

        #write messages to other users on the system

        ##mseg

            #enable/disable messages
                mseg n
                mseg
                    #n
                mseg y
                mseg
                    #y

        ##write

            #write to a user in a tty

                u=
                write $u tty3
                    #type you message
                    #type enter, and it is sent
                    #ctrl+d ends

                u=
                h=
                sudo write $h@$u tty2
                    #with sudo, you can write even is mseg n

        ##wall

            #write to all

                wall
                    #type you message
                    #message is only sent after you ctrl+d
                sudo wall
                    #sends to all even if disabled

        #play with it:
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

    ##mail

        ##MTA

            # Mail transfer agent.

        ##sendmail

            # Interface that comes in multiple packages such as ssmtp and postfix,
            # so to configure it you must first determine which package provides it.

            # `sendmail` is an utility. Its interface is probably implemented
            # by other packages because that utility was widely used.

            # May be symlink to an executable, or to the /etc/alternatives.

                echo "asdf" | sendmail

        ##mail

            # On a symlink to the alternatives system.

                echo -e "the message\n\nend of it" | mail -s "subject" -r "from@gmail.com" "to@gmail.com"
                mail -s "subject" -r "from@gmail.com" "to@gmail.com"

            # Mail ends in a line which contains a single dot `.` or ctrl+D.

        ##mailx

            # POSIX.

            # Does not seem to be used a lot, maybe because it does not have many capabilities.

        ##ssmtp

            # Simple SMTP.

            # Popular MTA. Really is simpler than Postfix to setup.

            # Configuration file:

                #vim /etc/ssmtp/ssmtp.conf

            # Configurations to send an email from gmail:

                Root=your_email@gmail.com
                Mailhub=smtp.gmail.com:465
                RewriteDomain=gmail.com
                AuthUser=your_gmail_username
                AuthPass=your_gmail_password
                FromLineOverride=Yes
                UseTLS=Yes

            # Now you can send emails from the command line as:

                printf 'Subject: sub\nBody' | ssmtp destination@mail.com
                printf 'Subject: sub\nBody' | sendmail destination@mail.com

            # The email will be sent from the email account you configured to send from.

        ##postfix

            # Main configuration file:

                /etc/postfix/main.cf

            # Postfix's `sendmail` does not show failure status immediately,
            # it seems that it simply puts the email on a send queue.

            # This is probably done so that email sending does not block the current session,
            # allowing in particular longer retry times.

            # To view the send queue, use `mailq`.

            ##mailq

                # Show email sending queue.

                # If delivery failed, explains why.

        ##mutt

            # Can send mail with attachment.

            # Curses inteface.

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

            #compare files *and* directory contents

            #files:

                echo -e "0\na\n1\n2\n3\n4\n5" > a
                echo -e "0\n1\n2\nb\n3\n5" > b
                nl a
                nl b

                diff a b

                diff -u a b
                #gitlike diff (unified format)

            #directories:

                mkdir a
                touch a/a
                touch a/c
                mkdir b
                touch b/b
                touch b/c
                diff a b

        ##comm

            #ultra simple diff

            #useless

            #posix 7

            cd "`mktemp -d`"
            echo -e "a\nc" > a
            echo -e "b\nc" > b
            comm a b
                #a
                #    b
                #        c

                #3 cols:
                    #lines only in a
                    #           in b
                    #      in both

                #tab separated columns
                    #long lines look horrible

        ##patch

        ##wdiff

            #word oriented diff

            sudo aptitude install -y wdiff

            wdiff a b

        #kiff3
            #kde diff tool
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

        #Move very fast with your keyboard without using a mouse.

        #Works inside terminals therefore no need for X display manager

        #gvim, runs in gtk outside command line
        #and thus gets around many command line limitations such as reserved shortcuts

            gvim

    ##eclipse

        #programming IDE.

        #Extensible, lots of good existing plugins, coded in Java and therefore sane.

        #Whatever you want to do you must click 50 menu items, no good config textual interface.

        ##install plugins

            #must be root for those operations so

                gksudo eclipse

            #can only be done sanely manually from the GUI like everything else.

            #Help > Install new software > Availabe software sources > Check every single case there!
            #Help > Install new software > New sources

        #add vim like editing to eclipse: http://vrapper.sourceforge.net/update-site/stable

        ##color themes

            #http://eclipse-color-theme.github.com/update

            #mine: http://www.eclipsecolorthemes.org/?view=theme&id=7915

            #to install: File > Import > Preferences > Select *.epf (Eclipse menus are SO unintuitive...)

        #c and c++: #http://download.eclipse.org/tools/cdt/releases/indigo/

        #python: http://pydev.org/updates

        #html, javascript, php: http://download.eclipse.org/webtools/repository/indigo/

        ##latex

            #http://texlipse.sourceforge.net
            #forward search to okular:
            #
            #inverse search from okular: Settings > Configure Okular > Editor
            #  Editor: custom text editor,
            #  Command: gvim --remote +%l %f

    ##libreoffice

        #Project contains wysiwyg text editor, tables, image editor, database management.

        #How to add new spellchecking language:<http://askubuntu.com/questions/72099/how-to-install-a-libreoffice-dictionary-spelling-check-thesaurus>

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

            assert [ "`echo a`" = a ]

        #multiple arguments are space separated:

            assert [ "`echo a b c`" = "a b c" ]

        ##gnu implementation

            #As explained in the versions section, POSIX does not specificy behaviour
            #if `-n` input starts or if input contains `\n`, and in practice inplementations
            #recognze other command line options besides `-n`.

            #Appends newline at end by default.

            #-n: no final newline:

                echo -n a

            #Does not interpret `\` escaped chars by default:

                assert [ "`echo 'a\nb'`" = $'a\\nb' ]

            #-e: interprets \ escaped chars:

                assert [ "`echo -e 'a\nb'`" = $'a\nb' ]
                assert [ "`echo -e '\x61'`" = $'a' ]

            #Print the `-n` string:
            #IMPOSSIBLE! not even gnu echo supports `--` since POSIX says that this should be supported.
            #=) use `printf`.

    ##printf

        # POSIX 7.

        # Goes around echo's quicks.

        # Anlogous to C printf.

        # Does not automatically append newline:

            assert [ "`printf "a"`" == "a" ]

        # Automatically interprets backslash escapes like C printf:

            printf "a\nb"

        # Automatically interprets backslash escapes like C printf:

        # Print the `-n` string:

            assert [ "`printf "%s" "-n"`" == "-n" ]

        # Supports C format strings:

            assert [ "`printf "%1.2d" 1`"       == "01" ]
            assert [ "`printf "%1.2f" 1.23`"    == "1.23" ]

        # Print the `-n` string:

            assert [ "`printf "%s" "-n"`" == "-n" ]

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

            assert [ "$(printf "a\nb\n" | tac)" = "$(printf "b\na")" ]

        # Things get messy if the input does not end in newline:

            assert [ "$(printf "a\nb" | tac)" = "$(printf "ba")" ]

    ##rev

        # Reverse bytewise.

            assert [ "`echo $'ab' | rev`" = $'ba' ]

    ##dd

        # POSIX

        # Menemonic: Duplicate Data.

        # Alternate funny mnemonic: Data Destroyer.
        # Reason: can manipulate sda devices directly without considering file structure,
        # making operations such as disk copy very fast, but potentially very destructive
        # if for example you exchange input and output disks, compying an empty disk over
        # useful data.

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

                assert [ `echo -n 1234 | dd status=none bs=2 count=1` = 12 ]
                assert [ `echo -n 1234 | dd status=none bs=1 count=3` = 123 ]

        ##size suffixes

            # -`c`: 1 (char)
            # -`w`: 2 (word)
            # -`kB`: 1000
            # -`K`: 1024
            # -`MB`: 1000*1000
            # -`M`: 1024*1024

            # and so on for G, T, P, E, Z and Y!

                assert [ `echo -n 123 | dd status=none bs=1c count=1` = 1 ]
                assert [ `echo -n 123 | dd status=none bs=1w count=1` = 12 ]

            # The larger the chunck size, the potentially faster file transfers will be.

            # Nowdays, `4M` is a good value for large file transfers.

        ##skip

            # Skip first n input blocks (defined by bs or ibs):

                assert [ `echo -n 123 | dd status=none bs=1 skip=1` = 23 ]

        ##seek

            # Skip first n output blocks (defined by bs or obs):

            # TODO minimal exmaple

        ##conv

            # Do serveral data conversions on copy

            # ucase: uppercase

                assert [ `echo -n abc | dd status=none conv=ucase` = ABC ]

        ##iflag oflag

            #TODO

        ##applications

            # Zero an entire block device located at `/dev/sdb` (CAUTION!!!! VERY DANGEROUS!!!!):

                 #sudo dd bs=4M if=/dev/zero of=/dev/sdb

            # As of 2013 with mainstream system specs,
            # this took around 6 minutes on a 2Gb flahs device (around 5.0 MB/s).

            # If you are really serious about permanently deleting files,
            # use a program for that with a potentially more advanced algorithm.

    ##pagers

        ##less

            # File pager (viewer).
            # Loads faster than vim.
            # Some vimlike commands

            # - `/`: search forward
            # - `n`: repeat last search
            # - `d`: down one page
            # - `u`: up one page
            # - `g`: top of document
            # - `G`: bottom of document
            # - `g`: top of document
            # <ENTER> : down one line

                less "$f"
                echo $'ab\ncd' | less

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

            assert [ "`echo -e "12345 6" | fold -s -w 3`" = $'123\n45\n6' ]

    ##fmt

        # coreutils.

        # Wrap lines, but don't cut words

            assert [ `echo "a bcd" | fold -w 2` = $'a\nbcd' ]

    ##column

        # bsdmainutils

        # If the input would be larger than the current terminal column count,
        # format it into newspaper like columns.

            seq 100 | column

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

    ##tsort

        # Topological sorting:
        # <http://en.wikipedia.org/wiki/Tsort_%28Unix%29>

            echo $'1 2\n2 3' | tsort
                #1
                #2
                #3

            echo $'1 2\n2 1' | tsort
                #contains loop
            echo $?
                #1

    ##uniq

        # POSIX 7

        #*Ajacent* dupe line operations.

        #Remove adjacent dupes lines:

            [ "$(echo $'a\nb' | uniq )" = $'a\nb' ] || exit 1
            [ "$(echo $'a\na' | uniq )" = $'a' ]    || exit 1

        #Non adjacent dupes are not removed:

            [ "$(echo $'a\nb\na\na' | uniq )" = $'a\nb\na' ] || exit 1

        #Thus the sort combo:

            [ "$(echo $'a\nb\na\na' | sort | uniq )" = $'a\nb' ] || exit 1

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

            assert [ `echo -n cab | tr abc ABC` =  CAB ]

        # Ranges are understood. Convert to uppercase:

            assert [ `echo -n cab | tr a-z A-Z` =  CAB ]

        # POSIX character classes are understood. Remove non alphtnum chras:

            assert [ `echo -n 'ab_@' | tr -cd "[:alpha:]"` = ab ]

        # - `c`: complement and replace. replaces all non abc chars by d

                assert [ `echo -n dcba | tr -c abc 0` =  0cba ]

        # - `d`: deletes abc chars:

                assert [ `echo -n dcba | tr -d abc` =  d ]

        # - `s`: replaces multiple consecutive 'a's and 'b's by isngle a

                assert [ `echo -n aabbaac | tr -s ab` =  abac ]

    ##cut

        # POSIX 7

        # Select columns from text tables.

        # For more complex operation such as selecting a line from a certain field, consider `awk`.

        # `-f`: field. what column to print.

             echo $'a\tb\nc\td' | cut -f1
                #$'a\nc'

        # `-d`: delimier

             echo $'a:b\nc:d' | cut -d: -f1
                #$'a\nc'

        # Gets last if delimier too large:

             echo $'a' | cut -d: -f2
                #$'a'

        # Multiple columns, first and third:

             echo $'a:b:c\nd:e:f' | cut -d: -f1,3
                #$'a:c\nd:f'

        # Column range from first to third:

            echo $'a:b:c:d\ne:f:g:h' | cut -d: -f1-3
                #$'a:b:c\ne:f:g'

    ##wc

        # POSIX 7

        # Does word, line, character and other similar counts.

        # Mnemonic: Word Count.

            echo -n $'a\nb c' | wc
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

        # Filter 10 first lines:

            seq 20 | head

        # Filter 3 first lines:

            seq 20 | head -n3

        # 2 first bytes:

            assert [ "`echo -en 'abc' | head -c 2`" = "ab" ]

        ##gnu coreutils

            # Remove last two bytes:

                assert [ "`echo -en 'abc' | head -c -2`" = "a" ]

    ##tail

        # POSIX 7

        # Show last 10 lines of f:

            tail "$f"

        # Show last 3 lines of f:

            tail -n3 "$f"

    ##truncate

        # Sets file to given size.

        # If greater, pads with 0s.

        # If smaller, data loss.

            echo ab > f
            truncate -s 1 f
            assert [ `cat f` = a ]

            truncate -s 2 f
            hexdump
            assert [ `cat f` = $'a\0' ]

    ##split

        # corutils.

        # Split files into new smaller files of same size

            echo -n abc > f

            split -db1 f p
            split -dn3 f p

            assert [ `cat p00` = a ]
            assert [ `cat p01` = b ]
            assert [ `cat p02` = c ]

        # Existing files are overwritten:

        # Options:

        # - `d`: uses number suffixes, otherwise, uses letters aa, ab, ac, ...
        # - `b`: bytes per file
        # - `n`: number of files

    ##csplit

        #corutils.

        # Split files into new smaller files at lines that match given EREs.

        # Matching lines are kept.

            echo $'0\naa\n1\naa\n2' > f
            csplit f '/^a/' '{*}'
            assert [ `cat xx00` = 0 ]
            assert [ `cat xx01` = $'aa\n1' ]
            assert [ `cat xx02` = $'aa\n2' ]

    ##paste

        # POSIX 7.

        # Useless

        # Shows files side by side line by line.

        # Default separator: tab.

        # Long lines will make this unreadable.

            echo -e "a a a a a a a a a a a a a a\na" > a
            echo -e "b b\nb b"                       > b
            echo -e "c c\nc c\nc"                    > c
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

        ##basename

                basename /usr/a.txt
                    #a.txt

                basename /usr/a.txt .txt
                    #a

        ##dirname

                #get the parent dir of a path, not / terminated except for /, no error checking
                dirname /path/to/dir/or/file
                    #/path/to/dir/or
                dirname /
                    #outputs /

    ##strings

        # Search for printable strings in file.

        # Prints sequences of at least 4 printable chars by default.

        # Useful to extract information from non textual formats,
        # which contain some textual data

            gcc c.c
            strings a.out

    ##sed

        # POSIX 7

        # Stream EDitor

        # Modifies files non-interactively.

        # Beginner to pro tutorial: <http://www.grymoire.com/Unix/Sed.html>

        ##alternatives

            # Consider using Python instead of this, or Perl if your are insane and really want to golf.

            # sed has only slightly better golfing than Perl.

            # The only real advantage of sed over Perl is that Sed is POSIX, while perl is only LSB.

        ##s command

            # Substitute:

                assert [ "`echo $'aba\ncd' | sed 's/a/b/'`" = $'bba\ncd' ]

            # pattern is a BRE

            # g modifier:

                assert [ "`echo 'aba' | sed 's/a/b/g'`" = $'bbb' ]

            # Replaces multiple non overalpping times on each line.

            ##patterns are BREs

                assert [ "`echo 'aa' | sed 's/[[:alpha:]]/b/'`" = 'ba' ]
                assert [ "`echo 'aa' | sed 's/.+/b/'`" = 'ab' ]
                    #+ is ordinary, thus BRE, and no match

                ##EREs with -r

                    #therefore always use -r for regexes

                        assert [ "echo 'aa' | `sed -r 's/.+/b/'`" = 'b' ]

            ##capturing groups

                    assert [ "`echo a1 | sed -r 's/a(.)/b\1/'`" = 'b1' ]
                    assert [ "`echo a1 | sed -r 's/a(.)/b\\1/'`" = 'b\1' ]
                    assert [ "`echo a1 | sed -r 's/a(.)/\0&/'`" = 'a1a1' ]
                        #\0 and & both refer to the entire match
                    assert [ "`echo a1 | sed -r 's/a(.)/\&/'`" = '&' ]

                    #no non-greedy *? operator. use [^]* combo instead

            ##flags

                ##g

                    #replace as many times as possible in string

                ##p

                    #is can also be a flag, besides being the print command

                ##w

                    #write lines to file:

                        echo $'a\nb\na' | sed -n 's/a/A/w f'
                        assert [ "`cat a`" = $'A\nA' ]

        ##/

            #only exec next command if match

                assert [ "`echo $'a\nb' | sed -n '/a/p'`" = $'a' ]

        ##restrict lines

            #line number:

                assert [ "`echo $'a\nb' | sed -n '1 p'`" = $'a' ]

            #last line:

                assert [ "`echo $'a\nb' | sed -n '$ p'`" = $'b' ]

            #before last line:

                assert [ "`echo $'a\nb' | sed -n '$-1 p'`" = $'a' ]

            #line matches pattern:

                assert [ "`echo $'a\nb' | sed '/a/ s/./c/'`" = $'c\nb' ]

            #line range:

                assert [ "`echo $'a\nb\nc\nd' | sed '1,3 s/./e/'`" = $'e\ne\ne\nd' ]

            ##pattern range

                    assert [ "`echo $'a\nb\nc\nd' | sed '/a/,/c/ s/./0/'`" = $'0\n0\n0\nd' ]

                #non-greedy:

                    assert [ "`echo $'a\nb\n0\n0\na\nb' | sed '/a/,/b/ s/./A/'`" = $'A\nA\n0\n0\nA\nA' ]

            ##multiple commands per restriction

                assert [ "`echo $'a\nb' | sed '1 {s/./c/; s/c/d/}'`" = $'d\nb' ]

            ##!

                #negation

                #act on non matching

                    assert [ "`echo $'a\nb' | sed -n '1! p'`" = $'b' ]
                    assert [ "`echo $'a\nb' | sed -n '/a/! p'`" = $'b' ]

        ##multiple commands

            #concatenate with ; or newlines

                assert [ "`echo $'a\nb' | sed '/a/ s/./B/; /B/ {s/B/C/; s/C/D/}'`" = $'D\nb' ]

        ##q

            #quit

                assert [ "`echo $'a\nb' | sed 's/./c/; q'`" = $'c' ]

        ##d

            #delete

                assert [ "`echo $'a\nb' | sed '/a/ d'`" = $'b' ]

        ##a, i, c

            #append (after), insert (before), change

                assert [ "`echo $'a\nb' | sed '1 i 0'`" = $'a\n0\nb' ]
                assert [ "`echo $'a\nb' | sed '1 i 0'`" = $'0\na\nb' ]
                assert [ "`echo $'a\nb' | sed '1 c 0'`" = $'0\nb' ]

            ##newlines and spaces

                assert [ "`echo $'a\nb' | sed '1 c 0 1\n2 3'`" = $'0 1\n2 3\nb' ]

        ##line number

            #=

                assert [ "`echo $'a\nb\na' | sed -n '/a/ ='`" = $'1\n3' ]

        ##replace chars

            #y

                assert [ "`echo $'a\nb' | sed -n 'y/ab/01'`" = $'0\n1' ]
                assert [ "`echo $'a\nb' | sed -n 'y/ab/AB'`" = $'A\nB' ]

        ##multiline

            #- pattern space: buffer that holds each line.

                #`s//` modifies pattern space

            #- n: empty pattern space, put next line into it. default action at end.

                #print first line after matching `/a/`:

                    assert [ "`echo $'a\nb' | sed -n '/a/ {n;p}'`" = $'b' ]

                #print second line after matching `/a/`:

                    assert [ "`echo $'a\nb\nc' | sed -n '/a/ {n;n;p}'`" = $'c' ]

            #- N: append next line to pattern space. Next line is not read again.

                    assert [ "`echo $'a\nb' | sed -n '/a/ {N;p};'`" = $'a\nb' ]
                    assert [ "`echo $'a\nb' | sed -n '/b/ p; /a/ {N;p};'`" = $'a\nb' ]

            #- p: print entire pattern space. default action at end if no `-n`.

            #- P: print up to first newline.

                    assert [ "`echo $'a\nb' | sed -n '/a/ N'`" = $'b' ]

            #- d: delete pattern space. go to next line. *Is a loop continue*

            #- D: delete first line of pattern space. go to next line.

        ##hold buffer

            #there is an storage area called **hold buffer** in addition to the pattern buffer

            #it can contain the strings

            ##h

                #put pattern buffer into storage

            ##x

                #exchange storage and pattern

                #print old/new newline pairs after substitution

                    assert [ "`echo $'a\nb' | sed -n 'h; /a/ {s/a/c/; s/$/\n/; x;p;x;p}'`" = $'a\nc\n' ]

                #print first line before matching `/b/`:

                    assert [ "`echo $'a\nb' | sed -n '/b/ {x;p;d}; h'`" = $'a' ]

            ##g

                #pattern space = hold space

                    assert [ "`echo $'a\nb' | sed -n 'h; /a/ {s/a/c/;x;p;g;p}'`" = $'a\nc' ]

            ##G

                #pattern space += hold space

                    assert [ "`echo $'a\nb' | sed -n 'h; /a/ {s/a/c/;x;G;p}'`" = $'a\nc' ]

        ##goto

            ##label

                #:label

                #may be on same line as command, ex: `:l s/a/b/` is the same as `:l; s/a/b`

            ##b

                #unconditional

                    assert [ "`echo $'a\nb' | sed '/a/ b c; s/./c/; :c'`" = $'a\nc' ]
                    assert [ "`echo $'a\nb' | sed '/a/ b c; s/./c/; :c s/c/d'`" = $'a\nd' ]

            ##t

                #jump if last s changed pattern space

                #remove spaces after a:

                    assert [ "`echo $'a  b  c' | sed ':a s/a /a/; t a'`" = $'ab  c' ]

                #remove everything between a and c

                    assert [ "`echo $'a  b  c' | sed ':a s/a[^c]/a/; t a'`" = $'ac' ]

        ##command line arguments

            ##-n

                #-n: don't print all lines (default)

                    sed -n 's/find/repl/gp'
                        #/p: print if match
                        #prints only lines that match find
                        #does not change f

                    sed -n '/find/p'
                        #same as grep

            ##-i

                    f=f
                    echo $'a\nb' > "$f"
                    sed -i 's/a/A/' "$f"
                    assert [ "`cat "$f"`" = $'A\nb' ]

                    sed -i.bak 's/A/a/' "$f"
                        #baks up old file with .bak suffix
                    assert [ "`cat "$f"`" = $'a\nb' ]
                    assert [ "`cat "$f".bak`" = $'A\nb' ]
                    assert [ `ls | wc -l` = 2 ]

                #-i: in place

                #whatever it would print to stdout, writes to the input file instead

                #cannot be used with stdin input!

            ##-e

                #execute

                #give multiple commands

                #execute in each line in given order

                #same as ; concatenating commands

                assert [ "`echo $'a\nb' | sed -e 's/a/b/' -e 's/b/c/'`" = $'c\nc' ]

            ##-f

                #read commands from given file

                #one command per line

                ##shebang

                    #can exec sed script with following shebang:

                    #!/bin/sed -f

        ##applications

            #If modified, print line number, old line, new line

            #Ex:

            #input:

                #a
                #b
                #a
                #b

            #regex: s/a/c/

            #output:

                #1
                #a
                #c
                #
                #3
                #a
                #c

            assert [ "`echo $'a\nb\na\nb' | sed -n 'h; s/a/c/; t p; d; :p {=;x;G;s/$/\n/;p}'`" = $'1\na\nc\n\n3\na\nc\n' ]

    ##awk

        #POSIX 7.

        #Use only for text table field manipulation

        #awk only gets slightly better golfing on a very limited problem set

        #The only real advantage of awk over perl is the fact that it is in POSIX,
        #while perl is only in LSB. awk only has slighty better golfing.
        #Therefore: don't rely on awk GNU extensions, or you lose the only major advantage of awk!

        #For more even more sanity, use python.

        ##variables

            #same as c

            #initialized to 0.

            #$0: entire record
            #$\n: fields
            #last field: $(NF-1)

            ##FS
                #field (column) separator
                #FS=':' FS=/[[:space:]]/ -F'/[[:space:]]/'
            #OFS: output field separator
            #RS: record (line) separator
            #ORS: output ""
            #NF: number of fields
            #NR: number of current record
            #FNR: total number of records in cur file

        #- arithmetic: same as C: +, *, -, /

        #- string comp: `==` and `!=`

        #- posix string ERE regex comp: ~// !~// (sub match accepted unless you use `^$`)

        #- if else for while: like C

        ##general syntax

            #A general awk program is of the type:

                #BEGIN          { STATEMENT_BEGIN }
                #CONDITION0     { STATEMENT0      }
                #CONDITION1     { STATEMENT1      }
                #...
                #CONDITION_N    { STATEMENT_N     }
                #END            { STATEMENT_END   }

            echo $'1 2\n3 4' | awk 'BEGIN{print "b"}1<2{print "l"}1<2{print "l2"; print "l3"}1>2{print "l4"}END{print "e"}'
            #$'b\nl\nl2\nl3\nl\nl2\nl3\ne

            echo '0.5 0.5' | awk '{print $1+$2}'
            #1

        ##string num conversion

                awk 'BEGIN{print "1"+1}'
                awk 'BEGIN{print " 1"+1}'
                #2

        ##print

            awk 'BEGIN{print "a", 1}'
                #'a 1'
                    #by default, print does space separation
            awk 'BEGIN{print "a"."b"}'
                #'ab'
                    #string concat
            awk '{print}'
                #cat

        ##applications

            #Print second field of all entries if first field equals:

                [ "$(echo $'1 a\n2 b\n1 c' | awk '$1 == 1 { print $2 }')" = "$(printf 'a\nc')" ] || exit 1

            #Same as above, but print only first match:

                [ "$(echo $'1 a\n2 b\n1 c' | awk '$1 == 1 { print $2; exit }')" = a ] || exit 1

            #Same as above, but match EREs:

                [ "$(echo $'1 a\n2 b\n1 c' | awk '$1 ~/^1$/ { print $2; exit }')" = a ] || exit 1

##moreutils

    #extra base linux utils

        sudo aptitude install moreutils

    ##sponge

        #solves the input to output problem problem

        #setup:

            echo $'0\n1' > a

        #fails:

            grep 0 a | cat > a
            assert [ "`cat a`" = '' ]

        #works:

            grep 0 a | sponge a
            assert [ "`cat a`" = '0' ]

    ##vipe

        #use editor (aka vim =)) in the middle of a pipe

            EDITOR=vim
            seq 10 | vipe | less

            a="`seq 10 | vipe`"
            echo "$a"

        #uses editor environment variable to determine editor

        #in ubuntu, this is set by default to vim in bashrc.

        #this is my preferred way to get user
        #input that might be large (git commit messages...)

            a="`echo -e "\n#lines starting with '#' will be ignored" | vipe | grep -Ev '^#' `"
            echo "$a"

##character encodings

    ##chinese

        #- Guobiao is mainly used in Mainland China and Singapore. Named as `GB\d+`
        #- Big5, used in Taiwan, Hong Kong and Macau

        #`file` does not work properly for chinese

    ##dos2unix

        #CR LF to CR

        #in place:

            echo -e 'a\r\nb\r\n' > a.txt
            dos2unix a.txt
            assert [ "`cat a.txt`" = $'a\nb\n' ]

    ##enca

        #detect and convert international encodings

        #guess encoding:

            enca a.txt

        #this may not work if you don't give the expected language as input.

        #view available languages:

            enca --list languages

        #tell enca that the file is in chinese:

            enca -L zh a.txt

        #you give languages as locales
        #(i think as 2 letter iso 639-1 codes <http://en.wikipedia.org/wiki/List_of_ISO_639-1_codes> since only `zh` worked for chinese)

    ##iconv

        #convet character encodings

        #major encodings
            #ASCII
            #UTF-8
            #UTF-16
            #chinese only:
                #GB18030: Guobiao Mainland China and Singapore. prefixed by GB, latest version GB18030
                #BIG-5: Taiwan, Hong Kong and Macau, is a one or two byte encoding.

        iconv -l
            #list available encodings

        iconv -f BIG-FIVE -t UTF-8 "$F"
            #convert contents of F from BIG-FIVE to UTF-8
            #no changes made: only outputs to stdout

    ##convmv

        #mv converting encodings

            sudo aptitude install convmv

##cron

    #Tell the computer to do things at specified times automatially.

    ##crontab

        #POSIX 7

        #Utility to manage crobjobs.

        #It is basically a frontend for the `/etc/crontab` file which an be edited directly.

        #It is not possible launch graphical applications via cron!

        #Edit user cron jobs in vim

            crontab -e

        #Sample line:

            1 2 3 4 5 /path/to/cmd.sh arg1 arg2 >/dev/null 2>&1

        #Fields:

        #- 1: Minute (0-59)
        #- 2: Hours (0-23)
        #- 3: Day (0-31)
        #- 4: Month (0-12 [12 == December])
        #- 5: Day of the week(0-7 [7 or 0 == sunday])
        #- /path/to/command - Script or command name to schedule#

        #Special notations:

        #- * : every
        #- */5 : every five
        #- 1,3,6 : several
        #- 1-5 : ranges

        #Convenient altenatives to the fields:

        #- @reboot	Run once, at startup.
        #- @yearly	Run once a year, "0 0 1 1 *".
        #- @annually	(same as @yearly)
        #- @monthly	Run once a month, "0 0 1 * *".
        #- @weekly	Run once a week, "0 0 * * 0".
        #- @daily	Run once a day, "0 0 * * *".
        #- @midnight	(same as @daily)
        #- @hourly	Run once an hour, "0 * * * *".

        #Example:

            @daily /path/to/cmd.sh arg1 arg2 >/dev/null 2>&1

        #`>/dev/null 2>&1` prevents cron from sending notification emails.

        #Otherwise if you want them add:

            #MAILTO="vivek@nixcraft.in"

        #to the config file.

        #List all cronjobs:

            crontab -l

        #List all cronjobs for a given user:

            crontab -u user -l

        #Erase all cronjobs:

            crontab -r

        #Erase all cronjobs for a given user only

            crontab -r -u username

    ##at

        #schedule job at a single specified time

        #not for a periodic job!

        cd "`mktemp -d`"
        echo "touch a" | at now + 1 minutes
            #in one minute `test -f a`
        echo "echo a" | at now + 1 minutes
            #nothing happens!
            #of course, job does not run in current shell
        echo "xeyes" | at now + 1 minutes
            #nothing happens

        atq
            #list jobs

        atrm 1
            #remove job with id 1
            #id can be found on atq output

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

    ##batch

        #posix 7

        #superset of `at`

        #execute only when system load average goes below 1.5
        #starting from now!

            cd "`mktemp -d`"
            echo "touch a" | batch

        #same, but with at you can change to any time

            echo "touch a" | at -q b now

##disk

    #This section is about: hard disks, mounting, partitions, filesystem, block devices.

    ##du

        #POSIX 7

        #Mnemonic: Disk Usage.

        #get disk usage per file/dir:

            du -sh * | sort -hr

        #- s: summarize: only for dirs in *, not subdirs
        #- h: human readable: G, M, b

    ##df

        #POSIX 7

        #Mnemonic: Disk Fill.

        #List mounted filesystems:

            df -h

        #`-h` for human readable.

        #Sample output:

            Filesystem      Size  Used Avail Use% Mounted on
            /dev/sda5       333G  155G  162G  49% /
            none            4.0K     0  4.0K   0% /sys/fs/cgroup
            udev            1.8G  4.0K  1.8G   1% /dev
            tmpfs           376M  1.1M  375M   1% /run
            none            5.0M     0  5.0M   0% /run/lock
            none            1.9G  928K  1.9G   1% /run/shm
            none            100M   28K  100M   1% /run/user
            /dev/sda2        94G   64G   30G  69% /media/win7
            /dev/sda7        16G  7.9G  6.6G  55% /media/ciro/375e62f3-b738-4670-8018-5e

        #Sort by total size:

            df -h | sort -hrk2

        #Sample output:

            /dev/sda5       333G  155G  162G  49% /
            /dev/sda2        94G   64G   30G  69% /media/win7
            /dev/sda7        16G  7.9G  6.6G  55% /media/ciro/375e62f3-b738-4670-8018-5ea1cb546cdf
            none            1.9G  928K  1.9G   1% /run/shm
            udev            1.8G  4.0K  1.8G   1% /dev
            tmpfs           376M  1.1M  375M   1% /run
            none            100M   28K  100M   1% /run/user
            none            5.0M     0  5.0M   0% /run/lock
            none            4.0K     0  4.0K   0% /sys/fs/cgroup
            Filesystem      Size  Used Avail Use% Mounted on

        #Also show partition filesystems type:

            df -T

        ##-i

            #Get percentage of inodes free / used:

                df -i

            #Sample output:

                Filesystem       Inodes  IUsed    IFree IUse% Mounted on
                /dev/sda5      22167552 832797 21334755    4% /
                /dev/sda2      30541336 189746 30351590    1% /media/win7

            #This is interesting because the number of inodes is a limitation of filesystems
            #in addition to the ammount of data stored.

            #This limits the ammount of files you can have on a system in case you have lots of small files.

    ##partitions

        #There are 2 main types of partitions: MBR or GPT

        ##MBR

            #You can only have 4 primary partitions.

            #Each one can be either divided into logical any number of logical partitions partitions.

            #A primary parition that is split into logical paritions is called an extended partition.

            #Primary partitions get numbers from 1 to 4.

            #Logical partitions get numbers starting from 5.

            #You can visualise which partition is insde which disk with `sudo lsblk -l`.

            #TODO more common?

        ##GPT

            #Arbitrary ammount of primary partitions.

            #No logical partitions.

        #You should unmount partitions before making change to them.

        #To get info on partitions, start/end, filesystem type and flags,
        #consider: `parted`, `df -f`

    ##format disks

        #To format a disk is to prepare it for initial utilization, often destroying all data it contains.

        #Disk formatation consists mainly of two steps:

        #- create a partition table. This can be done with a tool such as `fdisk`.
        #- create a filesystem. This can be done with a tool from the mkfs.XXX family.

        #GUI tools such as gparted exist to make both those steps conveniently.

    ##lsblk

        #List block devices (such as partitions, hard disks or DVD devices),
        #including those which are not mounted.

            sudo lsblk

        #Sample output:

            NAME   MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
            sda      8:0    0 465.8G  0 disk
            |-sda1   8:1    0   1.5G  0 part
            |-sda2   8:2    0  93.2G  0 part /media/win7
            |-sda3   8:3    0  13.7G  0 part
            |-sda4   8:4    0     1K  0 part
            |-sda5   8:5    0 338.1G  0 part /
            |-sda6   8:6    0   3.7G  0 part [SWAP]
            `-sda7   8:7    0  15.6G  0 part
            sdb      8:16   0 931.5G  0 disk
            `-sdb1   8:17   0 931.5G  0 part /media/ciro/DC74FA7274FA4EB0

        #-f: show mostly information on filesystems:

            sudo lsblk -f

        #Sample output:

            NAME   FSTYPE LABEL           MOUNTPOINT
            sda
            |-sda1 ntfs   SYSTEM_DRV
            |-sda2 ntfs   Windows7_OS     /media/win7
            |-sda3 ntfs   Lenovo_Recovery
            |-sda4
            |-sda5 ext4                   /
            |-sda6 swap                   [SWAP]
            `-sda7 ext4
            sdb
            `-sdb1 ntfs                   /media/ciro/DC74FA7274FA4EB0

    ##fdisk

        #View and edit partition tables and disk parameters

        #REPL interface.

        #Does not create filesystems. For that see: `mke2fs` for ext systems..

        #Mnemonic: Format disk.

        #Better use gparted for simple operations if you have X11

        #To view/edit partitions with interactive cli prompt interface.

        ##-l

            #Show lots of partition and disk data on all disks:

                sudo fdisk -l

            #Sample output for each disk:

                Disk /dev/sda: 500.1 GB, 500107862016 bytes
                255 heads, 63 sectors/track, 60801 cylinders, total 976773168 sectors
                Units = sectors of 1 * 512 = 512 bytes
                Sector size (logical/physical): 512 bytes / 4096 bytes
                I/O size (minimum/optimal): 4096 bytes / 4096 bytes
                Disk identifier: 0x7ddcbf7d

                   Device Boot      Start         End      Blocks   Id  System
                /dev/sda1   *        2048     3074047     1536000    7  HPFS/NTFS/exFAT
                /dev/sda2         3074048   198504152    97715052+   7  HPFS/NTFS/exFAT
                /dev/sda3       948099072   976771071    14336000    7  HPFS/NTFS/exFAT
                /dev/sda4       198504446   948099071   374797313    5  Extended
                Partition 4 does not start on physical sector boundary.
                /dev/sda5       198504448   907638783   354567168   83  Linux
                /dev/sda6       940277760   948099071     3910656   82  Linux swap / Solaris
                /dev/sda7       907640832   940267519    16313344   83  Linux

        ##REPL

            #Edit partitions for sdb on REPL interface:

                sudo fdisk /dev/sdb

            #Operation: make a list of changes to be made, then write them all to disk and exit with `w` (write).

            #Most useful commands:

            #- m: list options
            #- p: print info on partition, same as using `-l` option.
            #- o: create new DOS partition table.
            #- n: create new partition.
            #- d: delete a partition.
            #- w: write enqueued changes and exit.

    ##hard disks

        #Hard disks are represented by the system as block devices.

        #However, they have physical peculiarities which make their performance characteristics
        #different from block devices such as USB sticks.

        #The following parameters are relevant only to hard disks:

        #- sectors: smalles adressable memory in hd. you must get the whole sector at once.
        #- tracks
        #- cylinders
        #- heads

        #To understand those concepts, you must visualise the hard disk's physical arrangement:

        #- <http://osr507doc.sco.com/en/HANDBOOK/hdi_dkinit.html>
        #- <http://en.wikipedia.org/wiki/Track_%28disk_drive%29>

        #Those parameters can be gotten with commands such as `sudo fdisk -l`.

    ##filesystem

        #determines how data will get stored in the hard disk

        #ext2, ext3 and ext4 are the ones mainly used in linux today.

        #on ext4, only one dir is created at the root: lost+found

        #other important filesystems:

        #- ntfs: windows today
        #- nfat: dos
        #- mfs: Machintosh FileSystem. Mac OS X today.

        #to find out types see blkid or lsblk

        #each partition can have a different filesystem.

        #When creating partitions for external storage devices such as USB stick nowdays,
        #the best option is NTFS since Linux can read write to it out of the box, and it can be used on
        #the 95% of computers because they use Windows (which does not read / write to ext out of the box.)

    ##create filesystems

        #Find all commands to make filesystems:

            ls -l /sbin | grep mk

        #Sample output:

            -rwxr-xr-x 1 root root     26712 Feb 18 18:17 mkdosfs
            -rwxr-xr-x 1 root root     88184 Jan  2  2013 mke2fs
            -rwxr-xr-x 1 root root      9668 Feb  4 21:49 mkfs
            -rwxr-xr-x 1 root root     17916 Feb  4 21:49 mkfs.bfs
            -rwxr-xr-x 1 root root     30300 Feb  4 21:49 mkfs.cramfs
            lrwxrwxrwx 1 root root         6 Jan  2  2013 mkfs.ext2 -> mke2fs
            lrwxrwxrwx 1 root root         6 Jan  2  2013 mkfs.ext3 -> mke2fs
            lrwxrwxrwx 1 root root         6 Jan  2  2013 mkfs.ext4 -> mke2fs
            lrwxrwxrwx 1 root root         6 Jan  2  2013 mkfs.ext4dev -> mke2fs
            -rwxr-xr-x 1 root root     26220 Feb  4 21:49 mkfs.minix
            lrwxrwxrwx 1 root root         7 Feb 18 18:17 mkfs.msdos -> mkdosfs
            lrwxrwxrwx 1 root root        16 Feb 25 14:54 mkfs.ntfs -> /usr/sbin/mkntfs
            lrwxrwxrwx 1 root root         7 Feb 18 18:17 mkfs.vfat -> mkdosfs
            -rwxr-xr-x 1 root root     18000 Mar 12 04:43 mkhomedir_helper
            -rwxr-xr-x 1 root root     87484 Feb 25 14:54 mkntfs
            -rwxr-xr-x 1 root root     22152 Feb  4 21:49 mkswap

        #Where:

        #- mkfs.XXX are uniformly named frontends for filesystem creation
        #- mkfs is a frontend for all filesystem types.

        #You should only use on partition devices (ex: `sda1`), not on the entire devices (ex: `sda`).

        #If you want to edit the partition table,
        first use a tool like `fdisk`.

    ##mke2fs

        #Make ext[234] partitions.

        #Consider using gparted if you have X11.

        #- -t: type: ext2, ext3, ext4
        #- -L: label
        #- -i: inodes per group (power of 2)
        #- -j: use ext3 journaling. TODO for -t ext3/4, is it created by default?

    ##tune2fs

        #Get and set parameters of ext filesystems that can be tuned after creation.

        #List all parameters:

            sudo tune2fs -l /dev/sda5

    ##swap

        #used by OS to store RAM that is not being used at the moment to make room for more RAM.

        #should be as large as your RAM more or less, or twice it.

        #can be shared by multiple OS, since only one os can run at a time.

        #turn swap on on partition /dev/sda7:

            sudo swapon /dev/sda7

        #find the currently used swap partition:

            swapon -s

        #disable swapping:

            sudo swapoff

        #make a swap partition on partition with random uuid

            sudo mkswap -U random /dev/sda7

        #swap must be off

    ##gparted

        #gui to fdisk + mke2fs

        #very powerful and simple to use

    ##parted

        #get information on all partitions

        #very useful output form:

            sudo parted -l

        #sample output:

            Number  Start   End     Size    Type      File system     Flags
             1      1049kB  1574MB  1573MB  primary   ntfs            boot
             2      1574MB  102GB   100GB   primary   ntfs
             4      102GB   485GB   384GB   extended
             5      102GB   465GB   363GB   logical   ext4
             7      465GB   481GB   16.7GB  logical   ext4
             6      481GB   485GB   4005MB  logical   linux-swap(v1)
             3      485GB   500GB   14.7GB  primary   ntfs

    ##device files

        # Each hard disk has a corresponding device files.

        # Each partition has a corresponding block device file.

            ls -l /dev | grep -E ' (sd|hd)..?$'

        # Sample output:

            hda
            hda1
            hda2
            hda5
            sdb
            sdb1
            sdb2
            sdb3
            hdc

        # Format:

            hdc1
            ^^^^
            1 23

        # 1. partition type. hd: IDE (older). sb: SCSI (newer)
        # 2. hard disk identifier.
        # 3. parition number inside hard disk.

        # So on the example output given:

        # - 3 hds: had, sdb and hdc
        # - 1 and 3 are hd, 2 is sd
        # - 1 has 3 partitions

    ##uuid

        # Unique identifier for a partition. Field exists in ext and NTFS concept.

        # Given when you create of format a partition.

        # Can be found with tools such as lsblk, blkid or gparted.

        # Get UUID of a device:

            sudo lsblk -no UUID /dev/sda1

    ##blkid

        #Get UUID, label and filesystem type for all partitions

            sudo blkid

    ##label

        #An ext partitions concept.

        #Determines the mount name for the partition.

        #Should be unique, but not sure this is enforced. TODO

    ##e2label

        #get/set ext[234] label info

        #sets new label for partition:

            sudo e2label /dev/sda7
            sudo e2label /dev/sda new_label

        #Each partition may have a label up to 16 chars length.
        #If it does, the partition will get that name when mounted.

    #list all labels:

        sudo blkid

    ##/dev/disk

        #symliks to partition identifiers

        #allows you to get identifier info

        #if id no present, link not there

        #Example:

            cd /dev/disk/
            ls -l
                #by-id
                #by-label
                #by-path
                #by-uuid

            ls -l by-id

    ##mount

        #Mounting is the operation of making a block device available for operations such as open, read and write.

        #This is what you must do before you can use devices such as USB.

        #Many modern distributions mount such devices automatically.

        #Linux has system calls dedicated to this operation.

        #The block device will be mounted on a directory in the filesystem,
        #and from then on shall be essentially indistinguishable from normal directories.
        #This directory is known as mount point.

        #If the directory was not empty, old contents will be hidden.

        #You can mount several times on the same point,
        #the last operation hiding the old mounted system
        #until the latest mounted system is unmounted.

        #You can mount with the mount utility, and unmount with the umount utility.

    ##mount util

        #Mount block device file on filesystem:

            sudo mount /dev/sda1 /media/win/

        #List all mount points:

            sudo mount -l

        #Sample output:

            /dev/sda5 on / type ext4 (rw,errors=remount-ro)
            1            2      3     4

        #Shows:

        #1. device if any
        #2. mountpoint
        #3. type
        #4. flags

        ##bind

            # Make one dir a copy of the other, much like a hardlink does to files.

            # Requires `sudo` like mount because it uses kernel internals to do it.
            # For an userspace solution consider `bindfs`.

                mkdir a
                mkdir b
                sudo mount --bind a b
                touch a/a
                touch b/b
                assert [ `ls a` = $'a\nb' ]
                assert [ `ls b` = $'a\nb' ]
                sudo umount b
                assert [ `ls a` = $'a\nb' ]
                assert [ -z `ls b` ]

    ##umount

        #unmount what is on this dir

            sudo umount /media/win/

    ##fstab

        #This is about he file located at `/etc/fstab`.

        #Options for fsck

        #Basic usage: mount partitions at startup

        #Source

            #<http://www.tuxfiles.org/linuxhelp/fstab.html>
            #<https://wiki.archlinux.org/index.php/Fstab>

                man fstab
                man mount

            #options are here

        #list partitions that should mount up at startup
        #and where to mount them

            sudo cp /etc/fstab /etc/fstab.bak
            sudo vim /etc/fstab
            sudo mount -a

        #apply changes
        #only mounts `auto` option set.

        #syntax:

            <file system> <mount point>   <type>  <options>       <dump>  <pass>
            1             2               3       4               5       6

        #1. identifier to the file system.

            #Ex:

            #- /dev/sda1
            #- UUID=ABCD1234ABCD1234
            #- LABEL=mylabel

        #2. where it will get mounted.

            #The most standard option is to make a subdir of `/media` like `/media/windows`.

            #This dir must exist before mount
            #and preferably be used only for mounting a single filesystem.

            #It seems that fstab can auto create/remove the missing dirs.

        #3. Type. ext[234], ntfs, etc.

        #see sources for others.

        ##auto mount windwos filesystems

            #To mount windows filesystems such as NTFS or DOS use:

                umask=111,dmask=000

            #This way, dirs will be 000 and files 666 (not executable)

        ##dvd

            #Mounting dvds/usbs is similar to mounting partitions:

                /dev/cdrom 	/media/dvd 	noauto 	ro 0 0

            #However if you use auto, you always get errors when the dvd is empty.

            #It is best to use auto, because dvd can be of several formats.

    ##fuser

        #View which processes are using a device:

            fuser -m /dev/sdb1

        #Useful if you want to unmont a filesystem, and you have to find out who is still using it.

    ##fsck

        #File System Check

        #Check and repair linux filesystems.

##system info

    ##uname

        #gets information on host computer

        #POSIX 7

        #print all info uname has to give:

            uname -a

        #this includes kernel version, user, ...

        #you can each isolated with other opts

    ##processor ##cpu

        ##arch

            #architecture

            #subset of uname

                arch

            #i686

        ##mpstat

            #processor related stats

                mpstat

        ##nproc

            #number of processing unites (= cores?)

            #coreutils

                nproc

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

                23:00:13 up 12:00,  3 users,  load average: 0.72, 0.66, 0.6
                ^^^^^^^^ up ^^^^^,  ^ users,  load average: ^^^^, ^^^^, ^^^
                1           2       3                       4     5     6

            #Meanings:

            #- 1: cur time
            #- 2: how long the system has been up for
            #- 3: how many users are logged
            #- 4: load average for past 1  minute
            #- 5:                       5  minute
            #- 6:                       15 minutes

            ##load average

                #0.75: 0.75  as many scheduled tasks as your cpu can run
                    #rule of thumb maximum good value
                #1   :       as many scheduled tasks as your cpu can run
                    #break even point
                    #risky, a littly more and you are behind schedule
                #5   : 5x
                    #system critically overloaded

                #does not take into account how many cores you have!
                #ex: for a dual core, breakeven at 2.0!

            ##uptime

                #echo first line of top

                    uptime

        ##free

            #show RAM and swap memory in Megabytes

            #-t totals at bottom
            #-sN : repeat every N seconds

                free -m

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

                #new: usb 3.0
                #old still existing: usb 2.0

                #current uses: mouse, keyboard, external hard disks, external cd, flash storage devices

                #several device classes

                #several connector types: Standard-A, Standard-B, Micro-B, Mini-B
                #<http://en.wikipedia.org/wiki/File:Usb_connectors.JPG>

                #3.0:

                    #full duplex
                    #8 pins
                    #voltage: 5 V
                    #power: max 0.9 A (5V)
                    #signaling rate: 5 Gbit/s (Super Speed mode)
                    #maximal cable length: 5 meters

                    ##differentiate from usb 2.0

                        #3.0 tipically blue while 2.0 black

                        #3.0 has 8 pins instead of 4

                        #ss for super spped may be written

                        #<http://www.usb3.com/usb3-info.html>

                ##libusb

                    #control usbs

                    sudo aptitude install -y libusb-dev
                    sudo aptitude install -y libusb++-dev

            ##firewire

            ##ethernet

        #cpu info

            cat /proc/cpuinfo

        #mem info

            cat /proc/meminfo

        ##lspci

            sudo lspci

        ##hwinfo

            sudo aptitude install -y hwinfo

            hwinfo | less

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

##eval

    #POSIX 7.

    #exec string in current bash

        eval "a=b"
        assert [ $a = b ]

    #concatenates arguments, space separated:

        assert [ `eval echo a` = a ]

    ##applications

        #make varname from var

            a=b
            eval "$a=c"
            assert [ $b = c ]

##read

    #Reads from stdin and stores in shell variables.

    #Therefore, this *must* be a shell BUILTIN, since it modifies shell variables directly

    #POSIX 7.

    #Get string from user into variable `a`:

        #read a
        #echo "$a"

    #Cannot write with pipe into read because the pipe spawns a subshell,
    #which cannot modify a variable in its parent shell:
    #<http://stackoverflow.com/questions/13763942/bash-why-piping-input-to-read-only-works-when-fed-into-while-read-const>

        a=a
        echo b | read a         #`read a` is executed in a subshell!
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
                #    echo "$l";
                #done < "$f"

            #Read stdout linewise:

                while read l; do
                    echo "$l"
                done < <( echo -e "a\nb\na b" )

            #Split into fields:

                #IFS_OLD="$IFS"
                #while IFS=' : ' read f1 f2
                #do
                #    echo "$f1 $f2"
                #done < <( echo -e "a : b\nc : d" )
                #IFS="$IFS_OLD"

    ##GNU extensions

        #-p print a prompt message:

            read -p "enter string: " s
            echo "you entered $s"

##test

    #Compare values and check files, answer on exit status.

    #Equivalent convenient shorthand form via squre brackets: `[ ]`

    #Can do tons of different tests.

    #May also exist as a separate binary implementation on certain systems,
    #but the built-in has precedence:

        which test

    ##string compare

            test a = a && echo a
                #a
            test a = b && echo a
                #

    ##integer compare

        #always use `-eq` family, never `=` family:

            assert [ 1 -eq 1 ]
            assert [ 1 -eq 01 ]
            assert [ 1 -lt 2 ]
            assert [ 2 -gt 2 ]
            assert [ 1 -le 2 ]
            assert [ 2 -ge 2 ]

    ##file ops

        ##-f

            #exists and is regular file (not a symlink or directory)

                init_test
                touch a
                assert test -f a
                cleanup_test

        ##-r

            #File or directory exists and has read permission.

            #Useful in conjunction with `-f` before taking input from a file,
            #since just checking its exsitence is not enough to read from it.

        ##-e

            #file exists

            #may be a symlink or directory

            #useful to avoid overwriting useful files

        ##-s

            #exists and has size > 0

                rm -rf a
                touch a
                assert test -f a

    ##logical

            test ! a = a        && assert false
            test a = a -a b = b && assert false
            test a = a -a a = b && assert false
            test a = a -o a = b && assert false
            test a = b -o a = b && assert false


##process

    #get cur pid in bash:

        echo $$
        echo $pid

    ##pwd

        #print working directory of process

        #each program has a working directory set by the os

        #processes inherit working directory of calling process

        mkdir a
        chmod 777 a
        echo pwd > a/a
        chmod 777 a/a
        ./a/a
            #`pwd`
            #outside /a, the working directory of the caller (bash cwd)

    ##pwdx

        #print current working directory of given process

            pwdx $pid

    ##sleep

        #POSIX 7

        sleep 2
            #do nothing for 2 seconds

    ##wait

        #POSIX 7

        #wait for process with given pid to terminate

        #sets $! to the pid of the waited process

        #sleep 2 seconds and echo done:
            sleep 3 &
            wait $!
            echo $?

        #gets `$?` right even if process over already:
            false &
            sleep 2
            true
            wait $!
            assert [ "`echo $?`" = 1 ]

            true &
            sleep 2
            false
            wait $!
            assert [ "`echo $?`" = 0 ]

    ##ps

        #POSIX 7

        #list current executing processes and their info

        #psmisc package

        #implementations commonly use the proc filesystem.
        #There does not seem to be a POSIX way to implement this,
        #except maybe following a process tree.

        #see processes running on current tty:

            sleep 10 &
            sleep 10 &
            ps

        #Output fields include:

        #- pid
            #unique identifier for all process on system

        #- tty
            #from which tty it was launched

        #- time
            #cpu time used for process
            #not real time

        #- cmd
            #command that launched th process
            #without command line args

        #see all process on system

            ps -A

        #shows therads of each process

            ps -Am

        #shows lots of extra info columns in addition to the 4 default:

            ps -Al

        #sort output by:

        #- cmd
        #- time reversed (because of the `-`)
        #- pid
        #- tty reversed (-)

            ps -A --sort cmd,-time,pid,-tty

        #get pid of parent of process with pid p

            p=
            ps -p $p -o ppid=

    ##jobs

        #Shows:

        #- jobspec      : a local job id.
        #- status       : runnning, stopped, done
        #- invocation   : exact program call, including command line args. Ex: `ls ~`

            jobs

        #show pids of background jobs:

            jobs -p

        ##jobspecs

            #local job id, found by using <#jobs>

            #certain commands such as ``kill``, ``fg`` them in addition to pids

            #they are:

            #- %N	Job number [N]
            #- %S	Invocation (command line) of job begins with string S
                #if several matches, ambiguous, and does nothing
            #- ?S	Invocation (command line) of job contains within it string S
            #- %%	"current" job (last job stopped in foreground or started in background)
            #- %+	"current" job (last job stopped in foreground or started in background)
            #- %-	last job

        #It is possible to use jobspecs directly with certain bash built-ins that could also take PID.
        #For example, to kill process by jobspec `%1`:

            #kill %1

        #Note that `kill` also usually exists as an external executable, and that the external executable
        #cannot kill by jobspec since this information is only known by bash itself.

        #`help kill` states that one of the reasons why `kill` is implemented as a bash built-in is to be
        #able to write `kill %1`.

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

        #POSIX 7

        #Kill exists as a bash built-in.
        #One of the reasons for this is to allow users to `kill` by jobspec for example as `sleep 1- &; kill %1`,
        #which an external executable could not do. Killin gby PID is required by POSIX 7.

        #Send signals to a process. Signals are an ANSI C concept, with POSIX and Linux extensions.

        #Does not necessarily send SIGKILL, nor is SIGKILL the default signal sent!
        #The default signal it sends is SIGTERM.

        #It is unfortunatelly named kill because most signals end up killing process,
        #or also because the most used signal is SIGTERM generated by a C-C on the terminal.
        #which has the usual effect of killing a process.

        #List all signals available on the system:

            kill -l

        #lists numbers and descriptions.

        #Send SIGTERM signal to process:

            ps -A
            ID=
            kill $ID

        #SIGTERM is the default signal sent by `kill`.

        #Select by pid, found on ps for example.

        #Select by job-id found on jobs:

            sleep 10 &
            jobs
            kill %1

        #POSIX specifies this.

        #Send stop signal to process:

            kill -s SIGSTOP $ID
            kill -s sigstop $ID
            kill -s STOP $ID
            kill -s stop $ID

        #All of the above are specified by POSIX.

        #where `SIGSTOP` is the standard signal name.

        #Also possible with the XSI extension:

            kill -SIGSTOP $ID
            kill -sigstop $ID
            kill -STOP $ID
            kill -stop $ID

        #but not recommended because it is less uniform parameter passing,
        #and not guaranteed to be on all implementations.

    ##killall

        #Send signals to all process by name

        #psmisc package

        #Application: firefox/skype hanged. `ps -A | grep -i firef',
        #confirm that the name is firefox and that it is the only one with that name,
        #and then:

            killall firefox

        #this sengs SIGTERM, which programs may be programmed to handle,
        #so the progrma may still hang ( and in theory be trying to finish nicelly, although in practice this never happens... )

        #to kill it without mercy:

            killall -s 2

        #which sends SIGINT, which processes cannot handle, so they die

    ##env

        #POSIX 7

        #shows all environment variables and their values:

            env

        #change environment for a single command:

            a=b
            env a=c echo $a
            #c
            echo $a
            #b

        ##-i

            #exec in a clean environment:

                assert [ "`env -i a=b env`" = "a=b" ]

            ##start a subshell in the cleanest env possible

                #don't forget: subshells inherit all exported vars

                    env -i bash --noprofile --norc
                    env
                    #some default vars might still be there!
                    #I get: SHLVL, PWD
                    exit

    ##nohup

        #POSIX 7

        ##application

            #make a process that continues to run if calling bash dies:

                nohup firefox >/dev/null &
                exit

            #firefox still lives! it would be killed if it were not for nohup

        ##explanation

            #program ignores HUP (hangup) signal (signal is a linux os concept)

            #this signal is sent when the calling shell of a program is killed

            #most signals if uncaught (the case of most programs), kill the program

            #consequense: killing calling bash kills the program

            #*unless*, you use nohup

            #consequences of `nohup`:

            #- if stdin came from terminal (not pipe for example),
                #sdtin comes from `/dev/null` (you have no stdin!) instead

            #- if stdout would go to terminal (not pipe for example)
                #it is *appended to* `./nohup.out`, and if not possible from `$HOME/nohup.out`
                #instead
                #
                #if no stdout is generated, `nohup.out` is not created
                #
                #you can also redirect stdout to any file you want via `nohup cmd > file`
                #for example `nohup cmd > /dev/null` to ignore output
            #- the program is still visible in `jobs`, and may be killed with `kill %+`
            #- if you don't use `&`, it runs on foreground, preventing you from using bash

            #how to test all this:

                nohup bash -c 'for i in {1..10}; do echo $i; sleep 1; done'

            #try:

            #append `> f` to command
            #append `&`   to command

                jobs
                cat nohup.out

    ##timeout

        #run command for at most n seconds, and kill it if it does not finish in time

        #coreutils

            assert [ `timeout 3 bash -c 'for i in {1..2}; do echo $i; sleep 1; done'` = $'1\n2\n' ]
            assert [ `timeout 1 bash -c 'for i in {1..2}; do echo $i; sleep 1; done'` = $'1\n' ]

    ##nice

        #- -20: highest priority
        #- 20: lowest  priority

        #mnemonic: the nicest you are, the more you let others run!

        #POSIX 7

        #therefore the concept of niceness is included in POSIX

        #view nice of all processes:

            ps axl

        #run program with a nice of 10:

            nice -10 ./cmd

        #-10:

            sudo nice --10 ./cmd

        #you need sudo to decrease nice

        #change priority of process by PID:

            renice 16 -p 13245

    ##flock

        #puts an advisory file lock on given file while a command executes

            touch a
            flock a sleep 5 &

    ##pstree

        #psmisc package, not POSIX

        #shows tree of which process invocates which

            pstree

        #this works because in POSIX new processes are created exclusively
        #by forking from other processes, and parent information is stored
        #on each process, which dies if the parent dies

        #this is a very insightfull program to understand what happened after
        #the `init` process, first process on the system and common ancestor of all, started

        #particularaly interesting if you are on a graphical interface,
        #to understand where each process comes from

        #quotint `man pstree`, multiple processes with same name and parent are wrttin in short notation:

            #init-+-getty
            #     |-getty
            #     |-getty
            #     `-getty

        #becomes:

            #init---4*[getty]

        #threads (run parallel, but on same data, and cannot fork) are indicated by brackets:

            #icecast2---13*[{icecast2}]

        #means that `icecast2` has 13 threads.

    ##prtstat

        #TODO

    ##peekfd

        #TODO

    ##ipcs

        #list info on inter process communication facilities:

            ipcs

        #shows:

        #- shared mem
        #- semaphores
        #- message queues

        ##ipcrm

            #remove ipc facility

    ##chroot

        #Execute single command with new root.

        #The root of a process is a Linux concept: every process descriptor has a root field,
        #and system calls issued from that process only look from under the root (known as `/` to that process).

        ##application

            #You have a partition that contains a linux system,
            #but for some reason you are unable to run it.

            #You can use that partition with bash by using chroot into it,
            #and you might then try to fix it from there.

            #Example:

                sudo chroot /media/other_linux/

            #More advanced example, if you want to start from a completelly clean bash environment:

                sudo chroot /media/other_linux /bin/env -i \
                        HOME=/root                  \
                        TERM="$TERM"                \
                        PS1='\u:\w\$ '              \
                        PATH=/bin:/usr/bin:/sbin:/usr/sbin \
                        /bin/bash --login

            #This will in addition clear enviroment variables, and read login scripts found on the chroot.

##files

    ##ls

        #POSIX 7

        #list files in dirs

        ##-l

        #show lots of information:

            ls -l

        #sample output:

            #-rw-rw-r-- 1 ciro ciro    4 Feb 25 11:53 a
            #1          2 3    4       5 6            7

        #1) file permissions. See permissions
        #2) for files, number of hardlinks. For dirs number of subdirs + parent + self (min is 2 therefore)
        #3) owner
        #4) group
        #5) size in bytes
        #6) last modified
        #7) filename

        #ls is aware if its ouput goes to a pipe or not.
        #if yes, automatically newline separates it:

            ls | cat

        #one per line:

            ls -1

        #ls a file:

            touch a
            assert [ "$(ls a)" = "a" ]

        #ls a dir:

            mkdir d
            touch d/a d/b
            assert [ "$(ls d)" = "$(echo $'a\nb')" ]

        #ls many dirs:

            mkdir d
            touch d/a d/b
            mkdir e
            touch e/a e/b
            ls d e
                #nice listing of both

        #-d: list dirnames only:

            mkdir d
            touch d/a d/b
            mkdir e
            touch e/a e/b
            assert [ "$(ls -d d e)" = "$(echo $'d\ne')" ]

        #-lL : when showing symlinks, shows info to what is linked to

        ##sort

            #modification time (newest first):

                ls -t

            #inode change:

                ls -tc

            #file access:

                ls -tu

            #reverse sort order:

                ls -tr

        ##dircolors

            #config ls colors

        ##gnu extensions

            #-R: recursive

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
            assert [ `stat -c "%A" d` = 'drwxrwxrwt' ]

    ##mv

        #POSIX

        #move or rename files and dirs

        ##files

            #if dest does not exist, move the file to it:

                mkdir d
                touch d/a
                mkdir d2
                mv d/a d2/b
                assert [ "`ls d`" = '' ]
                assert [ "`ls d2`" = 'b' ]

            #if dest exists and is a file, overwrite by default:

                echo a > a
                echo b > b
                mv a b
                assert [ "`ls`" = "b" ]
                assert [ "`cat b`" = "a" ]

            #if dest exists and is a dir, move into dir:

                touch a
                mkdir d
                mv a d

        ##dirs

            #same as files except does not overwrite non empty dirs:

                mkdir d
                mkdir d2
                mkdir d2/d
                mv d d2
                    #d2/d was overwritten:
                assert [ "`ls`"     = "d2" ]
                assert [ "`ls d2`"  = "d" ]
                mkdir d
                touch d2/d/a
                mv d d2
                    #cannot mv: dir not empty

        ##-b

            #make backup if dest exits

            #if backupt exists, it is lost:

                touch a
                touch b

            #backup ~a is made:

                mv -b b a
                assert [ -f a ]
                assert [ -f a~ ]
                assert [ `ls | wc -l` = 2 ]

            #backup is only made if destination exists:

                mv -b a b
                assert [ -f a~ ]
                assert [ -f b ]
                assert [ `ls | wc -l` = 2 ]

            #if backup exists, it gets overwritten:

                touch a
                mv -b a b
                assert [ -f a ]
                assert [ -f a~ ]
                assert [ `ls | wc -l` = 2 ]

    ##cp

        # POSIX

        # Copy files and dirs.

        ##file

            # If dest does not exist, create it:

                echo a > a
                cp a b
                assert [ "`cat b`" = $'a' ]

            # If dest exists and is dir, copy into dir:

                mkdir d
                cp a d
                assert [ "`cat d/a`" = $'d/a' ]

            # If dest exists and is file, overwrite without asking!

                echo a > a
                echo b > b
                cp a b
                assert [ "`cat b`" = $'a' ]

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
                assert [ -d d2 ]
                teardown_test

            # `-r` on GNU is the same as `-R`, but is a GNU extensionto POSIX 7.

            # Unlike move, can copy into dir recursively overwritting by default:

                setup_test
                cp -R d d2
                assert [ "`ls d2/d`"    = 'a b' ]
                assert [ "`cat d2/d/a`"  = 'A' ]
                assert [ "`cat d2/d/b`"  = 'b' ]
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
                assert [ -f d ]
                assert [ "`cat a`" = $'a' ]

            # With the `-d` GNU extension, copies symlink to files into new symlinks (mnemonic: no-Dereference):

                cp -d c e
                assert [ -L d ]

            # For dirs by default copies symlink into a new symlink:

                mkdir d
                ln -s d dln
                cp dln e
                assert [ -L e ]

            # To dereference symlinks to directories, use `-L`:

                mkdir d
                ln -s d dln
                cp -L dln e
                assert [ -d e ]

            # Does not work with `-r`. Probable rationale:
            # the only thing this could do is to copy dirs
            # and symlink files. But then why not do this with hardlinks?

        ##hardlink

                echo a > a
                cp -l a b
                ln -l a b
                assert [ "`stat -c '%i' a`" = "`stat -c '%i' b `" ]

            # With `-r`, makes dirs, and hardlinks files:

                mkdir d
                touch d/a
                touch d/b
                cp -lr d e
                assert [ "`stat -c '%i' d/a`" = "`stat -c '%i' e/a `" ]
                assert [ "`stat -c '%i' d/b`" = "`stat -c '%i' e/b `" ]

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

        # Synchronize directories.

        # - works over networks.
        # - can synchronizes differentially for greater efficiency.
        # - can compress before sending over the network
        # - can encrypt files sent

        # Useful options:

        # - `-r`: recurse into directories
        # - `-z`: compress files before transfer, decompress after.

            # Useful if transfer will be done over a network,
            # so that smaller files can be transferred.

        # - `-a`: preserve timestamps.

            # By default, sets timestamps of new files to now.

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
            assert [ -d a ]
            assert [ -d a/b ]
            assert [ -d a/b/c ]

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
            assert [ `stat -c '%U' d` = newuser ]
            assert [ `stat -c '%G' d` = newgroup ]
            assert [ `stat -c '%U' d/f` = a ]

        # `-R` for recursive operation:

            su a
            mkdir d
            touch d/f
            sudo chown b d
            assert [ `stat -c '%U' d` = newuser ]
            assert [ `stat -c '%G' d` = newgroup ]
            assert [ `stat -c '%U' d/f` = newuser ]
            assert [ `stat -c '%G' d/f` = newgroup ]

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
                assert [ `stat -c "%a" f` = "234" ]

                chmod a=rt f
                assert [ "`stat -c "%A" f`" = "-r--r--r-T" ]

            # Inode:

                touch a
                ln a b
                assert [ "`stat -c "%i" a`" = "`stat -c '%i' b`" ]

        ##--print

            # Like `-c` but interprets escapes like `\n`:

                touch a
                echo "`stat --print "%a\n%a\n" a`"
                assert [ "`stat --print "\n" a`" = $'\n' ]

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

                assert [ "`readlink c`" = $'b' ]
                assert [ "`readlink b`" = $'a' ]

            # Recursive:

                assert [ "`readlink -f c`" = $'a' ]

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

    ##xargs

        # POSIX 7

        # Do a command that takes each line of stdin as an argument.

        # Great for combo with find to do a command on many files.

        ##alternatives

            # Downsides of xargs:

            #- max number of arguments
            #- escaping madness for multiple commands

            # Upsides of xargs:

            #- golfing!

            # In scripts, always use the more versatile (and slightly more verbose) read while techinque:

                while read f; do
                    echo "$f";
                done < <(find .)

        ##test preparations

                function f {
                    echo $1
                }

        ##basic operation

            # Read line from stdin, append as argument to the given command

            # Does not automatically quote!

            # The default command is echo, which is basically useless

                echo $'a\nb' | xargs
                echo $'a\nb' | xargs echo
                echo $'a\nb c' | xargs echo

            # Empty lines are ignored:

                echo $'a\n\nb' | xargs

        ##-0

            # Read up to nul char instead of newline char.

            # Allows for files with spaces, and even newlines!

                echo -en 'a\0b' | xargs -0

            # Combo with `find -print0`:

                find . -print0 | xargs -0

        ##-I

            # Allows you to put the argument anywhere and to quote it

                    echo $'a\nb' | xargs -I '{}' echo '{}'

        ##multiple commands

            # Must use the `xargs bash` technique.

            # Only use this for very simple commands, or you are in for an escaping hell!

            # If you have to do this, use the read while technique instead.

                    echo $'a\nb' | xargs -I '{}' bash -c "echo 1: '{}'; echo 2: '{}'"

        ##applications

            # Find and replace in files found with perl regex:

                find . -type f | xargs perl -pie 's/a/A/g'

            ##find files whose path differ from other files only by case

                # Useful when copying from linux to a system that does not accept
                # files that differ only by case (the case for MacOS and Windows)

                    find . | sort -f | uniq -di

                # Remove them:

                    find . | sort -f | uniq -di | xargs -I'{}' rm '{}'

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

    ##which

        # Prints full path of executable in path.

        # Does not necessarily reflect the actual program that will actually be used
        # since this is not a bash built-in so it does not know:

        # - the state of the bash path cache
        # - does not see built-ins

        # If you give it a command that only exists as a builtin such as `cd`, outputs nothing.

        # Note however that there are commands which exist both as shell built-ins and
        # as separate executales such as `echo`.

        # Examples:

            which ls

        # Sample output:

            /bin/ls

        # The following print nothing:

            which im-not-in-path

            which im-not-executable

            which cd

        ##application

            # Quick and dirty install if not installed:

                if [ -z "`which zenity`" ]; then
                        sudo aptitude install zenity
                fi

            # Could also be done bashonly with `type -P`.

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

        #- pick one by one
        #- tell fdupes to pick the first one without asking (seem to pick one of the dirs first always)

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

        cat /etc/passwd

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

        #Become another user, such as root:

            su otheruser
                #enter otheruser pass
            whoami
                #otheruser

        #Start a login shell as user a:

            su - a

        #without this starts a non-login shell

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

        #Do next single command as another user or super user

        #Safer than becoming root with su

        #In order to see who can sudo what as who and with what pass

                sudo cat /etc/sudoers

            #syntax:

                #Defaults:ALL timestamp_timeout=0
                    #passwords for all users timeout 0
                #Defaults:ALL timestamp_timeout=15
                    #BAD
                    #after any user enters a pass, he can sudo without pass for 15 mins
                #main lines:
                    #user   hostip=(runas)NOPASSWD ALL
                    #%group hostip=(runas)        :/bin/ls,/bin/cat
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
                        #%admin  ALL=(USERS) ALL
                    #command
                        #Cmnd_Alias APT     = /usr/bin/apt-get update,/usr/bin/apt-get upgrade
                        #Cmnd_Alias USBDEV  = /usr/bin/unetbootin,/usr/bin/gnome-format
                        #ALL_PROGS = APT,USBDEV
                        #%admin  ALL=(ALL) ALL

            ##redirection

                #sudo passes its stdin to the called program:

                    echo a | sudo cat
                        #a

                #Cannot "echo to a file" directly without permission

                    su a
                    mkdir b
                    chown b b
                    #fails:
                    sudo echo a > b/a

                #The reason why this fails is that bash gives sudo two arguments: `echo` and `a`.

                #sudo does `echo a`, produces `a`, and then *bash* attempts the redirection by writing
                #`a` to `b/a`, which of course fails because bash does not the necessary permissions.

                #Workarounds for that include:

                #Put everything inside a single bash command:

                    sudo bash -c 'echo a > b/a'

                #This works, but may lead to quoting hell.

                #Sudo a tee and let it do the work:

                    echo a | sudo tee b/a

                #And if we want to append to the file instead:

                    echo a | sudo tee -a b/a

                #The resaon this works is because `sudo` redirects its stdin
                #to the stdin of the program it will call.

                #-e to edit a file as sudo:

                    sudo -e /etc/file.conf

        ##ubuntu default

            #sudo group allows members to sudo whatever they want as root

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

        #logs out

        #can only be used on the login shell

            logout

    ##faillog

        faillog -a

    ##useradd

        # Create a new user with username `$u`:

            u=
            sudo useradd  -ms /bin/bash $u
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

        # Manage user passwords.

        # Passwords are normally stored hashed in the `/etc/shadow` file.

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

            assert [ `echo '1+1' | bc` = 2 ]

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

##libs

    #this is just a quick list, installation and cheats may go better
    #in other files/dirs since libs are usually large to understand

    ##performance note

        #to get the most out of applications, you have to
        #compile it on your own computer so that the compiler will
        #be able to make all the possible optimizations for your given
        #architecture.

    ##c

        sudo aptitude install -y linux-source linux-headers

        ##check

            #c unit testing

            sudo aptitude install -y check

        ##ncurses

            #command line interactive interfaces

                sudo aptitude install -y libncurses5-dev

        ##expat

            #xml parsing

        ##to evaluate

            ##PCRE

                #perl regexes. c11 has regexes.

            ##popt

                #parse command line options

    ##c++

        ##boost

            #cross platform utilities

            #very popular, largely influences c++ future

    ##glx

        #interface between opengl and x server

        #allows x windows to use opengl acceleration

        #must also support a given opengl version

        sudo aptitude install -y mesa-utils

        glxinfo | less
            #lots of opengl info
        glxgears
            #demo

##scientific

    ##netlib

        #lots of good scientific libs from there

        ##blas lapack
            #fortran: native
            #clang:   bindings

            #linear algebra. very widely standard.

    ##acts collection

        #<http://acts.nersc.gov/tools.html>

        #collection of good numerical libraries.

        #industry usage.

    ##opengl glut
        #native:   c++
        #bindings: python

        #adsf

        #3d rendering

        #de facto open source standard.

    ##opencv

        #langs: c++(native), python

        #computer vision

    ##gsl
        #c
        #c++

        #tons of scientific functions

    ##freefem

        #2d and 3d fem

        #TODO

    ##r

        #statistics

    ##it++

        #signal processing

    ##ode

        #rigid body physics engine

    ##plplot
        #c
        #cross platform

        #graph plotting

        #quite good at first sight

##dbus-send

    # Suspend computer:

        dbus-send --system --print-reply \
            --dest="org.freedesktop.UPower" \
            /org/freedesktop/UPower \
            org.freedesktop.UPower.Suspend

##factor

    # coreutils

    # Factor a number into prime constituents.

        assert [ "`factr 30`" = "30: 2 3 5" ]
