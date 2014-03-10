Ubuntu specific info.

Ubuntu is likely to be one of the most used distros as of 2014-03:

	http://distrowatch.com/dwres.php?resource=popularity

Ubuntu is maintained by Canonical company which gets money by offering maintenance,

#debian

Ubuntu is a Debian based distribution

Ubuntu is maintained by a company,  while Debian is managed by the community.

Important implications:

- many key package manager programs are the same:

	- `dpkg` for packages
	- `upstart` for init

- special directories conventions are the same:

	- `/media` for mounting

##get current ubuntu version

	lsb_release -a | grep Release

##upgrade ubuntu version

	sudo aptitude install -y update-manager-core
	sudo do-release-upgrade
	sudo aptitude update && sudo aptitude upgrade

# Open app without global menu:

	env UBUNTU_MENUPROXY=0 golly

#utilities

##ubuntu-tweak

Configure Ubuntu.
