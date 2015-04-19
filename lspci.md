# lspci

pciutils package <http://mj.ucw.cz/sw/pciutils/>

Produces a human readable versions of information found under `/sys/bus/pci/devices`. This tutorial assumes that you understand that tree.

Get numerical data:

    sudo lspci -n | head -n 1

Sample output:

    00:00.0 Host bridge: Intel Corporation 3rd Gen Core processor DRAM Controller (rev 09)
    ^^^^^^^ ^^^^^^^^^^^  ^^^^^^^^^^^^^^^^^ ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    1       2            3                 4

1. comes from the directory name under `/sys/bus/pci/devices`
2. TODO where does it come from? `class`?
3. translated `cat vendor` ID
4. translated `cat device` ID

This translates IDs with the `/usr/share/hwdata/pci.ids` file, provided by the `hwdata` package: <https://git.fedorahosted.org/hosted/hwdata.git/>.

Get the raw numerical data:

    sudo lspci -n | head -n 1

Sample output:

    00:00.0 0600: 8086:0154 (rev 09)
    ^^^^^^^ ^^^^  ^^^^ ^^^^
    1       2     3    4

where each field is the same as those of the translated output.
