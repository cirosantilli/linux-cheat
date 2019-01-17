#!/usr/bin/env bash

# Tested on: Ubuntu 18.10.
#
# Outcome: TianoCore logo shows, then after a while we go into an UEFI terminal.
#
# EDK helps implement UEFI, but it does not have the closed source low level parts
# which are left as exercises for the readers.
#
# OVFM implements those blobs for emulators.
#
# Bibliography:
#
# - https://github.com/tianocore/tianocore.github.io/wiki/How-to-build-OVMF/e372aa54750838a7165b08bb02b105148e2c4190
# - https://github.com/tianocore/tianocore.github.io/wiki/How-to-run-OVMF/aac4095ac9309c0746bd5a8fa2cee3bf79cc1436

git clone https://github.com/tianocore/edk2
cd edk2
https://github.com/tianocore/tianocore.github.io/wiki/How-to-build-OVMF
git checkout edk2-stable201811
sed -Ei \
  -e 's/^ACTIVE_PLATFORM .*/ACTIVE_PLATFORM = OvmfPkg\/OvmfPkgX64.dsc/' \
  -e 's/^TARGET_ARCH .*/TARGET_ARCH = X64/' \
  Conf/target.txt \
;
cd OvmfPkg
./build.sh
cd ..
qemu-system-x86_64 -bios ./Build/OvmfX64/DEBUG_GCC5/FV/OVMF.fd -enable-kvm
