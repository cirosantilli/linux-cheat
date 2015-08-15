# cpuid

Parse the CPUID instruction.

Source: <http://www.etallen.com/cpuid.html>

GitHub manual mirror: <https://github.com/ehabkost/cpuid>

Usage:

    cpuid

Sample output through `head -n20`:

    CPU 0:
       vendor_id = "GenuineIntel"
       version information (1/eax):
          processor type  = primary processor (0)
          family          = Intel Pentium Pro/II/III/Celeron/Core/Core 2/Atom, AMD Athlon/Duron, Cyrix M2, VIA C3 (6)
          model           = 0xa (10)
          stepping id     = 0x9 (9)
          extended family = 0x0 (0)
          extended model  = 0x3 (3)
          (simple synth)  = Intel Core i3-3000 (Ivy Bridge L1) / i5-3000 (Ivy Bridge E1/N0/L1) / i7-3000 (Ivy Bridge E1) / Mobile Core i3-3000 (Ivy Bridge L1) / i5-3000 (Ivy Bridge L1) / Mobile Core i7-3000 (Ivy Bridge E1/L1) / Xeon E3-1200 v2 (Ivy Bridge E1/N0/L1) / Pentium G1600/G2000/G2100 (Ivy Bridge P0) / Pentium 900/1000/2000/2100 (P0), 22nm
       miscellaneous (1/ebx):
          process local APIC physical ID = 0x0 (0)
          cpu count                      = 0x10 (16)
          CLFLUSH line size              = 0x8 (8)
          brand index                    = 0x0 (0)
       brand id = 0x00 (0): unknown
       feature information (1/edx):
          x87 FPU on chip                        = true
          virtual-8086 mode enhancement          = true
          debugging extensions                   = true
