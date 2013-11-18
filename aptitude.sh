#!/usr/bin/env bash

##apt-get vs aptitude vs synaptic

    #USE APTITUDE INSTEAD OF APT-GET!!!

    #reason: on remove aptitude removes all dependencies which were not installed explicitly
    #but apt-get does not. Example: you installed package a, with 50 dependancies d1, d2, etc.
    #which were not installed. If you do `apt-get unsinstall a`, the deps stay, and you have to do
    #`apt-get uninstall d1, d2, ...`, but if you installed with `aptitude`, and you do `aptitude unistall`,
    #d1 .. d50 are all removed.

    #*it seems that* apt-get aptitude, and synaptic are front-ends for dpkg. therefore they should be compatible.

    #synaptic has a gui interface, but less options..

    #aptitude seems to be more powerful than apt-get

    ##metapackages

        #metapackages are packages that contain no source code of their own, but have several dependencies

        #they serve as a collection of software that is useful when installed together.

        #examples: texlive-full (*lots* ot latex packages), several desktop environments, etc.

        #it seems that dpkg without additional info has no way to tell the
        #difference between packages installed as deps of a metadata
        #and packages explicitly installed: it is as if you had written if all by yourself on the command line

        #it seems that aptitude can store this information, and desinstall metapackages in one go:
        #*major* reason for using aptitude!!!

        #there seems to be no way of telling

    ##dev packages

        #are packages that contain libraries to build stuff, typically .so files

    ##source types

        #- Main - Officially supported software.
        #- Restricted - Supported software that is not available under a completely free license.
        #- Universe - Community maintained software, i.e. not officially supported software.
        #- Multiverse - Software that is not free.

##first time

    sudo apt-get update
    sudo apt-get install aptitude

    ##proxy

        sudo vim /etc/apt/apt.conf
        Acquire::http::Proxy "http://proxy.server.here:port/";
        #add the last line to your /etc/apt/apt.conf to enable apt-get through a proxy-server.

##making packages

    #TODO! =) someday ill get to the point of having something useful to package too myself...
    #and then I'll learn this!

##ppa

    #ppas are sources of software

    #they may or not be officially supported by ubuntu.

    #to add a new source you must do two things:

    #- add a the ppa key to the trusted ppa list
    #- add the ppa to the ppa list

    ##find sources

        #launchpad is the main source for ppas and the site is maintained by ubuntu. look there first.

        #next google it.

    ##list sources

        #Default sources:

            cat /etc/apt/sources.list

        #PPAs:

            ls -1 /etc/apt/sources.list.d/

    ##keys

        #in order to trus a ppa, you have to add its key.

        #this is called a <#digital signature>.

        #It is meant to:

        #- ensure that you received the data from who you think you did
        #- ensure that the data was not modified in its way to you

        #keys are managed by <#gpg>, and kept in:

            gpg /etc/apt/trustdb.gpg

        #so if you want to really understand things, you must first understand gpg

        #list keys easily:

            apt-key list

        ##add keys

                sudo apt-key adv --keyserver pgp.mit.edu --recv-keys 5044912E

            ##wget

                wget -q -O - http://archive.getdeb.net/getdeb-archive.key | sudo apt-key add -

    ##ppas in launchpad

        #launchapd is maintainedd by canonical, and it is easy to
        #install/remove packages from them with `add-apt-repository`
        #which add key and source easily

        ##launchpad ppas

                sudo add-apt-repository ppa:deluge-team/ppa
                sudo aptitude update

            #- `deluge-team` is an username
            #- ppa is an specific ppa from that username

            #-y: don't ask for confirmation:

                sudo add-apt-repository -y ppa

        #remove sources

            #you could remove them manually, but there it is better to do that with ppa-purge:

                sudo aptitude install ppa-purge
                sudo ppa-purge ppa:matthaeus123/mrw-gimp-svn

            #not sure what is the difference of:

                sudo add-apt-repository --remote

    ##ppas outside launchpad

        #the best I could find for now to add was the getdeb way:

            wget -q -O - http://archive.getdeb.net/getdeb-archive.key | sudo apt-key add -
            sudo sh -c 'echo "deb http://archive.getdeb.net/ubuntu quantal-getdeb games" >> /etc/apt/sources.list.d/getdeb.list'

        #and to remove:

            sudo rm /etc/apt/sources.list.d/getdeb.list
            apt-key list | less
                #pub   4096R/46D7E7CF 2009-05-15
                #            ^^^^^^^^
                #            KEY
            KEY=
            sudo apt-key del "$KEY"

        #keep a list of all ppas added like this somewhere.

        #if you want to uninstall, you will remember the filename to remove

        ##add-apt-repository

            #bad

            #you can also add just the source but not the key with:

                sudo add-apt-repository -y "deb http://archive.ubuntugames.org ubuntugames main"

            #and it will be appended to the `sources.list` directly,
            #which is worse than using a file that is easier to remove!

##update

    #looks for possible updgrades on known sources,
    #but does not install them

        sudo aptitude update

##get info on installed packages

    ##dpkg

        #info on installed packages

        #list all installed packages.and greps for foo:

            dpkg -l | grep $EXPRESSION

        #The first two letters mean:

        #- ii: installed
        #- rc: configuration files only (rc means config such as in bashRC)

        #list files in installed package

            dpkg -L mysql

        #Install `.deb` file:

            dpkg -i a.deb

##find new packages

    #searches package name and descriptions on the web:

        apt-cache search "$PATTERN"

    #pattern is a Posix ERE

    ##apt-file

        #search for and list package files

        #**very** useful:

        #- who provides such a file?
        #- where does htis file come from?

        sudo aptitude install apt-file
        apt-file update
        f=

        ##search

            #search for file "$F" in packages.

                apt-file search "$f"

            #literal full path substring match

            #use perl regex:

                apt-file search -x "a.c"

            #combo: search for an executable called a2x:

                apt-file search bin/a2x

        ##show

            #shows files in package p

                p=
                apt-file show "$p"

##get new package info

    #list package dependencies

        apt-cache depends $PKG

    #? what is the difference between this and depends

        sudo apt-get build-dep $PKG

    #find who depends on $PKG (reverse dependencies):

        sudo apt-rdepends -r $PKG

    #get basic information about a package:

        apt-cache show $PKG

    #get detailed information about a package:

        apt-cache showpkg $PKG

    sudo aptitude install debtags
    debtags tag ls $PKG

    #package naming conventions
        #-dev:  headers and libs, no docs
        #-doc:  documentation
        #-test: tests

##install

    #install package

        sudo aptitude install $PKG

    #also installs recommended packages

        sudo aptitude install -o APT::Install-Recommends="true" $PKGg

    #-o option changes things which could be in the config files.

    #also installs suggested packages

        sudo aptitude install -o APT::Install-Suggests="true" $PKGg

    #install only the dependencies required for a package but not the package itself:

        sudo aptitude build-dep $PKG

    #this is useful if you want to dev a package that has compiled dependencies

##upgrade installed packages

    #move to next version

    #upgrade a single package:

        sudo apt-get -u install $PKG

    #upgrades all packages for which upgrade does not involve installing more packages

        sudo apt-get -u upgrade

    #upgrades all packages, even if upgrade requires installation of new packages

        sudo apt-get dist-upgrade

##remove packages. someday they have to die =(

    #sudo apt-get remove $PKG
    sudo aptitude remove $PKG
    #remove package but leave configuration files

    #sudo apt-get purge $PKG
    sudo aptitude purge $PKG
    #remove package and configuration files

    sudo apt-get autoremove
    #removes dependencies which you did not install explicitly (didn't write on the command line yourself)
    #and that are no longer necessary. always follows remove or purge
    #dpkg then must contain information about what you installed yourself or not.

    #does nothing for packages that come from metapackages, which are treated as if you had
    #manually installed them. This is where aptitude comes in!

    sudo apt-get autoclean
    #?

    sudo apt-get clean
    #?

##optins

    sudo aptitude install -y "$PKG"
          #dont prompt for confirmation

##common combos

    #to correct dep problems try:

        PKG=gimp
        sudo apt-get update
        sudo apt-get purge $PKG
        sudo apt-get autoremove
        sudo apt-get autoclean
        sudo apt-get clean
        sudo apt-get autoremove
        suto apt-get install $PKG
        #also, if the package comes from a ppa, remove the ppa and try again
        #sources list. does not include ppas
