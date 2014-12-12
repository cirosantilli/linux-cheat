# top

Ncurses constantly updated process list with CPU and memory usage.

On Ubuntu 14.04 implemented on the procps package.

Flags:

- `h`: help
- `q`: quit
- `f`: chose which fields to show
- `F`: chose by which field to sort
- `O`: move sort field left right
- `k`: kill process
- arrow keys: move view

Output fields:

- `RES`: same as `RSS` on `ps`.
- `VIRT`: same as `VSZ` on `ps`.
- `SHR`: which subset of `VIRT` is shared.

## uptime

First line of top:

    uptime

Sample first header line:

    23:00:13 up 12:00, 3 users, load average: 0.72, 0.66, 0.6
    ^^^^^^^^    ^^^^^, ^^^^^^^,               ^^^^, ^^^^, ^^^
    1           2      3                      4     5     6

Legend:

1. current time
2. how long the system has been up for
3. how many users are logged
4. load average for past  1 minute
5.                        5 minutes
6.                       15 minutes
