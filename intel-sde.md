# Intel SDE

Intel CPU emulator.

Closed source... free to use non-commercially.

<https://software.intel.com/en-us/articles/intel-software-development-emulator>

Can emulate some CPU features before hardware even comes out.

Usage: unpack the binary, and run:

    ./sde64 -- /bin/ls

Or more interestingly:

    ./sde64 -- cpuid

`--` is mandatory.
