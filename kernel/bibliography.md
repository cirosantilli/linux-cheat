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

-   Official bug tracker: <https://bugzilla.kernel.org/>

-   `grep -R`

    Possible way to find where something is defined.

    May take a long time on the source root, and it may be hard to get the actual definitions, but it does works sometimes.

-   `ctags -R`

    Better than grep to find where things are defined / declared.

    Doing:

        ctags -R --c-kinds=-m

    on the kernel root generated a file of 134M, but this might be worth it as it may save lots of grepping time.

    You will might then want to add the following to your `.bashrc`:

        function ctag { grep "^$1" tags; } #CTAgs Grep for id
        function rctag { cd `git rev-parse --show-toplevel` && grep "^$1" tags; }

    Another similar option is to use [free-electrons][].

-   `make htmldoc` on the source.

    Generates documentation for the kernel from comments, and puts it under `Documentation/DocBook/index.html`

    The most useful is under `kernel api`. Still, this is grossly incomplete.

    The documentation seems to be stored in the `.c` files mostly rather than on the `.h`.

    Weirdly the snapshots of htmldoc on kernel.org have some extra functions, check it out: <https://www.kernel.org/doc/htmldocs/kernel-api.html>

-   [kernel.org][]

    kernel.org resources list

    Wiki for some subprojects: <https://wiki.kernel.org/>

-   [elinux.com](http://elinux.org)

    Embedded Linux wiki.

    Supported by the Linux kernel.

-   [kernelnewbies][]

-   [Corbet - 2005 - Linux Device Drivers][corbet05]

    Ultimate device driver source.

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
