# init

The first program that is run by the kernel.

By default it is found on the root filesystem.

Absolute minimal example: <http://superuser.com/a/991733/128124>

<https://github.com/ivandavidov/minimal> uses it to call the `/sbin/init` from BusyBox. Modifications that worked there:

- `/init` containing just `#!/bin/sh\nexec /bin/sh`, although that only has one TTY

The file can be set with a kernel command line parameter `init`: <http://stackoverflow.com/questions/20744200/how-the-init-process-is-started-in-linux-kernel>
