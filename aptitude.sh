#!/usr/bin/env bash

##apt-get vs aptitude vs synaptic

    # USE APTITUDE INSTEAD OF APT-GET!!!

    # Reason: on remove aptitude removes all dependencies which were not installed explicitly
    # But apt-get does not. Example: you installed package a, with 50 dependancies d1, d2, etc.
    # Which were not installed. If you do `apt-get unsinstall a`, the deps stay, and you have to do
    # `apt-get uninstall d1, d2, ...`, but if you installed with `aptitude`, and you do `aptitude unistall`,
    # D1 .. d50 are all removed.

    # *it seems that* apt-get aptitude, and synaptic are front-ends for dpkg. therefore they should be compatible.

    # Synaptic has a gui interface, but less options..

    # Aptitude seems to be more powerful than apt-get

    # #metapackages

        # Metapackages are packages that contain no source code of their own, but have several dependencies

        # They serve as a collection of software that is useful when installed together.

        # Examples: texlive-full (*lots* ot latex packages), several desktop environments, etc.

        # It seems that dpkg without additional info has no way to tell the
        # Difference between packages installed as deps of a metadata
        # And packages explicitly installed: it is as if you had written if all by yourself on the command line

        # It seems that aptitude can store this information, and desinstall metapackages in one go:
        # *major* reason for using aptitude!!!

        # There seems to be no way of telling

    # #dev packages

        # Are packages that contain libraries to build stuff, typically .so files

    # #source types

        # - Main - Officially supported software.
        # - Restricted - Supported software that is not available under a completely free license.
        # - Universe - Community maintained software, i.e. not officially supported software.
        # - Multiverse - Software that is not free.

##first time

    sudo apt-get update
    sudo apt-get install aptitude

    # #proxy

        sudo vim /etc/apt/apt.conf
        Acquire::http::Proxy "http://proxy.server.here:port/";
        # Add the last line to your /etc/apt/apt.conf to enable apt-get through a proxy-server.

##making packages

    # TODO! =) someday ill get to the point of having something useful to package too myself...
    # And then I'll learn this!

##ppa

    # Ppas are sources of software

    # They may or not be officially supported by ubuntu.

    # To add a new source you must do two things:

    # - add a the ppa key to the trusted ppa list
    # - add the ppa to the ppa list

    # #find sources

        # Launchpad is the main source for ppas and the site is maintained by ubuntu. look there first.

        # Next google it.

    # #list sources

        # Default sources:

            cat /etc/apt/sources.list

        # PPAs:

            ls -1 /etc/apt/sources.list.d/

    # #keys

        # In order to trus a ppa, you have to add its key.

        # This is called a <#digital signature>.

        # It is meant to:

        # - ensure that you received the data from who you think you did
        # - ensure that the data was not modified in its way to you

        # Keys are managed by <#gpg>, and kept in:

            gpg /etc/apt/trustdb.gpg

        # So if you want to really understand things, you must first understand gpg

        # List keys easily:

            apt-key list

        # #add keys

                sudo apt-key adv --keyserver pgp.mit.edu --recv-keys 5044912E

            # #wget

                wget -q -O - http://archive.getdeb.net/getdeb-archive.key | sudo apt-key add -

    # #ppas in launchpad

        # Launchapd is maintainedd by canonical, and it is easy to
        # Install/remove packages from them with `add-apt-repository`
        # Which add key and source easily

        # #launchpad ppas

                sudo add-apt-repository ppa:deluge-team/ppa
                sudo aptitude update

            # - `deluge-team` is an username
            # - ppa is an specific ppa from that username

            # -y: don't ask for confirmation:

                sudo add-apt-repository -y ppa

        # Remove sources

            # You could remove them manually, but there it is better to do that with ppa-purge:

                sudo aptitude install ppa-purge
                sudo ppa-purge ppa:matthaeus123/mrw-gimp-svn

            # Not sure what is the difference of:

                sudo add-apt-repository --remote

    # #ppas outside launchpad

        # The best I could find for now to add was the getdeb way:

            wget -q -O - http://archive.getdeb.net/getdeb-archive.key | sudo apt-key add -
            sudo sh -c 'echo "deb http://archive.getdeb.net/ubuntu quantal-getdeb games" >> /etc/apt/sources.list.d/getdeb.list'

        # And to remove:

            sudo rm /etc/apt/sources.list.d/getdeb.list
            apt-key list | less
                # Pub   4096R/46D7E7CF 2009-05-15
                #             ^^^^^^^^
                #             KEY
            KEY=
            sudo apt-key del "$KEY"

        # Keep a list of all ppas added like this somewhere.

        # If you want to uninstall, you will remember the filename to remove

        # #add-apt-repository

            # Bad

            # You can also add just the source but not the key with:

                sudo add-apt-repository -y "deb http://archive.ubuntugames.org ubuntugames main"

            # And it will be appended to the `sources.list` directly,
            # Which is worse than using a file that is easier to remove!

##update

    # Looks for possible updgrades on known sources,
    # But does not install them

        sudo aptitude update

##get info on installed packages

    # #dpkg

        # Info on installed packages

        # List all installed packages.and greps for foo:

            dpkg -l | grep $EXPRESSION

        # The first two letters mean:

        # - ii: installed
        # - rc: configuration files only (rc means config such as in bashRC)

        # List files in installed package

            dpkg -L mysql

        # Install `.deb` file:

            dpkg -i a.deb

##find new packages

    # Searches package name and descriptions on the web:

        apt-cache search "$PATTERN"

    # Pattern is a Posix ERE

    ##apt-file

        # Search for and list package files. **very** useful to know:
        # which package provides a missing file like a `bin/name` or `include/name.h`?

        sudo aptitude install apt-file
        apt-file update
        f=

        ##search

            # Search for file "$F" in packages.

                apt-file search "$f"

            # Literal full path substring match

            # Use perl regex:

                apt-file search -x "a.c"

            # Combo: search for an executable called a2x:

                apt-file search bin/a2x

        ##show

            # Shows files in package p

                p=
                apt-file show "$p"

##get new package info

    # List package dependencies

        apt-cache depends $PKG

    # ? what is the difference between this and depends

        sudo apt-get build-dep $PKG

    # Find who depends on $PKG (reverse dependencies):

        sudo apt-rdepends -r $PKG

    # Get basic information about a package:

        apt-cache show $PKG

    # Get detailed information about a package:

        apt-cache showpkg $PKG

    sudo aptitude install debtags
    debtags tag ls $PKG

    # Package naming conventions:

    # -dev:  headers and libs, no docs
    # -doc:  documentation
    # -test: tests

##install

    # Install package

        sudo aptitude install $PKG

    # Also installs recommended packages

        sudo aptitude install -o APT::Install-Recommends="true" $PKGg

    # -o option changes things which could be in the config files.

    # Also installs suggested packages

        sudo aptitude install -o APT::Install-Suggests="true" $PKGg

    # Install only the dependencies required for a package but not the package itself:

        sudo aptitude build-dep $PKG

    # This is useful if you want to dev a package that has compiled dependencies.

    # Install specific version of a package:

        sudo apt-get install apache2=2.2.20-1ubuntu1

    # Very likely to clash with other installed versions of the package.

##upgrade installed packages

    # Move to next version

    # Upgrade a single package:

        sudo apt-get -u install $PKG

    # Upgrades all packages for which upgrade does not involve installing more packages

        sudo apt-get -u upgrade

    # Upgrades all packages, even if upgrade requires installation of new packages

        sudo apt-get dist-upgrade

##remove packages. someday they have to die =(

    # Sudo apt-get remove $PKG

    # Remove package but leave configuration files:

        sudo aptitude remove $PKG

    # Sudo apt-get purge $PKG
    sudo aptitude purge $PKG
    # Remove package and configuration files

    sudo apt-get autoremove
    # Removes dependencies which you did not install explicitly (didn't write on the command line yourself)
    # And that are no longer necessary. always follows remove or purge
    # Dpkg then must contain information about what you installed yourself or not.

    # Does nothing for packages that come from metapackages, which are treated as if you had
    # Manually installed them. This is where aptitude comes in!

    sudo apt-get autoclean
    # ?

    sudo apt-get clean
    # ?

##optins

    sudo aptitude install -y "$PKG"
          # Dont prompt for confirmation

##common combos

    # To correct dep problems try:

        PKG=gimp
        sudo apt-get update
        sudo apt-get purge $PKG
        sudo apt-get autoremove
        sudo apt-get autoclean
        sudo apt-get clean
        sudo apt-get autoremove
        suto apt-get install $PKG
        # Also, if the package comes from a ppa, remove the ppa and try again
        # Sources list. does not include ppas
