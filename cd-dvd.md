# CD DVD

How to do operations such as convert and mount on CDs, DVDs, Blu-rays, etc.

## Formats

- bin: raw CD bytes
- [ISO 9660](https://en.wikipedia.org/wiki/ISO_9660): open standard
- `mdf`/`mds` pair: proprietary of the Alcohol 120% company

## Mount

    sudo mkdir d
    sudo mount -o loop my.iso d
    ls d
    umount d

Apparently ISO cannot be mounted as writable: <http://unix.stackexchange.com/questions/26237/iso-file-readonly> Seems to be a format limitation.
