# pv

Monitor data rate from stdin:

    yes | pv >/dev/null

Stdin is simply forwarded to stdout: if you don't put is somewhere it will show on the screen and hide `pv` output.

Try it across disks / USB sticks.

Measuring transfer rates in networks is another fun application.
