# Device drivers

One specific type of kernel module.

Device drivers offer an interface to userland through device files.

Device files are not regular on disk files, but offer an interface similar to disk files via the standard file system calls like `write` and `read`.

On this case however, it is entirely up to the device to implement what each system call should do. Obviously, developers should use intuitive calls for the operations, so for example `open` should make any required initializations, `write` send data to the device, `read` get data from the device, and `close` make cleanup operations.

Devices drives do not need to map to actual physical devices like keyboards, cameras etc., even though most are linked in some way to physical devices. E.g., `/dev/null` has absolutely no relation to physical objects.

The standard location for device files is `/dev/`. This section will not cover the standard device drivers present there.

## Type

## Major number

## Minor number

Three parameters identify a device driver:

1.  type: either block or char

    The type is required: a given major / minor pair can have two completely different meanings

1.  Major number.

    Traditionally tells kernel which driver controls the device represented by this file.

    Currently many drivers can share a single major number.

1.  Minor number.

    ID of each hardware controlled by a given driver.

### Get type, major and minor numbers

The `stat` system call gets it:

    stat /dev/null

Sample output:

      File: ‘/dev/null’

      Size: 0           Blocks: 0          IO Block: 4096   character special file
    Device: 5h/5d   Inode: 1029        Links: 1     Device type: 1,3
    Access: (0666/crw-rw-rw-)  Uid: (    0/    root)   Gid: (    0/    root)
    Access: 2015-04-20 08:15:17.667233382 +0200
    Modify: 2015-04-20 08:15:17.667233382 +0200
    Change: 2015-04-20 08:15:17.667233382 +0200
     Birth: -

Which says:

    character special file
    Device type: 1,3

That information also appears the output of `ls -l` which uses `stat` under the hood:

    ls -l /dev/null

Sample output:

    crw-rw-rw- 1 root root 1, 3 Apr 20 08:15 /dev/null

The `c` says it is a character device. `1,  3` appear where the file size would be, and show the major and minor numbers instead. For a block device it would be `b` instead.

Get a list of all major numbers attributed and the name of the related device:

    cat /proc/devices

### Representation of major and minor numbers

Major and minor numbers are stored inside a `dev_t` type (a single int, with some bytes for each number). You can manipulate `dev_t` with the macros:

- `MAJOR(dev_t dev)`: get major number of a `dev_t`
- `MINOR(dev_t dev)`: get major number of a `dev_t`
- `MKDEV(int major, int minor)`: make `dev_t` from major and minor

### Standard device numbers

Standard device number and paths are documented at: <http://www.lanana.org/docs/device-list/devices-2.6+.txt>, which is part of the LSB.

They are documented on the kernel 4.1 at: `Documentation/devices.txt`.

The device numbers are actually set on the kernel 4.1 at: `include/uapi/linux/major.h`. Note that it is under `uapi` since those numbers need to be seen outside of the kernel. Character / block device numbers are simply repeated, e.g.:

    #define VCS_MAJOR       7
    #define LOOP_MAJOR      7

## Create new device files

Create device files can be created with `mknod`.

A single device driver can map to multiple device files. E.g., we could make up multiple `/dev/urandom` as:

    sudo mknod -m 666 /tmp/myurandom1 c 1 9
    sudo mknod -m 666 /tmp/myurandom2 c 1 9

## Types of block devices

There are two main types of devices: char and block.

[corbet05][] chapter 01 also mentions a third type of device driver: network interfaces. TODO how are they different?

### Char device

Represents devices which retrieve data sequentially, e.g. a mouse.

For those devices, if may not be possible to do arbitrary `lseek` operations, since that could mean retrieving data from future mouse movements!

### Block device

Represent things like hard disks, CDs, etc., which have a size, and let you do random access (`lseek`) to the data.

### Network interfaces

TODO

## Coding device drivers

### alloc_chrdev_region

Allocate character device major and minor number for a new driver.

Defined in `fs/char_dev.c`.

Declared in `include/linux/fs.h`.

Defined in `fs/char_dev.c`.

    int alloc_chrdev_region(&dev, 0, 1, "char_cheat");

Where:

- `dev` is an output containing the device number dynamically allocated to your driver
- `firstminor` is the first minor number associated with the char driver
- `count` is the number of minor number which should be allocated.
- `name` is what will appear under `/proc/devices` and on the `sysfs` under TODO confirm

Returns `0` on success, negative integer on error.

You could fix the major device number yourself, but this is more and more deprecated. This was done with the `register_chrdev_region` function.

The only disadvantage of using dynamic allocation of major numbers is that we must create the character device files under `/dev` after registering the module, and to do so we must process information available at `/proc/devices` which contains char dev name / device number pairs.

Before being able to use those numbers, you still need to allocate a `cdev` with `cdev_init`, and then tell the kernel about it and which device numbers it represents via `cdev_add`.

Once a module is done with the device numbers, it should free those numbers via `unregister_chrdev_region`.

This does not create actual device files.

### cdev

Represents a character device in the kernel.

### cdev_init

Initializes a `cdev`, allocating data for it, and setting its file operations:

    void cdev_init(struct cdev *cdev, struct file_operations *fops);

### cdev_add

Register a `cdev` structure once it has been set up.

    int cdev_add(struct cdev *dev, dev_t num, unsigned int count);

### iminor and imajor

Inodes contain references to `cdev`.

To get the major and minor numbers from a character dev inode, use:

    unsigned int iminor(struct inode *inode);
    unsigned int imajor(struct inode *inode);
