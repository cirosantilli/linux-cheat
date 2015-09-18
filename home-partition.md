# Home partition

If you are a developer, create a separate partition and put your home on the root `/` of that partition, then mount it on the root filesystem.

Benefits:

- you can easily share your home between multiple operating systems: just mount it up, and all your user configs will be automatically reused across multiple development environments.
- if your home HD gets filled with large downloads, your system won't get into trouble, since it uses a separate partition.

An alternative is you have multiple users that you want to backup, is to put each one as:

    /user1
    /user2

on the partition.

When you boot, make sure to make the directory readable by the user:

    sudo mkdir /home/user1
    sudo chown user1:user1 /home/user1

On Ubuntu 14.04 Live Install, you can setup a home partition at the "Do something else" installation step: just select the partition and mount it on the right place.

Use the same username on new systems, and mount the partition automatically with `fstab`. For every new system, just copy the fstab line.

30GiB is a good size for each Ubuntu 14.04 root partition. Leave everything else for the home partition.
