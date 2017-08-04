# Capabilities

    man capabilities

Splits sudo into multiple permissions, similar to Android app permissions. TODO what system do Android app permissions use?

Implemented on the Linux kernel, and modified with the `capset` and `capget` system calls.

CLI programs are confusingly named `setcap` and `getcap`.

`CAP_SYS_ADMIN` grants all capabilities, and is equivalent to the old root.

`setcap` and `getcap` work on executables, e.g.:

    sudo setcap cap_sys_admin+ep virt_to_phys_user.out

now allows `virt_to_phys_user.out` to access `/proc/<pid>/pagemap`.

It can be retrieved with:

    getcap virt_to_phys_user.out
