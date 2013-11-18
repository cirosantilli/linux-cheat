GPUs are fast because they have many of processors.

GPUs are SIMD: a single instruction must be run parallel on several data,
not arbitrary instructions per data.

GPUs are optimized for 3D graphics processing, heavily used in modern computer games,
but can also be used for general parallel computations.
A few models of GPU have been made specifically for scientific computation, such as NVIDIA's Kepler and Fermi.

#vendors

The main vendors of GPUs as of 2013 are NVIDIA and AMD, controlling almost 100% of the market together.

ATI was a separate company bough by AMD in 1993. AMD sold ATI branded GPUs until 2010.

There are more and more GPUs integrated inside the CPU, such as is the case for Intel's iX family.
Such integrated GPUs are slower but consume less energy.

The GPU market is heavily moved by the gaming industry since good GPUs are needed to play modern games.
Therefore it should seem as no surprise if things just don't work in Linux and only in Windows
which controls about 100% of the gaming market as of 2013.

#find your graphics card

    sudo lspci | grep VGA

I get:

    00:02.0 VGA compatible controller: Intel Corporation 3rd Gen Core processor Graphics Controller (rev 09)
    01:00.0 VGA compatible controller: NVIDIA Corporation GF108M [NVS 5400M] (rev a1)

So I have 2 GPUs:

- `NVIDIA GF108M NVS 5400M`
- `Intel`. It is an integrated GPU.

#switchable graphics

As of 2013, NVIDIA and AMD installation on Linux is complicated because of switchable graphics.

If you have an integrated GPU in the CPU, which is likely the case,
then the GPU tries to be smart and only turn on when needed, leaving less energy consuming tasks
for the CPU's integrated GPU.

This technology is called Optimus by NVIDIA and more explicitly Dynamic Switchable Graphics by AMD.

The problem is that NVIDIA and AMD did not code software for things to work on Linux, so it generally does not.

As a result, if you have an integrated graphics card, *don't* try to install things like:

    #sudo apt-get install nvidia-current

as this will *not* work, and will only waste your time and cause configuration problems.

There are open source projects trying to implement Optimus correctly on Linux,
but their success is a long term goal.

Xorg is getting old and the future Wayland is considering the shift towards switchable graphics.

Bumblebee seems to be the best bet to support NVIDIA Optimus as of 2013.

#nvidia

##nvidia settings

To check that the installation is working, use `nvidia-settings`,
which monitors the GPU, and will show if the GPU is not properly installed.

##nvidia settings
