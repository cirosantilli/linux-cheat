# rsync

Very powerful and flexible file tool to synchronize directories.

Can:

-   work over networks. Both machines must have it installed.

    Capable of compressing before sending over the network, and decompressing on the other side.

    Sample usage:

        rsync -av 192.168.0.20:/some/path new/path

-   synchronize differentially: only copies files that are newer, skip already copied ones.

-   encrypt files sent

## e

`rsync` can use many "remote shells" (what is that?), and `ssh` is one of them (the default?)

So in order to use `rsync`, first make sure that you can login into the computer with plain ssh.

### Too many authentication failures for *username*

Sample usage at <http://superuser.com/questions/187779/too-many-authentication-failures-for-username>

    rsync -av -e 'ssh -o PubkeyAuthentication=no' 'remote_user@host.com:~/remote/file' 'local/file'

### Custom ssh port

    rsync -av -e 'ssh -p 2222' 'remote_user@host.com:~/remote/file' 'local/file'

## Useful options

`-a`: "archive mode". Sets all the most useful options:

    rsync -a origin dest

Sets : `-Dgloprt`

Does what you want it to do, before you notice you need it:

- `-D`: preserve special and device files. Requires sudo.
- `-g`: preserve group. Requires `sudo`
- `-l`: copy symlinks as symlinks
- `-o`: preserve owner. Requires `sudo`
- `-p`: preserve permissions
- `-r`: recurse into directories
- `-t`: preserve modification times
- `--exclude=`: Exclude directories
- `-v`: verbose
- `-z`: compress files before transfer, decompress after.

Useful if transfer will be done over a network, so that smaller files can be transferred.

## Combos

Back up everything except `/media` (where the backup will go to), and `/home`.

    sudo rsync -av --exclude=home --exclude=media / /media/SOMETHING/bak

WARNING: your disk must be ext4, not NTFS, or permissions are impossible. In that case: http://unix.stackexchange.com/questions/11757/is-ntfs-under-linux-able-to-save-a-linux-file-with-its-chown-and-chmod-settings

## Two remotes

- <http://serverfault.com/questions/411552/rsync-remote-to-remote>
- <http://unix.stackexchange.com/questions/183504/how-to-rsync-files-between-two-remotes>

## Move files

TODO impossible? I wanted that to use nice things like `--exclude` as in:

    rsync --remove-source-files --exclude .git * buildroot

but `--remove-source-files` does not prevent the copy with a `mv`, it only simply unlinks the original after it is copied.

- <http://serverfault.com/questions/147624/getting-rsync-to-move-file-from-source-to-destination>
- <http://stackoverflow.com/questions/9849794/mv-equivalent-rsync-command>
- <http://unix.stackexchange.com/questions/43957/using-rsync-to-move-not-copy-files-between-directories>
