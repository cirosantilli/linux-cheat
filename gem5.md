# gem5

BSD license.

Almost all 2016 commits by ARM and AMD employees.

Started in 2003 by <http://umich.edu/>.

ARM commits start 2009.

AMD commits start 2008.

## Getting started

Build:

    git clone https://gem5.googlesource.com/public/gem5.

    git clone
    hg clone http://repo.gem5.org/gem5
    cd gem5
    hg co stable_2015_09_03
    scons -j$(nproc) build/ARM/gem5.opt

Run Syscall Emulation (SE) mode:

    build/ARM/gem5.opt configs/example/se.py -c tests/test-progs/hello/bin/arm/linux/hello

Run Full System (FS) mode:

    export M5_PATH='/dist/m5/system'
    sudo mkdir -p "$M5_PATH"
    sudo chmod -R 777 "$M5_PATH"
    cd "$M5_PATH"
    wget http://www.gem5.org/dist/current/arm/aarch-system-2014-10.tar.xz
    unxz aarch-system-2014-10.tar.xz
    tar xvf aarch-system-2014-10.tar

    cd "$GEM_DIR"
    build/ARM/gem5.opt -d /tmp/output configs/example/fs.py

    # Another terminal.
    telnet localhost 3456

TODO: which image was used? How to change the default?

    build/ARM/gem5.opt -d /tmp/output configs/example/fs.py --disk-image /dist/m5/system/disks/aarch64-ubuntu-trusty-headless.img

Fails with:

    2777728592500: system.cpu.break_event: break event panic triggered

Some help at:

    build/ARM/gem5.opt -d /tmp/output configs/example/fs.py -h

TODO how were those images generated?

TODO screen / display image?
