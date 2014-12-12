# Ubuntu

Most useful files:

- [install.sh](install.sh): installation procedures for tons of programs.
- [apt-get.md](apt-get.md): information on Ubuntu's packages and related tools.

## Sources

-   <http://www.ubuntu.com/>: central official resource that links to all

-   <http://askubuntu.com/>

    Stack Exchange for Ubuntu. Sometimes you get fast answers, sometimes not.

-   <https://bugs.launchpad.net/ubuntu/>: official bug tracker.

    Includes bugs on the officially supported packages, e.g.: restricted:
    <https://bugs.launchpad.net/ubuntu/+source/nvidia-graphics-drivers-304>

## Introduction

Ubuntu is likely to be one of the most used distros as of 2014-03:

	http://distrowatch.com/dwres.php?resource=popularity

Ubuntu is maintained by the company Canonical which gets money by offering maintenance,

## Releases

Ubuntu is releases happen at approximately 6 month intervals.

Release numbers are based on the final release date and year. E.g.: Ubuntu 13.04 was released in April 2013.

Releases also get code names, which are date independent. E.g.: Ubuntu 12.04 is Precise Pangolin, AKA just Precise.

One in every four releases is marked Long Term Support LTS and receives official support for 5 years. As of 2014-02, the last LTS was Precise 12.04, with a new one coming soon. Non LTS releases are supporter for 18 months only.

For your sanity: only use LTS releases. If a problem is corrected in a future version, and there is a workaround, use the workaround. 6 months is too short a time interval for stability, and all server software should run on LTS, so you can reproduce production more easily.

## Debian

Ubuntu is a Debian based distribution.

Ubuntu is maintained by the company Canonical, while Debian is managed by the community.

Important implications:

-   many key package manager programs are the same:

	- `dpkg` for packages
	- `upstart` for init

-   special directories conventions are the same:

	- `/media` for mounting

## Open app without global menu

	env UBUNTU_MENUPROXY=0 golly

## Configurations

## Utilities

### Get current Ubuntu version

	lsb_release -a | grep Release

### Upgrade Ubuntu to newer version

	sudo aptitude install -y update-manager-core
	sudo do-release-upgrade
	sudo aptitude update && sudo aptitude upgrade


### ubuntu-tweak

Configure Ubuntu GUI.

### ubuntu-drivers

Present in 14.04. `jockey` was used in 12.04.

Command line interface for the "Additional drivers" dialog.

List possible drivers for present hardware:

    sudo ubuntu-drivers devices

Sample output from an NVIDIA GPU:

    == /sys/devices/pci0000:00/0000:00:01.0/0000:01:00.0 ==
    vendor   : NVIDIA Corporation
    modalias : pci:v000010DEd00000DEFsv000017AAsd000021F4bc03sc00i00
    model    : GF108M [NVS 5400M]
    driver   : nvidia-304 - distro non-free
    driver   : nvidia-331-updates - distro non-free
    driver   : nvidia-304-updates - distro non-free
    driver   : nvidia-331 - distro non-free recommended
    driver   : xserver-xorg-video-nouveau - distro free builtin

You can then install or uninstall the drivers with `apt-get`:
`nvidia-304`, `nvidia-331`, etc. are the actual package names.

### Locale

On 14.04, the following file defines many locale environment variables:

    cat /etc/default/locale

It sets them based on your location, not on your language.

## HWE

## Hardware Enablement

<http://askubuntu.com/questions/248914/what-is-hardware-enablement-hwe>
