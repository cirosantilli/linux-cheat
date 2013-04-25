#!/usr/bin/env bash

#"#!" is the <#shebang>

##meta

    #collection of programs that can be used on linux and basic howtos on how to use them.

    #if a program does not come with ubuntu 12.04, the aptitude install will be included

    #for installation, I focus on ubuntu which is what I am using.

    #if a program gets large enough, or fits better somewhere else, it might be moved
    #a commit note will say when that happens.

    #for all installs: grep -E "aptitude install" %

    #for a summary of up to level 2 header: `grep -E '^[[:space:]]{0,4}##' %`

#sources

    #http://linux.die.net/
        #linux man pages
        #dive into python
        #advanced bash scripting

    #almost official pages:
        #<http://www.kernel.org/>
        #<http://git.kernel.org/>
            #the git

    #<http://www.tldp.org/>
        #many tutorials

    #<http://www.thegeekstuff.com>
        #short tutorials with lots of examples
    
    #tuxfiles
        #<http://www.tuxfiles.org/linuxhelp/fstab.html>
        #some good tuts

    #linux man pages
        #check <#man>
        #not many examples, but full function list, and you often can guess what they mean!

    ##linux from scratch
    
        #teaches how to build a minimal linux distro from a working linux distro

##the standards

    #linux is based on the following:

    ##posix <#posix>
    ##linux standard base (lsb) <#lsb>
    ##file system hierarchy standard: <#fhs>

##POSIX

    #posix.1-2008, Single UNIX Specification, Version 4. formal name:`IEEE Std 1003.1-2008`
    #<http://pubs.opengroup.org/onlinepubs/9699919799/>
    
    ##open group

        #is an operating system standardization by IEEE and `the open group`
        #(merger of the `Open software foundation` with `X/Open`)

        #major open group supporters: Fujitsu, Oracle, Hitachi, HP, Orbus Software, IBM, Kingdee, NEC, SAP, US Department of Defense, NASA 

    #linux and mac OS X are largely posix compliant, but not certified
    #windows is not

    #for example, many linux system calls have very close interfaces
    #to the required posix `system interfaces`
    #example: `pipe` in posix, and `pipe`, `pipe2` system calls

    ##specifies

        ##shell command language

            #bash is compliant, with extensions

        ##utilities

            #programs in path/shell builtins that every shell should have

            #examples:
                #- cd
                #- ls
                #- cat
                #- mkdir
                #etc.

        ##system interface

            #standard c interfaces (header files)

            #they allow for operations such as:
                    #- threads
                    #- ipc
                    #- filesystem operations
                    #- user/group info

    ##does not specify:

        #the exact system calls
    
    ##regex
    
        man 7 regex

        #there are two types of posix regex:
        
        #basic and extended

        #basic is deprecated, so don't use it
        
        ##ERE
            
            ##examples
            
                echo $'a\nb' | grep -E '(a|b)'
                echo $'a\nb' | grep -E 'a*'
                echo $'a\nb' | grep -E 'a?'
                echo $'a\nb' | grep -E 'a+'
                echo $'a\nb' | grep -E '^a$'
                echo $'a\nb' | grep -E 'a{1,2}'
                assert [ "`echo $'aa\nab' | grep -E '(a)\1'`" = aa ]
                echo $'a\nb' | grep -E '.'
                echo $'a\nb' | grep -E '[[:alpha:]]'
                assert [ "`echo $'a\nA' | grep -E '[[:upper:][:lower:]]'`" = $'a\nA' ]
        
            #close to perl except:

            ##predefined character classes

                #which are enclosed in `[::]` inside a `[]`
                #full list:
                
                        #alnum       digit       punct
                        #alpha       graph       space
                        #blank       lower       upper
                        #cntrl       print       xdigit
                
                #in perl these are backlash escaped chars

    ##permissions

        ##concept

            #says who can do what

            #three types of people:

            #- owner. applies the person who created the file.
            #- group. the main group of he person who created the file.
                #applies to all people who are in that group.
            #- others. applies to all others who are not owner or in the group.

            #6 types of permissions:

            #- read
            #- write
            #- execute
            #- sticky bit
            #- sgid
            #- suid

            #see examples to understand those.

        ##notations

            #two standard types, symbolic and numeric.

            ##numeric

                #12 bits, logically grouped into 4 groups of three
                #thus use of octal (3 bits per digit)

                #meanings:

                #- 4000: suid
                #- 2000: sgid
                #- 1000: sticky bit
                #- 0400: owner read
                #- 0200:       write
                #- 0100:       exec
                #- 0040: group read
                #- 0020:       write
                #- 0010:       exec
                #- 0004: other read
                #- 0002:       write
                #- 0001:       exec

            ##symbolic

                #drwxrwxr-x
                #^^^^^^^^^^
                #123456789A
                
                ##1

                    #- -: regular file
                    #- d: dir
                    #- l: symlink (not for hardlink)
                    #- p: named pipe (fifo)
                    #- s: unix socket
                    #- c: character file
                    #- d: block device file

                ##2

                    #- r: owner can read
                    #- -: owner cannot read

                ##3

                    #- w: owner can write
                    #- -: owner cannot write

                ##4:

                    #- x: owner can    execute. suid off
                    #- s:       can           .      on
                    #- S:       cannot        . suid on

                ##567
                    
                    #same as 234, with 7 as 4 but for sgid

                ##89
                
                    #same as 23 and 56, but for others

                #A:
                    
                    #same as 4 and 7, but replace `suid` by `sticky bit`,
                    #`s` by `t` and `S` by `T`.

        ##directories
    
            ##read

                #you can view the files it contain

                #only works if you have read permission to *all* of the parent directories!
            
                    su a
                    mkdir -m 700 d
                    mkdir -m 700 
                    echo b > d/b
                    sudo chown b d/b d/d

                    su b
                    ls d
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

            ##write

                #you can change the list of contents in the dir:
                #add, remove and rename

                #only works if * x bit for is also on*!
                #it makes no sense to have `w` without `x` on dirs!!

                #works even if `r` is off.
            
                    mkdir -m 444 r
                    mkdir r/d
                    touch r/f
                        #permission denied
                    touch r/d/f
                        #permission denied

            ##execute

                #programs can cd into dir (every process has current dir informatio associated to it)

                #can access items in dir if their permissions let also you (read write exec)

                #can modify item list (add rename remove) *if w bit is also on*

                #all of that can be done *even if `r` is off*!

                #all only works if you have execute permissions to all of the parent dirs!

            ##sticky bit

                #if users cannot delete/move files in dir that don't belong to them

                #they can however create files.
                
                    su a
                    mkdir -m 1777 a
                    touch a/a

                    su b

                    rm a/a
                    mv a/a a/b
                        #permission denied

                    echo a > a/a
                    cat a/a
                        #ok

                    chmod a-t a
                    rm a/a
                        #removed

            ##sgid

                #files created under sgid dir get the same group as the parent dir.

                #dirs created under sgid also have sgid set!

                a=
                b=
                    #two existing users
                ga=`id -gn "$a"`
                gb=`id -gn "$b"`
                su "$a"

                #without sgid:

                    mkdir not-sgid
                    chmod 777 not-sgid
                    chmod a-st not-sgid
                    sudo -u "$b" touch not-sgid/f
                    stat -c "%G" not-sgid/f
                        #"$gb"
                    test -g not-sgid/f && echo g
                        #
                    sudo -u "$b" mkdir not-sgid/d
                    stat -c "%G" not-sgid/d
                        #"$gb"
                    test -g not-sgid/d && echo g
                        #

                #with sgid

                    mkdir sgid
                    chmod 2777 sgid
                    chmod u-s sgid
                    chmod o-t sgid
                    sudo -u "$b" touch sgid/f
                    stat -c "%G" sgid/f
                        #"$ga"
                        #inherits the group of parent dir!
                    test -g sgid/f && echo g
                        #
                    sudo -u "$b" mkdir sgid/d
                    stat -c "%G" sgid/d
                        #"$ga"
                    test -g sgid/d && echo g
                        #g
                        #subdirs also get sgid!

                ##application

                    #you want many users to colaborate under a single dir.

                    #you:

                    #1) create a group for collaboration
                    #2) create the dir with sticky bit
                    #3) add every user to the group
                    #4) make everyone give rwx on files they create

                    #this way, only the group can work under the dir,
                    #and they all can access each other's files

        ##files

            ##suid and sgid

                #DOES NOT WORK PROPERLY ON SCRIPTS: YOU MUST HAVE AN EXECUTABLE!!!!

                    echo '#include <unistd.h>

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
                        #your uid and gid twice
                    sudo -u b ./a.out
                        #b's uid and gid twice
                    chmod u+s ./a.out
                        #same, except the effective id is b's, not yours!
                    chmod g+s ./a.out
                        #now effective group is also b's!

        ##symlinks

            #symlinks always show 777 permission,
            #but this permission means nothing:

            #only the permissions and owners of target file
            #and its subdirs matter!

            ##file example

                    touch f
                    chmod 000 f
                    ln -s f fln
                    assert [ "$(stat -c "%A" fln)" = "lrwxrwxrwx" ]

                #still cannont cat from link:

                    if cat fln; then assert false; fi

                #trying to chmod the link, acts on the destination instead:
                
                    chmod 444 f
                    assert [ "$(stat -c "%A" f)"   = $'lr--r--r--' ]
                    assert [ "$(stat -c "%A" fln)" = $'lrwxrwxrwx' ]

            ##subdir example

                    mkdir -m 777 d
                    mkdir -m 777 d/d
                    ln -ds d/d ddln
                    chmod 000 d

                #cannot ls d/d even from ddln because no permission on d:

                    if ls ddln; then assert false; fi

    ##symlink

        #points to a target path

        #if if target is moved, the link is broken:

            echo A > a
            ln -s a b
            assert [ `cat b` = A ]
            assert [ `readlink b` = a ]
            mv a c
            if cat b; then assert false; fi

        #symlinks are identified by system metadata. programs can tell if a file is a symlink or not:

            touch a
            ln -s a b
            assert [ -L b ]

        ##what programs do when they see a symlink is up to them to decide

            #file content changes always affect the target of the link:

                touch a
                ln -s a b
                echo a > b
                assert [ `cat a` = a ]

            #file operations may use the link, or the link's content.
            #See: <#cp#symlink> for an example.

        #symlinks have their own inode:

            touch a
            ln -s a b
            assert [ ! "`stat -c "%i" a`" = "`stat -c '%i' b`" ]

        #it is therfore possible to make hardlinks of symlinks:

            touch a
            ln -s a b
            ln b c
            assert [ `readlink c` = a ]

    ##hardlink

        #points to an inode, a physical level filesystem file location id.

            echo A > a
            ln -s a b
            assert [ `cat b` = A ]
            assert [ "`stat -c '%i' a`" = "`stat -c '%i' b `" ]

        #changes in one file reflect immediatelly on the other:

            echo B > b
            assert [ `cat a` = B ]

        #it is impossible to get a list of files that have a given inode
        #without searching every file on the system.

        #the only way to check if two files are hardlinked is by comparing their inodes.

        #it is possible to tell how many hardlinks a file has with stat:

            stat -c '%h' f

##lsb
        
        #maintained by the linux foundation

        #link: <http://www.linuxfoundation.org/collaborate/workgroups/lsb/download>
        
        #it specifies things like:
        
            ##core
            
                #core c libraries
                #elf files
            
            ##c++
            
            ##interpreted languages
            
                #python
                #perl
            
            ##desktop

                #x11
                #gtk+
                #qt
                #jpeg, png
                #alsa

##fhs

    #filesystem hierarchy standard

    #maintained by the linux foundation

    #standard way for dir functions is called: standard directory architecture
    
    #like any classifications, many conventions are debatable

    #/bin : executables in path
    #/sbin : executables used only for admin taks
    #/lib : .so shared libraries/python modules
    #/src : c source files
    #/include : c header files
    #/doc : documentation
    #/tmp : temporary files
    #/media : automatically mounted stuff
    #/mnt : manually mounted stuff
    #/etc : linux configuration files
        #/etc/default : default values of some configs
    #/dev
        #devices
        #represent hardware
        #/dev/sd.. and /dev/hd..
            #hard disk partitions. see <#hd>
        #/dev/sr.
            #cd/dvd
        #/dev/cdrom
        #/dev/cdrw
            #usually link to /dev/sr.
        #/dev/(sd|hd)..
        #/dev/input/by-id
            #now remove you mouse
            #mouse files dissapear!
        #/dev/tcp/localhost/25
            #check ports open/close
            #(echo >/dev/tcp/localhost/25) &>/dev/null && echo "TCP port 25 open" || echo "TCP port 25 close"
    #/proc
        #processes and sys info
        #<http://www.thegeekstuff.com/2010/11/linux-proc-file-system/>
        #numbered folders:
            #represent processes!
        #you can `sudo cat` all files, even if they say size 0!
    #/root : root user home
    #/usr : user installed/distribuiton installed/managed by package manager
        #/usr/share
            #system independent data (not compiled for an specific system type)
            #/usr/share/doc
                #documentation for libraries and executables
            #/usr/share/sounds
                #system sounds like beeps and warnings
            #/usr/src/linux-headers-X.Y.Z-WW
                #kernel
    #/usr/local : user installed, managed either by package managers (pip) or manually
    #/var
        #data that changes while system runs
        #/var/log/
            #program outputs
            #some important ones: <http://www.thegeekstuff.com/2011/08/linux-var-log-files/>
                #/var/log/messages
                    #global system messages
                    #mail, cron, daemon, kern, auth
                    #ubuntu uses /var/log/syslog
                #/var/log/auth.log
                    #user logins, including sudo
                #/var/log/dpkg.log
                    #package install
                #/var/log/kern.log
                    #kernel messages
                #/var/log/mail.log
                #/var/log/Xorg.x.log
                #failed login attempts:
                    #/var/log/btmp 
                    #/var/log/faillog
                #/var/log/wtemp
                    #login information
                    #used by who and last
    #/lost+found : files recovered after system crash
    #/sys
        #non official
        #ubuntu: devices

    ##~
        #~/.profile
            #sourced when root bash starts
            #consequences:
                #variables will be acessible to programs, even if opened from desktop shortcuts/dash menu
        #~/.bashrc
            #sourced when each bash starts
        #~/.bash_logout
            #sourced when each bash ends
        #~/.xinitrc
            #xserver initi files
            #applications:
                #remap keys
    
    ##basename conventions
    
        #not in the fhs, but you should know about

        ##^\.
        
            #hidden files
            
            #it is up to programs to decide how to treat them
        
        ##\.~$
        
            #backup file

        ##\.bak$

            #backup file

        ##\.orig$
    
            #original installation file

        ##\.d$

            #many theories, a plausible one:
            #differentiate `a.conf file` from `a.conf.d` dir
            #normally, all files in the `a.conf.d` dir will be sourced
            #as if they wre inside `a.conf`

##licences

    ##gpl
    
        #you can use, study, share (copy), and modify the software
        #you *cannot* use it in non gpl projects (copyleft)
    
    ##mit liscence
    
        #like gpl
        #except you *can* use in commercial projects

##packages

    sudo apt-get update
    sudo apt-get install -y aptitude
        #like apt-get, but removing  a package will also uninstall all dependencies that
        #were installed for that package
    sudo aptitude install -y apt-file
    apt-file update
        #search package by file and list package files
    sudo aptitude install -y ppa-purge
        #remove added ppas
    sudo aptitude install -y apt-file
        #lets you search packages by files it contains
        #see http://www.thegeekstuff.com/2009/10/debian-ubuntu-install-upgrade-remove-packages-using-apt-get-apt-cache-apt-file-dpkg/
    sudo aptitude install -y apt-rdepends
        #fins packages that depend on a given package

##man

    #the manuals
    
    #posix 7

    ##search

        man intro
            #exact search on title
            #shows only first match
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
            #pages whose summaries match '.' reges: anychar)
        man -k . | grep '(8)'
            #list manual section
    
    ##show

        ##sections

            man 2 intro
                #read intro about section 2
            #1: commands (executables in path)
                #is the default section
                man 1 passwd
            #2: system calls (c interface)
                man 2 write
                    #write system call
                man 1 write
                    #write command
            #3: library. system call wrappers.
            #4: special files
                man 4 mouse
            #5: file formats
                man 5 passwd
                    #/etc/passwd file syntax
                man 5 elf
                    #elf executable format
            #6: games
            #8: system administration
                man 8 adduser
                    #commands that mostly only root can to

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

##ubuntu

    #a debian based distribution
    
    #important implications:
    
        #maby key programs are the same: `dpkg` for packages, `upstart` for init

    ##upgrade version

        sudo aptitude install -y update-manager-core
        sudo do-release-upgrade 
        sudo aptitude update && sudo aptitude upgrade

    #oppen app without global menu
    
        env UBUNTU_MENUPROXY=0 golly 

##configuration

    ##ubuntu

        sudo aptitude install -y ubuntu-restricted-extras
            #usefull stuff that does not come by default or Canonical would have to pay royalties

        #ubuntu-tweak
            #configure ubuntu
            sudo add-apt-repository -y ppa:tualatrix/ppa
            sudo aptitude update 
            sudo aptitude install -y ubuntu-tweak

        #sudo aptitude install -y myunity

        #additional drivers : non free vendors

            jockey-text --list
            #list

            jockey-text --enable=$DRIVER
            #enable from list. ex: xorg:fglrx_updates

    sudo aptitude install -y dconf-tools

    ##gnome tweak tool

        #gui to configure lots of desktop things.

        sudo aptitude install -y gnome-tweak-tool

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

    sudo aptitude install -y compiz compizconfig-settings-manager compiz-plugins-extra

##desktop

    unity --restart
        #restarts the unity shell only
        #less effective and drastic than restarting lightdm

    #gnome shell

        sudo add-apt-repository -y ppa:gnome3-team/gnome3
        sudo aptitude update
        sudo aptitude install -y gnome-shell

    #desktop/windows control

        gnome-open "$FILE"
            #opens with the deafult application. works in Ubuntu Unity 12.04

            #maximize and minimize windows by grepping title or class

            #GUI control

                sudo aptitude install -y wmctrl
                
                wmctrl -a ' - GVIM'
                #focus on a window with title containing '- GVIM' ( hopefully gVim! )

    #key logging
    
        #writes all keypresses to a file
        sudo aptitude install -y logkeys

        sudo logkeys -s
            #start

        sudo logkeys -k
            #end


    #ibus input methods

        #for chinese, japanes, etc input

        sudo aptitude install -y ibus-qt4
            #how have I looked for this, but no one told me: ibus for qt apps!!!!

    ##alarm
        sudo aptitude install -y alarm-clock-applet

    ##weather indicator

        sudo add-apt-repository -y ppa:atareao/atareao
        sudo apt-get update
        sudo apt-get install my-weather-indicator

##compresssion

    #the performance parameters are:
        #- compression ratio
        #- compression time
        #- can see and extracting single files
        #- support across OS
        #- ability to break into chunks
        #- keep file metadata such as permissions, hidden (windows), etc.

    ##zip

        #most widely supported
        #not so high compression
            #compresses dir one file by one it seems
        #easy to view and extract single files
        sudo aptitude install -y zip unzip

        zip -r "$F".zip "$F"
        #zip file or directory
            #-r : add dir recursivelly. otherwise, adds only the top dir! useless

        zip -er "$F".zip "$F"
        #-e : encrypts
            #you can still see filenames!! but not extract them

        unzip -l "$F".zip
        #list all files (recursive)

        unzip "$F".zip
        #extracts from zip
            #if has password, asks for it

        unzip "$F".zip -d out
        #to a dir

        for F in *; do echo "$F"; echo "$F".zip; zip "$F".zip "$F"; done
        #zip every file in cur dir to file.zip

    ##tar tar.gz tgz tar.bz2 tb2

        #tar only turns dir into file, but no compression
        #this is why it is often coupled with gz and bz2: those are files compressers
        #gz gives similar compression to .zip
        #gz2 is smaller than gz (30% for roms), but MUCH slower to make, and you can't extract individual files easily
        #tgz == tar.gz
        #txz == tar.xz
        #tb2 == tbz == tar.bz2

        #create
            tar vcf "$F".tar "$F" 
            tar vczf "$F".tgz "$F" 
            tar vcjf "$F".tbz "$F" 
            tar vcJf "$F".txz "$F" 
            #c: create
            #f: to file given as next arg, not to stdout
            #z: gzip
            #j: bzip2
            #v: verbose

        #extract
            tar vxf "$F".tar
            tar vxzf "$F".tgz
            tar vxjf "$F".tbz
            #f: from file given as next arg, not stdin

    ##rar
        
        #proprietary Roshal ARchive
        #can do split archive
            #split archive extensions:
                #.part\d+.rar
                #.r\d+

        unrar x a.rar
        #extract contents of a.rar to ./
        #
        #a.rar
        #  /dir1/
        #  /dir1/f1
        #  /dir1/f2
        #
        #===============
        #
        #a.rar
        #dir1/f1
        #dir1/f2

        unrar x a.rar out
        #out to ./out/, creates this folders if necessary

        unrar x a.r00
        unrar x a.part1.rar
        #extract multipart rar

        unrar e a.rar
        #recursivelly finds all files in a.rar, and outputs them to current dir
        #with old basename possible name conflicts
        #
        #a.rar
        #  /dir1/
        #  /dir1/f1
        #  /dir1/f2
        #
        #===============
        #
        #a.rar
        #f1
        #f2

    #7zip
        #microsoft proprietary program
        #can do lots of formats:
            #7z format
            #rar with p7zip-rar installed
            #zip
        #but *use only for 7z*, which it was made for
        #with 7zip, you can open .exe files to extract their inner data

        sudo aptitude install -y p7zip-full

    sudo aptitude install -y sharutils
        #shell archives

    sudo aptitude install -y unace
        #ace files

    sudo aptitude install -y uudeview
        #uuencode, xxencode, BASE64, quoted printable, BinHex

    sudo aptitude install -y mpack
        #mime messages

    sudo aptitude install -y lha
        #lzh, used on DOS, legacy

    sudo aptitude install -y arj
        #.arj files

    sudo aptitude install -y cabextract
        #microsoft cabinet format

    sudo aptitude install -y file-roller
        #gui app to view inside archives and extrac them

##encryption

    ##gpg

        ##sources

            #- good tut: <http://www.spywarewarrior.com/uiuc/gpg/gpg-com-4.htm>
            #- good tut: <http://www.madboa.com/geek/gpg-quickstart/>
            #- <https://help.ubuntu.com/community/GnuPrivacyGuardHowto>

        ##test preparation

            F=a
            echo a > "$F"

        ##encryption without keys

            #encryption and digital signing

            #create a "$F".gpg password only encrypted file:

                gpg -c "$F"

            #good combo with tar.gz.

            #create from stdin:

                cat "$F" | gpg -o "$F".gpg -c

            #decrypt to F:

                gpg "$F".gpg

            #decrypt to stdout:

                gpg -d "$F".gpg

            #decrypts to F:

                gpg -o "$F" -d "$F".gpg

            #decrypt from stdin:

                cat "$F".gpg | gpg -o "$F" -d 

        ##tar combos

            #targz encrypt "$F" to F.tgz.gpg, remove original:

                E=tgz.gpg
                tar cz "$F" | gpg -o "$F"."$E" -c && rm -rf "$F"

            #targz decrypt "$F"

                gpg -d "$F" | tar xz && rm "$F"

        ##encryption with keys

            #you have to understand the very basics of assymetric encryption
            #such as RSA before reading this.

            ##user id

                #uid can either be any case insensitive substring of the key name or email
                #that only one user has:

                    U="me@mail.com"
                    U="me"

            ##key id
                
                #is an identifier of the key:

                    K=12345678

                #to get it, use:

                    gpg --list-keys

                #TODO: how is it calculated this id?

            ##files

                #private keys is kept under `~/.gnupg/secring.gpg`. **NEVER SHARE THIS FILE**

                #public  keys that you trust are kept under `~/.gnupg/secring.gpg`.

                #the keys here are called keyring

                #`.asc` extension is used for ascii key files

                #each key file (`.asc` or `.gpg` may contain many keys)

            ##genarate pub/private pair

                    gpg --gen-key

            ##manage keys

                #list pub keys which you trust

                    gpg --list-keys

                #sample output:

                    pub   1234R/12345678 2000-01-01
                    uid                  user <mail>
                    sub   1234R/87654321 2000-01-01

                #pub: public key
                #sub: corresponding private pair
                #`12345678`: key id
                #`1234R`: ???

                #add pubkey ot the trust list:

                    gpg --import

            ##publicate you pubkey

                #- so that they can encrypt stuff so that you can read it.
                #- so that they can verify you are the creator of files.

                #as binary:

                    gpg -o a.gpg --export "$U"

                #this could be sent on an email attachment.

                #as ascii:

                    gpg -a -o a.gpg --export "$U"

                #this could be sent on an email body or as an attachment.

                #view keys in a key file (`.asc` or `.gpg`):

                    gpg a.gpg

                ##keyserver

                    #this is the best method, people only have to know your keyserver,
                    #and they can look for your key themselves.

                    #of course, nothing prevents you from signing as `Bill Gates`,
                    #and then you need some way to prove that that is your real identigy..

                    #well known servers:

                        S="http://pgp.mit.edu/"
                        S="https://keyserver.pgp.com/"

                    #you don't even need to create an account there to add your key:

                        gpg --send-keys "$K" --keyserver "$S"

                    #note that you need to use the key id, not the user id!
                    #since one user can have many keys.

                    #search for someone's key on a server:

                        gpg --search-keys "$U" --keyserver "$S"

                    #TODO not working

            ##encrypt decrypt

                #finnally!

                #create a "$F".gpg pubkey encrypted file:

                    gpg -r "$U" -e "$F"

                #only the person who knows the corresponding private key
                #will be able to decrypt it.

                #decrypt file for which you own the private key:

                    gpg -o "$F".out -e "$F"

            ##verify file

                #prove that a file comes from who he claims to:

                #create a "$F" verification file:

                    gpg -a -b "$F"

                #verify file with its verification file:

                    gpg --verify "$F".asc "$F"

                #only works of course if the key is in you keyring.

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

            sudo aptitude install -y goldendict

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
        
            #interactively checks files for spelling errors

            ##features

                #can add words to dict
                
                #understands some predefined formats!
            
            aspell -c f

            aspell --mode=tex -c f
            aspell --mode=html -c f
                #ignores language constructs!
            
            #modes can be added/removed. They are called `filters`
                sudo aspell --add-filter=$f
                sudo aspell --remove-filter=$f

#codecs #ERROR: mpg123libjpeg-progs cannot locate
    #use TAB to navigate msfonts
    sudo aptitude install -y mencoder totem-mozilla icedax tagtool libmad0 mpg321 mpg123libjpeg-progs
        #TODO understand/remove

##sound

    ##players

        ##cplay

            #has a file browser

                sudo aptitude install -y cplay

                cplay

    ##manipulation

        ##lame
        
            #encode, decode and modify mp3
            
                sudo aptitude install -y lame

            #increases volume 5x:
                lame --scale 5 a.mp3

        ##id3tool
        
            #get id3 tags info (for mp3 for example)

            sudo aptitude install -y id3tool

            TITLE="`id3tool "$1" | grep '^Song Title:' | awk '{ for (i=3;i<=NF;i++) { printf $i; printf " " } }'`"
            ARTIST="`id3tool "$1" | grep '^Artist:' | awk '{ for (i=2;i<=NF;i++) { printf $i; printf " " } }'`"
            ALBUM="`id3tool "$1" | grep '^Album:' | awk '{ for (i=2;i<=NF;i++) { printf $i; printf " " } }'`"
            YEAR="`id3tool "$1" | grep '^Year:' | awk '{ for (i=2;i<=NF;i++) { printf $i; printf " " } }'`"
            TRACKNUM="`id3tool "$1" | grep '^Year:' | awk '{ print $2 }'`"

            install -D "$1" /music/mp3/"$ARTIST-$ALBUM-$YEAR"/"$TRACKNUM-$ARTIST-$TITLE".mp3

        ##cut up flac cue into multiple files

            #via flacon GUI:
                sudo add-apt-repository -y ppa:flacon
                sudo aptitude update
                sudo aptitude install -y flacon

            #cuetools command line:
                sudo aptitude install -y cuetools shntool
                sudo aptitude install -y flac wavpack

                shntool split -f *.cue -o flac *.ape -t '%n - %p - %t'
                    #single ape and cue in dir, flac output, formatted as number, author, track

        ##sox

            #record, play and modify files cli

            #interactive front end for libSoX

            sudo aptitude intall -y sox
            sudo aptitude intall -y libsox-fmt-mp3
                #installs mp3 support
            apt-cache search libsox-fmt-
                #to see all available formats

            rec a.wav
                #records from microphone into a.wav file
                #ctrl+c : stop recording

            play a.wav
                #plays a.wav file
                #terminates when over

    ##system parameters

        ##alsamixer

            #ncurses interface to view/control sound parameters

            alsamixer
                #left/right : change active parameter
                #up/down    : change active parameter value

        ##amixer

            #cli for sound control

            amixer scontrols 
                #view available controls
            amixer sset 'Master' 50%
                #set master volume to 50%

    ##rip

        ##abcde

            ##cli

                sudo aptitude install -y abcde

            #rip:
                abcde
            #automatically starts ripping correctly on most systems!!
            #creates dir in cur dir and saves rip out as .ogg in it

##image

    ##image formats
    
        #<http://www.wfu.edu/~matthews/misc/graphics/formats/formats.html>
        
        ##listof
        
            #btm: bit by bit, no compression
            ##netpbm
                #PBM: black and white (1 or 0!)
                #PGM: gray scale
                #PPM: color
                #mainly linux
                #not compressed
            #gif: max mas 8 bit colors. obsolete
            #png: lossless, alpha layer,
            #tif: lossless or lossy, in practice lossless aplications only.
            #jpg: lossy, huge compression. removes fourrier transform high freqs I think.
            #svg: vector. image is described by mathematical formulas, not bits.
            ##ps
                #a programming language! can have goto, branch, variables
                #levels refer to versions: 1, 2 and 3 exist up to today
                #cannot split page by page
            #eps:
            #djvu:
            #pdf: text layers, image layers, can be viewd page by page
            #mobi: mobipocket company, free format
            #rtf: proprietary microsoft
    
    ##editors

        ##gimp
        
            #huge amount of functions

            sudo aptitude install -y gimp

        ##inkscape
        
            #svg
        
            sudo aptitude install -y inkscape

    ##viewers
    
        ##eog
        
            #eyes of gnome
        
            #lightweight
            
            eog a.jpg

        ##caca-utils
        
            sudo aptitude install -y caca-utils

            ##img2txt
            
                #stdout output

                img2txt a.jpg
                img2txt -W `tput cols` a.jpg
                    #-W: width
                    #fit to terminal
            
            ##caca view
            
                cacaview a.pjg
                    #img2text on x window

        ##aview
        
            #converts image to ascii art!!!
            
            #aview is only for p.m formats
            
            #bw only?
        
            sudo aptitude install -y aview

            asciiview a.jpg

            #I CANT CHANGE THE WIDTH!!!
                #asciiview -width a.jpg

    ##imagemagick

        #tons of image conversion tools

        #cli + apis in lots of langs, includeing c (native), c++ and python

        #reading the manual is a great image manipulation course!

        #install:

            sudo aptitude install -y imagemagick
            sudo aptitude install -y imagemagick-doc

        #list supported formats:

            identify -list format

        ##convert

            #- process images
            #- converts between formats

            #- input/output format can be deduced automatically (from extension/or magic?)

            #does not do:
            #- djvu

            ##options

                #tons of options available

                    ##size

                        ##-crop

                            #10x10: rectangle to keep:

                                convert -crop 10x10 a.jpg b.jpg

                            #+10+10: top left corner of rect

                                convert -crop 10x10+10+10 a.jpg b.jpg

                            #top 50 percent:

                                convert -crop 100x50% a.jpg b.jpg

                            #cannot give top left corner in percentage

                            #bottom 50 percent:

                                convert -gravity south -crop 100x50% a.jpg b.jpg

                    ##color

                        #-monochrome: monochrome image. == -depth 1? but not in practice =)

                        #-depth: number of bits per pixel.

                        #-density: pdfs are fixed width for printers, not pixel data,
                            #so you have to say how many dpi you want to take
                            #300 makes output quite readable

                            #always set this for pdfs

                            #pdf to one jpg per page:

                                convert -density 300 a.pdf a.jpg

                        #-threshold: 

                                convert -threshold 50 a.jpg b.jpg

                        #-level: 

                                convert -level -100,100 a.jpg b.jpg

    ##exactimage
        
        #concurrence to imagemagick, supposedly faster. c++ template api

        sudo aptitude install -y exactimage

    ##dvipng

        #convert dvi to png

        #important application: latex -> dvi -> png -> website.

        sudo aptitude install -y dvipng

##book

    ##readers

        ##okular

                sudo aptitude install -y okular okular-extra-backends

            #open at given page of document:

                okular -p 2 a.pdf

            #single instance:

                okular --unique a.pdf
                okular --unique b.pdf

            #`a.pdf` is closed, `b.pdf` is opened on same window.

        ##fbreader
            
            #mobi reader

            sudo aptitude install -y fbreader

    ##calibre
    
        #library management

        sudo aptitude install -y calibre
        mkdir ~/calibre
        #set library there: Cntr p > ...
    
    ##manipulation

        ##a2ps

            #txt to ps
            
                sudo aptitude install a2ps

                a2ps -o a.ps a.txt

            #-1: one page per sheet (default is 2)

                a2ps -B -1 -o a.ps a.txt

            #-B: remove default headers:

                a2ps -B -o a.ps a.txt

            #--borders=no: no default borders:

                a2ps -B -1 --borders=no -o a.ps a.txt

            #output to stdout

                a2ps -o - a.txt

        ##ps2pdf

                ps2pdf a.ps

                ps2pdf a.ps out.pdf

            #read from stdin:

                ps2pdf - a.pdf

            #out to stdout:

                ps2pdf a.ps -

        ##pdftotext

            #extracts text layer from pdf

            pdftotext a.pdf
            less a.txt

        ##pdftk

            #pdf Tool Kit

            sudo aptitude install -y pdftk

            #merge two or more pdfs into a new document:
                    pdftk 1.pdf 2.pdf 3.pdf cat output 123.pdf

            #or using handles:
                    pdftk A=1.pdf B=2.pdf cat A B output 12.pdf

            #or using wildcards:
                    pdftk *.pdf cat output combined.pdf

            #slice pdf: get pagets 1 to 7 only:
                    pdftk A="$f.pdf" cat A1-7 output "$f.pdf"

            #select pages from multiple pdfs into a new document:
                    pdftk A=one.pdf B=two.pdf cat A1-7 B1-5 A8 output combined.pdf

            #split pdf into single pages
                    pdftk mydoc.pdf burst

            #get pdf metadata like number of pages:
                    pdftk mydoc.pdf dump_data | less

            #rotate the first page of a pdf to 90 degrees clockwise:
                    pdftk in.pdf cat 1E 2-end output out.pdf

            #rotate an entire pdf document’s pages to 180 degrees:
                    pdftk in.pdf cat 1-endS output out.pdf

            #encrypt a pdf using 128-bit strength (the default) and withhold all permissions (the default):
                    pdftk mydoc.pdf output mydoc.128.pdf owner_pw foopass

            #Same as Above, Except a Password is Required to Open the PDF:
                    pdftk mydoc.pdf output mydoc.128.pdf owner_pw foo user_pw baz

            #Same as Above, Except Printing is Allowed (after the PDF is Open):
                    pdftk mydoc.pdf output mydoc.128.pdf owner_pw foo user_pw baz allow printing

            #Decrypt a PDF:
                    pdftk secured.pdf input_pw foopass output unsecured.pdf

            #Join Two Files, One of Which is Encrypted (the Output is Not Encrypted):
                    pdftk A=secured.pdf mydoc.pdf input_pw A=foopass cat output combined.pdf

            #Uncompress PDF Page Streams for Editing the PDF Code in a Text Editor:
                    pdftk mydoc.pdf output mydoc.clear.pdf uncompress

            #Repair a PDF’s Corrupted XREF Table and Stream Lengths (If Possible):
                    pdftk broken.pdf output fixed.pdf

        ##djvulibre-bin

                sudo aptitude install -y djvulibre-bin

                ##ddjvu

                    #convert djvu to other formats

                    #huge outputs! not practical sizes!

                    #very slow!
                    
                    #possible: pbm, pgm, ppm, pnm, rle, tiff, and pdf

                        ddjvu -format=pdf "$djvu" "$pdf"

                    #outputs pages 1 and 3, followed by all the document pages in reverse order up to page 4:

                        ddjvu -format=pdf -pages=1,3,99999-4 "$djvu" "$pdf"

                    #loses text layer

                ##djvm

                    #get number of pages of djvu:

                        djvm -l speak\ chinese\ 2.djvu | sed -nre '$ s/.+#([0-9]+).+/\1/p'

        ##ps2pdf

            ps2pdf a.ps
                #produces a.pdf
            ps2pdf a.ps b.pdf
                #produces b.pdf
            ps2pdf -dUseFlateCompression=true a.ps
                #compressed pdf
            ps2pdf -dOptimize=true report.ps
                #allows to see one page at a time (good for web)

##ocr

    #possibilities:
    #  gocr, ocrad, tesseract or cuneiform.

    #horc: format that contains orc + info about page position and certainty

    #orc indexing: tranform pdf textonly to searchable pdf
            #https://help.ubuntu.com/community/OCR#OCR_on_a_Multi_Page_PDF
            #http://blog.konradvoelkel.de/2010/01/linux-ocr-and-pdf-problem-solved/

    ##pdfs

        #before you go about extracting pdfs, you must use the right command to convert!
        #some good options are:
        convert -density 300 -monochrome -normalize a.pdf a.png
        convert -depth 1 -density 300 -normalize a.pdf a.png

    ##tesseract

        sudo aptitude install -y tesseract-ocr
        apt-cache search tesseract-ocr- #to find available languages
        sudo aptitude install -y tesseract-ocr-eng #english

        ##chinese hack
            sudo aptitude install -y tesseract-ocr-chi-sim #simplified chinese
            cd /usr/share/tesseract-ocr/tessdata
            sudo ln -s chi_sim.traineddata zho.traineddata
            #tesseract looks for zho instead of chi_sim
            #there is probably a better way to do this in the tesseract configs, but apparently not directly from vobsub2srt

        tesseract -l eng -psm 3 a.png a
        tesseract -l eng -psm 3 a.png a hocr
        #-psm 1 : detects pages *and* script automatically. most magic mode.

    ##cuneiform
        #sudo aptitude install -y cuneiform
        cuneiform -l eng -f text -o "$f.txt" "$f.png"
        #-f: html, hocr
        #-l: lang, see man cuneirform

    ##hocr2pdf from the ExactImage package.
        hocr2pdf -i "$f.png" -s -o "$f.pdf" < "$f.hocr"

##video

    #*ripping* is taking the dvd from the dvd to files in computer
    #*trancoding*, is encoding the dvd on some smaller format.
    #*containers* are filetypes that turn video, audio and subtitles in a single files
        #mkv
        #avi

    #DVD
        #DVDs have regions
        #http://en.wikipedia.org/wiki/DVD_region_code
        #this serves only to control copyright
        #dvd readers have a limited number of region changes
            #around 5
            #after this number of changes, YOU CANNOT CHANGE IT ANYMORE!!!!

    sudo aptitude install -y vlc
        
    ##handbrake

        #transcode
        #containers: mkv, mpeg4
        #first check this for some good info:
            #firefox http://msdn.microsoft.com/en-us/library/windows/desktop/dd388582%28v=vs.85%29.aspx

        sudo add-apt-repository -y ppa:stebbins/handbrake-releases
        sudo aptitude install -y handbrake-cli
        #sudo aptitude install -y handbrake-gtk
        #get command line version of course

        i=/media/
        HandBrakeCLI -t 0 -i "$i"
        #scans only for all titles and tracks

        s=1,2
        t=1
        HandBrakeCLI -B 160 -e x264 -f mkv -i "$i" -m -o 1.mkv -q 22 -s "$s" -t "$t"
        #1000 Kbps MPEG-4 Visual video and 160 Kbps AAC-LC audio in an MP4 container.
        #-f container format (mkv|mp4)
        #-m extract title markers
        #-e x264 : video encode format x264/ffmpeg4/ffmpeg2/theora.
        #-q 20 : CRF constant quality 0 .. 50. with x264: 22 for dvd, 22 for bluray.
        #-B 160 : sound kbps
        #-s 1,2,3 : subtitles to keep
        #-t 1: title 1. A DVD can contain many titles, which are usually independent films or tracks
        #In an MKV, you can store MPEG-4 video created by ffmpeg or x264, or Theora video.
                #It stores audio in the AAC, MP3, or Vorbis formats. It can also pass through the Dolby Digital 5.1 (AC3) and Digital Theater Systems (DTS) surround sound formats used by DVDs.
                #It supports chapters, as well as Variable Frame Rate video.
                #It can include "soft" subtitles that can be turned on or off, instead of always being hard burned into the video frame. These can either be bitmap images of the subtitles included on a DVD (known as vobsub) or text. 
                #it seems though that it can't produce srt

        #CRF ~2hrs film:
            #CRF off = 1214 MB
            #CRF 26 = 926 MB
            #CRF 24 = 1205 MB
            #CRF 22 = 1586 MB
            #CRF 20 = 2141 MB
            #CRF 16 = 4503 MB

        #to get subtitles
            #must do OCR
            #OGMRip : srt
            #MEncoder and Transcode : idx + sub
            #mkvextract : can do srt from mkvs

        #my results:
            #HandBrakeCLI -B 160 -e x264 -f mkv -i /media/DVDVolume -m -o ~/out.mkv -q 20 -s 1,2,3
            #initial length: 2:16
            #conversion time: 4 hours
            #final size: 2Gb
            #quality: same as original

            #HandBrakeCLI -B 160 -e x264 -f mkv -i /media/DVDVolume -m -o ~/out.mkv -q 22 -s 1,2,3
            #initial length: 2:16
            #conversion time: 2:23
            #final size: 2Gb
            #quality: same as original

    ##acidrip
        #containers: avi, mpg
        #gtk interface

    ##dvdrip

        sudo aptitude install -y dvdrip

    ##k9copy

        sudo aptitude install -y k9copy

    ##mkvtools

        sudo aptitude install -y mkvtools

        mkvinfo 1.mkv
        #see info about a

        t="3:ita 4:eng"
        mkvextract tracks 1.mkv $t
        #extracts tracks 3 and 4, save 3 to eng.$ext or str, 3 to chi.$ext
            #where ext is the extension of the contained audio
        #we know those are subtitles from mkinfo
        #3:asdf means track 3, asdf is the output name
        #the type is that contained in the tracks, not necessarily srt,
            #maybe vobsub idx + sub if you want srt from vobsub, try obsub2srt

    ##vobsub2srt

        #uses tesseract for the ocr: this means you must install tesseract lanugages
        #for chinese, must symlink 
        #see: #tesseract for installing the languages
        sudo add-apt-repository -y ppa:ruediger-c-plusplus/vobsub2srt
        sudo aptitude update
        sudo aptitude install -y vobsub2srt

        vobsub2srt --langlist 1 #view available languages inside a.sub a.idx pair
        l=en
        f=
        vobsub2srt --lang "$l" "$f"
        #takes eng.sub and eng.idx and makes eng.srt with optical recognition
        #en or 0 were taken from --langlist
        #don't know what to do if two subs for the same language such as
        #  simplified and traditional chinese, both of which get zh
        #output goes to a.str. don't forget to rename it as a.eng.srt before going to the next language

    ##srtmerge

        #https://github.com/wistful/srtmerge
        sudo pip install srtmerge
        srtmerge a b ab
        #mergers two srte files into one
        #if there are two timings that coincide, they are merged into one
        #newline separated
        #perfect for dual sub language learning

    ##guvcview

        sudo aptitude install -y guvcview
        #record video/audio with webcam
        #click on the bottom video icon to record, click again to stop

##chat messaging voice video

    sudo add-apt-repository -y "deb http://archive.canonical.com/ $(lsb_release -sc) partner"
    sudo aptitude update
    sudo aptitude install -y skype

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

        
#file sharing

    #torrent

        #deluge
            sudo add-apt-repository -y ppa:deluge-team/ppa
            sudo aptitude update
            sudo aptitude install -y deluge

    #dropbox

        sudo aptitude install -y nautilus-dropbox 

        firefox https://www.dropbox.com/home
            #see your home files on browser

        dropbox filestatus
        dropbox filestatus "$F" "$G"
                #a: up to date
                #b: unwatched

        dropbox status
            #idle

        dropbox ls
            #ls on current dir
            #green: synced

        dropbox puburl "$F"
        echo "wget `dropbox puburl "$F"`" > xsel
            #get public url of F
            #must be inside Public folder

        dropbox autostart y
            #autostart dropbox

        #ubuntu one
            #shows sync status on task bar
            sudo add-apt-repository -y ppa:noobslab/initialtesting
            sudo apt-get update
            sudo apt-get install indicator-ubuntuone

    #soulseek client nicotine+ 

        sudo aptitude install -y nicotine+
        #behind a proxy router
        # go to the router admin panel, port forwarding part
        #  (http://192.168.0.1/RgForwarding.asp on dlink for example, default login:admin pass:motorola)
        # open ports 2234 to 2239 on local ip found at
        #  ifconfig eth0 | grep "inet addr:"
        #
        #now either put your files in another partition at the root, or symlink
        #your share and download dirs to somewhere above user so that people cannot
        #see your username

##programming

    sudo aptitude install -y build-essential
        #building tools

    sudo aptitude install -y automake
        #makefile macros
        #generates makefiles

    sudo aptitude install -y libtool
        #helps generatin libraries for c, c++, fortran and java

    sudo aptitude install -y cmake
        #make advanced

    #nasm assembler

        sudo aptitude install -y nasm

        nasm -w+all -f elf -o a.o a.asm
            #-w+all : enable all warnings
            #-f ouptut format

        nasm -w+all -f elf -o a.o a.asm

    ##make

        make
            #uses Makefile in cur dir
        make -C /some/dir
            #changes current dir
    
    ##gcc ##g++

        #Gnu Compiler Collection: NOT c compiler
        #does: C, C++, Objective-C, Fortran, Java, Ada, and Go
        #large frontend to severl subprograms such as `as`, `cpp` and so on

        #g++:
            #http://stackoverflow.com/questions/172587/what-is-the-difference-between-g-and-gcc
            #most important:
                #1) g++ treats both .c and .cpp files as c++
                #2) g++ links to (but does not include) stdlib automatically, gcc does not!

        #http://www3.ntu.edu.sg/home/ehchua/programming/cpp/gcc_make.html#
        #http://www.adp-gmbh.ch/cpp/gcc/create_lib.html

        #compilation steps

            cpp a.c > a.i
            cpp b.c > b.i
            #expanded macros
            #c pre processor

            gcc -S a.i -o a.s
            gcc -S b.i -o b.s
                #generate human readable assembly code
                #default format: att
            gcc -masm=att -S a.c -o a.s
            gcc -masm=intel -S a.c -o a.s
                #specify format

            as -o a.o a.s
            as -o b.o b.s
                #make machine code

            gcc -c a.c -o a.o
            gcc -c b.c -o b.o
                #all above steps in one

            ld -o ab.out a.o b.o
                #link object files into single executable

            gcc a.c b.c -o ab.out
                #does all above steps in one
                #if you use make, it is faster to genterate `.o`
                #and keep them, since if the source does not change,
                #make will not recompile the corresponding `.o`

        ##compilation flags

            ##always use

                gcc -Wall
                    #enables all warnings
                    #ALWAYS USE IT
                gcc -Wall -Wno-unused-variable
                    #enables all warnings, except `unused-variable

                #std
                #specifies version os the language to be used
                #
                    #disable gcc extensions that conflict with c standrad
                    gcc -std=c90
                    gcc -std=c99
                    gcc -std=1x
                        #current most modern
                    gcc -std=c11
                        #not yet available
                        #will be when implementation complete

                    gcc -ansi
                        #changes with time, currently equals `-std=c90`
                        #don't use it

                gcc -std=c1x -pedantic 
                    #give warnings for code that does not comply with c1x standard
                    #this does not mean *FULL* complience, but greatly increases complience
                    #there is currently no full complience check in `gcc`
                gcc -std=c1x -pedantic-errors
                    #give errors instead of warnings

                ##-march cputype

                    #optimizes code to given cpu (arch is for archtecture)
                    #may use instructions only available to given cpu

                    gcc -march=native
                        #optimize for currrent compiling machine
                    gcc -march=i386
                        #80386 instruction set. old, compatible, used on almost all desktops and laptops
                    gcc -march=armv7
                        #Arm v.7, used on mobiles today

                ##code optimization

                    gcc -Q -O --help=optimizers
                    #shows optimizations for -O

                    #-O0 : no speed optimization. This is the default
                    #-O : -O1 basic speed optimization
                    #-O2 : more than O1
                    #-O3 : more than O2
                    #-Og : optimize for debugging
                    #-Os : optimize for size
                    #-Ofast : optimize for speed more than O3, *even if it breaks standards*

                    gcc -O3 a.c -o a.out
                    #compile with optimization

                    ##summary
                        
                        gcc -std=c99 -pedantic-errors -Wall -03 -march=native a.c
                            #always use this for production code
            
            ##other
            
                gcc -std=gnu90
                    #c90 + gcc extensions

        ##c preprocessor
        
            #the executable is `cpp`
            
            #gcc uses it implicitly
        
            ##define command line

                gcc -DLINELENGTH=80 -DDEBUG c.c -o c
                    #same as adding
                    #define LINELENGTH 80 
                    #define DEBUG
                    #to top of file
            
            ##include search path

                echo '' | cpp -v
                    #look for sections:
                        #include "..." search starts here:
                        #include <...> search starts here:

                    ##summary
                        
                        gcc -std=c99 -pedantic-errors -Wall -03 -march=native a.c
                            #always use this for production code
                export CPATH="/add/to/include"

                gcc a.c -I/path/dir/ -I/path/dir2/
                #-I: add path to include search path
                    #must be *full path*, that is, will not look realtive to existing search path

            ##output preprocessed file

                #learing purposes only
                gcc -E c.c -o c

        ##libs

            ##itro

                #**TO USE A LIBRARY YOU NEED 2 THINGS**:

                #- the header .h file(s)
                #- the compiled .so or .a file(s)

                #either those must be in you compiler find path
                #(different for headers and compiled files)
                #or you must explicitly add them to the path.

            ##search path
            
                #where gcc search path for .a and .so
                
                gcc -print-search-dirs | grep '^libraries' | tr ':' $'\n'

            ##static

                    #gets included in program
                    
                    #program gets larger
                    
                    #you don't have to worry about dependancies

                    gcc -c a.c
                    gcc -c b.c
                    ar rcs a.a a.o b.o
                    gcc a.a c.c

            ##dynamic
            
                #aka ##shared library
            
                ##loading vs linking
                
                    ##linking

                        #link to lib for entire program
                        
                        #simpler
                    
                    ##loading
                    
                        #explicitly load needed functions during program execution
                                        
                ##create so

                    gcc -c -fPIC a.c
                    gcc -c -fPIC b.c
                        #compile for .so
                        #*MUST* compile like this
                    gcc -shared a.o b.o -o libab.so

                    ##version numbering
                    
                        #standard: up to 3 numbers
                        
                        #yes, they come after the `.so`
                        #otherwise possible ambiguity:
                        #`liba.1.so` is version 1 of `liba` or simply `lib.a.1`?
                        
                        #to link to a given version:
                        #use full basename linking with verison number.
                        
                        #linking takes care of version defaults:
                        
                            #- liba.so.1.1.1
                                #necessarily itself
                            
                            #- liba.so.1.1
                                #itself
                                #or a link to 1.1.1
                                #or a link to 1.1.2
                                #...

                            #- liba.so.1
                                #itself
                                #or a link to 1.1
                                #or a link to 1.2
                                #or a link to 1.1.2
                                #or a link to 1.2.1
                                #...
                            
                            #- liba.so
                                #itself
                                #or a link to 1
                                #or a link to 2
                                #or a link to 1.1
                                #or a link to 1.2
                                #...
                            
                            #rationale: if you underspecify the library
                            #you get by default the most recent
                        
                            #convention: change in first number means possible interface break

                ##compile with so

                    ##-l
                    
                        #link to library libm.so:

                            gcc a.c -o a.out -lm
                            gcc a.c -o a.out -l:libm.so

                        #SAME
                        #relative paths to the load path get stored in the elf file
                        #`readelf -d` shows that

                            gcc a.c -o a.out -l:/full/path/to/libm.so 

                        #DIFFERENT
                        #the full path gets stored in the elf file
                        #`readelf -d` shows that
                        
                        #it must be in the load path. see: <#-L>
                    
                        #PUT -l AFTER ALL COMMANDS!!!!!!!!!!

                        #the name given to -l must be EITHER:

                            #- stripped from `lib` and `.so` part
                                #in this example: `m`, for `libm.so`. *will not work for `libm.so.1` !!!!!

                            #- colon + `:`full basename: `-l:libm.so.1`
                            
                            #you need to compile like this so gcc
                            #can tell if all your functions are definied

                        ##-L

                                gcc a.c -o a.out -L/full/path/to/ -lm
                                gcc a.c -o a.out -L./rel/path/to/ -lm
                                env LIBRARY_PATH=$LIBRARY_PATH:/path/to/ gcc a.c -o a.out -llib

                            #append path to link search path
                            #
                            #to view current path: <#library path>
                            #
                            #can also be done via LIBRARY_PATH variable
                            #
                            #HOWEVER, when the program will run,
                            #you still need to add it to the load path!!!
                            #
                            #either on /etc/ld.so.cache or on the variable
                            #`LD_LIBRARY_PATH` (which is completelly different from
                            #`LIBRARY_PATH`, which can be used for compilation path,
                            #but not for loading). see <#load path>.
                            #
                            #this is only good for compilation!!!
                
                ##execute
                
                    ##best method

                        sudo mv liba.so /some/where/in/link/path
                        sudo ldconfig
                            #optional but better, see <#search path>
                        ./a.out

                        #this suposes that when you compiled you used: `-lliba.so`
                    
                    ##LD_LIBRARY_PATH

                        #this has nothing to do with LIBRARY_PATH path variable
                        #which is used during compilation by gcc!
                        
                        #LD_LIBRARY_PATH is used during execution by the linker!

                        env LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/absolute/path/to/lib ./a.out
                        ./a.out

                        #BAD
                        
                            env LD_LIBRARY_PATH=$LD_LIBRARY_PATH:./rel/path/to/lib/from/cd ./a.out
                            ./a.out

                            #this only works if you are in the right dir
                            #since relative path is take to current dir
                        
                    #required libs are stored in the ELF file at compilation
                    #either as relative or absolute or absolute paths
                    
                    #next, the linker uses this information to find the library
                    #during execution
                    
                        
                        #you could build the exe, move the lib, and still link to it!
                        
                    ##ldd

                        #list required shared libraries
                        #and if they can be found
                        
                        #binutils package
                        
                        #is a convenient subset of `readelf -d`
                        
                        ldd a.out
                            ##cases:
                                ##Not a dynamic executable
                                ##liba.1.so => /lib/liba.1.so
                                ##liba.1.so => not found
                
                    ##load path
                
                        cat /etc/ld.so.conf
                            #search path
                            
                            #may also include other files as for example:
                                #`include /etc/ld.so.conf.d/*.conf`
                                #in this case you want to:
                                    cat /etc/ld.so.conf.d/*.conf

                            #the following are hard codded in `ldconfig`:
                                #- /lib/
                                #- /usr/lib/

                        ##cache

                            #it would be very slow to search the path every time
                            
                            #therefore the linker keeps uses a cache at:
                                cat /etc/ld.so.cache

                            #it first looks for libs there,
                            #and only then searches the path
                            
                            #you can generate `/etc/ld.so.cache` automatically
                            #once you have your `ld.so.conf` with `ldconfig`

                            #even if the linker finds the lib in the path,
                            #it does not automatically add it to the cache
                            #so you still have to run `ldconfig`

                            #running ldconfig is a part of every package install/uninstall
                            #if it conatins a lib
                            
                            ##ldconfig
                            
                                sudo ldconfig
                                    ##search in dirs listed in `/etc/ld.so.conf`
                                    #and write found libs to `/etc/ld.so.cache``

                                ldconfig -p
                                    #print cache stored in /etc/ld.so.cache and .d
                                    #does not show in which directory libraries are stored in
                                    #only where they link to
                    
                                ldconfig -v
                                    #show directories that are scanned and libraries that are found
                                    #in each dir
                                
                                ldconfig -v 2>/dev/null | grep -v $'^\t'
                                    #print search path
                                    
                                    ##hwcap
                                    
                                        #/usr/lib/i386-linux-gnu/sse2: (hwcap: 0x0000000004000000)
                                        
                                        #stands for `hardware capacities`
                                        
                                        #if present, means that those libraries can only be used
                                        #if you hardware has the given capacities
                                        
                                        #here for example, as shown in the directory name,
                                        #this path is for libraries which depend on the sse2
                                        #extensions (a set of cpu instructions, not present
                                        #in older cpus)
                                        
                                        ##where ldconfig finds this info:
                                        
                                        ##what the flags mean:
                                        
                                            #<http://en.wikipedia.org/wiki/CPUID#EAX.3D1:_Processor_Info_and_Feature_Bits>

                            ##environment
                            
                                #you can also add to path with environment variables
                                
                                #don't rely on this method for production
                                
                                export LD_LIBRARY_PATH="/path/to/link"
                
                ##override symbols in libraries
                
                    echo "/path/to/my/a.o" | sudo tee -a /etc/ld.so.preload
                        #symbols in a.o will override symbols in liked libs
                        
                        #emergency/tests
                    
                    export LD_PRELOAD=
                        #same effect

                ##interpreter
                
                    #program that loades shared libs for other programs
                    
                    #this program links to no shared libs!
                
                    readelf a.elf | grep "Requesting program interpreter"
                    file -L /lib/ld-linux.so.2
                        #ELF
            
        ##gdb
        
            #gnu symbolic debugger
            
            gcc -ggdb3 a.c
                #adds debug information to executable such as line numbers,
                #and symbol names (normally exceutables contain only memory adresses)
                #makes exec larger
                #-g : generate debug info for gdb
                #-ggdb : adds more info
                #-ggdb3 : adds max info. default if 2 when ggdb is used.

            gdb a.out
            gdb a.out $pid
                #attach to a running process
                #pauses the process
                #on quit, process continues

                #r
                    #run prog
                    #if already runnin, kill and rerun.
                    #keeps breakpoints, etc
                #r 1 2
                    #start running with arguments
                    #next r calls will use those args
                #set args
                    #removes args

                #k
                    #kill program
                    #keeps breakpoints, etc

                #b
                    #b 10
                    #b func
                    #b c.c:10
                    #b c.c:func
                    #b +2
                        #two lines down from cur
                    #b -2
                        #two lines down from cur

                #i b
                    #view breakpoints

                #dis 1
                    #disable breakpoint 1.
                    #1 is gotten from `i b`

                #en 1
                    #enable breakpoint 1.
                    #1 is gotten from `i b`

                #d
                    #delete all breakpoints
                #d 1
                    #delete breakpoint 1

                #cl 10
                #cl func
                #cl file:func
                #cl file:10
                    #delete breakpoint at line 10

                #w 
                    #set watchpoint
                    #stop prog when var or expr changes value

                #c
                    #set catchpoint
                    #TODO ?

                #s
                    #step exec next line
                    #if func call, step inside funv
                #n  
                    #setp next. if func call
                    #run entire func now
                #whe
                    #where, print line number

                #ba
                    #show backtrace of stack at current point

                #f
                    #show cur frame number
                #f 1
                    #go to frame 1

                #l
                    #list next 10 lines of code.
                    #l again, lists next 10.
                #l -
                    #previous
                #l 20
                    #list 10 lines around line 20
                #l 5,20
                #l ,20
                #l 5,
                #l func
                #l c.c
                #l c.c:12
                #l c.c:func
                #set listsize 5

                #p
                    #p x
                        #print value of variable x in current frame
                        #vars in other frames cannot be seen
                    #p x+1
                    #p x*2
                    #p func(1)
                    #p array
                    #p array[3]@5
                        #print 3 vals or array, starting at elem 5
                    #p myStruct
                    #p myStruct.key
                    #set print pretty

                    #format
                        #(gdb) p mychar    #default
                        #$33 = 65 'A'
                        #(gdb) p /o mychar #octal
                        #$34 = 0101
                        #(gdb) p /x mychar #hex
                        #$35 = 0x41
                        #(gdb) p /d mychar 
                        #$36 = 65
                        #(gdb) p /u mychar #unsigned decimal
                        #$37 = 65
                        #(gdb) p /t mychar #binary
                        #$38 = 1000001
                        #(gdb) p /f mychar #float
                        #$39 = 65
                        #(gdb) p /a mychar 
                        #$40 = 0x41
                    
                    #p &mychar
                        #addres of mychar
                        #p *(&mychar)

                    #pt x
                        #print type of var x

                #attach
                    #links to a running process

                #q
                    #quit

                #gdbinit
                    #~/.gdbinit
                    #somedir/.gdbinit

        ##profiling

            ##time

                time ./a.out

                #profiles a.out.
                #bash builtin, different from /usr/bin/time
                #
                #real: wall clock time
                #user: program cpu time usage
                #sys: system call time used for program

                /usr/bin/time -f "\t%U user,\t%S system,\t%x status" test.py
                    #time without path is the bash built-in
                    #does memorym iom etc profiles besides time profiles
            
            ##gprof
            
                #part of `binutils` package
                
                #shows time spent into each call of individual functions
                #also shows average times per function
                #sorts from most to least time consuming

                #you could get all those infos from <time.h> clock() func
                #but this automates all for you in the case you want to measure functions

                gcc -p -pg -c a.c -o a.o
                gcc -p -pg a.o -o a.out
                #generates extra profiling code for `prof` and `gprof` programs
                #must be used only both link and compile steps if separate

                ./a.out
                #will generate `gmon.out` with gprof data in *cur dir*, not bin dir 

                gprof a.out gmon.out
                #-b : remove large output explanation
                #-p : only flat profile
                #-pfunc1 : only flat profile of `func1`
                #-q : only call graph
                #-qfunc1 : only call graph for `func1`
    
    ##mingw
    
        #cross compile for windows
        
        #it seems gcc can't do this
        
        apt-cache search mingw

    ##fortran

        #gnu fortran 77:
            sudo aptitude install -y g77

        #gnu fortran 95:
            sudo aptitude install -y gfortran
    
    ##binutils package
    
        #utilities to view and modify compiled code

        ##ar

            #create .a archives from .o files
        
            ar rcs a.a a.o b.o

        ##nm
        
            #symbol table for object files
            
            nm a.o

        ##readelf
        
            #gets stored inside executable files
            #in a human readable way
        
            readelf -s liba.so
                #shows symtable (defined stuff) of elf .o or .so
            
            readelf -d a.out
                #shows dependencies of an executable (symbols and shared libs)

            readelf --relocs a.o
                #TODO ?
        
        ##elfedit
        
            #TODO

        ##objdump
        
            #see memory structure
            
            objdump --disassemble a.o
            objdump -h a.o

        ##size

            gcc -c a.c
            gcc a.o
            size a.out a.o
            #shows size of each memory part of a program
            #text : instructions
            #data : init and uinit data
            #dec and hex : size of executable in dec and hex

    ##pkg-config

        #info is contained in "$PKG_NAME.pc" files located mainly under:
            #/usr/share/pkgconfig/ 
            #/usr/lib/i386-linux-gnu/pkgconfig/
        
        #a part of program installation may be to put files there

        #usage in in a makefile:

            CFLAGS=$(shell pkg-config --cflags pkgname)
            LIBS=$(shell pkg-config --libs pkgname)

    ##strace
    
        #list system calls made by executable
        
        #includes calls that load program

        echo '#include <stdio.h>
int main(void)
{ printf("hello"); return 0; }' > a.c
        gcc a.c
        strace ./a.out

    ##editors ides

        ##eclipse

            #sudo aptitude install -y eclipse
                #problems with cdt tools

            #MANUAL: install plugins.

            #must be root for those operations so
            gksudo eclipse

            #Help > Install new software > Availabe software sources > Check every single case there!
            #Help > Install new software > New sources

            #add vim like editing to eclipse
            #http://vrapper.sourceforge.net/update-site/stable

            #add eclipe functionality to vim
            #http://vrapper.sourceforge.net/update-site/stable

            #color themes

            #http://eclipse-color-theme.github.com/update
            #	mine: http://www.eclipsecolorthemes.org/?view=theme&id=7915
            #to install: File > Import > Preferences > Select *.epf (Eclipse menus are SO unintuitive...)

            #c and c++
            #http://download.eclipse.org/tools/cdt/releases/indigo/

            #python
            #http://pydev.org/updates

            #html, javascript, php
            #http://download.eclipse.org/webtools/repository/indigo/

            #latex
            #http://texlipse.sourceforge.net
            #forward search to okular: 
            #   
            #
            #inverse search from okular: Settings > Configure Okular > Editor
            #  Editor: custom text editor,
            #  Command: gvim --remote +%l %f 

        ##vim

            sudo aptitude install -y vim
            sudo aptitude install -y vim-gtk
                #gvim, runs outside command line
                #and thus gets around many command line limitations such as reserved shortcuts

    ##version control

        ##git

            #see </git>

        ##mercurial subversion
            
            sudo aptutide install -y mercurial

        ##svn subversion

            sudo aptitude install -y subversion

    ##diff

        ##diff
        
            #compare files *and* directory contents

            #files
                echo -e "0\na\n1\n2\n3\n4\n5" > a
                echo -e "0\n1\n2\nb\n3\n5" > b
                nl a
                nl b

                diff a b

                diff -u a b
                #gitlike diff (unified format)

            #directories

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
        
    ##exuberant-ctags

        #generate tags for given file

        #this makes it possible for external applications to find symbols defined in this file
        #such as functions, variables, macros, etc

        #supports 55 languages

        sudo aptitude install -y exuberant-ctags

        exuberant-ctags a.c
        less tags

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
            #useractions
            #give shortcuts to useractions

        sudo aptitude install -y krusader
        sudo aptitude install -y konqueror #needs to manage bookmarks. (otherwise, button does nothing)
        sudo aptitude install -y konsole   #needs to terminal emulator. (otherwise, button does nothing)

    ##filezilla

        sudo aptitude install -y filezilla

##game

    ##getdeb

        #non launchapd ppa with lots of good games.

            wget -q -O - http://archive.getdeb.net/getdeb-archive.key | sudo apt-key add -
            sudo sh -c 'echo "deb http://archive.getdeb.net/ubuntu quantal-getdeb games" > /etc/apt/sources.list.d/getdeb.list'
            sudo aptitude update

        ##urban terror

            #my favorite linux free fps so far

            #cs like, but mostly capture the flag.

            #good inertia, not too fast.

            #free but closed source

                sudo aptitude install urbanterror

        ##world of padman

            #fps, very large scenarios, cool weaponsmoves

            #but too fast for my taste.

            #sudo aptitude install worldofpadman

        ##world of padman

            #fps, too fast for my taste

        ##wolfenstein

            #fps, ww2

            #too fast for my taste.

    ##console

        ##fortune
    
            #tells you fortune to stdout!

            sudo aptitude install -y fortune
            
            fortune
            fortune

        ##cowsay
        
            #an ascii art cow echoes stdin

            sudo aptitude install -y cowsay
            
            fortune | cowsay
            fortune | cowsay

        ##moon-buggy
        
            #simple, jump over obstacles

            moon-buggy

        ##robotfindskitten
        
            #cute!

            sudo aptitude install -y robotfindskitten

            robotfindskitten
    
        sudo aptitude install -y nethack-console
            #nethack dungeon rpg
        
        ##bsdgames
    
            #lots of console games/cute apps
            
            #highly recommened
            
            sudo aptitude install -y bsdgames
            
            afsh bsdgames | grep /usr/games/
                #get a list

            ##battlestar
                #MUD

            ##backgammon
            
            ##number
            
                #convert number in numerals to number in english
                
                assert [ `echo 1 | number` = "one." ]

            ##pom
            
                #displays the phase of the moon
        
            ##primes
            
                primes 1 100
                    #prints primes numbers between 1 to 100

                primes 1 100 | wc -l
                    #count primes

            ##robots
            
                #simple, fun, a bit too much luck
                    
                #play:
                    robots

                #play with better settings:
                    alias robots="robots -ta`for i in {1..10000}; do echo -n n; done`"

            ##atc
            
                #nice timing memory
                
                #E1 A0
                    #plane E1, will land at airport 0
                #e
                
                    atc

                #list scenarios and leave:
                    atc -l

                #play a scenario:
                    atc -g crossover

                #cannot pause...

            ##hack
                
                #nethack predecessor
                
                hack

            ##hunt
            
                #multiplayer shooter
                
                #looks *very* promissing, but multiplayer only...
        
        ##greed
            
            sudo aptitude install -y greed

        ##ninvaders

            sudo aptitude install -y ninvaders

    ##netreck
    
        #2d plane classic

        sudo aptitude install -y netrek-client-cow

    ##urban terror

        sudo aptitude install -y urban-terror
            #counter strike clone 

    ##golly

        #conways game of life simulator

        sudo aptitude install -y golly

        env UBUNTU_MENUPROXY=0 golly 
            #because the global menu does not work

    gnomine
        #minesweeper clone

    ##gnotski

        #knotski clone

        sudo aptitude install -y gnotski

        gnotski

    ##dosbox
    
        #some good games there
        
        sudo aptitude install -y dosbox
        cd
        mkdir dos
        dosbox game.exe
            #there are also `.bat` and `.com` executables

        ##inside the emulator
        
            mount c /home/$USER/dos
            c:
            dir
                #ls
            cd game
            game.exe
                #.exe and .bat are the extensions
        
        ##avoid mouting every time
        
            echo -e "mount c /home/$USER/dos\nc:" >> ~/.dosbox/dosbox-*.conf
                #should be under the [autoexec] section
        
        ##get the sound working
        
            #TODO 0

            sudo aptitude install -y pmidi
            pmidi -l
            vim ~/.dosbox/dosbox-*.conf
            #put the port in:
                #[midi]
                #midiconfig=14:0

##time date

    ##cal
    
        #cout a calendar!!!

        cal

    ##date
        sudo date
            #get system date

        sudo date -s "1 JUN 2012 09:30:00"
        #set system date

        TIMESTAMP=`date +%Y-%m-%d-%H-%M-%S`

    ##hwclock

        sudo hwclock --show
        #see hardware clock

        sudo hwclock --systohc
        #sync hardware clock to system clock

    ##set you time zone

        #on dual boot with windows there are conflicts because Windows uses local time, and Linux UTC (more logical...). you must either tell Linux to use local, or better, Windows to use UTC
        $TIMEZONE_LOCATION=/usr/share/zoneinfo
        cd $TIMEZONE_LOCATION
        ls
        $TIMEZONE_NAME=
        cp $TIMEZONE_LOCATION/$TIMEZONE_NAME /etc/localtime

##libreoffice

    sudo aptitude install -y libreoffice-base

##text

    ##echo

        #posix 7

        #print to stdout:

            assert [ "`echo a`" = $'a' ]

        #appends newline
        
        #-n: no final newline:
            echo -n a

        #prints all given arguments, space separated:

            assert [ "`echo a b c`" = "a b c" ]

        #does not interpret \ escaped chars:

            assert [ "`echo 'a\nb'`" = $'a\\nb' ]

        #-e: interprets \ escaped chars:

            assert [ "`echo -e 'a\nb'`" = $'a\nb' ]

        #print the `-n` string:

        #IMPOSSIBLE! not even gnu echo supports `--`. =) use `printf`.

    ##printf

        #posix 7

        #removes echo quicks

        #supports c format strings:

            assert [ "`printf "%1.2d" 1`"       == "01" ]
            assert [ "`printf "%1.2f" 1.23`"    == "1.23" ]

        #print the `-n` string:

            assert [ "`printf "%s" "-n"`" == "-n" ]

    ##grep

        #posix 7

        #select lines from stdin or files
        
        #dont use egrep and fgrep variations,
        #which are useless and deprecated

        echo $'a\nb' | grep a
        echo $'a\nb' > f
        grep a f
            #a
        
        echo $'A\nB' | grep -i a
            #A
            #-i: case insensitive
        
        ##invert
        
            echo $'ab\ncd' | grep -v a
                #cd
                #-v: invert. print lines that don't match.
            
            ##application

                #remove line from file
                
                f=
                l="^$"
                tmp="`mktemp`"
                grep -v "$l" "$f" > "$tmp"
                mv "$tmp" "$f"
        
        ##exit status
        
            echo a | grep b || echo 1
                #1
            echo -q a | grep a && echo 0
                #0
                #-q: suppress stdout
                    #useful if you only want the exit status
            
            ##application
            
                #append line to file
                #if it is not there already
                
                    f=""
                    l=""
                    grep -q "^$l$" "$f" || echo "$l" >> "$f"

                #very useful for files that have unordered
                #sets of things separated by newlines
        
        echo $'a\na' | grep -c a
            #2
            #-c: count lines that match

        ##or
        
            echo $'a\nb' | grep -e 'a' -e 'b'
                #-e: multiple criteria or
                #patters are BRE
            echo $'a\nb' | grep -E -e 'a' -e 'b'
                #patters are ERE
            echo $'a\nb' | grep -F $'a\nb'
                #multiple searche, separated by newline
                #or
                #literal match
        
        ##regexp
        
            #grep can use POSIX BRE and POSIX ERE
            
            #don't forget: BRE is deprecated

            #perl regexp is non POSIX
            
            #see: <#extended regex>

            echo $'a\nb' | grep -E '(a|b)'

        ##-n
        
            #show matching line Numbers

        #-v
            
            #inVert selection: select non matching

        ##gnu grep
        
            #non posix, so be warned

            ##-r
            
                #recurse, print filenames. *VERY* tempting... no more `find . -type f | xargs` !!
                
                    grep -r 'a'

            ##-A
            
                #also print n lines following the match
                
                #example:
                    assert [ "`echo $'a\nb' | grep -A1 a`" = $'a\nb' ]

                ##application

                    #get the nth line after matching line:
                        assert [ "`echo $'a\nb' | grep -A1 a | tail -n1`" = $'b' ]

                ##-B
                
                    #before
                    
                    assert [ "`echo $'a\nb' | grep -B1 b`" = $'a\nb' ]

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
    
        #coreutils package
    
        #factor a number into prime constituents
        
        assert [ "`factor 30`" = "30: 2 3 5" ]

    ##uniq

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

        #charwise text operations

        tr abc ABC
        #-s : replaces a by A and b by B and c by C

        tr -c abc d
        #-c : complement and replace. replaces all non abc chars by d

        tr -d abc
        #deletes abc

        tr -s a
        #replaces multiple consecutive 'a's by isngle a
        # aaaaa -> a

        tr a-z A-Z
        #to upper

        tr -cs "[:alpha:]" "\n"
        #replaces non alphanum by a newline

        tr -cd "[:print:]"
        #removes non printable chars

    ##cut
    
        #get columns from text databases
        
        #for more complex ops, consider <#awk>

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
    
        #count things
        
        #mnemonic: Word Count

        #posix 7

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

        head "$f"
            #shows 10 first lines of f

        head -n3 "$f"
            #shows 3 first lines of f

    ##tail

        tail "$f"
            #shows last 10 lines of f

        tail -n3 "$f"
            #shows last 3 lines of f
    
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

    ##dd

        #corutils package
    
        #TODO

    ##split

        #corutils package

        #split files into new smaller files of same size

        echo -n abc > f

        split -db1 f p
        split -dn3 f p

        assert [ `cat p00` = a ]
        assert [ `cat p01` = b ]
        assert [ `cat p02` = c ]

        #existing files are overwritten
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

    ##hexdump
    
        #view bytes in hexa

            echo abc | hexdump -C

        #-C : see bytes in hexadecimal
        #-n32 : only 32 bytes
        #-s32 : start at byte 32
        #-v: show duplicate lines
        #-e '1/1 " %02X"': format string

    ##od

        #posix 7

        #view bytes in octal

        od "$f"

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

            #consider using <#perl> instead of this
            
            #sed has only slightly better golfing than perl
        
        ##s command
        
            #substitute

            assert [ "`echo $'aba\ncd' | sed 's/a/b/'`" = $'bba\ncd' ]

            ##g modifier

                assert [ "`echo 'aba' | sed 's/a/b/g'`" = $'bbb' ]

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

        echo "touch a" | at -q b now
            #same, but with at you can change to any time
        
##hd

    #hard disk, mount partitions and filesystem

    ##du

        du -sh * | sort -hr
            #disk usage per file/dir
                #s: summarize: only for dirs in *
                #h: human readable: G, M, b
    
    ##paritions
        
        #you should unmount partitions before making change to them!

        ##df

            #show partitions, total and free space of each

            df -h
                #h: like `du -h`
            df -h | sort -hrk2
                #sort by total size
        
        ##parition devices
        
            #each hd gets a device
            
            #each partition gets a device
        
            #you can only have 4 primary partitions
            
            #each one can be divided into logical partitions
            
            #primary partitions get numbers from 1 to 4

            #logical partitions get numbers starting from 5
        
            ls -l /dev | grep -E ' (sd|hd)..?$'
                #hda
                #hda1
                #hda2
                #hda5
                #sdb
                #sdb1
                #sdb2
                #sdb3
                #hdc
                #hdc1
                #^^^^
                #1 23
                #1: partition type. hd: IDE (older). sb: SCSI (newer)
                #2: hard disk identifier.
                #3: parition number inside hard disk.
                #
                #example above:
                #3 hds: had, sdb and hdc
                    #1 and 3 are hd
                    #2 is sd
                #1 has 3 partitions
                #...
        
        ##label
        
            #an ext concept
            
            #determines the mount name for the partition
            
            #should be unique, but not sure this is enforced.
            
            ##e2label
            
                #get/set ext[234] label info

                sudo e2label /dev/sda7 
                sudo e2label /dev/sda new_label
                    #sets new label for partition
                
                #each partition may have a label up to 16 chars length.
                #if it does, th partition will get that name when mounted.
            
            ##list all labels:
            
                sudo blkid

        ##filesystem type
        
            ##ext[234]: linux today
                #on ext4, only one dir is created: lost+found
            ##ntfs: windows today
            ##nfat: dos
            
            #to find out types see: <#blkid> or <#lsblk>
            
        ##uuid
            
            #given when you create of format a partition
            
            #to view them, see <#blkid> or <#lsblk> or <#gparted>
        
        ##swap
            
            #used by os to store unused ram
            
            #should be as large as your ram more or less, or twice it.
            
            #can be shared by multiple os, since only one os can run at a time.
            
            sudo swapon /dev/sda7
                #tur swap on on partition /dev/sda7
            swapon -s
                #find the swap partition used on cur os
            
            sudo swapoff
                #disable swap partition
            
            sudo mkswap -U random /dev/sda7
                #make a swap partition on partition with random uuid
                #swap must be off

        ##blkid
        
            #get UUID, label and filesystem type for all partitions

            sudo blkid

        ##lsblk
        
            #list block devices (such as partitions)
            
            sudo lsblk -f
                #show filesystems (partitions) only
                #shows type, label and mountpoint
            sudo lsblk
                #lis all block devices.
                #to me, also lists `/dev/sr0`, my dvd.
            sudo lsblk -no UUID /dev/sda1
                #get UUID only

        ##/dev/disk
        
            #symliks to partition identifiers
            
            #allows you to get identifier info
            
            #if id no present, link not there

            cd /dev/disk/
            ls -l 
                #by-id
                #by-label
                #by-path
                #by-uuid

            ls -l by-id

        ##fdisk
        
            #format disk
            
            #better use <#gparted> if you have X11
            
            #edit partition table. does not create filesystems. for that see: <#mke2fs>
        
            #to view/edit partitions with interactive cli prompt interface
            
            #does not show labels and where partitions are mounted

            sudo fdisk -l /dev/sda
                #show partition table of hd
            sudo fdisk /dev/sda
                #view/edit partitions for hd sda

            #a primary parition that is split into logical paritions is called `extended`
            
            #logical partitions are limited to 16 scsi and 53 ide total.
            
            #interesting line:
                #255 heads, 63 sectors/track, 60801 cylinders, total 976773168 sectors
                #255 ^^^^^, 63 ^^^^^^^/^^^^^, 60801 ^^^^^^^^^, total 976773168 sectors
                #    1         2       3            4                                 
                # 
                #2: sector: smalles adressable memory in hd. you must get the whole sector at once.
                #4: defaults: rw, suid, dev, exec, auto, nouser, and async
                #
                #to understand, must see images:
                #
                #  <http://osr507doc.sco.com/en/HANDBOOK/hdi_dkinit.html>
                #  <http://en.wikipedia.org/wiki/Track_%28disk_drive%29>
        
        ##mke2fs
        
            #make ext[234] partitions

            #better use <#gparted> if you have X11

        ##gparted
        
            #gui to <#fdisk> + <#mke2fs>
            
            #really easy to use and informative

            sudo aptitude install -y gparted

            ##format an external hd
                #- erase partition table and create new one
                #- gpt seems to be a good choice of partition table type.
                #- create a partiion on the hd.
                #- ntfs seems to be best cross platform choice now.
                #- give a label. it will be mounted like that. I choose 300g for my 300 Gb hd.
                #- all ops are very quick!
    
    ##mount
    
        sudo mount /dev/sda1 /media/win/
            #mount /dev/sda1 on /media/win/
        
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

    ##umount

        sudo umount /media/win/
            #unmount what is on this dir

    ##/etc/fstab
        
        #source
            firefox http://www.tuxfiles.org/linuxhelp/fstab.html
            firefox https://wiki.archlinux.org/index.php/Fstab
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
        
            #<file system> <mount point>   <type>  <options>       <dump>  <pass>
            #1             2               3       4               5       6
            #1: identifier to the file system.
                #Ex:
                    #- /dev/sda1
                    #- UUID=ABCD1234ABCD1234
                    #- LABEL=mylabel
            #2: where it will get mounted.
                #On ubuntu: make a subdir of /media like /media/windows
                #This dir must exist before mount
                #and preferably be used only for mounting a single filesystem.
                #I don't think fstab can auto create/remove the missing dirs.
            #3: type. ext[234], ntfs, etc.
            #see sources for others.
            
            ##windows
                #use:
                umask=111,dmask=000 
                #this way, dirs will be 000 and files 666 (not executable)
                #see <#umask> to understand better
            
            ##dvd

                #mounting dvds/usbs is similar to mounting partitions:
                /dev/cdrom 	/media/dvd 	noauto 	ro 0 0
                #however if you use auto, you always get errors when the dvd is empty
                
                #it is best to use auto, because dvd can be of several formats.

    ##fuser

        fuser -m /dev/sdb1
            #which processes are keeping device busy
        
    ##fsck
    
        #check and repair linux filesystems

##system info

    ##uname
    
        uname -a
            #print all info uname has to give!

        #you can each isolated with other opts

    ##processor

        ##arch
        
            #architecture
            
            #subset of <#uname>
        
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

    ##kernel

        ##get version
        
            uname -r

            cat /proc/version

        ##sysctl

            #view/config kernel parameters at runtime
        
            sudo sysctl –a

        ##modules

            #.ko
                #extension used instead of .o
                #also contain module information
            
            #device drivers (programs that enables the computer to talk to hardware)
            #are one type of kernel modules
            
            #modules are loaded as object files
            #you can only use symbols defined by the kernel
            #list of them:
                cat /proc/kallsyms

            #note that this causes great possibility of name pollution
            #so choose names carefully!
            
            #modules share memory space with the rest of the kernel
            #this means that if a module segfaults, the kernel segfaults!
            
            #two devices can map to the same hardware!
            
            ##rings
            
                #x86 concept
            
                #programs can run in different rings
                
                #4 rings exist
                
                #linux uses 2:
                    #0: kernel mode
                    #3: user mode
    
            ##config files

                sudo ls /etc/modprobe.d
                #sudo ls /etc/modprobe.conf
                    #if file it gets read
                    #if dir, all files in dir get read

                sudo cat /etc/modules
                    #modules loaded at boot

            
            ##module-init-tools
            
                ##package version
                
                    #from any of the commands, --version
                    
                    modinfo --version
            
                #package that provides utilities
            
                ##lsmod
                    
                    #list loaded kernel modules
                    
                    #info taken from /proc/modules

                    lsmod
                        #cfg80211              175574  2 rtlwifi,mac80211
                        #^^^^^^^^              ^^^^^^  ^ ^^^^^^^,^^^^^^^^
                        #1                     2       3 4       5       
                        #1: name
                        #2: size
                        #3: numer of running instances
                        #4: depends on
                        #5: depends on

                        cat /proc/modules
                            #also contains two more columns:
                                #status: Live, Loading or Unloading
                                #memory offset: 0x129b0000

                ##moinfo
                
                    modinfo a.ko
                    modinfo a
                        #get info about a module
                
                ##insmod
                
                    #loads the module
                    #does not check for dependencies

                    sudo insmod
                
                ##modprobe

                    sudo modprobe -l
                        #lists available modules
                        #relative path to /lib/modules/VERSION/

                    sudo modprobe $m
                        #loads the module
                        #checks for dependencies
                    
                    sudo modprobe vmhgfs -o vm_hgfs
                        #load module under different name
                        #to avoid conflicts
                    
                    sudo modprobe -r $m
                        #remove module
            
                sudo depmod -a 
                    #chekc dependencies are ok

                m=a
                sudo rmmod $m
                    #get info about given .ko module file
                
            ##device drivers
            
                ls -l /dev
            
                #there are two types of devices: block and char
            
                    #crw-rw----  1 root tty       7,   1 Feb 25 09:29 vcs1
                    #^
                    #c: char
                    
                    #brw-rw----  1 root disk      8,   0 Feb 25 09:30 sda 
                    #^
                    #b: block
                    #this is my hd.
                    #each partition also gets a b file

                ##major minor numbers
                    
                    #crw-rw----  1 root tty       7,   1 Feb 25 09:29 vcs1
                    #                             ^    ^
                    #                             1    2
                    #1: major number. tells kernel which driver controls this file
                    #2: minor number. id of each hardware controlled by a
                    #   given driveer
                
                ##mknod
                
                    sudo mknod /dev/coffee c 12 2
                        #makes a char file, major number 12, minor number 2

    #distro name
    
        lsb_release -sc
        #precise
    
        #distro find
            cat /etc/*-release


    lsof | less
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
    
    ##performance

        ##free
        
            #ram and swap memory usage

            free -m
                #shows RAM and swap memory in Megabytes
                # -t totals at bottom
                # -sN : repeat every N seconds

        ##vmstat

            #memory, sway, io, cpu

            vmstat 1 100
            #run every 1s, 100 times

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

            sudo aptitude install -y sysstat
            #crontab -e
            #
            #paste:
            #*/5 * * * * root /usr/lib/sa/sa1 1 1

            sar -u
                #cpu usage

            sar –d
                #disk io stats

            sar -n DEV | more
            sar -n SOCK |more
                #network stats

    ##hardware info
    
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
            
                #
    
        cat /proc/cpuinfo
            #cpu info

        cat /proc/meminfo
            #mem info

        ##lspci

            sudo lspci

        ##hwinfo

            sudo aptitude install -y hwinfo

            hwinfo | less

##process

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

        pwdx $pid

    #$$
    
        #cur pid:
            echo $$

    ##sleep

        sleep 2
            #do nothing for 2 seconds

    ##wait

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

        #send signals to a process
        #not necessarily kill signal

        ps -A
        ID=
        kill $ID
            #send TERM signal
            #select by pid, found on ps for example

        jobs
        ID=
        kill $ID
            #select by jobid found on jobs

        kill -STOP $ID
            #stops process

        kill -CONT $ID
            #continues stopped process

    ##killall

        #kill all process by name
        
        #psmisc package

    ##top

        #ncurses constantly updated process list

        #h: help
        #f: field add/remove/sort
        #k: kill process
        #arrow keys: move view

        ##uptime

            #echo first line of <#top>

            #sample:
                #23:00:13 up 12:00,  3 users,  load average: 0.72, 0.66, 0.6
                #^^^^^^^^ up ^^^^^,  ^ users,  load average: ^^^^, ^^^^, ^^^
                #1           2       3                       4     5     6
                #
                #1: cur time
                #2: how long the system has been up for
                #3: how many users are logged
                #4: load average for past 1  minute
                #5:                       5  minute
                #6:                       15 minutes       

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
    
    ##nohup
        
        ##application
        
            #make a process that continues to run if calling bash dies
            #for example an X application!

            nohup firefox >/dev/null &
            exit
                #firefox still lives!
    
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
    
        #run command for at most n seconds
        
        #coreutils
    
        assert [ `timeout 3 bash -c 'for i in {1..2}; do echo $i; sleep 1; done'` = $'1\n2\n' ]
        assert [ `timeout 1 bash -c 'for i in {1..2}; do echo $i; sleep 1; done'` = $'1\n' ]
        
    ##nice

        #-20: highest priority
        # 20: lowest  priority
        #the nicest you are, the more you let others run!

        ps axl
            #ps with NI(CE) column

        nice -10 ./cmd 
            #set nice to 10

        sudo nice --10 ./cmd 
            #set nice to -10
            #only sudo can set negative nice

        renice 16 -p 13245
            #change priority of process

    ##flock

        #puts an advisory file lock on given file while a command executes

        touch a

        flock a sleep 5
    
    ##pstree
    
        #shows tree of which process invocates which
        
        #note how `init` is the parent of all processes

        #psmisc package
        
        pstree

    ##prtstat
    
        #TODO

    ##peekfd
    
        #TODO

    ##ipcs

        #list info on inter process communication facilities:
            #shared mem
            #semaphores
            #message queues
    
        ipcs

        ##ipcrm

            #remove ipc facility
    
    ##chroot
    
        #execute single command with new root
        
        ##application
        
            #you mounted another linux system
            
            #you want to try it out from bash, without rebooting
            
            sudo chroot /media/other_linux /bin/env -i \
                    HOME=/root                  \
                    TERM="$TERM"                \
                    PS1='\u:\w\$ '              \
                    PATH=/bin:/usr/bin:/sbin:/usr/sbin \
                ##1

                    #- -: regular file
                    #- d: dir
                    #- l: symlink (not for hardlink)
                    #- p: named pipe (fifo)
                    #- s: unix socket
                    #- c: character file
                    #- d: block device file

                    /bin/bash --login

            #`/bin/env` and `/bin/bash` must exist relavive to `/media/other_linux`
            
            #TODO check this and get asserts working =)

##files

    ##ls
        #POSIX
    
        #list files in dirs
        
        #posix 7

        ##-l

        #show lots of information:

            ls -l

        #sample output:

            #-rw-rw-r-- 1 ciro ciro    4 Feb 25 11:53 a
            #1          2 3    4       5 6            7

        #1) file permissions. See <#permissions>
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
        
            #config <#ls> colors

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

        cd dir
            #go to dir

        cd
        cd ~
            #goto home dir

        cd -
            #go back to last dir
            #only works once

        cd -lh
            #-a : (all) show hidden files
            #-h : human readable filesizes
            #-l : long. one per line, lots of data.

        #path for cd!
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

        #make a dir

        mkdir "$d"
            #make a dir
        mkdir -p "$d"
            #make a dir
            #no error if existant
        mkdir -m 1777 d
        assert [ `stat -c "%A" d` = 'drwxrwxrwt' ]
            #-m: mode (permissions)
    
    ##mv
        #POSIX
    
        #move or rename files
        
        touch a
        mv a b
        assert [ ! -f a ]
        assert [ -f b ]

        touch a
        mkdir d
        mv a d
        assert [ ! -f a ]
        assert [ -f d/a ]

        ##-b

            #make backup if dest exits
            
            #if backupt exists, it is lost
            
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

            #if backup exists, it gets overwritten
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

                mkdir c
                copy a c
                assert [ "`cat c/a`" = $'c/a' ]

            #if dest exists and is file, overwrite without asking!

                echo a > a
                echo b > b
                cp a b
                assert [ "`cat b`" = $'a' ]

        ##dir

            #must use recursive `-r`, even if dir is empty

                mkdir d
                if cp d d2; then assert false; fi
                cp -r d d2
                assert [ -d d2 ]

                echo a > d/a
                cp -r d d3
                assert [ "`cat a`" = $'a' ]

        ##symlink

            #default recursivelly follows symlink

            #with `-d` copies symlink

                echo a > a
                ln -s a b
                ln -s b c

                cp c d
                assert [ -f d ]
                assert [ "`cat a`" = $'a' ]

                cp -d c e
                assert [ -L d ]

            #does not work with `-r`. Probable rationale:

                #the only thing this could do is to copy dirs
                #and symlink files

                #but then why not do this with hardlinks?

        ##hardlink

                echo a > a
                cp -l a b
                ln -l a b
                assert [ "`stat -c '%i' a`" = "`stat -c '%i' b `" ]

            #with `r`, makes dirs, and hardlinks files:

                mkdir d
                touch d/a
                touch d/b
                cp -lr d e
                assert [ "`stat -c '%i' d/a`" = "`stat -c '%i' e/a `" ]
                assert [ "`stat -c '%i' d/b`" = "`stat -c '%i' e/b `" ]

    ##install
    
        #move and set: mode, ownership and groups
    
        #make all components of path:
        
            install -d a/b/c
            assert [ -d a ]
            assert [ -d a/b ]
            assert [ -d a/b/c ]

    ##rename

        rename -n 's/^([0-9]) /0$1 /g' *.mp3 
            #does not make changes to all .mp3 files

        rename 's/^([0-9]) /0$1 /g' *.mp3
            #makes changes

    ##cpio
    
        #TODO

        find . ! -iname '* - *' -type f -print | cpio -pvdumB './no author'
        #cfind selected files to destination, building and keeping their relative directory structure

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

        #see <#file permissions>
        
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

        #see: <#file permissions>

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

    ##links

        ##hard vs soft

            #TODO lazy

        ##ln

            #make hardlinks and symlinks

            #this can also be done with `cp`

            #hardlink:
                ln dest name

            #symlink files only:
                ln -s dest name

            #symlink dir:
                ln -ds dest name

            #note: if you give a relative destination,
            #the link will contain this relative destination.
            #to current link location. Ex:

                ln -s ../dest dest

            #absolute link:
                ln /full/path/to/dest dest

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

            #prefer <#readlink> which is more widespread by default in distros

            sudo aptitude install -y realpath

            mkdir a
            ln -s a b
            cd a
            touch a
            ln -s a b
            cd ..
            realpath ./b/b
                #= "`pwd`/a/a"

            #readlink -f

                #same:

                    readlink ./b/b

                #and is part of coreutils, so more widespread default.
    
    ##cmp 

        cmp "$F" "$G"
        #compares F and G byte by byte, until first difference
        #if equal, print nothing
            #else, print location of first difference
        
        ##-s

            #silent
            
            #return status 0 if equal
            #!= 0 otherwise

                cmp -s "$F" "$G"
                if [ $? -eq 1 ]; then
                        echo neq
                else
                        echo eq
                fi

    ##find

        #recursivelly looks for files and dirs that match tons of possible criteria

        #prints filenames to stdout, or do some few other actions

        #great for combo with <#xargs>

        #consider <#ack> instead when for searching code

        ##preparation

            touch a b

        ##matching criteria

            ##-name
            
                #*entire* basename matches shell glob expression

                ##-iname
                
                    #case insensitive

                ##applications

                    #find by extension and act upon:

                        find . -type f -name '*.sh' | xargs cat

            ##-type
            
                #f for files only, d for directories only

                    find . -type f
                    find . -type d

            ##-perm

                #permissions

                #mass permission changing!

                #exact match:
                    find . -perm 444
                    find . -perm u+4,g+4,o+4

                #any one matches:

                    find . -perm +111

                #finds files that are readable by either u, g or o.

                ##applications

                    #give `g+x` to all files that have `u+x`:

                      find . -type f -perm +100 | xargs chmod g+x

            #-regex: entire basename matches emacs regex

        ##actions

            ##delete

                #deletes matching files

                    #find . -delete

                #very dangerous!

            ##printf

                #print formated data about files instead of filename

                #%p	filename, including name(s) of directory the file is in
                #%m	permissions of file, displayed in octal.
                #%f	displays the filename, no directory names are included
                #%g	name of the group the file belongs to.
                #%h	display name of directory file is in, filename isn't included.
                #%u	username of the owner of the file

                    find . -printf '%f'

        ##take multiple actions

            #this is the way to go:

                while IFS= read -r -u3 -d '' FILE; do
                    echo "$FILE"
                done 3< <(find . -type f -print0)

            #the only thing tha breaks this is having programs that use 3<. godlike

            #this reverses find order of the find output, allowing you to rename directories also (with this, directories)
            #will come last and be renamed last. -r is for 'reverse, and -z is for null terminated

                while IFS= read -r -u3 -d $'\0' FILE; do
                    echo "$FILE"
                done 3< <(find /tmp -type f -print0 | sort -rz)

        ##xargs

            #posix 7

            #do some command on lots of files.

            #great for combo with <#find>.

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
        
        #this uses a database, which must be updated with <#updatedb> before your new file is found
        
        #commonly, `updatedb` is a <#cronjob>
        
        locate a.h

        ##updatedb
        
            sudo updatedb
    
    ##file
    
        #determine file type
        
        #posix 7

        #this is in general impossible,
        #but program makes good guesses
        
        echo a > a
        file a
            #a: ASCII text
        
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

        which ls
            #/bin/ls
        which im-not-in-path
            #
        which im-not-executable
            #
        which cd
            #
            #cd is not a program! it is a bash builtin!
        
        ##application

            #quick and dirty install if not installed!

                if [ -z "`which zenity`" ]; then
                        sudo aptitude install zenity
                fi

    ##temp

        ##mktemp

            f="$(mktemp)"
            echo "$f"
            assert test -f "$f"
            rm "$f"
                #creates a temporary file and returs its name

            d="$(mktemp -d)"
            assert test -d "$d"
            rm -r "$d"
                #dir instead of file
    
    ##pathchk
    
        #check if path is portable across posix systems
        
        pathchk -p 'a'
        pathchk -p '\'

    ##dirs

        #move between dirs in stack

        dirs
            #show dir stack
            # -v : verbose. one per line, with line numbers

        pushd .
            #push to dir stack

        popd
            #pop fro dir stack and cd to it

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

##users and groups

    #to play around with those in ubuntu, do ctrl+alt+f2, f3 ... f7
    #and you will go into login shells
    #so you can log with different users at the same time
    #while logged on a different shell, process on the other shells continue to run? TODO
        #totem stops
        #simple shell scripts continue

##setterm

    #outputs stdout that changes terminal properties

    #turns the cursor on/off:

        setterm -cursor off
        setterm -cursor on

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
        #can only be used on login shell
    
        logout

    ##faillog
        
        faillog -a
            #TODO understand output

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

##networking

    ##sources
        
        #<http://www.aboutdebian.com/network.htm>
    
    ##host concept
    
        #any computer connected to a network 
        
        #can be specified by
        
        #- an IP or by
        #- a string that will be resolved by a dns server to an ip

        ##host user pair

            #a user may access a (system) computer from a nother computer using for example <#ssh>
            
            #to do so, he must be registered in the target computer.
            
            #this is why user/host pairs are common: the host pair says from which computer
            #user is trying to access his account.

        ##hostname
        
            #an alias for you ip
            
            ##hostname

                echo $HOSTNAME
                hostname
                    #print hostname
                    #if in command prompt: `ciro@ciro-Thinkpad-T430`
                    #hostname is `ciro-Thinkpad-T430`

                h=
                sudo hostname "$h"
                    #change hostname for cur session
                    #prompt is not changed immediatelly
        
            ##host command
            
                #get ips for a given hostname
            
                host www.google.com
                host $HOSTNAME
            
            ##lan
            
                #on your lan, people can use that alias to communicate between computers
                
                ##example
                
                    ping $HOSTNAME
                    firefox $HOSTNAME
                        #if you have a server like apache running

                    #all the commands work equally if you give ips
                    #
                    #shows your apache index if you are running one
                    #
                    #this will work from other computers in the lan
                    #
                    #TODO if many people set up the same hostname, then what?
                
                ##change hostname permanently

                    h=
                    echo "$h" | sudo tee /etc/hostname
                    
                    ##windows
                    
                        #host is reffered to as "computer name". good name choice.
                
                        wmic computersystem where name="%COMPUTERNAME%" call rename name="NEW-NAME" 

            ##wan
            
                #on the internet, hotnames are resolved to ips by DNS servers
                
                #you must pay for hostnames to use them

    ##routers

        ##routing table
            
            ##advantages

                #- local requests don't go out
                #- you can block all forbidden websites and services on a single computer
        
            #great lan routing example: <http://en.wikipedia.org/wiki/Default_gateway>
            
            #note:
            
            #routing tables say: if the request should go to a given network, send it to a given interface
            
            #0.0.0.0 is the default if no other is found
            
            #routers have two interfaes each: inside and outside

        ##external vs internal ip

            #if you use a router, all computers behind the router have a single external ip seen
            #you have an external ip seen on the web and an internal ip seen on the private
            #local network (lan)
                
            curl http://ipecho.net/plain
            curl ifconfig.me
                #get external ip

            ifconfig | grep -B1 "inet addr" | awk '{ if ( $1 == "inet" ) { print $2 } else if ( $2 == "Link" ) { printf "%s:" ,$1 } }' | awk -F: '{ print $1 ": " $3 }'
                #internal adresses for current computer
                #different ones for wireless and for wired connections
            
            #computers in the network only talk to the router.
            #the server on the router is called **proxy server**.
    
        ##internal ip ranges
        
            #3 ip ranges are reserved for internal ips
            #they are called class [ABC]
            #if your address is in those ranges,
            #the routers proxy server knows it is an internal one you are asking about
            
            #most common home range is the Class C:
            
            #192.168.0.1 through 192.168.255.254
            #subnet mask 255.255.255.0

        ##subnet mask
            
            ##get mask for an interface:
            
                ifconfig wlan0 | sed -nr 's/.*Mask:([^ ]*)/\1/p'
        
            #internal ips have two parts: network and computer
            
            #the length of the network part may vary between networks
            
            #the length is given by the **subnet mask**, ex:
            
            #255.255.255.0
            #1111.1111.1111.0000
            
            #means that 12 first bits are network
            
            #255.255.0.0
            
            #means that 8 first bits are network
            
            #all computers in the same network must have the same subnet mask and the same 
            #network part, but different computer parts.
            
            #each network (formally **network segment**) is run by a single router #TODO confirm
        
        ##special adresses

            ##network address
                
                #aka #<zero address>
            
                ##sources

                    #<http://serverfault.com/questions/135267/what-is-the-network-address-x-x-x-0-used-for>
            
                #the last bytes 0 is reserved
                
                #it is used to refer to the network itself
                
                #it is used when several networks, one one a different router must speak to each other

            ##default gateway
                
                #0.0.0.0 network address in the routing table
                
                #if no network matches request, sends to this network
            
                #address you get automatically redirected to by reuter if the address you gave cannot be found
                
                ##get
                
                    route -n | awk '{ if( $1 ~ "0.0.0.0" ) print $2 }'

                    firefox `route -n | awk '{ if( $1 ~ "0.0.0.0" ) print $2 }'`
                        #go into the router configuration
        
            ##broadcast address
                
                #for the last bytes, 255 is reserved
                
                #the broadcast address means talking to all computers on a given network at once
                #instead of a single computer
                
                ##ex
                
                    ##Class C
                    
                        #- network part: 192.168.3

                            #broadcast is: 192.168.3.255

                        #- network part: 192.168.234

                            #broadcast is: 192.168.3.255

                    ##Class A
                
                        #- network part: 10

                            #broadcast is: 10.255.255.255
            
            ##.1
            
                #.1 is not special, but in home networks is often already taken by the router's inner interface
                
                #this is why your addresses may start at .2
    
        ##NIC

            #Network Interface Cards
            
            #hardware that does netowrk communication
            
            #come mostly built-in the motherboard today
            
            #each router has 2 NICs: one external and one internal.
            
            ##get all interface names
            
                ifconfig | perl -ne '/^(\S+)/ && print $1 . "\n"'
        
        ##MAC
        
            #unchangeable address of each NIC
            
            #unique across and within vendors
            
            #6 bytes: first 3 identify vendor, last 3 product
            
            #colon separated notation. Ex: `0C:21:B8:47:5F:96`
        
            ##aka
            
                #physical address
                
                #hardware address

                #media access control address
            
                #BIA: burnt in address
            
            ##get MAC addresses of my computer

                ifconfig | sed -nr 's/([^ ]*) .*HWaddr (.*)/\1 \2/p' 

            ##get MAC addresses of computers i talked to in the lan
            
                timeout 3 ping 192.168.1.3; arp -a | sed -nr 's/([^ ]*) .*at (.*)/\1 \2/p'

    ##/etc/hosts

        #tells your computer  where to redirect the given names
        
        #big downside: you have to have one of this file on every pc
        
        #therfore, use <#dns> instead
    
        cat /etc/hosts
        
        echo "127.0.0.1 www.wikipedia.org" | sudo -a /etc/hosts
        firefox www.wikipedia.org &
            #you see your localhost apache if it is running there
        sudo sed -i "$ d" /etc/hosts

        ##windows
        
            #the file is:
            
            C:\Windows\System32\Drivers\Etc\hosts

    ##dns
    
        #domain name system
        
        #convert strings into ips
        
    ##ifconfig
    
        #network InterFace configuration
        
        #includes stuff like IPs, subnet masks, MAC, etc

        #<http://www.thegeekstuff.com/2009/03/ifconfig-7-examples-to-configure-network-interface/>

        ifconfig
            #eth0  wired network 0
            #wlan0 wifi card 0
            #lo    loopback (local host)
        
        ifconfig | grep -B1 "inet addr" | awk '{ if ( $1 == "inet" ) { print $2 } else if ( $2 == "Link" ) { printf "%s:" ,$1 } }' | awk -F: '{ print $1 ": " $3 }'
            #get local ips (behind router)
            #wlan0 and eth0 give different results

    ##iwconfig
    
        #wireless network configuration

    ##ping 

        #sends an recieves data, measuring round trip, several times

        #main tool used to test connectivity
        
        #in online games, ping means the go and return time of the signal

        ping google.com
    
    ##arp

        #shows info of computers you connected to

        timeout 3 ping 192.168.1.3; arp -a

    ##route
    
        #view kernel routing table
        
        route

        route -n
            #numeric instead of names

    ##whois
    
        sudo aptitude install -y whois

        whois 201.81.160.156
            #check info about ip (country and ISP included)

        whois `curl ifconfig.me`

    ##wget

        #for recursive down only, for the rest, curl it

        u=
        wget -E -k -l inf -np -p -r $u
            #make local version of site
        wget -R *.pdf -R *.zip -R *.rar -E -k -l inf -np -p -r $u
            #don't take pdfs, zips and rars
        wget -A *.html -A *.css -A *.php -A *.gif -A *.png -A *.jpg -E -k -l inf -np -p -r $u
            #only take, html, css, and images

        wget -r -np -nH -A.au,.mp3 $u
            #get all files of a given types

        #-E --adjust-extension
            #converts for example `*.php?key=val` pages to `.php?key=val.html`
            #while keeping `*.css` extension untouched
        #--cut-dirs=2 : similar to -nd, but only does nd up to given level
        #-k : convert links to local if local has been downloaded
        #-l 5 : -r depth
            #-l inf
        #-m : mirror options. same as "-r -N -l inf --no-remove-listing"
        #-nd : dont make sub directories, even if they existed on original site
        #-np : dont recurse into parent dirs
        #-nH : dont make a dir structure starting at host
            #default: `wget http://www.abc.com/a/b/c`
            #creates: www.abc.com/a/b/c file structure.
            #
            #`wget -nH http://www.abc.com/a/b/c`
            #creates only : a/b/c
        #-p : page requesites : css, images
        #-r : follow links on page and downloads them
            #default max depth of 5
            #-L : follow relative links only
        #--user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.0.3) Gecko/2008092416 Firefox/3.0.3"
        #-A : accept patterns.
            #if *, ? or [] appear on expression, matches basename only
            #else, suffix (.mp3 will work)
            #-R : reject, opposite of A
            #-X : exclude dir
            #-I : include dir
        #-N : timestamping. only down if newer than already downloaded

    ##curl
    
        #does several web protocols
        
        #only use <#wget> for recursive mirroring

        sudo aptitude install -y curl

        #make GET request, reponse body to stdout:
            curl amazon.com

        ##-d

            #makes POST request
                curl -Ld "q=asdf" $URL
                curl -L "google.com?q=asdf" $URL

            ##--data-urlencode
            #encodes spaces and other signs for you:
                curl -d               "name=I%20am%20Ciro" $URL
                curl --data-urlencode "name=I am Ciro"     $URL

        curl -C - -O http://www.gnu.org/software/gettext/manual/gettext.html
        #resume download from where it stopped

        ##a-z range
        
            #example:
                curl ftp://ftp.uk.debian.org/debian/pool/main/[a-z]/

        ##protocols

            ##ftp

                #download:
                    curl -u ftpuser:ftppass -O ftp://ftp_server/public_html/xss.php

                #upload:
                    curl -u ftpuser:ftppass -T myfile.txt ftp://ftp.testserver.com
                    curl -u ftpuser:ftppass -T "{file1,file2}" ftp://ftp.testserver.com

            ##mail

                #send mail:
                    echo $'sent by curl!\n.' | curl --mail-from user@gmail.com --mail-rcpt user@gmail.com smtp://gmail.com
                #body ends with a single dot '.' on a line

            ##dict

                curl dict://dict.org/show:db #dictionnaries
                curl dict://dict.org/d:bash #general
                curl dict://dict.org/d:bash:foldoc #computing

        #-v , --trace $FILE, --trace-ascii $FILE: increasing levels of output showing
        
            curl -Lv google.com

        ##-L
        
            #follows redirects

            #ommits redirect page if any:
                curl google.pn
                curl -L google.pn
            #good example if you are not one of the 100 people who live in Pitcairn island.
            #google redirects you to your country domain.
            
            #with `-v` you can see the full transaction:
                curl -vL google.pn

        ##-u user:pass

            #does <#basic authentication>

            #`--digest` and `--ntlm` can be used together

            #if no `:pass`, will ask for pass on command line.

            #examples:
                curl          -u user:pass site.with.basic.auth.com
                curl --digest -u user:pass site.with.digest.auth.com

        ##-x
        
            #specifies proxy server
            
            #example:
                curl -x proxysever.test.com:3128
        
        ##-z
        
            #download iff it is modified after given date time (sounds like crawlers!)
        
            #example:
                curl -z 01-Jan-00 google.com
            #I assure you, it has changed since then =).

        ##-i
        
            #show received http header received. see: <#http>
        
            #example:
                curl -i google.com

        ##-I
        
            #make http HEAD request. see: <#http>
            
            #implies `-i` of course
            
            #example:
                curl -I google.com

        ##-X
        
            #make custom request
            
            #example:
                curl -X $'GET / HTTP/1.1\n\n' google.com
    
    ##md5sum
    
        #generates/checks md5 checksums
    
        echo a > a
        echo b > b
        md5sum a b > f
        cat f
            #60b725f10c9c85c70d97880dfe8191b3  a
            #3b5d5c3712955042212316173ccf37be  b
        md5sum -c f
            #a: OK
            #b: OK
            #checks checksums on current dir

        ##application:
        
            #have I downloaded the right file?
            
            #it is *very* difficult to make another file
            #with the same checksum
    
    ##base64
        
        #-d to decode:
            assert [ "`echo abc | base64 | base64 -d`" = abc ]
        
        #to understand see wiki: <http://en.wikipedia.org/wiki/Base64#Examples>
        
        ##application
        
            #transforms binary data which may contain non printable bytes like 0
            #into data that contain only printed bytes.
            
            #this makes it easier for humans input the data
            
            #tradeoff: data gets larger
        
            ##why 64?
            
                #there are 64 printable chars, but not 128.
            
            ##alternative
            
                #use base 16. Much easier for humans, but data gets much larger.
    
    ##ifup
    
        #TODO
        
        ##/etc/network/interfaces
        
            ##manual

                    man interfaces
        
            ##set static ip
            
                #on a home network that you control,
                #it is better to use intuitive hostnames
                #and let the addresses be dynamic,
                #unless some app really requires you
                #to enter ips.
                #see: <#hostname> for how.

                    sudo vim /etc/network/interfaces

                    auto lo wlan0 eth0

                    iface wlan0 inet static
                        address 192.168.1.100
                        netmask 255.255.255.0
                        broadcast 192.168.1.255
                        gateway 192.168.1.1

                #- auto if1 if2
                    #automatically create interfaces if1 and if2 on `ifup -a`

                #- iface if1
                    #from now on, define properties of if1

    ##nmap

        sudo aptitude install -y nmap
        nmap google.com
        #shows open ports at google.com
        #you are gonna get at least 80 for their http server

    ##netstat

        netstat -a
            #TODO understand crazy output

    ##telnet
    
        #protocol for comunicating between servers
        
        #no encryption, therefore *DONT'T SEND PASSWORDS ON UNTRUSTED NETWORK WITH THIS*!!

        #always use <#ssh> which is encrypted for anything even remotelly Pserious
        
        #the other computer must be running a telnet server

        #fun MUD games!
        
        #make http requests by hand for learning purposes:
            telnet google.com 80
        #type:
            GET / HTTP/1.0 <enter><enter>
        #you've made a get request by hand!
        
        #won;t work, why? 
            #echo $'GET / HTTP/1.0\n\n' | telnet www.google.com 80

    ##nc

        #open, listen, send and receive tcp/udp packages and sockets

        ##example

            #get apache working on port 80
            
            echo 'GET / HTTP/1.0' | nc google.com 80

    ##ssh
    
        #like <#telnet>, but encrypted
        
        #predominant implementation: OpenSSH

        sudo aptitude install -y openssh-client
        sudo aptitude install -y openssh-server
        
        man ssh
        man ssh_config

        ##server
        
            sudo cp /etc/ssh/ssh_config{,.bak}
            sudo vim /etc/ssh/ssh_config

            Host *                    #config for all hosts
                Port 22                 #open port 22
                AllowUsers user1 user2  #allow the given users
        
        ##client

            h=
            u=

            #get the version of you ssh:
            ssh -V

            #connect to hostname with your current username:
            ssh $h
            #for this to work you need:
                #your host (computer) is allowed. see <#ssh#server>
                #your user is allowed. see <#ssh#server>
                #your user exists in the server computer. see <#useradd>

            #connect to hostname with the given username:
            ssh $u@$h
            ssh -l $u $h

            #choose port:
            p=
            ssh -p $p $h

        ##usage

            #once you log in, it is as if you had a shell on the given ssh server computer!
            
            #you canno copy files between computer with ssh directly,
            #but you can use <#scp> or <#sftp> to do it
            
            #note how you appear on the who list:
            who
            
            #you cannot launch x11 programs:
            xeyes
                #Error: can't open display
            
            #to close your connection:
            logout
            #or hit <c-d>

        ##scp

            #cp with ssh encryption
            
            #get a file:
            p= #path to file
            d= #destination directory
            u=
            h=
            scp $u@$h:$p $d

            #send a file:
            scp $p $u@$h:$d

            #directories:
            scp -r $u@$h:$p
            #use -r

            #multiple files/dirs:
            scp -r $u@$h:"$p1" $u@$h:"$p2"
        
        ##sftp
        
            #similar to ftp, ssh encryption
    
    ##ftp
    
        #tcp/ip file transfer protocol
        
        #client: comes installed by default
        
        #install server:
            sudo aptitude install -y vsftpd
        #Very Secure FTP Deamon

        #list of free hosts: <http://freehosting1.net/free_ftp_hosting.aspx>

        #free hosts im inscribed in (so I don't forget):

        #- <http://freehostingnoads.net/>

            #2Gb      storage
            #2Gb      max file size
            #10Gb/mo  transfer
        
            #- <http://cirosantilli.t15.org/>

        #see all available commands:

            ?

        #connect:

            open ftp.domain.com

        #disconnect and but keep program open:

            bye

        #disconnect and exit program:

            bye

        #ls remote:

            ls

        #cd remote:

            cd

        #cd local:

            lcd

        #pwd remote:

            pwd

        #upload with same basename:

            put a

        #file a exists in current local dir

        #upload with different basename:

            put a b

        #download with same basename in current dir:

            get a

        #download with different basename in current dir:

            get a b

        #download on relative path:

            get d/a

        #subdir must exist locally

        #delete remote file:

            del a

        #create a remote directory:

            mkdir d

        #remove a remote directory:

            rm d

    ##cifs
    
        #TODO

        sudo aptitude install -y cifs-utils
    
    ##samba
    
        #open source linux implementation of the SMB/CIFS networking protocol
        #used by default on windows
    
        #it allows for file, printer and driver sharing on a network
        
        #best option for cross platform file transfers

        sudo aptitude install -y samba

    ##browser

        ##firefox
        
            #comes by default
            
            #search with default engine:
                firefox -search asdf

            #starts with disabled extensions in case they are causing a crash:
                firefox -safe-mode
    
        ##w3m
        
            #ncurses web broser!
            
            #might save you if x goes down
            
            sudo aptitude install -y w3m w3m-img

            w3m google.com

    ##sites
    
        #some random bookmarks
        
        firefox http://www.twiddla.com/1 &
            #draw on whiteboard
            #share with others
        firefox http://mathb.in
            #math pastebin
            #renders with mathjax
    
    ##files
    
        #TODO
    
        ##/etc/protocols
        
        ##/etc/services

        ##/etc/udev/rules.d/70-persistent-net.rules

    ##lamp

        #(Linux Apache + Mysqp + PHP)

        #sudo chown "$USER" /var/www/ #not sure it is safe, but good if you are on a test machine

        ##apache

                sudo aptitude install -y apache2

                #test apache:
                    firefox http://localhost/ &
            
            ##intro
            
                #apache is a web server
                
                #a web server listens to a port (default 80) for strings
                
                #theses strings are http requests
                
                #then it takes the http request, processes it, and then returns the request to the client
                
                #part of the processing may be passed to another program: typically a <#cgi> script

            ##test preparations
            
                #before doing anything, make this test dir:

                    mkdir test
                    cd test
                    echo '<html><body><h1>index.html</h1></body></html>' > index.html
                    echo '<html><body><h1>a.html</h1></body></html>' > a.html

                    mkdir a
                    cd a
                    echo '<html><body><h1>a/index.html</h1></body></html>' > index.html
                    echo '<html><body><h1>a/a.html</h1></body></html>' > a.html
                    cd ..

                    mkdir auth
                    cd auth
                    echo '<html><body><h1>auth/index.html</h1></body></html>' > index.html
                    echo '<html><body><h1>auth/a.html</h1></body></html>' > a.html
                    cd ..

                    mkdir noindex
                    cd noindex
                    echo '<html><body><h1>noindex/a.html</h1></body></html>' > a.html
                    echo '<html><body><h1>noindex/b.html</h1></body></html>' > b.html
                    cd ..

                    cd ../..
                
                #finally move our test dir to the serve root:
                    sudo mv test /var/www/

                #the default root for serving files is specified in the <#conf file>
                #by the `DocumentRoot` directive. In current ubuntu, it is `/var/www/`

                #the user under which the web server runs must have read access to this directory.
                
                #usually this user is a different user from `root` for sercurity.

            ##cut the conf file to the bare minimum

                #the bare minimum is:

                    Listen 80
                    User www-data
                    Group www-data
                    ErrorLog /var/log/apache2/error.log

                #this way you can really learn what is going on!
                
            ##default operation

                #"web subdirs" map directly to local dirs
                
                #ubuntu default is currently `/var/www/`
                
                #open file /var/www/test/index.html:
                    firefox localhost/test/index.html

                #going to a dir on the web browser opens the contained index.html file by default:
                    firefox localhost/test/
                #this can be configured with the <#DirectoryIndex> directive
                
                #if no index is contained, apache generates an html index:
                    firefox localhost/test/noindex/

            ##conf file

                #configurations only apply when you restart apache:
                    sudo service apache2 restart
                
                #move our test dir to the serve root:
                    sudo mv test /var/www/root

                #ubuntu default location:
                    sudo vim /etc/apache2/apache2.conf

                ##DocumentRoot

                    #set apache serve root at given dir:
                        DocumentRoot "/var/www/root"
                    #for this ot work, make sure `DocumentRoot` is not set anywhere else.
                    #(by default it was included in the include files, `grep -r DocumenRoot` shows where)

                    #for security concerns, only put things you want apache to serve directly inside DocumentRoot
                    #such as html, css and images.

                    #stuff that users should not see such as cgi scripts and *gasp* ssl certificates
                    #are better to remain outside it, so that you don't serve them by mistake!

                ##Listen

                    #listen those ports on all interfaces (for example, first wireless card, first ethernet card, etc...):

                        Listen 80
                        Listen 8000

                    #this configuration is mandatory

                #listen those ports on given interfaces:
                    Listen 192.0.2.1:80
                    Listen 192.0.2.5:8000

                #access filename:
                    AccessFileName .htaccess

                #allow overwride:
                    #TODO

                #include other files or entire dirs:
                    Include file.conf
                    Include conf-d

                #deny access from host
                    Deny from 10.252.46.165 
                    Deny from host.example.com

                ##DirectoryIndex

                    #what to do when user acesses a directory location:
                        DirectoryIndex index.html index.php /cgi-bin/index.pl 

                        #SAME:
                        DirectoryIndex index.html
                        DirectoryIndex index.php
                        DirectoryIndex /cgi-bin/index.pl 
                    #with this, for the entire site, first looks in order for:
                        #- `index.html`
                        #- `index.php`
                        #- `/cgi-bin/index.pl`
                    #note how you can specify a script outside of that dir

                    #in case none of those actions match, the default is for
                    #<#mod_autoindex> to generate an html directory listing

                    #for specific dirs, use the <#Directory> directive

                    ##mod_autoindex

                        #generates automatic html listings for dirs
                    
                        #turn off automatic listings for a given dir:
                            <Directory /var/www/root/test/dontlist>
                                Options -Indexes
                            </Directory>
                        #will simply give a not found

                        #ignore certain files in the listing:
                            IndexIgnore tmp* ..

                        #add headers/footers before/after index:
                            HeaderName header.html
                            ReadmeName footer.html

                        #same header/footer for every dir
                            HeaderName header.html
                            HeaderName /site/header.html
                            ReadmeName /site/footer.html

                        #use predefined styles:
                            IndexOptions FancyIndexing HTMLTable

                        #use given css style:
                            IndexStyleSheet /css/autoindex.css

            ##sections
            
                ##sources
                    
                    #official manual: <http://httpd.apache.org/docs/2.2/sections.html#mergin>
            
                ##Files

                    #acts on local filesystem

                    #deny file permissions for files that match regex "^\.ht":
                        <Files ~ "^\.ht">
                                Order allow,deny
                                Deny from all
                                Satisfy all
                        </Files>
                    #Order says: first process all allow directives, then all deny directives.
                    #since deny came last, it has precedence.

                ##Directory
                
                    #acts on local filesystem
                
                    <Directory /var/web/dir1>
                        Options +Indexes
                    </Directory> 

                ##combine
                
                    <Directory /var/web/dir1>
                        <Files private.html>
                            Order allow,deny
                            Deny from all
                        </Files>
                    </Directory> 

                ##Location
                
                    #acts on webspace

                    <LocationMatch ^/private>
                        Order Allow,Deny
                        Deny from all
                    </LocationMatch>
                    
                ##IfDefine
                    
                    <IfDefine ClosedForNow>
                        Redirect / http://otherserver.example.com/
                    </IfDefine> 

                ##IfVersion

                    <IfVersion >= 2.1>
                        # this happens only in versions greater or
                        # equal 2.1.0.
                    </IfVersion> 
            
            ##alias
            
                #you can create virtual paths to dirs and files
                
                ##sources
                
                    #man: <http://httpd.apache.org/docs/2.2/mod/mod_alias.html>
                
                #create virtual directory:

                    Alias /test/alias /var/www/test

                    firefox localhost/test/alias &

                #also works for subdirs:

                    firefox localhost/test/alias/a.html &
                    firefox localhost/test/alias/a      &

                #also works for files:

                    Alias /testfile/ /var/www/test/index.html

                    firefox localhost/testfile &

                #also works outside of serve root:
                
                    cd
                    echo "TEST" > index.html

                    Alias /test/alias-out-root/ /home/ciro/

                    firefox localhost/test/alias-out-root
                
                ##first match takes precedence

                        Alias /test/alias/a /var/www/test
                        Alias /test/alias   /var/www/test

                        firefox localhost/test/alias/  &
                            #test/index.html
                        firefox localhost/test/alias/a &
                            #test/a/index.html
                    
                    #BAD: both go to test/index.html:

                        Alias /test/alias   /var/www/test
                        Alias /test/alias/a /var/www/test

                        firefox localhost/test/alias/  &
                        firefox localhost/test/alias/a &
    
                ##Redirect
                
                    #precedence over aliases

                        Alias /test/redir /test
                        Redirect /test/redir http://www.google.com
                        firefox localhost/test/redir &
                            #goes to google
            
            ##http
            
                #best way to start: <http://www.jmarshall.com/easy/http/#structure>

                ##headers

                    ##Content-type

                        #specifies Internet media type
                        
                        #for huge list see: <http://en.wikipedia.org/wiki/Internet_media_type#Type_text>

                        #common examples:

                        #- text/html: browsers interprets body as html and renders it
                        #- text/plain: browser pastes to screen, no html rendering. So you will see tags like `<h1>` on screen.
                        #- text/css
                        #- application/pdf
                        #- application/javascript
                
                ##http authentication
                    
                    ##sources
                    
                        #goode one: <http://www.httpwatch.com/httpgallery/authentication/>
                        #comparison to form auth, nice diagrams: <http://docs.oracle.com/javaee/1.4/tutorial/doc/Security5.html>
                
                    ##form authentication
                    
                        #form authentication is the other form athentication
                        
                        ##sources
                        
                            #great post: <http://stackoverflow.com/questions/549/the-definitive-guide-to-forms-based-website-authentication>
                    
                        ##downsides of http
                        
                            #parameters are left to the browser. So for example:
                            #- the appearance of the login page
                            #- the time for which the user stays authenticated
                                #(time for which browser keeps resending user:pass automatically)
                            #therefore, you cannot cusomize them
                            #and users will get different interfaces on different browsers, bad user interface consistency
                        
                        ##updside of http
                        
                            #simple.
                        
                        #for those reasons, form authentication is used on most large sites today.
                
                    ##401

                        #server should include a `WWW-Authenticate` field specifying what kind of authentication is required.
                        
                        #try this with:
                            curl -I localhost/location/that/requires/auth

                        #I get for example:
                            WWW-Authenticate: Basic realm="AuthName value"
                        #so the type is Basic
                        #
                        #`AuthName value` is a any descriptive string
                        #set by the server operators.
                        #in Apache it is given by the `AuthName` directive
                
                        ##401 vs 403
                        
                            #<http://stackoverflow.com/questions/3297048/403-forbidden-vs-401-unauthorized-http-responses>
                    
                    ##basic authentication
                    
                        #authentication is sent on the header *unencrypted*!

                        #example:
                            curl -vu u:p google.com

                        #you see the header line:
                            Authorization: Basic dTpw
                            #              ^^^^^ ^^^^
                            #              1     2
                        #1: auth type
                        #2: base 64 of u:p. not encryption!!
                        
                        #just checking:
                            assert [ "`echo dTpw | base64 -d`" = "u:p" ]

                        ##url convention
                        
                            #many programs accept urls strings with user/pass included:
                                curl -v u:p@google.com

                            #this is however just a convention, since programs that accept it
                            #parse the string to extract the `u:p` part, and then send it
                            #on the header.

                    ##digest authentication
                    
                        #pretty cool concept

                        #see: <http://en.wikipedia.org/wiki/Digest_access_authentication
                    
                        #authentication is sent on the header md5 hashed
                            curl --digest -vu u:p google.com
                        
                        ##why it works

                            #data is appended to the authentication with `:` before hashing:
                            #- domain (www.google.com)
                            #- method (GET, POST, etc.)
                            #- nonce
                                #- nonce is sent to client from server.
                                #- *nonces can only be used once per client*!!
                                #- nonce prevents requests from being repeated with an old captured hashed string!
                                #- also increases the difficulty of cracking each user/pass
                            
                            #this way, the unknown user and pass get mixed up with the extra data
                            #in the hash and it is very hard to separate them.
                            #and the nonce makes sure requests cannot be remade by resending the hash.
                        
                        #merits:
                        #- simples than a full ssl to authenticate
                    
                    ##ntml
                    
                        #safer than digest: replay attacks impossible.
                        
                        #requires server state, so http 1.1 only.
                        
                        #little current support/usage.
                
                ##https
                
                    #assymetric key encryption between server and client.
                    
                    #encrypts both body and headers
                    
                    #downside: encrypt/decrypt costs time.
                    
                    #main usage: security critical operations such as authentication or payments.

                ##cgi
                
                    ##requires
                        
                        #<#http>
                
                    #**cgi** is a protocol of how a server communicates with a cgi script
                    
                    #a cgi script is simply a script/executable that outputs the part of http response
                    
                    #this part includes some last header lines which the server delegates to it,
                    #notably `content type`, followed by "\n\n" followed by the entire body.
                    
                    #the server passes information to the script through environment variables only.
                    
                    ##fastcgi
                    
                        #a faster version of cgi that does not start a new process pre request

                        #implementations: mod_fastcgi vs mod_fcgid
                        #<http://superuser.com/questions/228173/whats-the-difference-between-mod-fastcgi-and-mod-fcgid>
                        
                        #install mod_fastcgi:
                            sudo aptitude install -y libapache2-mod-fastcgi

                    ##ScriptAlias

                        #the script:
                            echo '#!/usr/bin/perl
print "Content-type: text/html";
    #first output line must be "Content-type: text/html\n\n"
#print "Status: 500  Internal Server Error"
print "\n\n"
print "<html><body><h1>environment</h1>"
    foreach $key (keys %ENV) {
    print "$key --> $ENV{$key}<br>";
}
print "</body></html>"
' > sudo tee /usr/lib/cgi-bin/test.pl
                            sudo chmod +x /usr/lib/cgi-bin/test.pl
                        
                        ##status 
                        
                            #optional, if not given suposes `200 OK`.

                            #if given as error, server will simply give the error and no data.

                            #uncomment the status line on the test script to see what happens.
                    
                        ##alias to dir
                        
                            #cgi scripts must be in the dir specified by script alias:

                                ScriptAlias /mycgi /usr/lib/cgi-bin

                            #same as:

                                Alias /mycgi /usr/lib/cgi-bin
                                <Location /mycti >
                                    #tell server that all files inside this dir are cgi scripts:
                                        SetHandler cgi-script
                                    #tell server that all .pl and .py files in dire are cgi scripts:
                                        AddHandler cgi-script .cgi .pl 
                                    #permit cgi execution for scripts in this dir:
                                        Options +ExecCGI
                                </Location> 

                            #run it:

                                firefox localhost/mycgi/test.pl

                            #note how `ScriptAlias` created a virtual directory
                            #not present in the actual filesystem.

                            #can also make individual script:

                                ScriptAlias /test/cgi-file /usr/lib/cgi-bin/test.pl

                        ##alias to script

                            #all subdirs of testpl are generated by the given test.pl:
                                
                                ScriptAlias /test/testpl /usr/lib/cgi-bin/test.pl

                                firefox localhost/testpl/       &
                                firefox localhost/testpl/a.html &

                    ##action

                        #run script whenever an html file is accessed:

                            Action test /cgi-bin/test.pl
                            AddHandler test .html 

                        #TODO: i get `Action` directive undefined... solve this.
                        
                        #try it:
                            firefox localhost/index.html
                        #this is how php does it!
                
            ##modules
            
                #apache plugins are called modules
                
                #modules are compiled `.so` files
                
                #modules may define new directives
                
                #for modules to become effective they must be loaded in the config file
                
                #only do certain commands if module is exists:
                    <IfModule mod_fastcgi.c>
                        commands...
                    </IfModule>

                #load a module:
                    LoadModule fastcgi_module /usr/lib/apache2/modules/mod_fastcgi.so
                    #          1              2
                    #1: module identifier hard coded in module?
                    #2: full path to .so

            ##handlers
                
                #part of the very default mime_module

                #determines filetypes and sets default actions accordingly

                #example:
                    Action add-footer /cgi-bin/footer.pl
                    AddHandler add-footer .html 
                #Action: defines a handler called add-footer
                #AddHandler: uses the handler called add-footer for all html files
                
                #handlers can be defined in modules
            
            ##authentication

                #you must chose *both* one <#method> and one <#provider>!

                ##methods
            
                    ##prerequisites

                        #<#http authentication>
                
                    #what algorithm is used to store the passwords more or less safely
                    
                    ##basic authentication
                    
                        #provided by `mod_auth_basic`
                
                        #apache conf:
                            LoadModule auth_basic_module /usr/lib/apache2/modules/mod_auth_basic.so
                            <Directory "/var/www/test/auth/">
                                    AuthType Basic
                                    AuthName "private dir"
                                    AuthBasicProvider file
                                    AuthUserFile /var/.htpasswd
                                    Require valid-user
                                    AllowOverride None
                            </Directory>

                    ##digest

                        #provided by `mod_auth_digest`
                    
                        #mod_auth_digest is better than mod_auth_basic, so use digest!

                        LoadModule auth_digest_module /usr/lib/apache2/modules/mod_auth_digest.so
                        <Directory "/var/www/test/auth/">
                                AuthType Digest
                                AuthName "private dir"
                                AuthDigestProvider file
                                AuthUserFile /var/.htpasswd
                                Require valid-user
                                AllowOverride None
                        </Directory>

                ##provider
                
                    #what type of storage is used for user password pairs
                    
                    #is specified by the `AuthBasicProvider` directive.
                    
                    ##file
                    
                        #a plain text file
                        
                        #safer to put outside serve root
                        
                        ##htpasswd
                        
                            #generate .htpasswd files

                            #generate user/pass pairs:
                                sudo htpasswd -bc /var/www/.htpasswd u p
                            #*-c: creates new file, destroying old one! necessary first time!*
                            #-b: use pass from command line. *less safe!!*
                                sudo htpasswd -b /var/www/.htpasswd u2 p

                            #lets take a look at the file:
                                sudo cat /var/www/.htpasswd
                            #note that the passwords are base64 enoded. See <#base64>

                    ##dbd
                    
                        #sql database
        
            ##try it out!!

                #test:
                    firefox localhost/test/auth &
                #try u and u2 pass p!
                
                ##browser cache
                
                        firefox localhost/test/auth &
                        firefox localhost/test/auth &
                    #the second time, you may not be prompted for a password!

                    #this is because firefox has cached your password for some time
                    #and resent it automatically! there is no server state.
                
                    #to avoid the cache use curl:
                        curl -I localhost/test/auth
                    #401 and WWW-Authenticate.
                    
                    #with pass:
                        curl u:p@localhost/test/auth
                        curl -u u:p localhost/test/auth
                    #of course, better using the `-u` option
                    #which could work also for different authentication methods.
                
        ##php
        
            #interpretre language almost always run from a server to generate web content.
            
            #dominates web today, but faces increasing concurrence python/ruby/perl.

            ##core:
                sudo aptitude install -y php5
        
            ##apache integration:
                sudo aptitude install -y libapache2-mod-php5

            #test:
                sudo service apache2 restart
                echo '<?php phpinfo(); ?>' | sudo tee /var/www/testphp.php
                firefox http://localhost/testphp.php &
            #if you see php specs, it works!

        #install mysql server. see: <#mysql server>

    ##vpn

        #control another computer with you computer

        #unless the other computer says who you are,
        #it is impossible to tell that you are not the other computer

        #several protocols exist.

            sudo aptitude install network-manager-openvpn network-manager-openvpn-gnome

        #servers

            http://www.vpnbook.com/#pricing

##boot

    #summary of the boot process: <http://www.ibm.com/developerworks/library/l-linuxboot/>

    ##grub

        sudo vim /etc/default/grub
            #GRUB_DEFAULT : default os choice if cursor is not moved.
                #starts from 0, the order is the same as shown at grub os choice menu
            #GRUB_TIMEOUT : time before auto OS choice in seconds

        sudo update-grub
            #must update grub after changing this file
    
    ##init
    
        #parent of all processes!
        
        #last thing that is run at boot process
        
        #firs user-space process
        
        #determines runlevel
        
        sudo init 6
            #set runlevel 6: reboot

    ##run levels
    
        #ubuntu uses upstart, newer replacement to `system v` init
        
        #/etc/init: upstart configuration files
            #programs here are named services
        #/etc/init.d: are the old compatibility only system v initi dirs
        #links to programs that get run on each runlevel: /etc/rc\n.d/
    
        runlevel
            #determines previous and current run level
            #N == none
        
        #S == 1. better use 1 always on debian systems.
        
        ##upstart
        
            ##service
        
                #upstart interface to services
            
                #get status of all services:
                    sudo service --status-all
                #legend:
                    #"+" started
                    #"-" stopped
                    #"?" unknow
                
                sudo service apache2 status
                sudo status apache2

                sudo service apache2 start
                sudo start apache2

                sudo service apache2 stop
                sudo stop apache2

                sudo service apache2 restart
                sudo restart apache2

                #TODO service restart vs restart?

##interpreters

    ##shebang

        #she: name for '#', bang: name for '!'

        #tells linux which interpreter to use to run the program

        #*must* be first char of first line

        #if this were a phython script for example,
        #we'd use `/bin/python`
        
        #in older linux versions, interpreter must be a compiled binary.
        #in newer linux versions, it can an interpreted script also.

        ##what it does exactly
        
            #<http://www.in-ulm.de/~mascheck/various/shebang/> at section "Test results from various systems"

                echo "#!/progs/prog a b" > /scripts/script
                chmod +x /scripts/script
                ./scripts/script
            
            #the following happens:
            #- prog runs
            #- its command line arguments are:
                #- 0: `/progs/prog`
                #- 1: `a b`
                #- 2: `/scripts/cript`
            
            #how this works for python:
            #- `#!/bin/python` runs `/bin/python /scripts/script`
                #which for the python interpreter means: execute `/scripts/script`
            #- python comments start with `#`. Therefore: *the shebang line is ignored by `/bin/python`.
        
                #Therefore: All interpreted languages should have `#` as a comment character!

        ##env

            #you could use `!#/bin/bash` instead
            #but if you go on a system where bash is located
            #at `/usr/bin/bash`, your script breaks

            #with env, path is used instead
            #so if `bash` is in the users $PATH,
            #and /usr/bin/env exists 
            #it works

            ##why it works

                #`env cmd` simply executes a program in current environment

                #in our case, the bash program

            #the advantage of this is that:
                #- env is more often located in `/usr/bin` than bash in `/usr` acros *NIX TODO check
                #- all you interpreters

        ##why not from extension

            #in windows, interpreter is determined by extension

            ##advantage os extension
            
                #easier to spot program type.

            ##disadvantage os extension

                #you need an extra EXT env var that says: you can execute a.py as py, a.sh as a

                #it is important to execute a.sh as `a` because if someday you decide that
                #it sould be written in python istead, you don't break all dependant programs
                #by using `a.py`

    ##bc

        #simple interpreted language, calulator focus
        
        #c-like syntax
        
        #features: variable definition, function definition, arrays, strings

        #non features: string concatenation

        #posix 7
        
        assert [ `echo '1+1' | bc` = 2 ]

    ##flash

        sudo apt-add-repository -y "deb http://archive.canonical.com/ $(lsb_release -sc) partner"
        sudo aptitude update
        sudo aptitude install -y flashplugin-installer

    ##java

        #its sometimes hard to make this work...

        #not sure which is best

        #sudo add-apt-repository -y ppa:webupd8team/java
        #sudo aptitude update
        #sudo aptitude install -y oracle-java7-installer
        #sudo aptitude install -y oracle-java7-set-default
            ##set env variables
        #sudo aptitude install -y icedtea6-plugin
            #allows to run java on certain brosers, including firefox

        sudo aptitude install openjdk-7-jre icedtea-7-plugin

    ##perl
    
        #perl is good for command line golfing and quite powerful
        
        #i find python clearer and less implicit
        
        #perl is installed by default for posix compliance
        
        #the following contains lots of man pages and html docs:
            sudo aptitude install -y perl-doc

            man perldoc
            man perlcheat

        #waits a ctrl-d and then execute everything:
            perl
        
        ##sources
            
            #famous perl one liners: <http://www.catonmat.net/blog/perl-one-liners-explained-part-six/>
        
        ##command line options
        
            ##-e "$s"

                #execute given string instead of file program

            ##-n:

                #use `while (<>) { ... }` loop aroud given program
                #this makes perl act linewise
                #each line gets the default value `$_`
                #therfore to print the current line, you instead of `print($_)` can simply write `print`
                #the endline `"\n"` is part of the string

            ##-p
            
                #same as `-n`, with `print` at end

            ##-i

                #what would get printed is put into file instead:
                    echo $'a\nb' > f
                    assert [ "`perl -lpi -e 's/a/A/g' f`" ]
                    assert [ "`cat f`" = $'A\nb' ]
                #newlines are affected
                #-i: inline

                #saves old file to F.bak, original is changed:
                    echo $'a\nb' > f
                    assert [ "`perl -lpi.bak -e 's/a/A/g' f`" ]
                        #NO SPACE BETWEEN I AND '.bak'!!!
                    assert [ "`cat f`" = $'A\nb' ]
                    assert [ "`cat f.bak`" = $'a\nb' ]

            ##-a

                #autosplit

                #adds `@F = split(/ /);` to top of loop.
                #requires `-n` or `-p`. 
                
                    assert[ "`echo $'a b c\nd e f' | perl -nae 'print $F[0]. ":" . $F[1] . ":" . $F[2]'`" = "a:b:c:d:e:f:" ] 

                #multiple spaces are split:
                    assert[ "`echo $'a  b c' | perl -nae 'print $F[0]. ":" . $F[1] . ":" . $F[2]'`" = "a:b:c"] 

                #tabs are split:
                    assert[ "`echo $'a\0b\tc' | perl -nae 'print $F[0]. ":" . $F[1] . ":" . $F[2]'`" = "a:b:c"] 

            ##-F

                #`-F: '/pattern/'`: set field separator for `-a`
                
                #must be used with <#-a>

                #change
                assert[ "`echo $'a:b:c' | perl -naF':' -e 'print $F[0]. " " . $F[1] . " " . $F[2]'`" = "a b c"] 

            ##-0
            
                #`-000` sets `$/` (IRS) to a given octal value
                
                #default: "\n"
                
                ##special values
                
                    ##0777

                        #slurp mode. read everything at once.
                    
                    ##00
                    
                        #paragraph mode. read up to "\n\n"
            
            ##-l
            
                #adds chomp to loops
                
                #no arg: sets `$\ = $/` (ORS = IRS)
                
                #with arg: sets `$\ = $/` (ORS = IRS)
                
                #default `$\`: ''
                
                ##application
                
                    #add newline to prints if `-0` is not set
                    #(and thus equals newline)

            ##-M
            
                #import modules
                
                #print sum of lines:
                    perl -MList::Util=sum -alne 'print sum @F'
        
        ##important one liners

            echo $'a\nb' | perl -lape 's/a/A/'
                #regex replace
                #no newline match in the match

            perl -pe 's/\n/ /g' F
                #acts on newlines at end

            echo $'a\nb\na' | perl -lane 'print if s/a/A/g'
                #print only new modified lines to screen

            echo $'a\nb\nc\nb' | perl -lane '$o = $_; if (s/b/B/g) { print $. . "  " . $o . "\n" . $. . "  " . $_ . "\n" }'
                #print only modified lines
                #print old and new
                #with line numbers

            perl -0777 -lape 's/\n\n+/\n/\ng' F
                #not linewise

            perl -ne 'print $., "  ", $_' F
                #print file with line numbers, tab separated by 2 spaces from text

            echo $'a\nb\nc\nda\nb\nc' | perl -ne 'print if /a/ .. /c/'
                #$'a\nb\nc\na\nb\nc'
                #print between regexes inclusive non greedy
            
            echo $'a\nb\nc' | perl -ne 'BEGIN{ $a = 0 }; $a = 0 if /c/; print if $a; $a = 1 if /a/;'
                #b
                #print between regexes exclusive non greedy

            perl -ne 'print if 15 .. 17' F
                #print fron line 15 to 17

            perl -pe '/baz/ && s/foo/bar/'
                #substitute (find and replace) "foo" with "bar" on lines that match "baz".

            ifconfig | perl -ne '/HWaddr (\S*)/ && print $1 . "\n"'
                #print backreference only on matching lines
        
            echo $'a\nb' | perl -ne 'BEGIN{ $a = "b" } END{ print $a }'
                #b
                #act only on begin and end
            
            echo $'a\nab' | perl -ne 'print length, "\n"'
                #$'2\n3'

            ##ack combo

                #regex refactoring:
                ack -f | xargs perl 's/a/b/'
        
##x11

    #real name: X Window System

    #x11 is a `window system`
    
    #upcoming alternative: wayland
    #not yet widely used,
    #but plans made for use in Ubuntu

    #x11 is only an interface.
    #there can be different implementations:
        #`X.org` implentation currently dominates
        #`XFree86` was the dominant prior to 2004
            #it broke glp, and fell into disgrace

    ##it is an abstraction layer for things like:
        
        #windows
            #stack access order for alt tab
        #key presses
        #mouse position / presses
        #screen backlight

    #it is usually graphic accelerated
    #this is why messing with gpu settings may break your desktop =)

    ##it does not include things like:

        ##x display management
            #a graphical login screen
            #choice of window manager
            #some implementations:
                #LightDM (lightweight), ubuntu
                #KDM, kde
                #GDM (gnome) fedora

        ##`x window manager`:
            #functions:
                #window switching (alt tab / visible list of open windows)
                #program opening with button clicks
                    #dock
                    #dash
                #multiple desktops
            #implementations:
                #metacity
                #compiz

        #sound management
            #this has been taken up by several related projects:
                #PulseAudio
                #Advanced Linux Sound Architecture (ALSA)

    #it uses a server/client mode
    #client and server can be on different machines
        #client:
            #typically programs with a window
            #clients give commands to the xserver and tell it to draw on screen
            #clients respond to input events via callback functions 
        #server:
            #creates the image
            #sends inputs events to clients who responds to it via callbacks
            #a server has many displays
            #a display has many screens, one mouse and one keyboard
            #to set the display to use use the DISPLAY var:
                export DISPLAY=localhost:0.0
                DISPLAY=localhost:0.1 firefox & #single commena
                    #0.1 means: display 0, screen 1

    #for higher level APIs, use toolkits:

        #gtk: primarily for x11, but can be cross platform
        #qt

        #gtk

            sudo aptitude install -y libgtk-3-dev libgtk-3-doc gtk2.0-examples

            gtk-demo
                #very nice demo of lots of 2.0 features with easy to see source code
    
    ##xorg
    
        #is the dominant implementation of the x server

        ##conf file
        
            man xorg.conf

            #first of:
                #/etc/X11/<cmdline>
                #/tmp/Xorg-KEM/etc/X11/<cmdline>
                #/etc/X11/$XORGCONFIG
                #/tmp/Xorg-KEM/etc/X11/$XORGCONFIG
                #/etc/X11/xorg.conf-4
                #/etc/X11/xorg.conf
                #/etc/xorg.conf
                
                #where <cmdline> is specified on the command line at startup
        
        ##log file
        
            less /var/log/Xorg.0.log
            #                 ^   
            #0: display number

    ##X

        #get xserver version
    
        sudo X -version

    ##xhost
    
        #x control

    ##service lightdm

        sudo restart lightdm
            #restart lightdm display manager used for Unity
            
            #restart X too
            
            #closes all your programs
            
            #do this on a tty, not on an xterminal
            #don't ask me why! =), but probably because
            #your terminal is going to die in the middle of the operation

        sudo stop lightdm

        sudo start lightdm

    #starts x, somewhere
    
        startx

    ##xlsclients

        #list x clients
        #this allows you to see all windows

        xlsclients
        xlsclients -l
            #more info

    #xprop

        #get window info

        xprop -name Krusader
            #-name: select by name
            #-id: select by id 
        xprop -spy -name Krusader

    #xmodmap

        #modify key maps

        f=~/.Xmodmap
        echo "! Swap caps lock and escape
remove Lock = Caps_Lock
keysym Escape = Caps_Lock
keysym Caps_Lock = Escape
add Lock = Caps_Lock
" >> "$f"
        xmodmap "$f"
            #esc and caps lock are changed!

        echo "xmodmap \"$f\"
" >> ~/.xinitrc
              #~/.xsession could also be used depending on system
        chmod +x ~/.xinitrc
            #now the change will happen every time at startup

    ##xdotool

        #send clicks and manage window properties.

        sudo aptitude install -y xdotool

        #select window

            #if no selector given, act on cur

            id=
            xdotool search --window "$id" key ctrl+c
                #to a window id

            n=
            xdotool search --name "$n" key ctrl+c
                #all windows with given name
                #this is exactly what is shown on window titlebar

        #keystrokes

            xdotool key a
                #send a to cur window
            xdotool key a b
                #send a then b to cur window
            xdotool key F2
                #send F2 to cur window
            xdotool key Aacute
                #send á to cur window
            xdotool key ctrl+l
                #send ctrl+l to cur window

        #key:     up and down
        #keydown: only down
        #keyup:   only up

            xdotool type 'ab cd'
                #sends a then b then space then c then d
            xdotool type --delay 1 'ab'
                #key a, waits 1 ms then key b

        #sync
            google-chrome &
            xdotool search --sync --onlyvisible --class "google-chrome"
                #wait until results
                #you can launch an app and send commands, making sure they will be received!

    ##keyboard and mouse automation 

        #autokey
            #sudo apt-add-repository ppa:cdekter/ppa
            #sudo aptitude install -y autokey-gtk

    ##xbacklight

        #control screen brightness
      
        sudo aptitude install -y xbacklight

        xbacklight -get
            #see current
        xbacklight -set 80
            #set to 80%

    ##xsel

        #manipulate the x selection and clipboard

        sudo aptitude install -y xsel
        
        ##x selection
        
            #is the last focused selected text
            
            #can be pasted with a middle click

            echo a > xsel
                #set x selection
            assert [ `xsel` = a ]
                #print contents of xselection
        
        ##clipboard

            #uses the clipboard (ctrl+c) instead of selection
            
            echo a | xsel -b
                #set clipboard
            assert [ `xsel -b` = a ]
                #print clipboard
        
        ##append
        
            echo a | xsel
            echo b | xsel -a
            assert [ "`xsel`" = $'a\nb\n' ]
        
        ##follow
        
            #follows stardard input as it grows

            echo a > f
            xsel -f < f
            assert [ "`xsel`" = $'a\n' ]
            echo b >> f
            assert [ "`xsel`" = $'a\nb\n' ]

            ##stop
            
                echo a | xsel
                echo c > f
                assert [ "`xsel`" = $'a\n' ]

    ##xmodmap
    
        #view and modify key mappings
        
        xmodmap -pke > ~/.Xmodmap
            #outpus all keymappings to a file
            #
            #keycode  24 = q Q q Q adiaeresis Adiaeresis
            #              ^ ^ ^ ^ ^^^^^^^^^^ ^^^^^^^^^^
            #              1 2 3 4 5          6         
            #         
            #1: no modifiers
            #2: shift
            #3: mode_switch no shift
            #4: mode_switch +  shift
            #5: ?
            #6: ?
            #7: ?
            #8: ?
            #9: ?
            #
            #**AltGru** is the mode_switch key
            #
            #up to 8 keysims bay be attached to each keycode
            #
            #however, only the first 4 are commonly used
    
    ##xeyes
        
        #fun x11 test prog

        xeyes

    ##xev
    
        #opens test window and prints x events description to stdout
        
        xterm
            #does not work well on guake
        xev

    ##xwd

        #take screenshots (x11 write dump)

        xwd -root -out a.xwd
            #take screenshot of all windows
        xwd -out a.xwd
            #wait for mouse click
            #take screenshot of clicked window only
        xwd | xwdtopnm | pnmtopng > Screenshot.png
            #change format

    ##wmctrl

        wmctrl -m
            #detect

    ##display manager

        cat /etc/X11/default-display-manager
            #detect which

        #lightdm

            echo $GDMSESSION
                #tells option chosen from login screen

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

##misc

    ##shutdown reboot

        sudo shutdown -P now
            #brings down the system and powers off afterwards
            #`usual` shutdown
            #sends TODO signal to running processes and waits for their termination TODO?

        sudo reboot now
            #usual restart computer

    ##setleds
    
        #set/get capslock, numlock and scrolllock led state
    
        #only works from tty (ctrl+alt+F[1-6] on ubuntu) 
        
            setleds

    ##gtk themes

        #it is best to install them from ppas
        #since at every update of gtk version themes break =)

        #to change themes with a gui (recommended) use: <#gnome tweak tools>

        ##manual theme management

            #to install for a single user, place themes folders under `~/.themes` and they will become available

        ##webupd8team/themes ppa

            #they have a many themes there!

                sudo add-apt-repository -y ppa:webupd8team/themes
                sudo aptitude update

            #my favorourite theme:

                sudo aptitude install -y gnomishdark-theme
