#!/usr/bin/env bash
set -eu

## sed

# POSIX 7 http://pubs.opengroup.org/onlinepubs/9699919799/utilities/sed.html

# Stream EDitor.

# Modifies files non-interactively.

# Beginner to pro tutorial: http://www.grymoire.com/Unix/Sed.html

## Alternatives

  # Consider using Python instead of this, or Perl if your are insane and really want to golf.

  # sed has only slightly better golfing than Perl.

  # The only real advantage of sed over Perl is that Sed is POSIX, while perl is only LSB.

## Command line arguments

  ## n

    # Don't print all lines (default).

    # Print new line if match:

      sed -n 's/find/repl/gp'

    # grep:

      sed -n '/find/p'

  ## e

    # Execute.

    # Give multiple commands.

    # Execute in each line in given order.

    # Same as ; concatenating commands.

      [ "$(printf 'a\nb\n' | sed -e 's/a/b/' -e 's/b/c/')" = $'c\nc' ]

  ## f

    # Read commands from given file.

    # One command per line.

    ## shebang

      # Can exec sed script with following shebang:

        #!/bin/sed -f

## Syntax

  ## s command

    # Substitute:

      [ "$(printf 'aba\ncd\n' | sed 's/a/b/')" = $'bba\ncd' ]

    ## Patterns are BREs

      # `+` is ordinary, thus BRE, and no match TODO why fails?

        #[ "$(echo 'aa' | sed 's/[[:alpha:]]/b/')" = 'ba' ]
        #[ "$(echo 'aa' | sed 's/.+/b/')" = 'ab' ]

      # POSIX does not seem to support EREs.
      # For that you need the GNU extension `-r` flag.

    ## g

      # Replaces multiple non overalpping times on each line:

        [ "$(echo 'aba' | sed 's/a/b/g')" = 'bbb' ]

    ## Capturing groups

        [ "$(echo a1 | sed -r 's/a(.)/b\1/')" = 'b1' ]
        [ "$(echo a1 | sed -r 's/a(.)/b\\1/')" = 'b\1' ]
        [ "$(echo a1 | sed -r 's/a(.)/\0&/')" = 'a1a1' ]
          #\0 and & both refer to the entire match
        [ "$(echo a1 | sed -r 's/a(.)/\&/')" = '&' ]

        #no non-greedy *? operator. use [^]* combo instead

    ## Flags

      ## g

        # Replace as many times as possible in string

      ## p

        # Is can also be a flag, besides being the print command

      ## w

        # Write lines to file:

          f="/tmp/f"
          printf 'a\nb\na\n' | sed -n "s/a/A/w $f"
          [ "$(cat "$f")" = $'A\nA' ]

    # Replace only first occurence:
    # http://stackoverflow.com/questions/148451/how-to-use-sed-to-replace-only-the-first-occurrence-in-a-file

  ## /

    # Only exec next command if match:

      [ "$(printf 'a\nb\n' | sed -n '/a/p')" = 'a' ]

  ## Restrict lines

    # Line number:

      [ "$(printf 'a\nb\n' | sed -n '1 p')" = 'a' ]

    # Last line:

      [ "$(printf 'a\nb\n' | sed -n '$ p')" = 'b' ]

    # TODO Before last line:
    # http://stackoverflow.com/questions/14115820/vim-vi-sed-act-on-a-certain-number-of-lines-from-the-end-of-the-file

    # Line matches pattern:

      [ "$(printf 'a\nb\n' | sed '/a/ s/./c/')" = $'c\nb' ]

    # An empty pattern like `//` means: reuse the last regexp.

    # Line range:

      [ "$(printf 'a\nb\nc\nd\n' | sed '1,3 s/./e/')" = $'e\ne\ne\nd' ]

    # Multiple individual lines:
    # http://unix.stackexchange.com/questions/117511/is-it-possible-to-match-multiple-specific-line-numbers-not-range-with-sed

    ## pattern range

        [ "$(printf 'a\nb\nc\nd\n' | sed '/a/,/c/ s/./0/')" = $'0\n0\n0\nd' ]

      # Non-greedy:

        [ "$(printf 'a\nb\n0\n0\na\nb\n' | sed '/a/,/b/ s/./A/')" = $'A\nA\n0\n0\nA\nA' ]

    ## multiple commands per restriction

      [ "$(printf 'a\nb\n' | sed '1 {s/./c/; s/c/d/}')" = $'d\nb' ]

    ## !

      # Negation.

      # Act on non-matching:

        [ "$(printf 'a\nb\n' | sed -n '1! p')" = 'b' ]
        [ "$(printf 'a\nb\n' | sed -n '/a/! p')" = 'b' ]

  ## Multiple commands

    # Concatenate with ; or newlines:

      [ "$(printf 'a\nb\n' | sed '/a/ s/./B/; /B/ {s/B/C/; s/C/D/}')" = $'D\nb' ]

  ## q

    # Quit, stop execution:

      [ "$(printf 'a\nb\n' | sed 's/./c/; q')" = 'c' ]

  ## d

    # Delete:

      [ "$(printf 'a\nb\n' | sed '/a/ d')" = 'b' ]

  ## a

  ## i

  ## c

    # Append (after), insert (before), change

      [ "$(printf 'a\nb\n' | sed '1 a 0')" = $'a\n0\nb' ]
      [ "$(printf 'a\nb\n' | sed '1 i 0')" = $'0\na\nb' ]
      [ "$(printf 'a\nb\n' | sed '1 c 0')" = $'0\nb' ]

    ## newlines and spaces

      [ "$(printf 'a\nb\n' | sed '1 c 0 1\n2 3')" = $'0 1\n2 3\nb' ]

  ## =

    # Line number:

      [ "$(printf 'a\nb\na\n' | sed -n '/a/ =')" = $'1\n3' ]

  ## y

    # Replace individual chars tr-like:

      [ "$(printf 'a\nb\n' | sed 'y/ab/01/')" = $'0\n1' ]
      [ "$(printf 'a\nb\n' | sed 'y/ab/AB/')" = $'A\nB' ]

  ## multiline

    # - pattern space: buffer that holds each line.

      #`s//` modifies pattern space

    # - `n`: empty pattern space, put next line into it. default action at end.

      # Print first line after matching `/a/`:

        [ "$(printf 'a\nb\n' | sed -n '/a/ {n;p}')" = $'b' ]

      # Print second line after matching `/a/`:

        [ "$(printf 'a\nb\nc\n' | sed -n '/a/ {n;n;p}')" = $'c' ]

    # - `N`: append next line to pattern space. Next line is not read again.

        [ "$(printf 'a\nb\n' | sed -n '/a/ {N;p};')" = $'a\nb' ]
        [ "$(printf 'a\nb\n' | sed -n '/b/ p; /a/ {N;p};')" = $'a\nb' ]

    # - `p`: print entire pattern space. default action at end if no `-n`.

    # - `P`: print up to first newline. TODO error:

        #[ "$(printf 'a\nb\n' | sed -n '/a/ P')" = $'b' ]

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

        [ "$(printf 'a\nb\n' | sed -n 'h; /a/ {s/a/c/; s/$/\n/; x;p;x;p}')" = $'a\nc\n' ]

      # Print first line before matching `/b/`:

        [ "$(printf 'a\nb\n' | sed -n '/b/ {x;p;d}; h')" = $'a' ]

    ## g

      # Pattern space = hold space

        [ "$(printf 'a\nb\n' | sed -n 'h; /a/ {s/a/c/;x;p;g;p}')" = $'a\nc' ]

    ## G

      # Pattern space += hold space

        [ "$(printf 'a\nb\n' | sed -n 'h; /a/ {s/a/c/;x;G;p}')" = $'a\nc' ]

  ## goto

    ## label

      # May be on same line as command, ex: `:l s/a/b/` is the same as `:l; s/a/b`.

    ## b

      # Unconditional jump.

        [ "$(printf 'a\nb\n' | sed '/a/ b c; s/./c/; :c')" = $'a\nc' ]
        [ "$(printf 'a\nb\n' | sed '/a/ b c; s/./c/; :c s/c/d')" = $'a\nd' ]

    ## t

      # Jump if last s changed pattern space.

      # Remove spaces after a:

        [ "$(printf 'a b c\n' | sed ':a s/a /a/; t a')" = $'ab c' ]

      # Remove everything between a and c:

        [ "$(printf 'a b c\n' | sed ':a s/a[^c]/a/; t a')" = $'ac' ]

## GNU extensions

  ## Command line arguments GNU

    ## r

      # Use EREs instead of BREs:

        [ "$(echo 'aa' | sed -r 's/.+/b/')" = 'b' ]

    ## i

      # Edit files in-place, modifying them.

      # WARNING: transforms symlinks into regular files!
      # Use the GNU extension `--follow-symlinks`, to prevent this.

        f=/tmp/f
        printf 'a\nb\n' > "$f"
        sed -i 's/a/A/' "$f"
        [ "$(cat "$f")" = $'A\nb' ]

        sed -i.bak 's/A/a/' "$f"
          #baks up old file with .bak suffix
        [ "$(cat "$f")" = $'a\nb' ]
        [ "$(`cat "$f".bak)" = $'A\nb' ]
        [ `ls | wc -l` = 2 ]

      # Whatever it would print to stdout, writes to the input file instead.

      # Cannot be used with stdin input!

    # https://www.gnu.org/software/sed/manual/sed.html

  ## Syntax

    ## Numeric byte values

      # https://www.gnu.org/software/sed/manual/sed.html#Escapes

      # Numeric character specifications:

        #\dxxx
        #\oxxx
        #\xxx

      # Great for when you fell like doing some binary file editing.

    ## Character classes

      # GNU sed offers some Perl like character class notation like `\s`.

## Applications

  ## Show substitutions made

    # If modified, print line number, old line, new line

    # E.g.:

    # Input:

      #a
      #b
      #a
      #b

    # Regex: `s/a/c/`.

    # Output:

      #1
      #a
      #c
      #
      #3
      #a
      #c

        [ "$(printf 'a\nb\na\nb\n' | sed -n 'h; s/a/c/; t p; d; :p {=;x;G;s/$/\n/;p}')" = $'1\na\nc\n\n3\na\nc\n' ]

  ## Print all lines between a start and end matching lines

    # http://unix.stackexchange.com/questions/17404/show-only-text-between-2-matching-pattern
    # http://stackoverflow.com/questions/17988756/how-to-select-lines-between-two-marker-patterns-which-may-occur-multiple-times-w

echo 'ALL ASSERTS PASSED'
