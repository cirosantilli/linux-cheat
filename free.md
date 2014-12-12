# free

Implemented by the procps package on Ubuntu 14.04.

Print RAM and swap memory in Megabytes:

    free

Sample output:

                 total       used       free     shared    buffers     cached
    Mem:       3767368    3629844     137524     457068      30312    1098720
    -/+ buffers/cache:    2500812    1266556
    Swap:      3910652     445044    3465608

`-h`: human readable output:

                 total       used       free     shared    buffers     cached
    Mem:          3.6G       3.4G       172M       451M        29M       1.0G
    -/+ buffers/cache:       2.4G       1.2G
    Swap:         3.7G       434M       3.3G

Other flags:

`-s1`, `-s0.01`: repeat every N seconds. ms resolution.
