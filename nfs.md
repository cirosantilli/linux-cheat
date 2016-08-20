# NFS

Network File System.

Designed for LAN, has higher throughput than FTP.

FTP preferred on WAN.

Usage:

    sudo mkdir -p /mnt/local
    sudo mount -t nfs server.com:/path/in/server /mnt/local -o sync
    ls /mnt/local

The server may restrict access to only certain paths.
