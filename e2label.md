# e2label

Get / set ext[234] label info

Set new label for partition:

    sudo e2label /dev/sda7
    sudo e2label /dev/sda new_label

Each partition may have a label up to 16 chars length. If it does, the partition will get that name when mounted.

List all labels:

    sudo blkid
