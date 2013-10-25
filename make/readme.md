Make allows you to:

- make command line interfaces of the type:

        make <something> a=b c=d

    *very* easily

- only build outputs when inputs have changed

    this may save lots of time when building large projects

Make is specified by posix and implemented by GNU with extensions
It is the de facto standard make tool for POSIX systems.

#downsides of make

The main problems of make are:

- low cross-platform portability
- its Yet Another Scripting Language to learn (and not a very powerful one at that)

#alternatives

Because of the downsides of make, many other make systems have been devised.
None has yet dominated on most applications, but important ones include:

- cmake

    Generates programs that make the project, including projects for IDEs.

    For example, it can generated:

    - POSIX `Makefiles` on Linux,
    - `cmd.exe` build scripts for Windows
    - CodeBlocks project

    all from the same input file.

    Makefiles are written in Yet Another Scripting Language.

- rake

    Similar to `make`, Ruby implemented with makefiles written in pure Ruby.

- apache ant

    Written in Java, mainly used for Java project.

    Makefiles are written in XML, so a bit verbose to write by hand.

#makefile vs Makefile

- <http://stackoverflow.com/questions/12669367/should-i-name-makefile-or-makefile>

`make` tries the following names, in order: GNUmakefile, makefile and Makefile

`Makefile` has the advantages:

- appears at the top of ls by default (because ascii uppercase comes before ascii lowercase)
- is more conventional

`makefile` has the advantages:

- sticks to the other widespread convention of naming everything lowercase

#sources

- <http://www.jfranken.de/homepages/johannes/vortraege/make_inhalt.en.html>

    good first tutorial to make

- <http://www-cip.physik.uni-bonn.de/pool/infos/make/advanced.html>
