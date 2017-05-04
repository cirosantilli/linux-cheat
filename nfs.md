# NFS

Network File System.

Designed for LAN, has higher throughput than FTP.

FTP preferred on WAN.

Usage:

    sudo mkdir -p /mnt/local
    sudo mount -t nfs server.com:/path/in/server /mnt/local -o sync
    ls /mnt/local

The server may restrict access to only certain paths.

## Server

Good tutorial: <https://www.digitalocean.com/community/tutorials/how-to-set-up-an-nfs-mount-on-ubuntu-14-04>

    sudo mkdir /var/nfs
    sudo chown nobody:nogroup /var/nfs
    sudo service nfs-kernel-server start
    echo '/shared/dir *(rw,sync,no_subtree_check)' | sudo tee /etc/exports
    sudo exportfs -a
