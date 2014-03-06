#!/usr/bin/env bash

# Cheat on the perl command line interface, including very useful one liner combos.

##command line options

    # Official man:

        #perldoc perlrun

    # Not part of LSB, so you may need to install perldoc.

	##e "$s"

		#execute given string instead of file program

	##n:

		#use `while (<>) { ... }` loop aroud given program
		#this makes perl act linewise
		#each line gets the default value `$_`
		#therfore to print the current line, you instead of `print($_)` can simply write `print`
		#the endline `"\n"` is part of the string

	##p

		#same as `-n`, with `print` at end

	##i

		#what would get printed is put into file instead:

			echo $'a\nb' > f
			assert [ "`perl -lpi -e 's/a/A/g' f`" ]
			assert [ "`cat f`" = $'A\nb' ]

		#newlines are affected

		#-i: inline

		#saves old file to F.bak, original is changed:

			echo $'a\nb' > f
			assert [ "`perl -lpi.bak -e 's/a/A/g' f`" ]
				#NO SPACE BETWEEN I AND '.bak'!!!
			assert [ "`cat f`" = $'A\nb' ]
			assert [ "`cat f.bak`" = $'a\nb' ]

	##a

		# Autosplit

		# Adds `@F = split(/ /);` to top of loop.

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

		#import modules

		#print sum of lines:

			perl -MList::Util=sum -alne 'print sum @F'

##combos

    # Find files with matching names and print only new modified lines to stdout:

        find . -iname "*.tex" | xargs perl -lne 'print if s/a/A/g'

    # Useful before you do mass refactoring

    # Make the modifications on files with matching names, print nothing to stdout

        find . -iname "*.tex" | xargs perl -lapi -e 's/a/A/g'

    # For multiline operations:

        find . -iname "*.tex" | xargs perl -0777 -ne 'print if s/a/A/g'
        find . -iname "*.tex" | xargs perl -0777 -pi -e 's/a/A/g'

    # For the love of God, do not use `-l` with this unless you know what you are doing.

    # **Whatch out for the trailing newline!**. `.` will match any character now.

    # Useful to do mass regex refactoring.

    # **Very dangerous!!!!**, so make a backup of the current directory before proceeding.

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

    # Not linewise

        perl -0777 -lape 's/\n\n+/\n/\ng' F

    # print file with line numbers, tab separated by 2 spaces from text:

        perl -ne 'print $., "  ", $_' F

    # Print between regexes inclusive non greedy

        echo $'a\nb\nc\nda\nb\nc' | perl -ne 'print if /a/ .. /c/'
        #$'a\nb\nc\na\nb\nc'

    # Print between regexes exclusive non greedy

        echo $'a\nb\nc' | perl -ne 'BEGIN{ $a = 0 }; $a = 0 if /c/; print if $a; $a = 1 if /a/;'
        #b

    # Print fron line 15 to 17:

        perl -ne 'print if 15 .. 17' F

    # Substitute (find and replace) "foo" with "bar" on lines that match "baz".:

        perl -pe '/baz/ && s/foo/bar/'

    # Print backreference only on matching lines:

        ifconfig | perl -ne '/HWaddr (\S*)/ && print $1 . "\n"'

    # Act only on begin and end:

        echo $'a\nb' | perl -ne 'BEGIN{ $a = "b" } END{ print $a }'
		#b

        echo $'a\nab' | perl -ne 'print length, "\n"'
		#$'2\n3'
