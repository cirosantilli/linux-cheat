# setarch

CLI for the `personality` system call, which alters some process parameters.

`util-linux` package.

Some `personality` settings may be per-process, no-sudo required versions of more global settings, e.g., ASLR can be toggled both with personality:

    setarch "$(uname -m)" -R strace -i ls

and `proc` filesystem;

    echo 0 | sudo tee /proc/sys/kernel/randomize_va_space
