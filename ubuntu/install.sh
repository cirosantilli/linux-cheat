#!/usr/bin/env bash

# Running this file should do all automatable steps to install useful stuff in Ubuntu 12.04.

# To install the SSH survival kit use:

  #wget -O- https://raw.githubusercontent.com/cirosantilli/linux/master/ubuntu/install.sh | bash -s min-ssh

# To install GUI survival kit use:

  #wget -O- https://raw.githubusercontent.com/cirosantilli/linux/master/ubuntu/install.sh | bash -s min

# Non-automatable steps shall be labelled with: `MANUAL`

##installation procedures

  # SSH survival kit.

    # Package manager

      sudo apt-get update
      sudo apt-get install -y aptitude

    # git

      sudo aptitude install -y git

    # Dotfiles:

      git clone https://github.com/cirosantilli/dotfiles
      cd dotfiles
      ./install.sh

    # Editor

      sudo aptitude install -y vim
      git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
      # TODO fails from bash pipe becuase not TTY.
      #vim +PluginInstall +qall

  if [ "$1" = "min-ssh" ]; then exit 0; fi

  # GUI survival kit.

    # Terminal

      sudo aptitude install -y guake

    # Editor

      sudo aptitude install -y vim-gtk

    # File manager

      sudo aptitude install -y krusader
      sudo aptitude install -y konsole
      sudo aptitude install -y kwalletmanager

    # PDF

      sudo aptitude install -y okular okular-extra-backends

    # Communication

      sudo aptitude install -y pidgin
      sudo aptitude install -y skype
      # Google Talk
      wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
      sudo sh -c 'echo "deb http://dl.google.com/linux/talkplugin/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
      sudo aptitude update
      sudo aptitude install -y google-talkplugin

    # X

      sudo aptitude install -y xsel
      sudo aptitude install -y wmctrl

  if [ "$1" = "min" ]; then exit 0; fi

  ##package management

      sudo aptitude install -y apt-rdepends
      sudo aptitude install -y apt-file
      apt-file update
      sudo aptitude install -y ppa-purge

  # Usefull stuff that does not come by default or Canonical would have to pay royalties:

    sudo aptitude install -y ubuntu-restricted-extras

  ##uncategorized

    # xxencode, BASE64, quoted printable, BinHex

      sudo aptitude install -y uudeview

    # mime messages

      #sudo aptitude install -y mpack

  ##text

      sudo aptitude install -y dos2unix

  ##sysadmin

      sudo aptitude install -y finger
      sudo aptitude install -y acct
      sudo aptitude install -y makepasswd

  ##printer

    # MANUAL

    # Tested for: EPSON xp-202.

    # Type `printer` in dash.

    # The guide shows you everything.

  ##desktop

    sudo aptitude install -y alarm-clock-applet
    # GNOME tweak tool:
    sudo aptitude install -y gconf-editor
    #sudo aptitude install -y logkeys
    sudo aptitude install -y recordmydesktop
    #sudo aptitude install -y gtk-recordmydesktop
    sudo aptitude install -y guvcview

    # ibus input methods for QT:
    sudo aptitude install -y ibus-qt4
    # Useful for example if you want Chinese input for Qt applications.

  ##book

    sudo aptitude install -y okular okular-extra-backends
    #sudo aptitude install -y fbreader
    #sudo aptitude install -y calibre

    sudo aptitude install -y pdftk
    sudo aptitude install -y djvulibre-bin

    ##chm

      sudo aptitude install -y chmsee
      sudo aptitude install -y chm2pdf
      sudo aptitude install -y archmage
      #sudo aptitude install -y kchmreader

    # Texlive 2009:

      #sudo aptitude install -y texlive

    # Texlive 2009 full: latex

      #sudo aptitude install -y texlive-full

    # Texlive 2013 full:

      curl https://raw.github.com/cirosantilli/latex-cheat/master/install-texlive2013-ubuntu12.04.sh | bash

    sudo aptitude install -y asciidoc
    sudo aptitude install -y blahtexml
    sudo aptitude install -y pandoc

  ##audiou

    sudo aptitude install -y abcde
    sudo aptitude install -y cplay
    sudo aptitude install -y cuetools
    sudo aptitude install -y flac
    sudo aptitude install -y id3tool
    sudo aptitude install -y lame
    sudo aptitude install -y shntool
    sudo aptitude install -y libportaudio-dev libportaudio-doc
    # pico2wave
    sudo aptitude install -y libttspico-utils
    sudo aptitude install -y wavpack

  ##image

    sudo aptitude install -y aview
    sudo aptitude install -y caca-utils
    sudo aptitude install -y dvipng
    #sudo aptitude install -y exactimage
    sudo aptitude install -y imagemagick
    sudo aptitude install -y imagemagick-doc

    # Graph UML GUI:

      #sudo aptitude install -y dia

    # Batch graph draw CLI:

      #sudo aptitude install -y dot

    # GIMP 2.6: no single window mode.

      #sudo aptitude install -y gimp

    # GIMP 2.8: single window mode.

      sudo apt-add-repository -y ppa:otto-kesselgulasch/gimp && sudo aptitude update
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

    # Now search for formats and install those you want:

      #apt-cache search libsox-fmt-

    sudo aptitude install -y sysstat

  ##ocr

    ##tesseract

        sudo aptitude install -y tesseract-ocr

        # MANUAL: find available languages

          #apt-cache search tesseract-ocr-

        # English

          sudo aptitude install -y tesseract-ocr-eng

      #chinese hack

        #sudo aptitude install -y tesseract-ocr-chi-sim #simplified chinese
        #cd /usr/share/tesseract-ocr/tessdata
        #sudo ln -s chi_sim.traineddata zho.traineddata

      sudo aptitude install -y cuneiform

  ##video

      sudo aptitude install -y vlc

    # handbreak

      sudo add-apt-repository -y ppa:stebbins/handbrake-releases
      sudo aptitude install -y handbrake-cli
      #sudo aptitude install -y handbrake-gtk

    # vobsub2srt

      sudo add-apt-repository -y ppa:ruediger-c-plusplus/vobsub2srt
      sudo aptitude update
      sudo aptitude install -y vobsub2srt

    sudo aptitude install -y mkvtoolnix
    sudo aptitude install -y oggvideotools

    # ffmpeg:

      sudo aptitude install -y libav-tools

    ##editors

      # Cinelerra:

        #sudo apt-add-repository ppa:cinelerra-ppa/ppa
        #sudo apt-get update
        #sudo apt-get install cinelerra-cv

      ##pitivi

        # A bit too old, missing key features like multi selection on video line:

          #sudo aptitude install -y libav-tools

        # From source:

          sudo aptitude build-deps -y pitivi
          sudo aptitude install -y libcairo-dev python-cairo-dev itstool
          cd /tmp
          wget -O- http://ftp.gnome.org/pub/GNOME/sources/pitivi/0.93/pitivi-0.93.tar.xz | tar xvz
          cd pitivi-0.93
          ./configure
          make
          sudo make install

  ##compression

      sudo aptitude install -y zip unzip

    #7 zip:

      sudo aptitude install -y p7zip-full

    #.ace files

      #sudo aptitude install -y unace

      sudo aptitude install -y rar
      sudo aptitude install -y unrar

    # Shell archives:

      #sudo aptitude install -y sharutils

    # .arj files:

      #sudo aptitude install -y arj

    # Microsoft cabinet format:

      #sudo aptitude install -y cabextract

    # .lzh files used on DOS, legacy:

      #sudo aptitude install -y lha

      sudo aptitude install -y file-roller

  ##game

    ##getdeb

      # Non Launchapd ppa with lots of good games.

        wget -q -O - http://archive.getdeb.net/getdeb-archive.key | sudo apt-key add -
        # REPLACE precise with the codename for your distro!
        sudo sh -c 'echo "deb http://archive.getdeb.net/ubuntu precise-getdeb games" > /etc/apt/sources.list.d/getdeb.list'
        sudo aptitude update
        sudo aptitude install urbanterror
        #sudo aptitude install worldofpadman

    sudo aptitude install -y nethack-console
    sudo aptitude install -y fortune
    sudo aptitude install -y cowsay
    sudo aptitude install -y robotfindskitten
    sudo aptitude install -y bsdgames
    sudo aptitude install -y greed
    #sudo aptitude install -y ninvaders
    sudo aptitude install -y netrek-client-cow
    #sudo aptitude install -y urban-terror
    #sudo aptitude install -y golly
    #sudo aptitude install -y gnotski

    #sudo aptitude install -y zsnes
    #sudo aptitude install -y mupen64plus
    #sudo aptitude install -y pcsxr

    # super maryo chronicles:

      #sudo aptitude install -y smc

      #sudo aptitude install -y wesnoth

      #sudo aptitude install -y supertuxkart

    ##dosbox

        #sudo aptitude install -y dosbox

      ## MANUAL: get the sound working

        #TODO get working

          #pmidi -l
          #vim ~/.dosbox/dosbox-*.conf

        #put the port in:

          #[midi]
          #midiconfig=14:0

        #sudo aptitude install -y pmidi

  ##editors

      #sudo aptitude install -y eclipse

    ##Libreoffice

        sudo aptitude install -y libreoffice

      # Database editor:

        #sudo aptitude install -y libreoffice-base

  ##terminal emulators

    #sudo aptitude install -y guake
    #sudo aptitude install -y yakuake
    sudo aptitutde install -y tmux

    sudo add-apt-repository -y ppa:finalterm/daily
    sudo aptitude update
    sudo aptitude install -y finalterm

  ##program

    #gcc docs:

        #sudo aptitude install -y gcc-doc

      # Located at: `/usr/share/doc/gcc-doc`

      # gcc and c++ 4.8. Default on Ubuntu 12.04 is 4.6.

        sudo add-apt-repository -y ppa:ubuntu-toolchain-r/test
        sudo aptitude -y update
        # GCC
        sudo aptitude install -y gcc-4.8
        sudo aptitude install -y gcc-4.8-doc
        sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.8 50
        # G++
        sudo aptitude install -y g++-4.8
        sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.8 50

    # Glasgow haskell compiler:

      #sudo aptitude install -y ghc

      sudo aptitude install -y build-essential

      sudo aptitude install -y ant
      sudo aptitude install -y automake
      sudo aptitude install -y doxygen
      sudo aptitude install -y doxygen-doc
      sudo aptitude install -y cmake
      sudo aptitude install -y exuberant-ctags
      sudo aptitude install -y g++
      sudo aptitude install -y libtool
      #sudo aptitude install -y m4

    ##fortran

      # GNU fortran 77:

        sudo aptitude install -y g77

      # GNU fortran 95:

        sudo aptitude install -y gfortran

      sudo aptitude install -y nasm

    ##version control

        # Very outdated:
        #sudo aptutide install -y tig
        sudo aptitude install -y bzr
        sudo aptitude install -y cvs
        sudo aptutide install -y mercurial
        sudo aptitude install -y subversion

    #sudo aptitude install -y puppet

    ##c and c++ libraries

      # Requirements to build conqueror:

        sudo aptitude install -y libkonq5-dev

        sudo aptitude install -y libirrlicht-dev
        sudo aptitude install -y libirrlicht-doc

        sudo aptitude install -y freeglut3-dev

        sudo aptitude install -y libopencv-dev
        sudo aptitude install -y opencv-doc

        sudo aptitude install -y libplplot-dev
        sudo aptitude install -y plplot11-driver-xwin

        sudo aptitude install -y linux-source linux-headers
        #sudo aptitude install -y check
        sudo aptitude install -y libncurses5-dev

      # Boost c++

        # Install all packages:

          #sudo aptitude install -y libboost-all-dev

        # For G++ 4.8:

          sudo aptitude install -y libboost1.48-all-dev

        # Some subprojects have specific packages of their own,
        # but we recommend that you install all at once as it is not that large.

          #sudo aptitude install -y libboost-dbg
          #sudo aptitude install -y libboost-doc
          #sudo aptitude install -y libboost-graph-dev

        # To find what you need:

          #apt-cache search liboost

      # Blas C / Fotran and lapack fortran:

        sudo aptitude install -y liblapack-dev

      # Lapack C via LAPACKE:

        #sudo aptitude install -y liblapacke-dev

        sudo aptitude install -y libgsl0-dev
        sudo aptitude install -y gsl-doc-info

      # glx utils:

        sudo aptitude install -y mesa-utils

      # Many source code for examples to learn qt4.

        sudo aptitude install -y libqt4-dev
        sudo aptitude install -y qt4-demos

      ##gtk

          sudo aptitude install -y libgtk-3-dev
          sudo aptitude install -y libgtk-3-doc
          sudo aptitude install -y gtk2.0-examples

      ##KDE

        # KDE core dev libs:

          sudo aptitude install -y kdelibs5-dev

        # KDE game development files:

          sudo aptitude install -y libkdegames-dev

      ##vlc

        # Missing development requirements to compile VLC:

          sudo aptitude install -y liblua5.1-0-dev libmad0-dev liba52-0.7.4-dev \
            libxcb-composite0-dev libxcb-xv0-dev libxcb-randr0-dev libgcrypt11-dev

    ##python

        sudo aptitude install -y gunicorn

    ##ruby

        curl -L https://get.rvm.io | bash -s stable
        . ~/.rvm/scripts/rvm
        rvm install 2.1.1
        # Logout, login, and works for all shells.

    ##node

      # NVM install:

        VERSION=0.10.26
        curl https://raw.github.com/creationix/nvm/master/install.sh | sh
        . ~/.nvm/nvm.sh
        echo ". ~/.nvm/nvm.sh
        nvm use "$VERSION" &>/dev/null
        " >> ~/.bashrc
        nvm install "$VERSION"

      # Package node: old. Use NVM.

        #sudo aptitude install -y nodejs

      # NPM: comes with later nodes.

        #sudo aptitude install -y npm

      # After install, configure with:

        npm config set registry http://registry.npmjs.org/

    ##virtualization ##vm

      # Don't forget to enable virtualization on your BIOS when using virtualization tools.
      # Some features may only be available with it enabled.

      ##virtualbox

          #wget -q http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc -O- | sudo apt-key add -
          #sudo sh -c 'echo "deb http://download.virtualbox.org/virtualbox/debian raring contrib" >> /etc/apt/sources.list.d/virtualbox.list'
          #sudo aptitude update
          #sudo aptitude install -y virtualbox-4.2
          #MANUAL https://www.virtualbox.org/wiki/Download_Old_Builds_4_2

        # On the guest:

          #sudo aptitude install virtualbox-guest-utils

        ##vagrant

          # MANUAL download:

            #firefox http://www.vagrantup.com/downloads.html
            #cd download_dir
            #sudo dpkg -i vagrant*.deb

          # Aptitude install failed on Ubuntu 12.04.

            #sudo aptitude install -y vagrant

      ##docker

        # Only exists for 64bit, not 32.
        # http://docs.docker.io/en/latest/installation/ubuntulinux/

          #sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9
          #sudo sh -c "echo deb http://get.docker.io/ubuntu docker main\
          #> /etc/apt/sources.list.d/docker.list"
          #sudo aptitude update
          #sudo aptitude install -y lxc-docker

      ##wine

          sudo add-apt-repository ppa:ubuntu-wine/ppa
          sudo aptitudeapt-get update
          sudo aptitude install -y wine1.7
          sudo aptitude install -y winetricks
          winetricks winxp d3dx9 vcrun2005 vcrun2008 wininet corefonts

      # play on linux:

          sudo aptitude install -y playonlinux

    ##perl

      # Interpreters and related libs.

        sudo aptitude install -y perl-doc

    ##Java

      # Java is a pain to make work sometimes.

      # Make sure you get the latest version, or things may not work.

      # If things don't work, do the standard procedure: uninstall everything related to java, and try again.

      # To clear everything, first find all realted packages via:

        dpkg -l | grep -E '(java|openjdk|icedtea)' | grep -iv javascript | perl -F'/\s+/' -lane 'print $F[1]'

      # and then do:

        #sudo aptitude purge $PKG

      # Then install Oracle version (some things only work with it):

        sudo add-apt-repository -y ppa:webupd8team/java
        sudo aptitude update
        sudo aptitude install -y oracle-java8-installer

      # This already comes with the browser plugin.

      # Openjdk version + firefox plugin:

        #sudo aptitude install openjdk-7-jre
        #sudo aptitude install icedtea-7-plugin

      sudo aptitude install -y maven

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

        sudo add-apt-repository -y ppa:webupd8team/themes && \
        sudo aptitude update && \
        sudo aptitude install -y gnomishdark-theme

        sudo aptitude install -y compizconfig-settings-manager

      #sudo aptitude install zenity

      #sudo add-apt-repository ppa:webupd8team/y-ppa-manager && sudo aptitude update
      #sudo aptitude install -y yad

  ##fs

      sudo aptitude install -y inotify-tools

  ##net

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

        # First make sure that php and mysql are installed.

          sudo aptitude install -y libapache2-mod-auth-mysql php5-mysql phpmyadmin

          sudo vim /etc/apache2/apache2.conf

        # Ensure following line is anywhere in the file:

          #Include /etc/phpmyadmin/apache.conf

          sudo service apache2 restart

        # Test phpmyadmin and mysql:

          firefox http://localhost/phpmyadmin &

        # Login: 'root'. password: what you entered at installation.

        sudo aptitude install -y openssh-client
        sudo aptitude install -y openssh-server

        sudo aptitude install -y nmap
        sudo aptitude install -y whois

    ##browser

        sudo aptitude install -y chromium-browser

      # Terminal web browser:

        sudo aptitude install -y w3m w3m-img

      # Tor:

        sudo add-apt-repository ppa:webupd8team/tor-browser
        sudo apt-get update
        sudo apt-get install tor-browser

    ##db

      # MySQL:

        sudo aptitude install -y mysql-server

      ##remove mysql

        # Sometimes, misterious forces will prevent you mysql server from starting
        # and you will fell like erasing everything and restarting.
        # purging mysql-server may not be enough.
        # A hardcore solution that causes dataloss that worked for me once use:

          #sudo aptitude purge -y mysql-server
          #sudo aptitude purge -y mysql-common
          #sudo rm -rf /var/log/mysql
          #sudo rm -rf /var/log/mysql.*
          #sudo rm -rf /var/lib/mysql
          #sudo rm -rf /etc/mysql
          #sudo aptitude install -y mysql-server

        sudo aptitude install -y libmysqld-dev
        sudo aptitude install -y libmysqlclient-dev
        sudo aptitude install -y libmysql++-dev
        sudo aptitude install -y libmysql++-doc
        sudo aptitude install -y libmysqlcppconn-dev

      # PostgreSQL:

        sudo aptitude install -y libpq-dev
        sudo aptitude install -y postgresql
        sudo aptitude install -y postgresql-client

      # Redis server and cli client:

        sudo aptitude install -y redis-server

      # MongoDB server and cli client:

        sudo aptitude install -y mongodb

    ##mail

        sudo aptitude install -y mutt
        sudo aptitude install -y ssmtp

      # Conflicts with ssmtp:

        #sudo aptitude install -y postfix

  ##disk

      sudo aptitude install -y gparted

  ##desktop

    # Install all of the following. If a bug relates to graphical stuff,
    # change desktops to test.

      sudo aptitude install -y gnome-tweak-tool

    # Gnome shell:

      #sudo add-apt-repository -y ppa:gnome3-team/gnome3 && sudo aptitude update
      #sudo aptitude install -y gnome-shell

    # Linux Mint shell cinnamon:

      #sudo add-apt-repository -y ppa:gwendal-lebihan-dev/cinnamon-stable && sudo aptitude update
      #sudo aptitude install -y cinnamon

    # KDE shell plasma:

      sudo aptitude install -y kde-plasma-desktop

    # Xubuntu shell xfce:

      sudo aptitude install -y xfce4
      sudo aptitude install -y xfce4-battery-plugin

    # Lubuntu lxde:

      #sudo aptitude install -y lxde

    #  For `qtconfig-qt4`:

      sudo aptitude install -y qt4-qtconfig

  ##chat messaging voice video

    # Skype

      sudo add-apt-repository -y "deb http://archive.canonical.com/ $(lsb_release -sc) partner"
      sudo aptitude update
      sudo aptitude install -y skype

    # Google talk

      wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
      sudo sh -c 'echo "deb http://dl.google.com/linux/talkplugin/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
      sudo aptitude update
      sudo aptitude install -y google-talkplugin

    # Pidgin

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
      sudo aptitude install -y krusader
      sudo aptitude install -y kde-baseapps-bin  # needs to manage bookmarks. (otherwise, button does nothing): https://bugs.launchpad.net/ubuntu/+source/krusader/+bug/999695
      #sudo aptitude install -y konqueror
      sudo aptitude install -y konsole      # needs to terminal emulator. (otherwise, button does nothing)
      #sudo aptitude install -y khelpcenter4    # help
      sudo aptitude install -y kwalletmanager   # password manager

      sudo aptitude install -y fdupes

  ##gpu

    #nvidia

      sudo aptitude install -y nvidia-319
      sudo aptitude install -y nvidia-settings-319
      sudo aptitude install -y nvidia-prime
      sudo aptitude install -y nvidia-opencl-dev

  ##encoding

      sudo aptitude install convmv

  ##init

      sudo aptitude install -y chkconfig

  ##paas

    ##Google

      # Google Compute Engine gcutil

        #curl https://dl.google.com/dl/cloudsdk/release/install_google_cloud_sdk.bash | bash

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
