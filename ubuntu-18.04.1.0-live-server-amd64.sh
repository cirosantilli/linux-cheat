#!/usr/bin/env bash
set -eu
# Tested on host: Ubuntu 18.10.
# TODO: get working without GUI:
# https://askubuntu.com/questions/1108334/how-to-boot-and-install-the-ubuntu-server-image-on-qemu-nographic-without-the-g
./ubuntu-18.04.1-desktop-amd64.sh -i ubuntu-18.04.1.0-live-server-amd64 -- "$@"
