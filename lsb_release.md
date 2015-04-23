# lsb_release

Required by the LSB.

Get distro maintainer, name, version and version codename:

    lsb_release -a

Sample output:

    LSB Version:    core-2.0-amd64:core-2.0-noarch:core-3.0-amd64:core-3.0-noarch:core-3.1-amd64:core-3.1-noarch:core-3.2-amd64:core-3.2-noarch:core-4.0-amd64:core-4.0-noarch:core-4.1-amd64:core-4.1-noarch:security-4.0-amd64:security-4.0-noarch:security-4.1-amd64:security-4.1-noarch
    Distributor ID: Ubuntu
    Description:    Ubuntu 14.04.2 LTS
    Release:        14.04
    Codename:       trusty

TODO understand `LSB Version`.

Extract id programmatically to autodetect distro:

    distro_id="$(lsb_release -i | sed -r 's/.*:\t(.*)/\1/')"
    distro_version="$(lsb_release -r | sed -r 's/.*:\t(.*)/\1/')"
