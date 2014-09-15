# TODO convert to md.

# The manuals.

# POSIX 7 specifies only the option `-k` and nothing about pages,
# those are Linux concepts.

##pages

  # The manual is organized into 7 pages.

  # When you install a new page, the developers decide where to put the documentation.

  # Every page has an intro section which says what it is about:

    man 2 intro
    man 3 intro

  # As in the case of the intro, you can distinguish ambiguities by giving the page number.

  # `write` system call:

    man 2 write

  # `write` shell command:

    man 1 write

  # List all entries of a page:

    man -k . | grep '(8)'

  # - 1: user commands (executables in path)

    # This is normally the largest section.

      man 1 passwd

  # - 2: system calls (c interface)

    # Those are *not* actual system calls, but portable low level system interfaces.

    # Most of the POSIX C library is here.

    #  POSIX write function:

      man 2 write

  # - 3: library. system call wrappers.

    # Higher level than 2.

    # Distinction from `man 2` is hard to tell.

    # Contains for example:

    # - some POSIX apis like pthreads
    # - X11 APIs

  # - 4: special files such as device files

      man 4 zero
      man 4 random
      man 4 mouse

  # - 5: file formats specifications.

    # Examples:

    # `/etc/passwd` file syntax:

      man 5 passwd

    # elf executable format:

      man 5 elf

  # - 6: games

  # - 7: standards.

    # Contains standards summaries such as:

      man unicode
      man url
      man X

  # - 8: system administration

    # Commands that mostly only root can do.

    # Their binaries are typically under `/usr/sbin/`.

    # Examples:

      man 8 adduser
      man 8 grub-install
      man 8 mount

##GNU command line options

  # Exact search on title. Shows only first page found match:

    man intro

  # Show each match in succession and asks if you want to continue to the next on each quit:

    man -a intro

  # Without that option, shows only one page then quits.

  # Summary:

    man -k password

  # Entire text:

    man -K password

  # May be slow:

  ##--regex

    # Whatever you were searching search with ERE now.

    # Regex on title:

      man --regex 'a.c'

    # Regex on entire manual:

      man --regex -K 'a.c'

    # Same

      apropos password

  # List all manual pages pages whose summaries match '.' regex: anychar)

    man -k .

##linux man-pages project

  # <https://www.kernel.org/doc/man-pages/>

  # Project that maintains many Linux related manpages and also some non Linux specific entries.

  # Most distros to come with those manpages installed.

  # It is not a part of the kernel tree, and does not seem to be mentioned in the LSB.

##whatis

  # Non POSIX

  # Show man short description of ls

    whatis ls

##manpath

  # Man search path

  # Non-POSIX

    manpath

  # Sample output:

    #/usr/local/man:/usr/local/share/man:/usr/share/man

  # Languages man:

    ls /usr/share/man

  # Section 1 pages in English:

    ls /usr/share/man/man1 | less

##GUI front-ends

  # There is one single and drastic advantage to it:
  # clickable references to other manpages

  ##yelp

    # Ubuntu default documentation front-end. Also does other formats.

      yelp man:ls
