#!/usr/bin/env bash
set -eu

# TODO make all asserts pass

# POSIX 7 <http://pubs.opengroup.org/onlinepubs/9699919799/utilities/sed.html>

# Stream EDitor

# Modifies files non-interactively.

# Beginner to pro tutorial: <http://www.grymoire.com/Unix/Sed.html>

## alternatives

  # Consider using Python instead of this, or Perl if your are insane and really want to golf.

  # sed has only slightly better golfing than Perl.

  # The only real advantage of sed over Perl is that Sed is POSIX, while perl is only LSB.

## s command

  # Substitute:

    [ "$(printf 'aba\ncd\n' | sed 's/a/b/')" = $'bba\ncd' ] || exit 1

  ## patterns are BREs

    # `+` is ordinary, thus BRE, and no match TODO fails?

      #[ "$(echo 'aa' | sed 's/[[:alpha:]]/b/')" = 'ba' ] || exit 1
      #[ "$(echo 'aa' | sed 's/.+/b/')" = 'ab' ] || exit 1

    ## r

      # Use EREs instead of BREs. Always use it.

        [ "$(echo 'aa' | sed -r 's/.+/b/')" = 'b' ] || exit 1

  ## g

    # Replaces multiple non overalpping times on each line:

      [ "$(echo 'aba' | sed 's/a/b/g')" = 'bbb' ] || exit 1

  ## capturing groups

      [ "$(echo a1 | sed -r 's/a(.)/b\1/')" = 'b1' ] || exit 1
      [ "$(echo a1 | sed -r 's/a(.)/b\\1/')" = 'b\1' ] || exit 1
      [ "$(echo a1 | sed -r 's/a(.)/\0&/')" = 'a1a1' ] || exit 1
        #\0 and & both refer to the entire match
      [ "$(echo a1 | sed -r 's/a(.)/\&/')" = '&' ] || exit 1

      #no non-greedy *? operator. use [^]* combo instead

  ## flags

    ## g

      # Replace as many times as possible in string

    ## p

      # Is can also be a flag, besides being the print command

    ## w

      # Write lines to file:

        f="/tmp/f"
        printf 'a\nb\na\n' | sed -n "s/a/A/w $f"
        [ "$(cat "$f")" = $'A\nA' ] || exit 1

## /

  # Only exec next command if match:

    [ "$(printf 'a\nb\n' | sed -n '/a/p')" = 'a' ] || exit 1

## restrict lines

  # Line number:

    [ "$(printf 'a\nb\n' | sed -n '1 p')" = 'a' ] || exit 1

  # Last line:

    [ "$(printf 'a\nb\n' | sed -n '$ p')" = 'b' ] || exit 1

  # Before last line: TODO http://stackoverflow.com/questions/14115820/vim-vi-sed-act-on-a-certain-number-of-lines-from-the-end-of-the-file

  # Line matches pattern:

    [ "$(printf 'a\nb\n' | sed '/a/ s/./c/')" = $'c\nb' ] || exit 1

  # Line range:

    [ "$(printf 'a\nb\nc\nd\n' | sed '1,3 s/./e/')" = $'e\ne\ne\nd' ] || exit 1

  ## pattern range

      [ "$(printf 'a\nb\nc\nd\n' | sed '/a/,/c/ s/./0/')" = $'0\n0\n0\nd' ] || exit 1

    # Non-greedy:

      [ "$(printf 'a\nb\n0\n0\na\nb\n' | sed '/a/,/b/ s/./A/')" = $'A\nA\n0\n0\nA\nA' ] || exit 1

  ## multiple commands per restriction

    [ "$(printf 'a\nb\n' | sed '1 {s/./c/; s/c/d/}')" = $'d\nb' ] || exit 1

  ## !

    # Negation.

    # Act on non-matching:

      [ "$(printf 'a\nb\n' | sed -n '1! p')" = 'b' ] || exit 1
      [ "$(printf 'a\nb\n' | sed -n '/a/! p')" = 'b' ] || exit 1

## multiple commands

  # Concatenate with ; or newlines:

    [ "$(printf 'a\nb\n' | sed '/a/ s/./B/; /B/ {s/B/C/; s/C/D/}')" = $'D\nb' ] || exit 1

## q

  # Quit, stop execution:

    [ "$(printf 'a\nb\n' | sed 's/./c/; q')" = 'c' ] || exit 1

## d

  # Delete:

    [ "$(printf 'a\nb\n' | sed '/a/ d')" = 'b' ] || exit 1

## a, i, c

  # Append (after), insert (before), change

    [ "$(printf 'a\nb\n' | sed '1 a 0')" = $'a\n0\nb' ] || exit 1
    [ "$(printf 'a\nb\n' | sed '1 i 0')" = $'0\na\nb' ] || exit 1
    [ "$(printf 'a\nb\n' | sed '1 c 0')" = $'0\nb' ] || exit 1

  ## newlines and spaces

    [ "$(printf 'a\nb\n' | sed '1 c 0 1\n2 3')" = $'0 1\n2 3\nb' ] || exit 1

## =

  # Line number:

    [ "$(printf 'a\nb\na\n' | sed -n '/a/ =')" = $'1\n3' ] || exit 1

## y

  # Replace individual chars tr-like:

    [ "$(printf 'a\nb\n' | sed 'y/ab/01/')" = $'0\n1' ] || exit 1
    [ "$(printf 'a\nb\n' | sed 'y/ab/AB/')" = $'A\nB' ] || exit 1

## multiline

  # - pattern space: buffer that holds each line.

    #`s//` modifies pattern space

  # - `n`: empty pattern space, put next line into it. default action at end.

    # Print first line after matching `/a/`:

      [ "$(printf 'a\nb\n' | sed -n '/a/ {n;p}')" = $'b' ] || exit 1

    # Print second line after matching `/a/`:

      [ "$(printf 'a\nb\nc\n' | sed -n '/a/ {n;n;p}')" = $'c' ] || exit 1

  # - `N`: append next line to pattern space. Next line is not read again.

      [ "$(printf 'a\nb\n' | sed -n '/a/ {N;p};')" = $'a\nb' ] || exit 1
      [ "$(printf 'a\nb\n' | sed -n '/b/ p; /a/ {N;p};')" = $'a\nb' ] || exit 1

  # - `p`: print entire pattern space. default action at end if no `-n`.

  # - `P`: print up to first newline. TODO error:

      #[ "$(printf 'a\nb\n' | sed -n '/a/ P')" = $'b' ] || exit 1

  # - `d`: delete pattern space. go to next line. *Is a loop continue*

  # - `D`: delete first line of pattern space. go to next line.

## hold buffer

  # There is an storage area called **hold buffer** in addition to the pattern buffer.

  # It can contain the strings.

  ## h

    # Put pattern buffer into storage

  ## x

    # Exchange storage and pattern.

    # Print old/new newline pairs after substitution:

      [ "$(printf 'a\nb\n' | sed -n 'h; /a/ {s/a/c/; s/$/\n/; x;p;x;p}')" = $'a\nc\n' ] || exit 1

    # Print first line before matching `/b/`:

      [ "$(printf 'a\nb\n' | sed -n '/b/ {x;p;d}; h')" = $'a' ] || exit 1

  ## g

    # Pattern space = hold space

      [ "$(printf 'a\nb\n' | sed -n 'h; /a/ {s/a/c/;x;p;g;p}')" = $'a\nc' ] || exit 1

  ## G

    # Pattern space += hold space

      [ "$(printf 'a\nb\n' | sed -n 'h; /a/ {s/a/c/;x;G;p}')" = $'a\nc' ] || exit 1

## goto

  ## label

    # May be on same line as command, ex: `:l s/a/b/` is the same as `:l; s/a/b`.

  ## b

    # Unconditional jump.

      [ "$(printf 'a\nb\n' | sed '/a/ b c; s/./c/; :c')" = $'a\nc' ] || exit 1
      [ "$(printf 'a\nb\n' | sed '/a/ b c; s/./c/; :c s/c/d')" = $'a\nd' ] || exit 1

  ## t

    # Jump if last s changed pattern space.

    # Remove spaces after a:

      [ "$(printf 'a b c\n' | sed ':a s/a /a/; t a')" = $'ab c' ] || exit 1

    # Remove everything between a and c:

      [ "$(printf 'a b c\n' | sed ':a s/a[^c]/a/; t a')" = $'ac' ] || exit 1

## Command line arguments

  ## n

    # Don't print all lines (default).

    # Print new line if match:

      sed -n 's/find/repl/gp'

    # grep:

      sed -n '/find/p'

  ## i

    # Edit files in-place, modifying them.

    # WARNING: transforms symlinks into regular files!
    # Use the GNU extension `--follow-symlinks`, to prevent this.

      f=/tmp/f
      printf 'a\nb\n' > "$f"
      sed -i 's/a/A/' "$f"
      [ "$(cat "$f")" = $'A\nb' ] || exit 1

      sed -i.bak 's/A/a/' "$f"
        #baks up old file with .bak suffix
      [ "$(cat "$f")" = $'a\nb' ] || exit 1
      [ "$(`cat "$f".bak)" = $'A\nb' ] || exit 1
      [ `ls | wc -l` = 2 ] || exit 1

    # Whatever it would print to stdout, writes to the input file instead.

    # Cannot be used with stdin input!

  ## e

    # Execute.

    # Give multiple commands.

    # Execute in each line in given order.

    # Same as ; concatenating commands.

      [ "$(printf 'a\nb\n' | sed -e 's/a/b/' -e 's/b/c/')" = $'c\nc' ] || exit 1

  ## f

    # Read commands from given file.

    # One command per line.

    ## shebang

      # Can exec sed script with following shebang:

        #!/bin/sed -f

  ## GNU extensions

## applications

  # If modified, print line number, old line, new line

  # E.g.:

  # Input:

    #a
    #b
    #a
    #b

  # Regex: `s/a/c/`

  # Output:

    #1
    #a
    #c
    #
    #3
    #a
    #c

  [ "$(printf 'a\nb\na\nb\n' | sed -n 'h; s/a/c/; t p; d; :p {=;x;G;s/$/\n/;p}')" = $'1\na\nc\n\n3\na\nc\n' ] || exit 1

echo 'All tests passed.'
