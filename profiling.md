profiling is testing how fast an executable or script runs,
and trying to speed it up if needed.

complex performance improvements should be left for a later stage of design
after the interfaces are good and the speed up is really needed.

one of the major techniques to speeding up is to find what is the slowest part of a
program (the bottle neck) and working on it, since most programs spend much of their
running time on a single part.

#time

there are two utilities called time:

- a bash built-in
- an executable at `/usr/bin/time`

TODO what is the difference

see how fast `a.out` runs:.

    time ./a.out

bash builtin, different from /usr/bin/time

output fields:

- real: wall clock time
- user: program cpu time usage
- sys: system call time used for program

    /usr/bin/time -f "\t%U user,\t%S system,\t%x status" test.py

time without path is the bash built-in

does memory iom etc profiles besides time profiles

#gprof

part of `binutils` package

shows time spent into each call of individual functions
also shows average times per function
sorts from most to least time consuming

you could get all those infos from <time.h> clock() func
but this automates all for you in the case you want to measure functions

    gcc -p -pg -c a.c -o a.o
    gcc -p -pg a.o -o a.out

generates extra profiling code for `prof` and `gprof` programs
must be used only both link and compile steps if separate

    ./a.out

will generate `gmon.out` with gprof data in *cur dir*, not bin dir

    gprof a.out gmon.out

- b : remove large output explanation
- p : only flat profile
- pfunc1 : only flat profile of `func1`
- q : only call graph
- qfunc1 : only call graph for `func1`
