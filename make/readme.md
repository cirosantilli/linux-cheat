make allows you to:

- make command line interfaces of the type:

        make <something> a=b c=d

    *very* easily

- only build outputs when inputs have changed

    this may save lots of time when building large projects

it is the de facto standard tool for that today,
but there is serious effort going on to replace
it because it is yet a nother scripting language

make is specified by posix and implemented by GNU with extensions

# sources

- <http://www.jfranken.de/homepages/johannes/vortraege/make_inhalt.en.html>

    good first tutorial to make

- <http://www-cip.physik.uni-bonn.de/pool/infos/make/advanced.html>

# makefile vs Makefile

- <http://stackoverflow.com/questions/12669367/should-i-name-makefile-or-makefile>

`make` tries the following names, in order: GNUmakefile, makefile and Makefile

`Makefile` has the advantages:

- appears at the top of ls by default (because ascii uppercase comes before ascii lowercase)
- is more conventional

`makefile` has the advantages:

- sticks to the other widespread convention of naming everything lowercase
