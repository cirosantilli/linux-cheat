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

##desktop

    unity --restart
        #restarts the unity shell only
        #less effective and drastic than restarting lightdm

    #gnome shell

    #desktop/windows control

        gnome-open "$FILE"
            #opens with the deafult application. works in Ubuntu Unity 12.04

    #key logging

        #writes all keypresses to a file

        sudo logkeys -s
            #start

        sudo logkeys -k
            #end

    #ibus input methods

        #for chinese, japanes, etc input

        #how have I looked for this, but no one told me: ibus for qt apps!!!!

    ##alarm clock applet

        #notifies you with sounds when a certain time passed

    ##weather indicator

##dictionnary

    ##dictionnary formats

        ##stardict
        #<http://goldendict.org/dictionaries.php>

        #for dicts, go: <www.stardict.org/download.php>

        ##bgl
        #babylon
        #windows oriented: exes on site!
        #can open .exe with 7zip to extract data content
        #now most exes are downloader without blgs, probably vendor lockin
        #I found some that actually contained the blg here:
        #  http://www.babylon.com/dictionaries-glossaries

    ##goldendict

        #fork of stardict

        #select text can make popup windows!

        #supported formats: stardict, blg,

    ##sdcv

        #command line stardict

        #supported formats: stardict only

        #to install dict place it under:

            /usr/share/stardict/dic
            $(HOME)/.stardict/dic

        #list available dicts:

            sdcv -l

    ##spell checking

        ##aspell

            ##features

                #can add words to dict

                #understands some predefined formats!

            #interactively checks files for spelling errors:

                aspell -c f

            #if modified, change inline but create `.bak` file

            #french:

                aspell -l fr -c f

            #must first install wordlist

            #same but ignore language constructs (modes):

                aspell --mode=tex -c f
                aspell --mode=html -c f

            #modes can be added/removed. They are called `filters`

                sudo aspell --add-filter=$f
                sudo aspell --remove-filter=$f

#codecs #ERROR: mpg123libjpeg-progs cannot locate

    #use TAB to navigate msfonts

    #TODO explain or remove:

            sudo aptitude install -y mencoder totem-mozilla icedax tagtool libmad0 mpg321 mpg123libjpeg-progs

##chat messaging voice video

    ##skype

        sudo add-apt-repository -y "deb http://archive.canonical.com/ $(lsb_release -sc) partner"
        sudo aptitude update
        sudo aptitude install -y skype

    ##google talk

        wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
        sudo sh -c 'echo "deb http://dl.google.com/linux/talkplugin/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
        sudo aptitude update
        sudo aptitude install -y google-talkplugin

    sudo aptitude install -y pidgin

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

        #TODO
            #get any of this to work =)

        #MTA mail transfer agent
            #examples:
                #sendmail
                #postfix

        #mail

            #sudo aptitude install -y sendmail
            #sudo aptitude install -y mailutils

            echo -e "the message\n\nend of it" | mail -s "subject" -r "from@gmail.com" "to@gmail.com"
            mail -s "subject" -r "from@gmail.com" "to@gmail.com"
                #you type
                #mail ends in line with '.' only or ctrl+d

        #mutt

            #mail with attachment

            #curses inteface

            sudo aptitude install -y mutt


##file sharing

    ##torrent

        ##deluge

            sudo add-apt-repository -y ppa:deluge-team/ppa
            sudo aptitude update
            sudo aptitude install -y deluge

    ##dropbox

        sudo aptitude install -y nautilus-dropbox

        firefox https://www.dropbox.com/home
            #see your home files on browser

        dropbox filestatus
        dropbox filestatus "$F" "$G"
                #a: up to date
                #b: unwatched

        #Get status:

            dropbox status

        #Possible status:

        #- idle: program running but doing nothing


        #get information on sync status of files on current dir:

            dropbox ls

        #- green: synced

        #Get public url of F into the clipboard:

            dropbox puburl "$F"
            echo "wget `dropbox puburl "$F"`" > xsel

        #The file must be inside Public folder.

        #Autostart dropbox at startup:

            dropbox autostart y

    ##ubuntu one

        #open source cross platform canonical dropbox like program

        #web interface:

            firefox https://one.ubuntu.com/dashboard/

        #check deamon status:

            u1sdtool -s

        #publish a file:

            u1sdtool --publish-file a

        #get file public url to the clipboard:

            u1sdtool --publish-file a | perl -ple 's/.+\s//' | xsel -b

        #To shows icon with sync status on task bar:

            sudo add-apt-repository -y ppa:noobslab/initialtesting
            sudo apt-get update
            sudo apt-get install indicator-ubuntuone

    ##nicotine+

        #soulseek client

            sudo aptitude install -y nicotine+

        #behind a proxy router
        #go to the router admin panel, port forwarding part
        #  (http://192.168.0.1/RgForwarding.asp on dlink for example, default login:admin pass:motorola)
        #open ports 2234 to 2239 on local ip found at
        #  ifconfig eth0 | grep "inet addr:"
        #
        #now either put your files in another partition at the root, or symlink
        #your share and download dirs to somewhere above user so that people cannot
        #see your username

##programming

    ##pkg-config

        #info is contained in "$PKG_NAME.pc" files located mainly under:

            #/usr/share/pkgconfig/
            #/usr/lib/i386-linux-gnu/pkgconfig/

        #a part of program installation may be to put files there

        #usage in in a makefile:

            CFLAGS=$(shell pkg-config --cflags pkgname)
            LIBS=$(shell pkg-config --libs pkgname)

    ##editors ides

        ##eclipse

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

        ##vim

            #gvim, runs in gtk outside command line
            #and thus gets around many command line limitations such as reserved shortcuts

                gvim

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

        ##

        ack --py perl_regex
            #recursive find grep for perl_regex in python files only, detects shebangs

        ack -f --py --print0 | xargs -0 -I '{}' git add '{}'
        #adds all python files git. shebang aware.

        ack --cc '#include\s+<(.*)>' --output '$1'
        #prints only include names in cpp files
        #--sh for bash

        ##-f

            #list all filenames of known types:

                ack -f

        ##-g

            #list files of known types that match regex:

                ack -g '\.py$'

        ack --thpppt
        #bill the cat

        ##combos

            #find lines in files:
                ack -f | xargs grep 'find'

            #dry run replace in files with regex::
                ack -f | xargs -lne 'print if s/a/A/g'
            #only prints modified lines

            #non-dry run replace in files:
                ack -f | xargs perl -pie 's/z/Z/g'
            #prints nothing

    ##ctags

        #POSIX 7

        #Reads c file and generates a list of symbol definitions / locations.

        #Put output on a `tags` file on current dir:

            ctags *.h

        ##gnu extensions

            #Recurse:

                ctags -R

            #Makes a single ctags in current directory!

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

##file management

    ##krusader

        #great file manager

        #features:

        #- useractions:
            #Execute shell scripts wich access to things like current directory or selected files

        #- give shortcuts to useractions
            #you can give shortcuts to anything, including user actions!

        #- ftp. Just enter an ftp url on the address bar and it all works.

            #filezilla is still better at this I think.

        sudo aptitude install -y krusader
        sudo aptitude install -y konqueror          #needs to manage bookmarks. (otherwise, button does nothing)
        sudo aptitude install -y konsole            #needs to terminal emulator. (otherwise, button does nothing)
        sudo aptitude install -y  khelpcenter4      #help
        sudo aptitude install -y  kwalletmanager    #password manager

##time date

    ##cal

        #cout a calendar!!!

        cal

    ##date

        #get system date:

            sudo date

                    TODO get working

                        pmidi -l
                        vim ~/.dosbox/dosbox-*.conf

                    put the port in:

                        [midi]
                        midiconfig=14:0

        #set system date:

            sudo date -s "1 JUN 2012 09:30:00"

        #format current time and output it:

            TIMESTAMP=`date +%Y-%m-%d-%H-%M-%S`

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

##libreoffice

    #wysiwyg text editor, tables, image editor:

        sudo aptitude install -y libreoffice

    #database management:

        sudo aptitude install -y libreoffice-base

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

        #posix 7

        #goes around echo's quicks

        #anlogous to C printf.

        #does not automatically append newline:

            assert [ "`printf "a"`" == "a" ]

        #automatically interprets backslash escapes like C printf:

            printf "a\nb"

        #automatically interprets backslash escapes like C printf:

        #print the `-n` string:

            assert [ "`printf "%s" "-n"`" == "-n" ]

        #supports C format strings:

            assert [ "`printf "%1.2d" 1`"       == "01" ]
            assert [ "`printf "%1.2f" 1.23`"    == "1.23" ]

        #print the `-n` string:

            assert [ "`printf "%s" "-n"`" == "-n" ]

        #print a string ignoring all escape sequences (always appends terminates in a single newline):

            printf "%s\n" "\n\r"

        #never terminate in a newline:

            printf "%s" "\n\r"

        #include trailling newlines:

            TODO

        #do interpret the escapes:

            printf "%ba" "\n"

    ##cat

        #concatenate files to stdout

        echo asdf > a
        echo qwer > b

        cat a
            #asdf

        cat a b
            #asdf
            #qwer

    ##tac

        #cat reversed linewise

            assert [ "`echo $'a\nb' | tac`" = $'b\na' ]

    ##rev

        #reverse bytewise

            assert [ "`echo $'ab' | rev`" = $'ba' ]

    ##dd

        #POSIX

        #Menemonic: Duplicate Data.

        #Alternate mnemonic: Data Destroyer.
        #Reason: can manipulate sda devices directly without considering file structure,
        #making operations such as disk copy very fast, but potentially very destructive
        #if for example you exchange input and output disks, compying an empty disk over
        #useful data.

        ##if of

            #if = input file. If not given, stdin.

            #of = output file. If not given, stdout.

            #echo a | cat:

                echo a | dd

            #cat a:

                echo a > a
                dd if=a

            #cp a b:

                dd if=a of=b

        ##status

            #stop printing status lines:

                echo a | dd status=none

        ##bs

            #How many input and output bytes to read/write at once.

            #Also defines the block size for count, skip and seek.

            #Obs and ibs for output and input seprately.

            #Default values: 512 B.

        ##count

            #copy up to count blocks (defined by bs):

                assert [ `echo -n 1234 | dd status=none bs=2 count=1` = 12 ]
                assert [ `echo -n 1234 | dd status=none bs=1 count=3` = 123 ]

        ##size suffixes

            #-c: 1 (char)
            #-w: 2 (word)
            #-kB: 1000
            #-K: 1024
            #-MB: 1000*1000
            #-M: 1024*1024

            #and so on for G, T, P, E, Z and Y!

                assert [ `echo -n 123 | dd status=none bs=1c count=1` = 1 ]
                assert [ `echo -n 123 | dd status=none bs=1w count=1` = 12 ]

            #The larger the chunck size, the potentially faster file transfers will be.

            #Nowdays, `4M` is a good value for large file transfers.

        ##skip

            #skip first n input blocks (defined by bs or ibs):

                assert [ `echo -n 123 | dd status=none bs=1 skip=1` = 23 ]

        ##seek

            #skip first n output blocks (defined by bs or obs):

            #TODO minimal exmaple

        ##conv

            #do serveral data conversions on copy

            #ucase: uppercase

                assert [ `echo -n abc | dd status=none conv=ucase` = ABC ]

        ##iflag oflag

            #TODO

        ##applications

            #Zero an entire block device located at `/dev/sdb` (CAUTION!!!! VERY DANGEROUS!!!!):

                #sudo dd bs=4M if=/dev/zero of=/dev/sdb

            #As of 2013 with mainstream system specs,
            #this took around 6 minutes on a 2Gb flahs device (around 5.0 MB/s).

            #If you are really serious about permanently deleting files,
            #use a program for that with a potentially more advanced algorithm.

    ##pagers

        ##less

            #file pager (viewer)
            #loads faster than vim
            #vimlike commands

            #/ : search forward
            #n : repeat last search
            #d : down one page
            #u : up one page
            #g : top of document
            #G : bottom of document
            #g : top of document
            #<ENTER> : down one line

            less "$f"
            echo $'ab\ncd' | less

        ##more

            #worse than less

            echo a | more

        ##pg

            #worse than more

            echo a | pg

        ##pr

            #break file into pages with a certain number of lines
            #and print to stdout

            ( for i in `seq 200`; do echo a; done ) | pr

    ##sort

        #sort linewise

        #uses External R-Way merge
        #this algorithm allows to sort files that are larger than memory

        sort f1 f2
            # sort f1, f2 together linewise
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

        #topological sorting
        #<http://en.wikipedia.org/wiki/Tsort_%28Unix%29>

        echo $'1 2\n2 3' | tsort
            #1
            #2
            #3

        echo $'1 2\n2 1' | tsort
            #contains loop
        echo $?
            #1

    ##factor

        #coreutils

        #factor a number into prime constituents

        assert [ "`factor 30`" = "30: 2 3 5" ]

    ##uniq

        #POSIX 7

        #ajacent dupe line operations

        echo $'a\nb' | uniq
            #a
            #b

        echo $'a\na' | uniq
            #a

        echo $'a\nb\na' | uniq
        #a
        #b
        #a
        #not adjacent

        #sort combo detected

            echo $'a\nb\na' | sort | uniq
            #a
            #b

        echo $'a\na' > a
        uniq a
            #a

        # -u : only show lines that have no dupe
        # -d : dupe lines only
        # -c : counts how many dupes

    ##read

        #-p print message

            read -p "enter string: " s
            echo "you entered $s"

        #read from file descriptor linewise and assign to variable

            ##applications

                #read file linewise:

                    while read l; do
                        echo "$l";
                    done < "$f"

                #read stdout linewise:

                    while read l; do
                        echo "$l"
                    done < <( echo -e "a\nb\na b" )

                #split into fields:

                    IFS_OLD="$IFS"
                    while IFS=' : ' read f1 f2
                    do
                        echo "$f1 $f2"
                    done < <( echo -e "a : b\nc : d" )
                    IFS="$IFS_OLD"

    ##tee

        #POSIX 7

        ls | tee file
            #ls to stdou and file
        ls | tee file 1>&2
            #ls to
        ls -l | tee file | sort
            #ls to file and sort
        ls | tee –a file
            #ls append to file
        ls | tee f1 f2 f3
            #ls to multple files

        #tee to multiple processes:
            echo a | tee >(seqn 2) tee >(seqn 2) | tr a b
        #note how process are run in parallel and output order is not variable.

    ##tr

        #POSIX 7

        #charwise text operations

        #replaces a by A and b by B and c by C:

            assert [ `echo -n cab | tr abc ABC` =  CAB ]

        #ranges are understood. Convert to uppercase:

            assert [ `echo -n cab | tr a-z A-Z` =  CAB ]

        #posix character classes are understood. Remove non alphtnum chras:

            assert [ `echo -n 'ab_@' | tr -cd "[:alpha:]"` = ab ]

        #-c : complement and replace. replaces all non abc chars by d

            assert [ `echo -n dcba | tr -c abc 0` =  0cba ]

        #-d: deletes abc chars:

            assert [ `echo -n dcba | tr -d abc` =  d ]

        #-s: replaces multiple consecutive 'a's and 'b's by isngle a

            assert [ `echo -n aabbaac | tr -s ab` =  abac ]

    ##cut

        #get columns from text databases

        #for more complex ops, consider awk

        echo $'a\tb\nc\td' | cut -f1
            #$'a\nc'
            #-f: field. what column to print.

        echo $'a:b\nc:d' | cut -d: -f1
            #$'a\nc'
            #-d: delimier

        echo $'a' | cut -d: -f2
            #$'a'
            #gets last if larger

        echo $'a:b:c\nd:e:f' | cut -d: -f1,3
            #$'a:c\nd:f'
            #first and columns

        echo $'a:b:c:d\ne:f:g:h' | cut -d: -f1-3
            #$'a:b:c\ne:f:g'
            #first to third columns

    ##wc

        #POSIX 7

        #count things

        #mnemonic: Word Count.

        echo -n $'a\nb c' | wc
            #1 3 5
            #^ ^ ^

        #newline, word, byte

            #-c bytes only
            #-m chars only
            #-l newlines only
            #-L max line lenght only
            #-w words only

    ##head

        #POSIX 7

        #filter 10 first lines:

            seq 20 | head

        #filter 3 first lines:

            seq 20 | head -n3

        #2 first bytes:

            assert [ "`echo -en 'abc' | head -c 2`" = "ab" ]

        ##gnu coreutils

            #remove last two bytes:

                assert [ "`echo -en 'abc' | head -c -2`" = "a" ]

    ##tail

        #POSIX 7

        #show last 10 lines of f:

            tail "$f"

        #show last 3 lines of f:

            tail -n3 "$f"

    ##truncate

        #sets file to given size

        #if greater, pads with 0s

        #if smaller, data loss

        echo ab > f
        truncate -s 1 f
        assert [ `cat f` = a ]

        truncate -s 2 f
        hexdump
        assert [ `cat f` = $'a\0' ]

    ##split

        #corutils package

        #split files into new smaller files of same size

            echo -n abc > f

            split -db1 f p
            split -dn3 f p

            assert [ `cat p00` = a ]
            assert [ `cat p01` = b ]
            assert [ `cat p02` = c ]

        #existing files are overwritten:

        #-d: uses number suffixes, otherwise, uses letters aa, ab, ac, ...
        #-b: bytes per file
        #-n: number of files

    ##csplit

        #corutils package

        #split files into new smaller files at lines that match given EREs

        #matching lines are kept

        echo $'0\naa\n1\naa\n2' > f
        csplit f '/^a/' '{*}'
        assert [ `cat xx00` = 0 ]
        assert [ `cat xx01` = $'aa\n1' ]
        assert [ `cat xx02` = $'aa\n2' ]

    ##nl

        #number lines

        #posix 7

        #corutils package

        nl "$f"
            #cat lines, number non-empty ones

    ##fold

        #wrap lines

        #posix 7

        echo -e "aaaa\nbb" | fold -w 3
            #aaa
            #a
            #bb

        #-s: only break at spaces:

            assert [ "`echo -e "12345 6" | fold -s -w 3`" = $'123\n45\n6' ]

    ##fmt

        #coreutils

        #wrap lines, but don't cut words

        assert [ `echo "a bcd" | fold -w 2` = $'a\nbcd' ]

    ##paste

        #useless

        #posix 7

        echo -e "a a a a a a a a a a a a a a\na" > a
        echo -e "b b\nb b"                       > b
        echo -e "c c\nc c\nc"                    > c
        paste a b c
            #shows files side by side line by line
            #default separator: tab
            #long lines will make this unreadable

    ##expand

        #useless

        #posix 7

        #expand tabs to spaces

        echo -e "a\tb" | expand

        ##unexpand

            #contrary

    ##seq

        seq 1
        seq 1 3
            #1
            #2
            #3

        seq 1 2 5
            #1
            #3
            #5

        #-s : separator
        #-w : equal width

        ##non-application

            #you could use this for loops:

                for i in `seq 10`; do echo $i; done

            #but don't

            #use brace expansion instead which is a bash built-in,
            #and thus potentially faster (possibly no new process spawned):

                for i in {1..10}; do echo $i; done

            #use this only if you really need to control
            #the output with the options

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

        #search for printable strings in file

        #prints sequences of at least 4 printable chars by default

        #useful to extract information from non textual formats,
        #which contain some textual data

        gcc c.c
        strings a.out

    ##sed

        ##sources

            #beginner to pro tutorial: <http://www.grymoire.com/Unix/Sed.html>

        #Stream EDitor

        #posix 7

        #modifies files non-interactively

        ##learning suggestion

            #consider using perl instead of this

            #sed has only slightly better golfing than perl

        ##s command

            #substitute:

                assert [ "`echo $'aba\ncd' | sed 's/a/b/'`" = $'bba\ncd' ]

            #patter is a BRE

            #g modifier:

                assert [ "`echo 'aba' | sed 's/a/b/g'`" = $'bbb' ]

            #replaces multiple non overalpping times on each line

            ##patterns are BREs

                assert [ "`echo 'aa' | sed 's/[[:alpha:]]/b/'`" = 'ba' ]
                assert [ "`echo 'aa' | sed 's/.+/b/'`" = 'ab' ]
                    #+ is ordinary, thus BRE, and no match

                ##EREs with -r

                    #therefore always use -r for regexes

                        assert [ "echo 'aa' | `sed -r 's/.+/b/'`" = 'b' ]

            ##replace references

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

        ##combos

            #if modified, print line number, old line, new line
            #
            #Ex:
            #
            #input:
            #
            #a
            #b
            #a
            #b
            #
            #regex: s/a/c/
            #
            #output:
            #
            #1
            #a
            #c
            #
            #3
            #a
            #c

            assert [ "`echo $'a\nb\na\nb' | sed -n 'h; s/a/c/; t p; d; :p {=;x;G;s/$/\n/;p}'`" = $'1\na\nc\n\n3\na\nc\n' ]

    ##awk

        #use only for text table field manipulation

        #consider not to learn this and just learn pearl one liners instead
        #since pearl is more flexible, powerful, good for golfing and has similar syntax

        #awk only gets slightly better golfing on a very limited problem set

        #for more complex tasks, use python or real databases

        #variables

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

        #arithmetic: same as c
        #string comp: ~, !~
        #posix ERE regex: ~// !~// (inner match ok)
        #if else for while: like c

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

    ##m4

        #macro language

        sudo aptitude install -y m4

        #TODO

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

    #you can't launch graphical applications!

    crontab -e
    #edit user cron jobs in vim
    #1 2 3 4 5 /path/to/cmd.sh arg1 arg2 >/dev/null 2>&1
        #1: Minute (0-59)
        #2: Hours (0-23)
        #3: Day (0-31)
        #4: Month (0-12 [12 == December])
        #5: Day of the week(0-7 [7 or 0 == sunday])
        #/path/to/command - Script or command name to schedule#
        #
        #* : every
        #*/5 : every five
        #1,3,6 : several
        #1-5 : ranges
        #
        #>/dev/null 2>&1 to avoid recieving emails
        #
        #otherwise:
        #MAILTO="vivek@nixcraft.in"
        #1 2 3 ...

        crontab -l
            #list all cronjobs
        crontab -u user -l
            #for a given user
        crontab -r
            #erase all crontabs
        crontab -r -u username
            #for a given user only

        #@reboot	Run once, at startup.
        #@yearly	Run once a year, "0 0 1 1 *".
        #@annually	(same as @yearly)
        #@monthly	Run once a month, "0 0 1 * *".
        #@weekly	Run once a week, "0 0 * * 0".
        #@daily	Run once a day, "0 0 * * *".
        #@midnight	(same as @daily)
        #@hourly	Run once an hour, "0 * * * *".
        #
        #can use instead of the 5 fields

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

        #each like hard disk    has a corresponding device files

        #each partition         has a corresponding block device file

            ls -l /dev | grep -E ' (sd|hd)..?$'

        #sample output:

            hda
            hda1
            hda2
            hda5
            sdb
            sdb1
            sdb2
            sdb3
            hdc

        #format:

            hdc1
            ^^^^
            1 23

        #1. partition type. hd: IDE (older). sb: SCSI (newer)
        #2. hard disk identifier.
        #3. parition number inside hard disk.

        #so on the example output given:

        #- 3 hds: had, sdb and hdc
        #- 1 and 3 are hd, 2 is sd
        #- 1 has 3 partitions

    ##uuid

        #Unique identifier for a partition. Field exists in ext and NTFS concept.

        #Given when you create of format a partition.

        #Can be found with tools such as lsblk, blkid or gparted.

        #Get UUID of a device:

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

    ##umount

        #unmount what is on this dir

            sudo umount /media/win/

    ##bind

        #make one dir a copy of the other

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

    ##processor

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
                #4

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

        sleep 100
        sleep 100
        ps
            #see processes running on current tty
            #pid
                #unique identifier for all process on system
            #tty
                #from which tty it was launched
            #time
                #cpu time used for process
                #not real time
            #cmd
                #command that launched th process
                #without command line args

        ps -A
            #see all process on system

        ps -Am
            #shows thrads of each process

        ps -Al
            #shows lots of extra columns in addition to the 4 default:

        ps -A --sort cmd,-time,pid,-tty
            #sort output
            #cmd
            #time reversed (-)
            #pid
            #tty reversed (-)

        p=
        ps -p $p -o ppid=
            #get pid of parent of process with pid p

    ##kill

        #POSIX 7

        #send signals to a process (signal is a ANSI C concept, with POSIX and Linux extensions)

        #not necessarily kill signal

        #it is unfortunatelly named kill because most signals end killing process,
        #or also because the most used signal is SIGTERM generated by a C-C on the terminal.
        #which has the usual effect of killing a process.

        #list all signals available on the system:

            kill -l

        #lists numbers and descriptions

        #send TERM signal to process:

            ps -A
            ID=
            kill $ID

        #select by pid, found on ps for example

        #select by jobid found on jobs

            jobs
            ID=
            kill $ID

        #send stop signal to process:

            kill -STOP $ID

        #send continue signal to process:

            kill -CONT $ID

    ##killall

        #send signals to all process by name

        #psmisc package

        #application: firefox/skype hanged. `ps -A | grep -i firef',
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

        #POSIX

        #copy files and dirs

        ##file

            #if dest does not exist, create it:

                echo a > a
                copy a b
                assert [ "`cat b`" = $'a' ]

            #if dest exists and is dir, copy into dir:

                mkdir d
                copy a d
                assert [ "`cat d/a`" = $'d/a' ]

            #if dest exists and is file, overwrite without asking!

                echo a > a
                echo b > b
                cp a b
                assert [ "`cat b`" = $'a' ]

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

            #must use recursive `-r`, even if dir is empty

                setup_test
                if cp d e; then assert false; fi
                teardown_test

                setup_test
                cp -r d d2
                assert [ -d d2 ]
                teardown_test

            #unlike move, can copy into dir recursively overwritting by default:

                setup_test
                cp -r d d2
                assert [ "`ls d2/d`"    = 'a b' ]
                assert [ "`cat d2/d/a`"  = 'A' ]
                assert [ "`cat d2/d/b`"  = 'b' ]
                teardown_test

            #if fails however if you try to overwrite a file with a dir:

                setup_test
                if cp -r d a; then assert false; fi
                teardown_test

            #it also fails if you try to overwrite a link to a dir with a dir:

                setup_test
                if cp -r d d3; then assert false; fi
                teardown_test

        ##symlink

            #by default, for files copies content of symlinks to new files/dirs:

                echo a > a
                ln -s a b
                ln -s b c

                cp c d
                assert [ -f d ]
                assert [ "`cat a`" = $'a' ]

            #with `-d` copies symlink to files into new symlinks (mnemonic: no-Dereference):

                cp -d c e
                assert [ -L d ]

            #for dirs by default copies symlink into a new symlink:

                mkdir d
                ln -s d dln
                cp dln e
                assert [ -L e ]

            #to dereference symlinks to directories, use `-L`:

                mkdir d
                ln -s d dln
                cp -L dln e
                assert [ -d e ]

            #does not work with `-r`. Probable rationale:

                #the only thing this could do is to copy dirs
                #and symlink files

                #but then why not do this with hardlinks?

        ##hardlink

                echo a > a
                cp -l a b
                ln -l a b
                assert [ "`stat -c '%i' a`" = "`stat -c '%i' b `" ]

            #with `-r`, makes dirs, and hardlinks files:

                mkdir d
                touch d/a
                touch d/b
                cp -lr d e
                assert [ "`stat -c '%i' d/a`" = "`stat -c '%i' e/a `" ]
                assert [ "`stat -c '%i' d/b`" = "`stat -c '%i' e/b `" ]

            #if `-l` is used, does not overwrite file:

                echo a > a
                echo b > b
                if cp -l a b; then assert false; fi

            #but can overwrite if `-f` is given:

                cp -fl a b
    ##rm

        #Remove files and dirs.

        #-r: recursive. Mandatory for directories. Potentially dangerous.

    ##recover data removed with rm like tools

        #`rm` only removes files from filesystem indexes, but the data remains in place
        #until the event that another file is writen on it, which may take severl minutes or hours.

        #Even after the file data overwritten few times, it is still possible to recover
        #the data using expensive forensic methods (only viable for organizations).

        #To permanently remove data from hard disk, you must use a tool like shred,
        #which writes certain sequences to the hard disk, making it impossible to
        #recover the data even with forensic methods.

        #Such operations take a very long time, and are not viable on entire hard disks,
        #so if you serious about clearing a hard disk, mechanical desctruction is a better option
        #(open the hard disk case and destroy the disk).

    ##rename

        #Mass file regex renaming.

        #Dry run:

            rename -n 's/^([0-9]) /0$1 /g' *.mp3

        #Act:

            rename 's/^([0-9]) /0$1 /g' *.mp3

    ##cpio

        #TODO

        find . ! -iname '* - *' -type f -print | cpio -pvdumB './no author'
        #cfind selected files to destination, building and keeping their relative directory structure

    ##rsync

        #TODO powered up `cp`?

    ##install

        #move and set: mode, ownership and groups

        #make all components of path:

            install -d a/b/c
            assert [ -d a ]
            assert [ -d a/b ]
            assert [ -d a/b/c ]

    ##mkfifo

        #make a fifo (named pipe)

        mkfifo f
        echo a > f &
            #the other end of the pipe has not been opened to read
            #therefore the echo write system call blocks
        cat f
            #a
            #requests for data
            #echo sends its data
            #echo terminates
            #this closes the echo input pipe

            #TODO understand this!

    ##chown
        #POSIX

        #change owner and group of files

        #you must use sudo to do this, because otherwise users would be able to:

        #- steal ownership of files
        #- git ownership to users who do not want to own the files

            su a
            mkdir d
            touch d/f
            sudo chown newuser:newgroup d
                #must use sudo to chown
            assert [ `stat -c '%U' d` = newuser ]
            assert [ `stat -c '%G' d` = newgroup ]
            assert [ `stat -c '%U' d/f` = a ]

        #`-R` for recursive operation:

            su a
            mkdir d
            touch d/f
            sudo chown b d
            assert [ `stat -c '%U' d` = newuser ]
            assert [ `stat -c '%G' d` = newgroup ]
            assert [ `stat -c '%U' d/f` = newuser ]
            assert [ `stat -c '%G' d/f` = newgroup ]

        #to change only user:

            sudo chown newuser

        #to change only group:

            sudo chown :newgroup

    ##chmod

        #POSIX

        #change file permissions

        #chomod [ugoa][+-=][rwxXst]+
            chmod a+x "$f"
                #makes f executable for all (owner, group and other)
            chmod a+r "$f"
                #makes f readable for all
            #a vs nothing: umask
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
            chmod -x "$f"
                #makes f not executable for all
            chmod =r "$f"
                #makes file readable by all
                #makes file not executable and not writeble by all
            chmod u+x "$f"
                #makes f executable for owner
            chmod go+x "$f"
                #makes f executable for group and other
            chmod +rw "$f"
                #makes f readable and writible for all
            chmod +w "$f"
        chmod 777 "$f"
            #chmod =rwx

        #sticky bit, suid sgid bits

            #sticky

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
            #can't clear them on numeric mode! only symbolic!
                chmod 7777 f
                stat -c "%A" "$f"
                    #-rwsrwsrws
                chmod 0 f
                stat -c "%A" "$f"
                    #---S--S--T
                chmod a-st f
                stat -c "%A" "$f"
                    #----------

        #can only change permissions for files you own
        #even if you have all the permissions on the file:

            su a
            touch a
            chmod 777 a
            su b
            if ! chmod 770 a; then assert true; fi

    ##umask

        #shows/sets permissions that will be *removed*
        #this is system implemented, and interacts with certain system calls such as `open`
        #this also has direct effect on commands such as `chmod` and `touch`

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

        #POSIX

        #cli for sys_stat

        #get file/dir info such as:

        #- size
        #- owner
        #- group
        #- permissions
        #- last access date
        #- create date
        #- modify date

            touch f
            stat f
                #lots of info

        ##-c

            #format string

                chmod 1234 f
                assert [ `stat -c "%a" f` = "234" ]

                chmod a=rt f
                assert [ "`stat -c "%A" f`" = "-r--r--r-T" ]

            #inode:

                touch a
                ln a b
                assert [ "`stat -c "%i" a`" = "`stat -c '%i' b`" ]

        ##--print

            #like `-c` but interprets escapes like `\n`

                touch a
                echo "`stat --print "%a\n%a\n" a`"
                assert [ "`stat --print "\n" a`" = $'\n' ]

    ##links

        ##ln

            #make hardlinks and symlinks

            #this can also be done with `cp`

            #hardlink:

                ln dest name

            #symlink files only:

                ln -s dest name

            #symlink dir:

                ln -ds dest name

            #the link will be created even if the destination does not exist:

                ln -s idontexist name

            #if the name is in another dir, the destination is not changed by default:

                mkdir d
                ln -s a d/a
                [ `readlink d/a` = a ] || exit 1

            #to create relative to dest use `-r`:

                mkdir d
                ln -rs a d/a
                [ `readlink d/a` = ../a ] || exit 1

            #if the name is in another dir, the destination is not changed by default:

            #absolute link:

                ln /full/path/to/dest name
                [ `readlink name` = "/full/path/to/dest" ] || exit 1

        ##readlink

            #get target of symlink

                touch a
                ln -s a b
                ln -s b c

                assert [ "`readlink c`" = $'b' ]
                assert [ "`readlink b`" = $'a' ]

            #recursive:

                assert [ "`readlink -f c`" = $'a' ]

        ##realpath

            #resolve all symbolic links and '.' and '..' entries of a path recursivelly

            #prefer readlink which is more widespread by default in distros

                mkdir a
                ln -s a b
                cd a
                touch a
                ln -s a b
                cd ..
                realpath ./b/b

            #Output:

                = "`pwd`/a/a"

            #readlink -f

                #same:

                    readlink ./b/b

                #and is part of coreutils, so more widespread default.

    ##cmp

        #compares F and G byte by byte, until first difference is found.

            cmp "$F" "$G"

        #if equal, print nothing.

        #else, print location of first difference.

        ##-s

            #silent

            #return status 0 if equal
            #!= 0 otherwise

            #print nothing.

                cmp -s "$F" "$G"
                if [ $? -eq 1 ]; then
                        echo neq
                else
                        echo eq
                fi

    ##xargs

        #posix 7

        #do some command on lots of files.

        #great for combo with find.

        ##alternatives

            #downsides of xargs:

            #- max number of arguments
            #- escaping madness for multiple commands

            #upsides of xargs:
            #- golfing!

            #in scripts, always use the more versatile (and slightly verbose) read while techinque:

                while read f; do
                    echo "$f";
                done < <(find .)

        ##test preparations

                function f {
                    echo $1
                }

        ##basic operation

            #read line from stdin, append as argument to the given command

            #does not automatically quote!

            #the default command is echo, which is basically useless

                echo $'a\nb' | xargs
                echo $'a\nb' | xargs echo
                echo $'a\nb c' | xargs echo

            #empty lines are ignored:

                echo $'a\n\nb' | xargs

        ##-0

            #read up to nul char instead of newline char

            #allows for files with spaces, and even newlines!

                echo -en 'a\0b' | xargs -0

            #combo with `find -print0`:

                find . -print0 | xargs -0

        ##-I

            #allows you to put the argument anywhere and to quote it

                    echo $'a\nb' | xargs -I '{}' echo '{}'

        ##multiple commands

            #must use bash

            #only use this for very simple commands, or you are in for an escaping hell!

            #if you have to do this, use the read while technique instead

                    echo $'a\nb' | xargs -I '{}' bash -c "echo 1: '{}'; echo 2: '{}'"

        ##applications

            #find and replace in files found with perl regex:

                find . -type f | xargs perl -pie 's/a/A/g'

            ##find files whose path differ from other files only by case

                #useful when copying from linux to a system that does not accept
                #files that differ only by case (the case for MacOS and Windows)

                    find . | sort -f | uniq -di

                #remove them:

                    find . | sort -f | uniq -di | xargs -I'{}' rm '{}'

    ##locate

        #searchs for files in entire computer

        #prints all matches

        #this uses a database, which must be updated with updatedb before your new file is found

        #commonly, `updatedb` is a cronjob

        #match any substring in entire path:

            locate a
            locate /a

        #to force update of file cache, use updatedb

    ##updatedb

        #updates file cache for locate

            sudo updatedb

    ##file

        #determine file type

        #posix 7

        #this is in general impossible,
        #but program makes good guesses

            echo a > a
            file a

        #Output:

            a: ASCII text

        ##-L

            #follow links

            echo a > a
            ln -s a b
            file b
                #b: symbolic link to `a'
            file -L b
                #b: ASCII text

    ##fuser

        #psmisc package

        #determines which process are using a file or directory

        #optionally sends signals to those processes

        fuser .
            #shows pids followed by a prostfix:
                #c      current directory
                #e      executable being run
                #f      open file. f is omitted in default display mode
                #F      open file for writing. F is omitted in default display mode
                #r      root directory
                #m      mmap’ed file or shared library

            #you will have at least one process here: your bash

        fuser -v .
            #shows program and user also

        fuser -v -n tcp 5000
            #check process using tcp/udp ports

    ##which

        #prints full path of executable in path

        #very useful to understand where things are located

        #If you give it a sh builtin like `cd`, outputs nothing,
        #so this is a convenient test is something is a `sh` builtin or not.

        #Examples:

            which ls

        #Sample output:

            /bin/ls

        #The following print nothing:

            which im-not-in-path

            which im-not-executable

            which cd

        ##application

            #quick and dirty install if not installed:

                if [ -z "`which zenity`" ]; then
                        sudo aptitude install zenity
                fi

            #could also be done bashonly with `type -P`.

    ##mktemp

        #create temporary directories and files in currend directory

        #creates a temporary file in `/tmp/`:

            f="$(mktemp)"
            echo "$f"
            assert test -f "$f"
            rm "$f"

        #directory:

            d="$(mktemp -d)"
            echo "$f"
            assert test -d "$d"
            rm -r "$d"

        #custom name template:

            f="$(mktemp --tmpdir abcXXXdef)"
            assert echo "$f" | grep -E 'abc...def'
            assert test -f "$f"
            rm "$f"

        #must use `--tmpdir` with template or else file is created in current dir

    ##pathchk

        #check if path is portable across posix systems

            pathchk -p 'a'
            pathchk -p '\'

    ##fdupes

        #fine command line tool for eliminating byte by byte duplicates
        #you can either
            #pick one by one
            #tell fdupes to pick the first one without asking (seem to pick one of the dirs first always)

        sudo aptitude install -y fdupes

        fdupes -r .
            #finds and prints dupes

        fdupes -rd .
            #finds dupes, and prompt which to keep for each match

##prompt user

    ##while read case

        #ask for user input, break into cases
        #if none of the cases is met, print error message and ask again.
        while true; do
                read -p "Which case do you want? case a [a], case b [b], case c [c])" c
                case "$c" in
                    "a" ) echo "Action for case a"; break;;
                    "b" ) echo "Action for case b"; break;;
                    "c" ) echo "Action for case c"; break;;
                    * ) echo "Does not match any of the possible cases. Try again."
                esac
        done

        #same as above, but for the ultra common case of yes [Y] no [n] case
        while true; do
                read -p "Yes or no? [Y/n]" yn
                case "$yn" in
                        Y ) ; break;;
                        n ) ; break;;
                        * ) echo "Please enter either 'Y' or 'n'.";;
                esac
        done

##setterm

    #outputs stdout that changes terminal properties

    #turns the cursor on/off:

        setterm -cursor off
        setterm -cursor on

##users and groups

    #to play around with those in ubuntu, do ctrl+alt+f2, f3 ... f7

    #and you will go into login shells

    #so you can log with different users at the same time

    #while logged on a different shell, process on the other shells continue to run? TODO

    #- totem stops
    #- simple shell scripts continue

    cat /etc/passwd
        #shows users
        #includes special users
        #format:
            #ciro:x:1000:1000:ciro,,,:/home/ciro:/bin/bash
            #ciro: user name
            #x: password is encrypted and stored in /etc/shadow
            #1000: user id. 0: root. 1-99: predefined. 100-999: reserved by system. 1000: first `normal` user
            #1000: primary user group
            #ciro,,, : comment field. used by finger command.
            #/home/ciro: home dir
            #/bin/bash: login shell

    cat /etc/group
        #show groups
        #format:
            #groupname:x:5:user1,user2,user3
            #x: encrypted pass if any
            #5: group id. `regular` groups start at 1000

        getent group "$g"
            #cat line of /etc/group for group g

    cat /etc/default/useradd

    ##groups

          groups "$u"
              #list groups of u
          groups
              #list groups of cur user

    ##who

        #list who is logged on system

        who

    ##last

        #list last user logins on system

        last

    ##whoami

        #print effective user name

        whoami

    ##id

        #shows user and groups id and names

        #whoami/groups superset

        id "$u"
            #for user u
        id
            #cur user
        id -u
            #effective userid
        id -un
            #effective username
        id -ur
            #real userid
        id -urn
            #real username
        id -g
            #groupid
        id -gn
            #groupname

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

        #become another user, such as root

        su otheruser
            #enter otheruser pass
        whoami
            #otheruser

        #BAD
            #never become root

            sudo passwd root
                #give root a pass so people can log into it
                #this is disabled by defaut on some systems as ubuntu for security
            su
                #enter root pass
            whoami
                #root

        #login

            #TODO login vs su?

        ##login shell

            su - a
                #start a login shell
                #without this starts a non-login shell

    ##sudo

        #do next single command as another user or super user

        #safer than becoming root with su

        #in order to see who can sudo what as who and with what pass

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

                #sudo passes stdin to the called program:
                    echo a | sudo cat
                        #a

                #cannot "echo to a file" directly:
                    su a
                    mkdir b
                    chown b b
                    #sudo echo a > b/a
                        #does not work
                    sudo bash -c 'echo a > b/a'
                        #works, but quoting is hell
                    echo a | tee b/a
                        #best method. shorter and no quoting hell

                #sudo echo a > b/a
                    #does not work
                echo a | tee -a b/a
                    #to append use -a

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

        u=
        sudo useradd -c '$fullname,$office,$office2,$homephone' -g 1000 -G 1001,1002 -m -s /bin/bash $u
            #addes user username u
            #-m makes home dir owned by him with permissions 707
                #without -m:
                    #ubuntu won't be able to log in
                    #if he logs in on tty, he goes to /
                    #to correct this:
                        sudo mkdir /home/$u
                        sudo chmod 700 /home/$u $u
                        sudo chown /home/$u $u

                    #home dir files will me copied from a default template located at `/etc/skel`
                    #to change this template use `-k /path/to/skel/`.
                    #to create no files: `-k /dev/null`

            #-p $p
                #bad because visible
                #without -p:
                    #user can't login
                    #to correct this:
                        sudo passwd $u
                            #sets passwd for u
            #-s sets login shell
                #without -s:
                    sudo chsh -s /bin/bash $u
                        #for u
                    sudo chsh -s /bin/bash
                        #cur user
            #-g: set group he belongs to
            #-G: add to other groups too
                #if g missing, either create a group u and add user
                #of add to a default group specified in some config file
            #-c: comment field of /etc/passwd
                #this format is used for `finger` command

                #chfn
                    sudo chfn -f full_name -r room_no -w work_ph -h home_ph -o other $u

                    #changes this info


        sudo useradd -e 2000-00-00 -f 5 $u
            #-e: password expires automatically at the given date.
            #-f: account disables 5 days after password expires if pass not changed.

    ##userdel

        #remove users
        #cannot be used on logged in users

        userdel $u
            #delete user, keep home
        userdel -r $u
            #delete user and his home

    ##groupadd

        #create new groups

            g=
            sudo groupadd $g

    ##usermod

        #add/remove users to groups

        #if you are the user, you have to logout/login again for changes to take effect

        #change primary group of user u to g:
            usermod -g $g $u

        g=1000,1001

        #Sets exactly the supplementary groups of user u.
        #Remove from non listed ones:

            usermod -G $g $u

        #Append (-a) groups g to supplementary groups of user u:

            usermod -aG $g $u

        #Change home dir of user u to d.
        #The old contents are not moved:

            usermod -d $d $u

        #Also move his current dir contents to new dir

            usermod -md $d $u

    ##passwd

        #set user passws

        passwd
            #change passwd for cur user
        sudo passwd "$u"
            #change passwd for u
            #if you are not u, you need sudo...
        sudo passwd -d "$u"
            #delete passwd for u, disabling his account

    ##chsh

        #change login shell

        less /etc/shells
            #view available shells
        chsh -s /bin/bash
            #change your shell to bash

    ##ac

        #connection statistics

        sudo aptitude install -y acct

        ac -d
        #current user connection in hours, broken by days

        ac -p
        #connection time for all users

    ##finger

        #shows user info
        #some data taken from /etc/passwd comment field

        sudo aptitude install -y finger

        finger "$u"
            #shows info on user u

        ##pinky

            #lightweight finger

            #coreutils package

    ##ldap

        #filesystem, printer, etc server over network

    ##radius

        #login server

        #freeradius major implementation

##languages

    ##bc

        #simple interpreted language, calulator focus

        #c-like syntax

        #features: variable definition, function definition, arrays, strings

        #non features: string concatenation

        #posix 7

            assert [ `echo '1+1' | bc` = 2 ]

    ##ruby

        #perl python concurrent

        ##gem

            #ruby package manager

            #install a package:

                sudo gem install pkg

    ##haskell

        #glasgow compiler is the main compiler implementation

        #compile:

            echo 'main = putStrLn "a"' > a.hs
            ghc a.hs
            [ `./a` = a ] || exit 1

        #standard REPL interpreter that comes with the glasgow compiler:

            ghci

##setleds

    #set/get capslock, numlock and scrolllock led state

    #only works from tty (ctrl+alt+F[1-6] on ubuntu)

        setleds

##scanner

    ##simple-scan

        #very simple to scan! after installing the printer drivers.

            #simple-scan

        #then click scan button. The image updates as the scan is made,
        #and you can stop it when you are done before the scanner reached the bottom.

        #make sure your scanner supports the definition preferences you set
        #or you will get a connexion error

##graphics card

    ##find your graphics card

    sudo lspci | grep VGA
        #I get:
            #NVIDIA Corporation GF108 [Quadro NVS 5400M] (rev a1)
            #                                 ^^^^^^^^^
            #so my card is: `NVS 5400M`

    ##nvidia

        ##download driver

            #<http://www.nvidia.com/Download/index.aspx?lang=en-us>

            #select your card on the list

        ##software prerequisites:

            ./NVIDIA*.run --extract-only
            vim NVIDIA*/README

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

    #suspend computer:

        dbus-send --system --print-reply \
            --dest="org.freedesktop.UPower" \
            /org/freedesktop/UPower \
            org.freedesktop.UPower.Suspend

##yes

    #coreutils

    #repeat an output forever!

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

    yes | timeout 1 cat
