# Forensic rm

`rm` only removes files from filesystem indexes, but the data remains in place until the event that another file is written on it, which may take several minutes or hours.

Even after the file data overwritten few times, it is still possible to recover the data using expensive forensic methods (only viable for organizations).

To permanently remove data from hard disk, you must use a tool like shred, which writes certain sequences to the hard disk, making it impossible to recover the data even with forensic methods.

Such operations take a very long time, and are not viable on entire hard disks, so if you serious about clearing a hard disk, mechanical destruction is a better option (open the hard disk case and destroy the disk).

This is specially important for data-centers that are reusing / throwing away data.

- <http://askubuntu.com/questions/57572/how-to-delete-files-in-secure-manner>
- <http://security.stackexchange.com/questions/5662/is-it-enough-to-only-wipe-a-flash-drive-once/5665#5665>
- <http://security.stackexchange.com/questions/89404/how-do-i-prevent-ssd-file-recovery>

Tools:

- full-disk encryption
- `wipe`
- `shred`
- `sfill`

Physical methods:

- <http://askubuntu.com/a/58697/52975>

## Recover data removed with rm like tools
