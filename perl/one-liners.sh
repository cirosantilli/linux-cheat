#!/usr/bin/env bash

##sources

	#famous perl one liners: <http://www.catonmat.net/blog/perl-one-liners-explained-part-six/>

#wait a ctrl-d and then execute everything:

	perl

##command line options

	##-e "$s"

		#execute given string instead of file program

	##-n:

		#use `while (<>) { ... }` loop aroud given program
		#this makes perl act linewise
		#each line gets the default value `$_`
		#therfore to print the current line, you instead of `print($_)` can simply write `print`
		#the endline `"\n"` is part of the string

	##-p

		#same as `-n`, with `print` at end

	##-i

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

	##-a

		#autosplit

		#adds `@F = split(/ /);` to top of loop.
		#requires `-n` or `-p`.

			assert[ "`echo $'a b c\nd e f' | perl -nae 'print $F[0]. ":" . $F[1] . ":" . $F[2]'`" = "a:b:c:d:e:f:" ]

		#multiple spaces are split:
			assert[ "`echo $'a  b c' | perl -nae 'print $F[0]. ":" . $F[1] . ":" . $F[2]'`" = "a:b:c"]

		#tabs are split:
			assert[ "`echo $'a\0b\tc' | perl -nae 'print $F[0]. ":" . $F[1] . ":" . $F[2]'`" = "a:b:c"]

	##-F

		#`-F: '/pattern/'`: set field separator for `-a`

		#must be used with `-a`

		#change

            assert[ "`echo $'a:b:c' | perl -naF':' -e 'print $F[0]. " " . $F[1] . " " . $F[2]'`" = "a b c"]

	##-0

		#`-000` sets `$/` (IRS) to a given octal value

		#default: "\n"

		##special values

			##0777

				#slurp mode. read everything at once.

			##00

				#paragraph mode. read up to "\n\n"

	##-l

		#adds chomp to loops

		#no arg: sets `$\ = $/` (ORS = IRS)

		#with arg: sets `$\ = $/` (ORS = IRS)

		#default `$\`: ''

		##application

			#add newline to prints if `-0` is not set
			#(and thus equals newline)

			#remove the annoying end newline which may match your `\s`!!

	##-M

		#import modules

		#print sum of lines:
			perl -MList::Util=sum -alne 'print sum @F'

##Important one liners

    #Find files with matching names and print only new modified lines to stdout:

        find . -iname "*.tex" | xargs perl -lane 'print if s/a/A/g'

    #Useful before you do mass refactoring

    #Make the modifications on files with matching names, print nothing to stdout

        find . -iname "*.tex" | xargs perl -lapi -e 's/a/A/g'

    #Useful to do mass regex refactoring.
    #*Very dangerous*, so make a backup of the current direcotyr before proceeding!

    #Print only modified lines, old and new, with line numbers:

        echo $'a\nb\nc\nb' | perl -lane '$o = $_; if (s/b/B/g) { print $. . "  " . $o . "\n" . $. . "  " . $_ . "\n" }'

    #Not linewise

        perl -0777 -lape 's/\n\n+/\n/\ng' F

    #print file with line numbers, tab separated by 2 spaces from text:

        perl -ne 'print $., "  ", $_' F

	echo $'a\nb\nc\nda\nb\nc' | perl -ne 'print if /a/ .. /c/'
		#$'a\nb\nc\na\nb\nc'
		#print between regexes inclusive non greedy

	echo $'a\nb\nc' | perl -ne 'BEGIN{ $a = 0 }; $a = 0 if /c/; print if $a; $a = 1 if /a/;'
		#b
		#print between regexes exclusive non greedy

	perl -ne 'print if 15 .. 17' F
		#print fron line 15 to 17

	perl -pe '/baz/ && s/foo/bar/'
		#substitute (find and replace) "foo" with "bar" on lines that match "baz".

	ifconfig | perl -ne '/HWaddr (\S*)/ && print $1 . "\n"'
		#print backreference only on matching lines

	echo $'a\nb' | perl -ne 'BEGIN{ $a = "b" } END{ print $a }'
		#b
		#act only on begin and end

	echo $'a\nab' | perl -ne 'print length, "\n"'
		#$'2\n3'

	##ack combo

		#regex refactoring:
		ack -f | xargs perl 's/a/b/'
