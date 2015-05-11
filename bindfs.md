# bindfs

<https://github.com/mpartel/bindfs>

FUSER filesystem similar to `mount --bind`, but allows you to mess with ownership and permissions.

Useful command:

    sudo bindfs -u a -g a --create-for-user=b --create-for-group=b from to

Mounts `from/` on `to/`.

`b` must exist.

`-u a -g a`: everything seen on `to` is owned by `a:a`

Everything created / saved on `b`, is created on `a` with owner `b:b`.

Unmount:

    fusermount -u /home/johnc/ISO-images
