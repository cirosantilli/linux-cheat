# rsync

Very powerful and flexible file tool to synchronize directories.

Can:

-   work over networks. Both machines must have it installed.

    Capable of compressing before sending over the network, and decompressing on the other side.

-   synchronize differentially: only copies files that are newer, skip already copied ones.

-   encrypt files sent

Useful options:

- `-a`: "archive mode".

  # rsync -a origin dest

Sets : `-Dgloprt`

Does what you want it to do, before you notice you need it:

- `-D`: preserve special and device files. Requires sudo.
- `-g`: preserve group. Requires `sudo`.
- `-l`: copy symlinks as symlinks.
- `-o`: preserve owner. Requires `sudo`.
- `-p`: preserve permissions.
- `-r`: recurse into directories.
- `-t`: preserve modification times.
- `--exclude=`: Exclude directories.
- `-v`: verbose
- `-z`: compress files before transfer, decompress after.

Useful if transfer will be done over a network,
so that smaller files can be transferred.

Combos:

Back up everything except `/media` (where the backup will go to), and `/home`.

    sudo rsync -av --exclude=home --exclude=media / /media/SOMETHING/bak

WARNING: your disk must be ext4, not NTFS, or permissions are impossible. In that case: http://unix.stackexchange.com/questions/11757/is-ntfs-under-linux-able-to-save-a-linux-file-with-its-chown-and-chmod-settings
