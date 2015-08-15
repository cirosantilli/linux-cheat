# Sources

Consider reading books on general operating system concepts, as those tend to explain better concepts which are used on Linux as well as other OS.

Linux kernel documentation kind of sucks.

Most function definitions or declarations don't contain any comments, so you really need to have a book in your hands to understand the high level of things.

## Free

-   `git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git`

    The source code, *the* only definitive source.

    Also see the built-in documentation at `Documentation/`.

    Ways to browse:

    -   the most official way is the cgit: <https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/>

    -   GitHub mirror <https://github.com/torvalds/linux>

    -   [free-electrons][]

        Has ctag-like hyperlinks in the kernel code.

        Possible alternatives: `ctags` and `grep`.

-   [kernel-mail][]

    Kernel mailing lists.

    Mostly bleeding edge design decisions.

    `linux-kernel`: is the highest volume one. TODO: better replies than Stack Overflow?

    `linux-newbie`: looks like a good one for me

    Web UIs suck: <http://unix.stackexchange.com/questions/90080/how-do-i-search-the-linux-kernel-mailing-list-archives>

-   Official bug tracker: <https://bugzilla.kernel.org/>

    Not used by many developers, most stick to the mailing list...

-   `make htmldoc` on the source.

    Generates documentation for the kernel from comments, and puts it under `Documentation/DocBook/index.html`

    The most useful is under `kernel api`. Still, this is grossly incomplete.

    The documentation seems to be stored in the `.c` files mostly rather than on the `.h`.

    Weirdly the snapshots of htmldoc on kernel.org have some extra functions, check it out: <https://www.kernel.org/doc/htmldocs/kernel-api.html>

-   <http://0xax.gitbooks.io/linux-insides/content/Initialization/linux-initialization-4.html>

    Good book.

    Above all: hosted on GitHub.

-   [kernel.org][]

    kernel.org resources list

    Wiki for some subprojects: <https://wiki.kernel.org/>

-   [elinux.com](http://elinux.org)

    Embedded Linux wiki.

    Supported by the Linux kernel.

-   [kernelnewbies][]

-   [Corbet - 2005 - Linux Device Drivers][corbet05]

    Ultimate device driver source.

-   Interviews with many kernel devs:

    <https://www.linux.com/news/special-feature/linux-developers>

    Good getting started info.

## Non-free

### Books on operating systems in general

-   [stallings11][]

### Books on the Linux kernel

-   [bovet05][]

    Inner workings.

    Reasonable info on x86 hardware.

-   [love06][]

    Love - 2006 - Linux kernel development.

[bovet05]:        http://www.amazon.com/books/dp/0596005652
[corbet05]:       https://lwn.net/Kernel/LDD3/
[free-electrons]: http://lxr.free-electrons.com/ident
[kernel-mail]:    http://vger.kernel.org/vger-lists.html
[kernel.org]:     https://www.kernel.org
[kernelnewbies]:  http://kernelnewbies.org/
[love06]:         http://www.amazon.com/books/dp/0596005652
[stallings11]:    http://www.amazon.com/Operating-Systems-Internals-Principles-Edition/dp/013230998X
