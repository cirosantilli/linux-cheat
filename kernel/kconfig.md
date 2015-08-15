# Kconfig

System to configure how the kernel will be built.

Documented at:

- <https://github.com/torvalds/linux/blob/v4.0/Documentation/kbuild/kconfig.txt>
- <https://github.com/torvalds/linux/blob/v4.0/Documentation/kbuild/kconfig-language.txt>

Those files are used to generate `.config` with the configuration make targets.

There are around ~6k options!

Most options (TODO all) options generate preprocessor macros which control system through `#ifdef` checks.

## How it works

For example, in `arch/x86/Kconfig`:

    config SMP
    	bool "Symmetric multi-processing support"
    	---help---
    	  This enables support for systems with more than one CPU. If you have
    	  a system with only one CPU, say N. If you have a system with more
    	  than one CPU, say Y.

leads to a line in `.config` of the type:

    CONFIG_SMP=y

if set, and a line of type:

    # CONFIG_SMP is not set

otherwise.

Then `make` reads the `.config` and generates:

    include/generated/autoconf.h

TODO how is this included? Grepping the source shows a few `-include` on Makefiles, and very few `#include`.

Then throughout the kernel source `ifdef`s are used:

    #ifdef CONFIG_SMP

    #endif

## help

The `---help---` is not necessary: most places use just `help`.

A patch to remove this inconsistency was WONTFIXed... <https://lkml.org/lkml/2005/5/2/181>

## Important options

Quick selection of options that appear everywhere throughout the code and which every hacker should know.

-   `arch/x86/Kconfig`

    - `SMP`: symmetric multiprocessing
    - `IA32_EMULATION`

## Cross compile the kernel

<http://raspberrypi.stackexchange.com/questions/192/how-do-i-cross-compile-the-kernel-on-a-ubuntu-host>
