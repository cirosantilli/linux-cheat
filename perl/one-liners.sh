#!/usr/bin/env bash

# Cheat on the perl command line interface, including very useful one liner combos.

##command line options

    # Official man:

        #perldoc perlrun

    # Not part of LSB, so you may need to install perldoc.

	##e "$s"

		#execute given string instead of file program

	##n:

		# Use `while (<>) { ... }` loop aroud given program
		# This makes perl act linewise.
		# Each line gets the default value `$_`.
		# Therfore to print the current line, you instead of `print($_)` can simply write `print`
		# the endline `"\n"` is part of the string.

	##p

		# Same as `-n`, with `print` at end

	##i

		# What would get printed is put into file instead:

			printf 'a\nb\n' > f
			assert [ "`perl -lpi -e 's/a/A/g' f`" ]
			assert [ "`cat f`" = $'A\nb' ]

		#newlines are affected

		#-i: inline

		#saves old file to F.bak, original is changed:

			printf 'a\nb\n' > f
			assert [ "`perl -lpi.bak -e 's/a/A/g' f`" ]
				#NO SPACE BETWEEN I AND '.bak'!!!
			assert [ "`cat f`" = $'A\nb' ]
			assert [ "`cat f.bak`" = $'a\nb' ]

	##a

		# Autosplit

		# Adds `@F = split(' ');` to top of loop, so defualt separator is a single space `' '`.

		# Requires `-n` or `-p`.

			assert[ "`echo $'a b c\nd e f' | perl -nae 'print $F[0]. ":" . $F[1] . ":" . $F[2]'`" = "a:b:c:d:e:f:" ]

		# Multiple spaces are split:

			assert[ "`echo $'a  b c' | perl -nae 'print $F[0]. ":" . $F[1] . ":" . $F[2]'`" = "a:b:c"]

		# Tabs are split:

			assert[ "`echo $'a\0b\tc' | perl -nae 'print $F[0]. ":" . $F[1] . ":" . $F[2]'`" = "a:b:c"]

	##F

		# `-F: '/pattern/'`: set field separator for `-a`

		# Must be used with `-a`

		# Literal:

            [ "$(echo $'a:b:c' | perl -F':' -lane 'print $F[0] . " " . $F[1] . " " . $F[2]')" = "a b c"] || exit 1

		# regex separator:

            [ "$(echo 'a:%b:]c' | perl -F'/:./' -lane 'print $F[0] . " " . $F[1] . " " . $F[2]')" = "a b c" ] || exit 1

	##0

		#`- 000` sets `$/` (IRS) to a given octal value

		# Default: "\n"

		##special values

			##0777

				# Slurp mode. read everything at once.

			##00

				# Paragraph mode. read up to "\n\n".

	##l

		# Adds chomp to loops.

		# No arg: sets `$\ = $/` (ORS = IRS)

		# With arg: sets `$\ = $/` (ORS = IRS)

		# Default `$\`: ''

		##application

			# Add newline to prints if `-0` is not set
			# (and thus equals newline)

			# Remove the annoying end newline which may match your `\s`!

	##M

		# Import modules.

		# Print sum of lines:

			perl -MList::Util=sum -alne 'print sum @F'

##combos

    # **Very dangerous!!!!**, so make a backup of the current directory before proceeding.

    # Find files with matching names and print only new modified lines to stdout:

        find . -iname "*.tex" | xargs perl -lane 'print if s/a/A/g'

    # Useful before you do mass refactoring

    # Make the modifications on files with matching names, print nothing to stdout

        find . -iname "*.tex" | xargs perl -lapi -e 's/a/A/g'

    ##multiline ##slurp

      # For multiline operations:

        find . -iname "*.tex" | xargs perl -0777 -ne 'print if s/a/A/g'
        find . -iname "*.tex" | xargs perl -0777 -pi -e 's/a/A/g'

      # For the love of God, do not use `-l` with this unless you know what you are doing.

      # **Whatch out for the trailing newline!**. `.` will match any character now.

      # Useful to do mass regex refactoring.

      # Remember that the dot does not match newlines by default.

        [ -z "$(printf 'a\n' | perl -0777 -ne 'print m/a./')" ] || exit 1

      # You need `gs` for that:

        [ "$(printf 'a\na\n' | perl -0777 -ne 'print m/a./gs')" = "$(printf "a\na")" ] || exit 1

      # The `g` is mandatory TODO why

    # Print only modified lines, old and new, with line numbers and file names

      find . -type f | xargs -L 1 perl -lane '$o = $_; if (s/'"$1"') { print $ARGV . ":" . $. . "\n" . $o . "\n" . $_ . "\n" }'

    # Sample output:

      #./a:1
      #a
      #c
      #
      #./b:1
      #b
      #c

    # Print file with line numbers, tab separated by 2 spaces from text:

      perl -ne 'print $., "  ", $_' F

    # Print between regexes inclusive non greedy

      printf 'a\nb\nc\nda\nb\nc\n' | perl -ne 'print if /a/ .. /c/'
      #$'a\nb\nc\na\nb\nc'

    # Print between regexes exclusive non greedy

      printf 'a\nb\nc\n' | perl -ne 'BEGIN{ $a = 0 }; $a = 0 if /c/; print if $a; $a = 1 if /a/;'
      #b

    # Print fron line 15 to 17:

      perl -ne 'print if 15 .. 17' F

    # Substitute (find and replace) "foo" with "bar" on lines that match "baz".:

      perl -pe '/baz/ && s/foo/bar/'

    # Print backreference only on matching lines:

      ifconfig | perl -ne '/HWaddr (\S*)/ && print $1 . "\n"'

    # Act only on begin and end:

      printf 'a\nb\n' | perl -ne 'BEGIN{ $a = "b" } END{ print $a }'
      #b

      printf 'a\nab\n' | perl -ne 'print length, "\n"'
      #$'2\n3'

    # Print all matching regexes only:

      [ "$(printf 'a0 b1\nc2 a3\n' | perl -ne 'print m/a./g')" = "a0a3" ] || exit 1
