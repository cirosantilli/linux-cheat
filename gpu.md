# GPU

GPUs are fast because they have many of processors.

GPUs are SIMD: a single instruction must be run parallel on several data, not arbitrary instructions per data.

GPUs are optimized for 3D graphics processing, heavily used in modern computer games, but can also be used for general parallel computations. A few models of GPU have been made specifically for scientific computation, such as NVIDIA's Kepler and Fermi.

## Vendors

The main vendors of GPUs as of 2013 are NVIDIA and AMD, controlling almost 100% of the market together.

ATI was a separate company bough by AMD in 1993. AMD sold ATI branded GPUs until 2010.

There are more and more GPUs integrated inside the CPU, such as is the case for Intel's iX family. Such integrated GPUs are slower but consume less energy.

The GPU market is heavily moved by the gaming industry since good GPUs are needed to play modern games. Therefore it should seem as no surprise if things just don't work in Linux and only in Windows which controls about 100% of the gaming market as of 2013.

## Open-sourceness of drivers

- <http://www.pcworld.com/article/2911459/why-nvidia-graphics-cards-are-the-worst-for-open-source-but-the-best-for-linux-gaming.html>
- <http://www.phoronix.com/scan.php?page=article&item=steamos-open-ubuntu&num=1>

As of 2015, the situation is as follows:

-   NVIDIA has the fastest Linux driver, but offers them as blobs only.

    Nouveau http://nouveau.freedesktop.org/wiki/ is an open source driver reverse engineered from the blobs. Worse performance than blobs obviously.

-   AMD: has both blobs and an open source version. Blob is less powerful than NVIDIA blobs, and open source less powerful still.

    Employs people to write the open source code.

    2016: open up movement: <http://gpuopen.com/welcometogpuopen/>

-   Intel: apparently the most open source friendly one.

## Find your graphics card model

<http://askubuntu.com/questions/72766/how-do-i-find-out-the-model-of-my-graphics-card>

    sudo lspci | grep VGA

I get:

    00:02.0 VGA compatible controller: Intel Corporation 3rd Gen Core processor Graphics Controller (rev 09)
    01:00.0 VGA compatible controller: NVIDIA Corporation GF108M [NVS 5400M] (rev a1)

So I have 2 GPUs:

- `NVIDIA GF108M NVS 5400M`
- `Intel`. It is an integrated GPU.

## Switchable graphics

As of 2013, NVIDIA and AMD installation on Linux is complicated because of switchable graphics.

If you have an integrated GPU in the CPU, which is likely the case, then the GPU tries to be smart and only turn on when needed, leaving less energy consuming tasks for the CPU's integrated GPU.

This technology is called Optimus by NVIDIA and more explicitly Dynamic Switchable Graphics by AMD.

The problem is that NVIDIA and AMD did not code software for things to work on Linux, so it generally does not.

As a result, if you have an integrated graphics card, *don't* try to install things like:

    #sudo apt-get install nvidia-current

as this will *not* work, and will only waste your time and cause configuration problems.

There are open source projects trying to implement Optimus correctly on Linux, but their success is a long term goal.

Xorg is getting old and the future Wayland is considering the shift towards switchable graphics.

Bumblebee seems to be the best bet to support NVIDIA Optimus as of 2013.

## NVIDIA

Check the required driver:

- <http://www.nvidia.com/Download/index.aspx>

### Make it work

It is either made to work, or it wont work, don't try too much.

Managed to make a NVS 5400M work on Ubuntu 15.10 with just:

    sudo apt-get install nvidia-352

where `-352` is the latest driver available.

Good luck:

- <http://askubuntu.com/questions/162639/how-do-i-get-ubuntu-to-recognize-my-nvidia-graphics-card>
- <http://askubuntu.com/questions/472928/correct-nvidiaintel-graphics-setup-in-14-04>
- <http://askubuntu.com/questions/61396/how-do-i-install-the-nvidia-drivers>
- <http://askubuntu.com/questions/172609/how-to-disable-discrete-gpu-using-nvidia-drivers>

### NVIDIA version names

Each hardware has two names:

- model: precise name of a single piece of hardware
- codename: marketing name that may group several models

For example, from the `lspci` output, in `GF108M [NVS 5400M]`:

- `NVS 5400M` is the model name
- `GF108M` is the codename

## Check that GPU is being used

- <http://askubuntu.com/questions/68028/how-do-i-check-if-ubuntu-is-using-my-nvidia-graphics-card>
- <http://unix.stackexchange.com/questions/16407/how-to-check-which-gpu-is-active>
- <http://askubuntu.com/questions/363775/what-is-the-use-of-nvidia-prime>

`nvidia-settings`: TODO what indicates that it is working?

## dGPU

Discrete GPU, a traditional GPU separate from the CPU, with it's own internal memory.

## IGP

Intermediate between CPU and GPU, uses RAM memory.

<http://en.wikipedia.org/wiki/Graphics_processing_unit#Integrated_graphics_solutions>

## Benchmarks

<http://askubuntu.com/questions/31913/how-to-perform-a-detailed-and-quick-3d-performance-test>

- `glxgears`
- `glmark2`. But it segfaults after installing NVIDIA: <https://bugs.launchpad.net/ubuntu/+source/glmark2/+bug/1475902>

## nvidia-prime

Tools to control GPUs:

Chose which GPU to use:

    prime-select

## AMD

### APU

### Fusion

AMD's on-board GPU.

<https://en.wikipedia.org/wiki/AMD_Accelerated_Processing_Unit>

They are fabless.

## vsync

Synchronizes GPU output to the monitor refresh: <http://gaming.stackexchange.com/questions/198184/what-is-v-sync-and-when-should-i-enable-it?newreg=c80b4777d5484fb2b8b533ab8c506cd5>

Monitors can only refresh at certain rates. If the GPU does not sync with it, artifacts may happen.

Still, it is better for GPUs to be able to render more than say 30FPS, or else a drop in performance will be noticeable.
