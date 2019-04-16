#!/usr/bin/env bash

# TODO: Tested on host: Ubuntu 18.10, fails to set password most times.
# But I am alomst 100% that I've had at least one success with this exact same command.
# But the rate is so small that I sometimes doubt my memory.
#
# Bug report at: https://bugs.launchpad.net/cloud-images/+bug/1818197
#
# [FAILED] Failed to start Initial cloud-init job (pre-networking). always shows, including on working runs.
# It did not show on Ubuntu 18.04 host.
#
# Usually there is no error message, but I once saw this:
#
# [  113.002366] cloud-init[528]: Cloud-init v. 18.4-0ubuntu1~18.04.1 running 'init' at Thu, 17 Jan 2019 00:22:16 +0000. Up 105.40 seconds.
# [  113.020759] cloud-init[528]: ci-info: +++++++++++++++++++++++++++Net device info++++++++++++++++++++++++++++
# [  113.031208] cloud-init[528]: ci-info: +--------+-------+-----------+-----------+-------+-------------------+
# [  113.041449] cloud-init[528]: ci-info: | Device |   Up  |  Address  |    Mask   | Scope |     Hw-Address    |
# [  113.051615] cloud-init[528]: ci-info: +--------+-------+-----------+-----------+-------+-------------------+
# [  113.061778] cloud-init[528]: ci-info: | enp0s1 | False |     .     |     .     |   .   | 52:54:00:12:34:56 |
# [  113.071307] cloud-init[528]: ci-info: |   lo   |  True | 127.0.0.1 | 255.0.0.0 |  host |         .         |
# [  113.088462] cloud-init[528]: ci-info: |   lo   |  True |  ::1/128  |     .     |  host |         .         |
# [  113.097037] cloud-init[528]: ci-info: +--------+-------+-----------+-----------+-------+-------------------+
# [  113.100513] cloud-init[528]: ci-info: +++++++++++++++++++Route IPv6 info+++++++++++++++++++
# [  113.103872] cloud-init[528]: ci-info: +-------+-------------+---------+-----------+-------+
# [  113.107605] cloud-init[528]: ci-info: | Route | Destination | Gateway | Interface | Flags |
# [  113.111566] cloud-init[528]: ci-info: +-------+-------------+---------+-----------+-------+
# [  113.115000] cloud-init[528]: ci-info: +-------+-------------+---------+-----------+-------+
# [  113.118441] cloud-init[528]: 2019-01-17 00:22:23,983 - util.py[WARNING]: failed stage init
# [  113.238277] cloud-init[528]: failed run of stage init
# [  113.252444] cloud-init[528]: ------------------------------------------------------------
# [  113.255576] cloud-init[528]: Traceback (most recent call last):
# [  113.268398] cloud-init[528]:   File "/usr/lib/python3/dist-packages/cloudinit/cmd/main.py", line 658, in status_wrapper
# [  113.272674] cloud-init[528]:     ret = functor(name, args)
# [  113.285055] cloud-init[528]:   File "/usr/lib/python3/dist-packages/cloudinit/cmd/main.py", line 362, in main_init
# [  113.288945] cloud-init[528]:     init.apply_network_config(bring_up=bool(mode != sources.DSMODE_LOCAL))
# [  113.293122] cloud-init[528]:   File "/usr/lib/python3/dist-packages/cloudinit/stages.py", line 671, in apply_network_config
# [  113.304953] cloud-init[528]:     return self.distro.apply_network_config(netcfg, bring_up=bring_up)
# [  113.309150] cloud-init[528]:   File "/usr/lib/python3/dist-packages/cloudinit/distros/__init__.py", line 178, in apply_network_config
# [  113.322181] cloud-init[528]:     dev_names = self._write_network_config(netconfig)
# [  113.327226] cloud-init[528]:   File "/usr/lib/python3/dist-packages/cloudinit/distros/debian.py", line 114, in _write_network_config
# [  113.341030] cloud-init[528]:     return self._supported_write_network_config(netconfig)
# [  113.353698] cloud-init[528]:   File "/usr/lib/python3/dist-packages/cloudinit/distros/__init__.py", line 93, in _supported_write_network_config
# [  113.358591] cloud-init[528]:     renderer.render_network_config(network_config)
# [  113.376713] cloud-init[528]:   File "/usr/lib/python3/dist-packages/cloudinit/net/renderer.py", line 56, in render_network_config
# [  113.381516] cloud-init[528]:     templates=templates, target=target)
# [  113.385465] cloud-init[528]:   File "/usr/lib/python3/dist-packages/cloudinit/net/netplan.py", line 210, in render_network_state
# [  113.389682] cloud-init[528]:     self._netplan_generate(run=self._postcmds)
# [  113.393637] cloud-init[528]:   File "/usr/lib/python3/dist-packages/cloudinit/net/netplan.py", line 217, in _netplan_generate
# [  113.397718] cloud-init[528]:     util.subp(self.NETPLAN_GENERATE, capture=True)
# [  113.401648] cloud-init[528]:   File "/usr/lib/python3/dist-packages/cloudinit/util.py", line 2067, in subp
# [  113.405796] cloud-init[528]:     cmd=args)
# [  113.411233] cloud-init[528]: cloudinit.util.ProcessExecutionError: Unexpected error while running command.
# [  113.416694] cloud-init[528]: Command: ['netplan', 'generate']
# [  113.420785] cloud-init[528]: Exit code: -11
# [  113.424647] cloud-init[528]: Reason: -
# [  113.428686] cloud-init[528]: Stdout:
# [  113.431914] cloud-init[528]: Stderr:
# [  113.435345] cloud-init[528]: ------------------------------------------------------------

set -eux

# Parameters.
id=ubuntu-18.04-server-cloudimg-arm64
img="${id}.img"
img_snapshot="${id}.img.snapshot.qcow2"
flash0="${id}-flash0.img"
flash1="${id}-flash1.img"
user_data="${id}-user-data"
user_data_img="${user_data}.img"

# Install dependencies.
pkgs='cloud-image-utils qemu-system-arm qemu-efi'
if ! dpkg -s $pkgs >/dev/null 2>&1; then
  sudo apt-get install $pkgs
fi

# Get the image.
if [ ! -f "$img" ]; then
  wget "https://cloud-images.ubuntu.com/releases/18.04/release/${img}"
fi

# Create snapshot.
if [ ! -f "$img_snapshot" ]; then
  qemu-img \
    create \
    -b "$img" \
    -f qcow2 \
    "$img_snapshot" \
    1T \
  ;
fi

# Set the password.
if [ ! -f "$user_data" ]; then
  cat >"$user_data" <<EOF
#cloud-config
password: asdfqwer
chpasswd: { expire: False }
ssh_pwauth: True
EOF
  cloud-localds "$user_data_img" "$user_data"
fi

# Firmware.
if [ ! -f "$flash0" ]; then
  dd if=/dev/zero of="$flash0" bs=1M count=64
  dd if=/usr/share/qemu-efi/QEMU_EFI.fd of="$flash0" conv=notrunc
fi
if [ ! -f "$flash1" ]; then
  dd if=/dev/zero of="$flash1" bs=1M count=64
fi

# Run.
qemu-system-aarch64 \
  -machine virt \
  -cpu cortex-a57 \
  -device rtl8139,netdev=net0 \
  -device virtio-blk-device,drive=hd0 \
  -drive "if=none,file=${img_snapshot},id=hd0" \
  -drive "file=${user_data_img},format=raw" \
  -m 2G \
  -netdev user,id=net0 \
  -nographic \
  -pflash "$flash0" \
  -pflash "$flash1" \
  -smp 2 \
  "$@" \
;
