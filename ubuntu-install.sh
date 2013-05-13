#!/usr/bin/env bash

#ubuntu info, and in special ubuntu specific program installation procedures

#running this file should do all automatable steps to install useful stuff we find useful.

##info

    #a debian based distribution

    #important implications:

        #maby key programs are the same: `dpkg` for packages, `upstart` for init

    ##upgrade version

        #sudo aptitude install -y update-manager-core
        #sudo do-release-upgrade
        #sudo aptitude update && sudo aptitude upgrade

    #oppen app without global menu

        #env UBUNTU_MENUPROXY=0 golly

    #ubuntu-tweak

        #configure ubuntu


##installation procedures

    ##before anything

            sudo apt-get update

        #like apt-get, but removing  a package will also uninstall all dependencies that
        #were installed for that package:

            sudo apt-get install -y aptitude

    ##default ppas

        #those already come in default ppas

            sudo aptitude install -y abcde
            sudo aptitude install -y alarm-clock-applet
            sudo aptitude install -y apt-rdepends

            sudo aptitude install -y apt-file
            apt-file update

            sudo aptitude install -y aview

        #.arj files:

            #sudo aptitude install -y arj

        #microsoft cabinet format:

            #sudo aptitude install -y cabextract

            sudo aptitude install -y caca-utils
            sudo aptitude install -y cplay
            sudo aptitude install -y dvipng
            #sudo aptitude install -y exactimage
            sudo aptitude install -y file-roller

        #glasgow haskell compiler:

            #sudo aptitude install -y ghc

            sudo aptitude install -y gimp
            sudo aptitude install -y gnome-tweak-tool
            sudo aptitude install -y goldendict

        #ibus input methods for qt:

            sudo aptitude install -y ibus-qt4

            sudo aptitude install -y id3tool

        #image magick:

            sudo aptitude install -y imagemagick
            sudo aptitude install -y imagemagick-doc

            sudo aptitude install -y inkscape

            sudo aptitude install -y lame
            sudo aptitude install -y logkeys

        #nasm assembler:

            sudo aptitude install -y nasm

        #.lzh files used on DOS, legacy:

            #sudo aptitude install -y lha

        #mime messages

            #sudo aptitude install -y mpack

        #7 zip:

            sudo aptitude install -y p7zip-full

            sudo aptitude install -y ppa-purge
            sudo aptitude install -y python-scipy
            sudo aptitude install -y python-matplotlib

        #shell archives:

            #sudo aptitude install -y sharutils

        ##sox

                sudo aptitude intall -y sox
                sudo aptitude intall -y libsox-fmt-mp3

            #search for formats and install those you want:

                #apt-cache search libsox-fmt-

        #usefull stuff that does not come by default or Canonical would have to pay royalties:

            sudo aptitude install -y ubuntu-restricted-extras


        #.ace files

            #sudo aptitude install -y unace

        #uuencode, xxencode, BASE64, quoted printable, BinHex

            sudo aptitude install -y uudeview

            sudo aptitude install -y zip unzip
            sudo aptitude install -y wmctrl

        ##chm

            #sudo aptitude install -y kchmreader
            sudo aptitude install -y chmsee

##launchpad ppas

    #you must first add ppas with `apt-add-repository`

        sudo add-apt-repository -y ppa:tualatrix/ppa && sudo aptitude update
            sudo aptitude install -y ubuntu-tweak

        sudo add-apt-repository -y ppa:atareao/atareao && sudo apt-get update
            sudo apt-get install my-weather-indicator

        sudo add-apt-repository -y ppa:flacon && sudo aptitude update
            sudo aptitude install -y flacon

    #gnome shell:

        sudo add-apt-repository -y ppa:gnome3-team/gnome3 && sudo aptitude update
            sudo aptitude install -y gnome-shell

##non launchpad ppas

    #you must first add ppas manually:
