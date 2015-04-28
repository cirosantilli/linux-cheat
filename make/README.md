# Make

POSIX 7 build system.

Special targets:

- [.PRECIOUS](precious/)
- [Plus sign (+)](plus-sign/)
- [include](include/)

## Introduction

Make allows you to:

-   make command line interfaces of the type:

        make <something> a=b c=d

    *very* easily.

-   only build outputs when inputs have changed

    This may save lots of time when building large projects.

Make is specified by POSIX 7 <http://pubs.opengroup.org/onlinepubs/9699919799/utilities/make.html> and implemented by GNU with extensions. It is the de facto standard make tool for POSIX systems.

## Downsides of Make

The main problems of make are:

- not available on Windows
- its Yet Another Scripting Language to learn, and uses Bash inside of it

## Alternatives

Because of the downsides of make, many other make systems have been devised. None has yet dominated on most applications, but important ones include:

-   CMake

-   Rake.

    Similar to `make`, Ruby implemented with Makefiles written in pure Ruby.

-   Apache Ant.

    Written in Java, mainly used for Java project.

    Makefiles are written in XML, so a bit verbose to write by hand.

## Makefile filename case

- <http://stackoverflow.com/questions/12669367/should-i-name-makefile-or-makefile>

Make tries the following names, in order: `GNUmakefile`, `makefile` and `Makefile`.

`Makefile` has the advantages:

- appears at the top of ls by default (because ASCII uppercase comes before ASCII lowercase)
- is more conventional

`makefile` has the advantages:

- sticks to the other widespread convention of naming everything lowercase

## Command line options

### j

Let make run in 5 threads:

    make -j5

*Be warned*: this will make standard output of all threads mix up so the stdout will be meaningless.

Also, this *may break your makefiles*, since in a rule like:

    all: a b c

`a`, `b`, and `c` are run in parallel, it it might be the case that `c` *must* run only after `a` and `b`.

## Sources

-   <http://www.jfranken.de/homepages/johannes/vortraege/make_inhalt.en.html>

    Good first tutorial to make.

-   <http://www-cip.physik.uni-bonn.de/pool/infos/make/advanced.html>
