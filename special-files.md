# Special files

The kernel communicates parameters to user space using special files located `/proc/`, `/sys/` and `/dev/`.

Those files are not stored in permanent storage like HDs, only in RAM. They can still be accessed via open, read and write system calls, therefore they can be manipulated from sh via `cat` and redirection.

What the file IO system calls do exactly when operating on special files depends on what the `file_operations` `struct` associated to the file was programmed to do. Kernel modules can create devices which do any arbitrary operation. But sane implementations do intuitive things, like reading the main data on `read`, and writing parameters on `write`.

Certain utilities are implemented on Linux not via system calls, but by interpreting `proc` information of specific files. For example, `ps` finds process information through the `proc` filesystem. One can therefore rely on those interfaces ( which files outputs information in which format).

TODO why is it advantages to use special files instead of system calls? Is it useful mostly to handle information for which the output size is unknown, by reusing file IO operations?
