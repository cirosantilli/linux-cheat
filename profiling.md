# Profiling

Profiling is testing how fast an executable or script runs,
and trying to speed it up if needed.

Complex performance improvements should be left for a later stage of design
after the interfaces are good and the speed up is really needed.

One of the major techniques to speeding up is to find what is the slowest part of a
program (the bottle neck) and working on it, since most programs spend much of their
running time on a single part.

## time

There are two utilities called time:

- a bash built-in
- an executable at `/usr/bin/time`

TODO what is the difference

See how fast `a.out` runs:.

    time ./a.out

Bash built-in, different from `/usr/bin/time`.

Output fields:

-   real: wall clock time

-   user: program CPU time usage

-   sys: system call time used for program

        /usr/bin/time -f "\t%U user,\t%S system,\t%x status" test.py

`time` without path is the bash built-in.

Also does other profiles like does memory IO besides CPU usage.

## gprof

`binutils` package

Shows time spent into each call of individual functions
also shows average times per function
sorts from most to least time consuming.

You could get all those information from the `<time.h> clock()` function
but this automates all for you in the case you want to measure functions.

    gcc -p -pg -c a.c -o a.o
    gcc -p -pg a.o -o a.out

Generates extra profiling code for `prof` and `gprof` programs
must be used only both link and compile steps if separate.

    ./a.out

Generates `gmon.out` with gprof data in *current directory*,
not the directory where the binary is located.

    gprof a.out gmon.out

- `-b` : remove large output explanation
- `-p` : only flat profile
- `-p func1` : only flat profile of `func1`
- `-q` : only call graph
- `-q func1` : only call graph for `func1`
