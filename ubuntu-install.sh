#!/usr/bin/env bash

#ubuntu info, and in special ubuntu specific program installation procedures

#running this file should do all automatable steps to install useful stuff we find useful.

#non automatable steps shall be labelled as:

    #MANUAL: edit that file and click some buttons

##ubuntu genearl info

    #a debian based distribution

    #unlike debian maintained by the cannonical company
    #which gets money by offering maintaincance (debian is managed by the community)

    #important implications: many key programs are the same:

    #- `dpkg` for packages
    #- `upstart` for init

    ##get current ubuntu version

        #lsb-release -a | grep Release

    ##upgrade ubuntu version

        #sudo aptitude install -y update-manager-core
        #sudo do-release-upgrade
        #sudo aptitude update && sudo aptitude upgrade

    #open app without global menu

        #env UBUNTU_MENUPROXY=0 golly

    #ubuntu-tweak

        #configure ubuntu

##installation procedures

    ##before anything

            sudo apt-get update

        #like apt-get, but removing  a package will also uninstall all dependencies that
        #were installed for that package:

            sudo aptitude install -y aptitude

    ##package management

            sudo aptitude install -y apt-rdepends
            sudo aptitude install -y apt-file
            sudo aptitude install -y ppa-purge
            apt-file update

    #usefull stuff that does not come by default or Canonical would have to pay royalties:

        sudo aptitude install -y ubuntu-restricted-extras

    ##uncategorized

        #uuencode, xxencode, BASE64, quoted printable, BinHex

            sudo aptitude install -y uudeview

        #mime messages

            #sudo aptitude install -y mpack

    ##printer

        #worked for: EPSON xp-202

        #type printer in dash

        #the guide shows you everything

    ##desktop

        sudo aptitude install -y alarm-clock-applet
        sudo aptitude install -y logkeys
        sudo aptitude install -y guvcview

        #ibus input methods for QT:

            sudo aptitude install -y ibus-qt4

        #Useful for example if you want Chinese input for qt applications.

    ##book

        sudo aptitude install -y okular okular-extra-backends
        sudo aptitude install -y fbreader
        sudo aptitude install -y calibre

        sudo aptitude install -y pdftk
        sudo aptitude install -y djvulibre-bin

        ##chm

            sudo aptitude install -y chmsee
            sudo aptitude install -y chm2pdf
            sudo aptitude install -y archmage
            #sudo aptitude install -y kchmreader

    ##sound

        sudo aptitude install -y abcde
        sudo aptitude install -y cplay
        sudo aptitude install -y id3tool
        sudo aptitude install -y lame
        sudo aptitude install -y shntool
        sudo aptitude install -y cuetools
        sudo aptitude install -y flac
        sudo aptitude install -y wavpack

        sudo aptitude install -y libportaudio-dev libportaudio-doc

    ##image


        sudo aptitude install -y aview
        sudo aptitude install -y caca-utils
        sudo aptitude install -y dvipng
        #sudo aptitude install -y exactimage
        sudo aptitude install -y imagemagick
        sudo aptitude install -y imagemagick-doc

        #graph uml gui:

            sudo aptitude install -y dia

        #batch graph draw cli:

            sudo aptitude install -y dot

        sudo aptitude install -y gimp
        sudo aptitude install -y inkscape

    ##dict

        sudo aptitude install -y aspell
        sudo aptitude install -y aspell-fr
        sudo aptitude install -y aspell-pt-br
        sudo aptitude install -y goldendict

    ##sox

            sudo aptitude intall -y sox
            sudo aptitude intall -y libsox-fmt-mp3

        #now search for formats and install those you want:

            #apt-cache search libsox-fmt-

        sudo aptitude install -y sysstat

    ##ocr

        ##tesseract

                sudo aptitude install -y tesseract-ocr

                #MANUAL: find available languages

                    #apt-cache search tesseract-ocr-

                #english

                    sudo aptitude install -y tesseract-ocr-eng

            #chinese hack

                #sudo aptitude install -y tesseract-ocr-chi-sim #simplified chinese
                #cd /usr/share/tesseract-ocr/tessdata
                #sudo ln -s chi_sim.traineddata zho.traineddata

            sudo aptitude install -y cuneiform

    ##video

            sudo aptitude install -y vlc

        #handbreak:

            sudo add-apt-repository -y ppa:stebbins/handbrake-releases
            sudo aptitude install -y handbrake-cli
            #sudo aptitude install -y handbrake-gtk

        #vobsub2srt:

            sudo add-apt-repository -y ppa:ruediger-c-plusplus/vobsub2srt
            sudo aptitude update
            sudo aptitude install -y vobsub2srt

        sudo aptitude install -y mkvtoolnix

    ##compression

            sudo aptitude install -y zip unzip

        #shell archives:

            #sudo aptitude install -y sharutils
            sudo aptitude install -y file-roller

        #7 zip:

            sudo aptitude install -y p7zip-full

        #.ace files

            #sudo aptitude install -y unace

            sudo aptitude install -y rar
            sudo aptitude install -y unrar

        #.arj files:

            #sudo aptitude install -y arj

        #microsoft cabinet format:

            #sudo aptitude install -y cabextract

        #.lzh files used on DOS, legacy:

            #sudo aptitude install -y lha

    ##game

        ##getdeb

            #non launchapd ppa with lots of good games.

                wget -q -O - http://archive.getdeb.net/getdeb-archive.key | sudo apt-key add -
                sudo sh -c 'echo "deb http://archive.getdeb.net/ubuntu quantal-getdeb games" > /etc/apt/sources.list.d/getdeb.list'
                sudo aptitude update
                sudo aptitude install urbanterror
                #sudo aptitude install worldofpadman

        sudo aptitude install -y nethack-console
        sudo aptitude install -y fortune
        sudo aptitude install -y cowsay
        sudo aptitude install -y robotfindskitten
        sudo aptitude install -y bsdgames
        sudo aptitude install -y greed
        sudo aptitude install -y ninvaders
        sudo aptitude install -y netrek-client-cow
        sudo aptitude install -y urban-terror
        sudo aptitude install -y golly
        sudo aptitude install -y gnotski

        sudo aptitude install -y zsnes
        sudo aptitude install -y mupen64plus
        sudo aptitude install -y pcsxr

        ##dosbox

            sudo aptitude install -y dosbox

            ## MANUAL: get the sound working

                #TODO get working

                    #pmidi -l
                    #vim ~/.dosbox/dosbox-*.conf

                #put the port in:

                    #[midi]
                    #midiconfig=14:0

                #sudo aptitude install -y pmidi

    ##editors

        sudo aptitude install -y vim
        sudo aptitude install -y vim-gtk
        #sudo aptitude install -y eclipse

        sudo aptitude install -y libreoffice
        sudo aptitude install -y libreoffice-base

    ##terminal emulators

        #sudo aptitude install -y guake
        sudo aptitude install -y yakuake

    ##program

        #glasgow haskell compiler:

            #sudo aptitude install -y ghc

            sudo aptitude install -y ant
            sudo aptitude install -y automake
            sudo aptitude install -y build-essential
            sudo aptitude install -y doxygen
            sudo aptitude install -y doxygen-doc
            sudo aptitude install -y cmake
            sudo aptitude install -y exuberant-ctags
            sudo aptitude install -y g++
            sudo aptitude install -y libtool
            #sudo aptitude install -y m4

        #gcc docs:

                sudo aptitude install -y gcc-doc

            #located at: `/usr/share/doc/gcc-doc`

        ##fortran

            #gnu fortran 77:

                sudo aptitude install -y g77

            #gnu fortran 95:

                sudo aptitude install -y gfortran

        #nasm assembler:

            sudo aptitude install -y nasm

        ##source control

                sudo aptutide install -y git
                sudo aptutide install -y mercurial
                sudo aptitude install -y subversion

        sudo aptitude install -y puppet

        #Many source code for examples to learn qt4.

            sudo aptitude install -y qt4-demos

    ##c and c++ libraries

            sudo aptitude install -y libgtk-3-dev
            sudo aptitude install -y libgtk-3-doc
            sudo aptitude install -y gtk2.0-examples

        ##KDE

            #KDE core dev libs:

                sudo aptitude install -y kdelibs5-dev

            #KDE game development files:

                sudo aptitude install -y libkdegames-dev

        #requirements to build conqueror:

            sudo aptitude install -y libkonq5-dev

            sudo aptitude install -y libirrlicht-dev
            sudo aptitude install -y libirrlicht-doc

            sudo aptitude install -y freeglut3-dev

            sudo aptitude install -y libopencv-dev
            sudo aptitude install -y opencv-doc

            sudo aptitude install -y libplplot-dev
            sudo aptitude install -y plplot11-driver-xwin

        #boost c++

            #Some subprojects have specific packages of their own.

            #To find what you need:

                #apt-cache search liboost

                sudo aptitude install -y libboost-dbg
                sudo aptitude install -y libboost-doc
                sudo aptitude install -y libboost-graph-dev

        #blas c / fotran and lapack fortran:

            sudo aptitude install -y liblapack-dev

        #lapack c via lapacke:

            sudo aptitude install -y liblapacke-dev

            sudo aptitude install -y libgsl0-dev
            sudo aptitude install -y gsl-doc-info

    ##python

            sudo aptitude install -y python-dev
            sudo aptitude install -y python-pip
            sudo aptitude install -y python-scipy
            sudo aptitude install -y python-matplotlib
            sudo aptitude install -y gunicorn

    ##ruby libraries

            sudo aptitude install -y ruby-dev

    ##virtualization

        ##virtualbox

                #wget -q http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc -O- | sudo apt-key add -
                #sudo sh -c 'echo "deb http://download.virtualbox.org/virtualbox/debian raring contrib" >> /etc/apt/sources.list.d/virtualbox.list'
                #sudo aptitude update
                #sudo aptitude install -y virtualbox-4.2

            #On the guest:

                #sudo aptitude install virtualbox-guest-utils

            sudo aptitude install -y vagrant

    ##language

        #interpreters and related libs

            sudo aptitude install -y perl-doc

        ##Java

            #Java is a pain to make work sometimes

            #If things don't work, do the standard procedure:
            #uninstall everything related to java, and try to install again.

            #Make sure you get the latest version, or things may not work.

            #You should find all packages of type:

                #dpkg -l | grep java | grep -iv javascript
                #dpkg -l | grep openjdk
                #dpkg -l | grep icedtea

            #and then do:

                #sudo aptitude purge $PKG

            #Oracle version:

                sudo add-apt-repository ppa:webupd8team/java
                sudo aptitude update
                sudo aptitude install -y oracle-java8-installer

            #This already comes with the browser plugin

            #Openjdk version:

                #sudo aptitude install openjdk-7-jre

            #Firefox java plugin:

                #sudo aptitude install icedtea-7-plugin

            #Whichever don't forget to enable the plugin on firefox ( <c-s-a> to open plugins menu )

        ##flash

                sudo apt-add-repository -y "deb http://archive.canonical.com/ $(lsb_release -sc) partner"
                sudo aptitude update
                sudo aptitude install -y flashplugin-installer

		##desktop

			sudo aptitude install -y xbacklight
			sudo aptitude install -y xsel
            sudo aptitude install -y wmctrl
			sudo aptitude install -y xdotool
			#sudo apt-add-repository ppa:cdekter/ppa
			#sudo aptitude install -y autokey-gtk

            #gtk themes:

                    sudo add-apt-repository -y ppa:webupd8team/themes
                    sudo aptitude update
                    sudo aptitude install -y gnomishdark-theme

            sudo aptitude install -y compizconfig-settings-manager

		##networking

                sudo aptitude install -y apache2
                sudo aptitude install -y libapache2-mod-fastcgi

                sudo aptitude install -y traceroute
                sudo aptitude install -y wireshark

            #php:

                sudo aptitude install -y php5

            #php apache module:

                sudo aptitude install -y libapache2-mod-php5
                    #Will ask you to initialize the password for the `root` user.
                sudo aptitude install -y sqlite

            ##phpmyadmin

                #First make sure that php and mysql are installed.

                    sudo aptitude install -y libapache2-mod-auth-mysql php5-mysql phpmyadmin

                    sudo vim /etc/apache2/apache2.conf

                #Ensure following line is anywhere in the file:

                    #Include /etc/phpmyadmin/apache.conf

                    sudo service apache2 restart

                #Test phpmyadmin and mysql:

                    firefox http://localhost/phpmyadmin &

                #Login: 'root'. password: what you entered at installation.

                sudo aptitude install -y openssh-client
                sudo aptitude install -y openssh-server

                sudo aptitude install -y nmap
                sudo aptitude install -y whois

            #terminal web browser:

                sudo aptitude install -y w3m w3m-img

            #MySQL:

                sudo aptitude install -y mysql-server
                sudo aptitude install -y libmysql++-dev
                sudo aptitude install -y libmysql++-doc
                sudo aptitude install -y libmysqlcppconn-dev

            #PostgreSQL:

                sudo aptitude install -y libpq-dev
                sudo aptitude install -y postgresql
                sudo aptitude install -y postgresql-client

            ##mail

                    sudo aptitude install -y mutt
                    sudo aptitude install -y ssmtp

                # Conflicts with ssmtp:

                    #sudo aptitude install -y postfix

    ##disk

            sudo aptitude install -y gparted

    ##desktop environments

        #Install all of the following. If a bug relates to graphical stuff,
        #change desktops to test.

            sudo aptitude install -y gnome-tweak-tool

        #gnome shell:

            #sudo add-apt-repository -y ppa:gnome3-team/gnome3 && sudo aptitude update
            #sudo aptitude install -y gnome-shell

        #linux mint shell cinnamon:

            #sudo add-apt-repository -y ppa:gwendal-lebihan-dev/cinnamon-stable && sudo aptitude update
            #sudo aptitude install -y cinnamon

        #kde shell plasma:

            sudo aptitude install -y kde-plasma-desktop

        #xubuntu shell xfce:

            sudo aptitude install -y xfce4
            sudo aptitude install -y xfce4-battery-plugin

        #lubuntu lxde:

            #sudo aptitude install -y lxde

        #for `qtconfig-qt4`:

            sudo aptitude install -y qt4-qtconfig

    ##chat messaging voice video

        #skype

            sudo add-apt-repository -y "deb http://archive.canonical.com/ $(lsb_release -sc) partner"
            sudo aptitude update
            sudo aptitude install -y skype

        #google talk

            wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
            sudo sh -c 'echo "deb http://dl.google.com/linux/talkplugin/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
            sudo aptitude update
            sudo aptitude install -y google-talkplugin

        #pidgin

            sudo aptitude install -y pidgin

    ##file sharing

        ##torrent

            #deluge

                sudo add-apt-repository -y ppa:deluge-team/ppa
                sudo aptitude update
                sudo aptitude install -y deluge

        #dropbox

            sudo aptitude install -y nautilus-dropbox

        #ubuntuone taskbar indicator

            sudo add-apt-repository -y ppa:noobslab/initialtesting
            sudo apt-get update
            sudo aptitude install indicator-ubuntuone

        ##soulseek

            sudo aptitude install -y nicotine+

        ##ftp

            #very secure ftp deamon ftp server:

                #sudo aptitude install -y vsftpd

            sudo aptitude install -y filezilla

            #higher level ftp operations such as recursive dir addition:

                sudo aptitude install -y lftp

        sudo aptitude install -y samba

    ##file manager

        #krusader and highly recommended tools

            sudo aptitude install -y krusader
            sudo aptitude install -y konqueror          #needs to manage bookmarks. (otherwise, button does nothing)
            sudo aptitude install -y konsole            #needs to terminal emulator. (otherwise, button does nothing)
            sudo aptitude install -y khelpcenter4       #help
            sudo aptitude install -y kwalletmanager     #password manager

    ##gpu

        #nvidia

            sudo aptitude install -y nvidia-319
            sudo aptitude install -y nvidia-settings-319
            sudo aptitude install -y nvidia-prime
            sudo aptitude install -y nvidia-opencl-dev

##xinit

    #TODO

##ck-list-sessions

    #TODO

##launchpad ppas

    #you must first add ppas with `apt-add-repository`

        sudo add-apt-repository -y ppa:tualatrix/ppa && sudo aptitude update
        sudo aptitude install -y ubuntu-tweak

        sudo add-apt-repository -y ppa:atareao/atareao && sudo aptitude update
        sudo aptitude install my-weather-indicator

        sudo add-apt-repository -y ppa:flacon && sudo aptitude update
        sudo aptitude install -y flacon

##non launchpad ppas

    #you must first add ppas manually:
