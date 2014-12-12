# CD image

How to do operations such as convert and mount on CDs, DVDs, Blu-rays, etc.

## Formats

- bin: raw CD bytes
- ISO: open standard
- `mdf`/`mds` pair: proprietary of the Alcohol 120% company

## Mount

    sudo mkdir /media/iso
    sudo mount -o loop path/to/iso/file/YOUR_ISO_FILE.ISO /media/iso
