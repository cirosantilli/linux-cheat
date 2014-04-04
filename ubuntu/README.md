Ubuntu specific info.

Most useful files:

- [install.sh](install.sh): installation procedures for tons of programs.
- [apt-get.md](apt-get.md): information on Ubuntu's package system.

#Introduction

Ubuntu is likely to be one of the most used distros as of 2014-03:

	http://distrowatch.com/dwres.php?resource=popularity

Ubuntu is maintained by the company Canonical which gets money by offering maintenance,

#Releases

Ubuntu is releases happen at approximately 6 month intervals.

Release numbers are based on the final release date and year. E.g.: Ubuntu 13.04 was released in April 2013.

Releases also get code names, which are date independent. E.g.: Ubuntu 12.04 is Precise Pangolin, AKA just Precise.

One in every four releases is marked Long Term Support LTS and receives official support for 5 years. As of 2014-02, the last LTS was Precise 12.04, with a new one coming soon. Non LTS releases are supporter for 18 months only.

For your sanity: only use LTS releases. If a problem is corrected in a future version, and there is a workaround, use the workaround. 6 months is too short a time interval for stability, and all server software should run on LTS, so you can reproduce production more easily.

#Debian

Ubuntu is a Debian based distribution.

Ubuntu is maintained by the company Canonical, while Debian is managed by the community.

Important implications:

- many key package manager programs are the same:

	- `dpkg` for packages
	- `upstart` for init

- special directories conventions are the same:

	- `/media` for mounting

#Get current Ubuntu version

	lsb_release -a | grep Release

#Upgrade Ubuntu to newer version

	sudo aptitude install -y update-manager-core
	sudo do-release-upgrade
	sudo aptitude update && sudo aptitude upgrade

#Open app without global menu

	env UBUNTU_MENUPROXY=0 golly

#Utilities

##ubuntu-tweak

Configure Ubuntu.
