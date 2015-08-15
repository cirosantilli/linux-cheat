# FHS

<http://en.wikipedia.org/wiki/Filesystem_Hierarchy_Standard>

Standard: <http://refspecs.linuxfoundation.org/fhs>. As of Feb 2015, version 3 is beta, version 2.3 is the latest.

    man hier

The filesystem hierarchy standard specifies base directories for the system and what should go in them.

It is also maintained by the Linux foundation, and required by the LSB.

[freedesktop.org basedir spec](http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html)  is another an important directory standard that specifies directory structures on top of the FHS. It has been adopted by the recent LSB 4.1 under the desktop section: <http://refspecs.linux-foundation.org/LSB_4.1.0/LSB-Desktop-generic/LSB-Desktop-generic.html#XDG-BASEDIR>

## var

### crash

<http://unix.stackexchange.com/questions/139071/what-are-files-in-var-crash>

System crashes, but Ubuntu uses it for user space as well using the <https://packages.debian.org/unstable/main/corekeeper> package.

## libexec

Executables meant to be called only from other executables, and not directly be in the `PATH`.

http://www.linuxbase.org/betaspecs/fhs/fhs/ch04s07.html

Optional and not present in Ubuntu 14.04, but the concept is used by GCC (e.g. for `cc1`) and Git (external commands).

## De facto extensions

Common naming patterns not present in any major standard.

### /etc/alternatives

Contains symlinks that determine default programs.

For example: `editor -> /usr/bin/vim` and so on.

Can be updated via `man update-alternatives`.

Some important ones are:

- editor: text editor
- x-www-browser: text editor

### /etc/issue

Contains the message that is printed before login shells (Ubuntu Ctrl + Alt + 1).

See:

    man issue

<http://unix.stackexchange.com/questions/84280/is-etc-issue-common-file>

Of course, since this is meant to be shown to end users, it serves as a broadcast message for CLI only environments, and should not be used to identify the distribution even though it usually contains the distribution ID by default.

### ^\.

Hidden files.

It is up to programs to decide how to treat them.

### \.~$

Backup file.

### \.bak$

Backup file.

### \.orig$

Original installation file.

### \.d$

Many theories, a plausible one: differentiate `a.conf file` from `a.conf.d` dir normally, all files in the `a.conf.d` dir will be sourced as if they are inside `a.conf`.

### /etc/environment

TODO
