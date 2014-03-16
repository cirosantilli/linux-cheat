#!/usr/bin/env perl

use feature qw(say);

use strict;

use warnings;
no warnings 'redefine';
no warnings;

##variables

    my $i = 1;
    (my $i2 = 1, my $i3);
    my $count;
    my $line;
    #my $i = 1;
    my $s = 'string';
    my @s = (1,3,'string');
    my @i; #works but is bad practice

##scope

    ##my

        # Confines variable to current block.

        # From that point onwards, it is not possible to access an external variable with same name.

            $i = 0;
            {
                $i = 1;
                my $i;
                $i = 2
            }
            $i == 1 || exit 1;

            $i = 0;
            { $i = 1; }
            $i == 1 || exit 1;

    ##local

        # Creates a new scope valid for current function and functions that the function calls.

            #my $x = 0;
            #sub f0 { return $x; }
            #sub f1 { local $x = 0; $x += 1; return f0(); }
            #f1() == 1 || exit 1;
            #$x == 0 || exit 1;

##stdout

    ##print

            print "print\n";
            print "a", 1, "\n";

    ##say

        # Automatically adds newlines.

            say 'say';

##booleans

        !0 == 1     or die;
        !1 == 0     or die;
        !-1 == 0    or die;
        !'' == 1    or die;
        !'a' == 0   or die;

        1 && 1    or die;
        !(1 && 0)   or die;

        1 || 1  or die;
        1 || 0  or die;

##arithmetic

    ##eq

        # TODO vs ==

        #==	!= <	<= >  >=
        #eq	ne lt	le gt ge

##strings

    ##single quote vs double quote literals

        my $s = "a";
        "$s\n" == "a\n" or die;

        # Single quote does not interpret backslash escapes:

            '$s\n' == "\$s\\n" or die;

    # Operations

        ('ab' . 'cd') == 'abcd' or die;
        ('ab' x 3) == 'ababab' or die;
        length('abc') == 3 or die;
        substr('abcd', 2, 2) == 'cd' or die;
        index('abb', 'b') == 1 or die;
        rindex('abb', 'b') == 2 or die;

    # Weakly typed insanity:

        1 + "1" == 2 or die;
        "1" + 1 == 2 or die;
        2 . 2 == "22" or die;

    ##chomp

        $s = "a\n\rb\n\r\r";
        chomp $s;
        $s == "a\n\r" or die;

    ##join

        join(',', (1, 2)) == "1,2" or die;

##array

        my @a = (0, 'a', 1);
        #array = ();

        $a[2] == 1 or die;

    # Last element

        #$#a == 2 or die;

        my @a = (0, 1);
        #push(@a, 2) == (0, 1, 2) or die;

        pop @a;
        print @a;

        shift @a;
        print @a;

        unshift @a, 0;
        print @a;

    # scalar context magic:

        #my $l = @a;
        #$l == length(@a) or die;

##list

        (1, 2, 'asdf', (1,2) );

    # Range:

        (0 .. 2) == (0, 1) or die;

    # TODO vs list: <http://stackoverflow.com/questions/6023821/perl-array-vs-list>

##hash map

    my %hash = ('key1', 'value1', 'key2', 'value2');
    #my %hash = (key1 => 'value1', key2 => 'value2'); #same
    print %hash;
    print $hash{key1};
    print keys %hash;
    print values %hash;
##context

    #operators such as = are overloaded depending if the act on variables ($), lists (@) or hashmaps (%)

##branch

    ##if

        ##single line

            #same as ``&&``

            #same as ``and``

                print 'a' if 1;
                print 'b' if 0;
                1 && print 'a';
                0 && print 'b';
                1 and print 'a';
                0 and print 'b';

            ##concatenate

                #ERROR:

                    #print 'a' if 1 if 1;

                #both conditions must be true

                    1 && 1 && print 'a';
                    1 and 1 and print 'a';

            ##can only use single command

            #no ``;`` accepted

                print 'a'; print 'b' if 0;
                    #a
                0 && print 'a'; print 'b';
                    #b

        ##multiline

            if (1) {
                    print 'Hello';
            }
            elsif (1) {
                    print 'Bye';
            }
            else {
                    print 'Neither';
            }

    ##unless

        #``unless``, ``&&`` and ``and`` are exact same as
        #``if``, ``||`` and ``or`` but negated.

        print 'a' unless 0;
        unless(0) {
            print 'a'
        }
        0 || print 'a';
        1 || print 'b';
        0 or print 'a';
        1 or print 'b';
        0 || 0 || print 'a';
        0 or 0 or print 'a';

    ##for

        ##single line

            print for (1 .. 10);

    ##foreach

        #example:
            foreach my $e (1 .. 3) {
                    print $e;
            }

        #default argument:

            foreach (1..3) {
                    print;
            }

        #single line:

            print foreach (1 .. 3);

        #like if, only single command (no ``;`` allowed)

        #uses references:

            my @a = (1 .. 5);
            foreach (@a) {
                $_ *= 2;
            }
            $a[0] == 2 || exit 1;

    ##while

        #example:

            $i = 10;
            while ($i > 0) {
                print $i;
                $i = $i - 1;
            }

        ##last = break

            $i = 0;
            while ($i < 100) {
                last if $i == 10;
                print $i;
                $i = $i + 1;
            }

        ##single line

            $count = 0;
            print $count, " " while ++$count <= 10;
            print "\n";

##regexp

    # Perl regexps were highly influential on regexes of other languages.

    # Perl regexps can do much more than the formal definition of regexps.

        "ab" =~ /a./ or die;
        "ab" =~ /b/ or die;

    # Ignore case:

        "A" =~ /a/i or die;
        "A" =~ /A/i or die;

    # Capturing groups:

        "a0b1" =~ /a(.)b(.)/;
        $1 == "0" or die;
        $2 == "1" or die;

    # Multiple matches with g:

        ("a0b1" =~ /(\d)/g) == "01" or die;

        my @a = ("a0b1" =~ m/(\d)/g);
        #@a == ["0", "1"] or die;

    # Loop multiple matches:

        my $s = "a0";
        $s =~ s/a(.)/b$1/ or die;
        #$s == "b0" or die;

    # Almost every backslash escape has a meaning in Perl.

    #- `\A`: Matches only at the beginning of a string
    #- `\Z`: Matches only at the end of a string or before a newline
    #- `\z`: Matches only at the end of a string
    #- `\G`: Matches where previous m//g left off

    #- `\U`: Start replacing by uppercase until `\E` is found or end of regexp.
    #- `\E`

#defalut variables

    ##sources

    #<http://www.kichwa.com/quik_ref/spec_variables.html>

    ##$_

        # Default arg to functions:

            $_ = 'Hello';
            print;
                #prints hello

        # Gets modified by functions:

    ##$.

        # Line numeber of last handle read

    ##input record reparator

        # Char at which perl stops reading from handle

            $/ = ':';
            print $/;

    ##output record reparator

        # What goes after print

            $\ = "a"; #output record separator for print

            print '';
                #a

    ##$,

        #output field separator for print when printing lists

            $, = ", ";
            print 1..3;

        # Output:

            #1, 2, 3

    ##$#

        #output format for numbers in print

    ##$$

        #cur process number

            print $$;

    ##$0

        #name of file of script being executed

            print $0;

    ##command line arguments

        # TODO

            #say $ARGV[0];

    ##regex

        #- $1..$9 #nth capturing group of last regex match

        #- $& #entire last regex match

        #- $`

        #- $'

        #- $+

    ##environment

            say "ENV";
            foreach my $key (keys %ENV) {
                say "  $key = $ENV{$key}";
            }

##functions ##sub

    # Called subprocess;

        sub f {
            my($a, $b) = @_;
            $a + $b;
            #return $a+$b
                # Return value is value of last evaluated expression.
                # No explicit `return` required.
                # If is also possible to use an explicit `return` command
                # to exit in the middle of a function.
        }

    #It is possible to ommit parenthesis to make the call:

        f(1, 2) == 3 or die;
        f 1, 2 == 3 or die;

    #This is specially useful on interactive sessions.

##file io

    ##file handles

        #readonly:

            #open(FH,"<path/to/file.txt")           or die "Opening: $!";
            #while(<FH>){print}
            #close(FH)                              or die "Closing: $!";

        #writeonly:

            #open(FH,">path/to/file.txt")           or die "Opening: $!";
            #print FH a, "\n"
            #print FH b, "\n"
            #close(FH)                              or die "Closing: $!";

        ##default

            #STDOUT:

                say STDOUT "stdout";

            #STDERR:

                say STDERR "stderr";

            #STDIN:

    ##readline

        #read from handle up to next line terminator char

        #all the same:

            #$_ = readline(STDIN)
            #$_ = readline
            #$_ = <STDIN>
            #$_ = <>

    ##diamond

        #Read from filehandle linewise.

        #If no filehandle given:

        #- if ARGV not empty, treat $ARGV[i] as files and read from them

        #- else, read from STDIN filehandle.

        #As usual, if no pipe is comming in, wait for user input.

        #@ARGV = ("file1.txt", "file2.txt");
        #while(<>) {
                #print;
        #}

        #perl -ne 'YOUR CODE HERE'

            #while (<>) {
                ##YOUR CODE HERE
            #}

        #perl -pe 'YOUR CODE HERE'

            #while (<>) {
                ##YOUR CODE HERE
                #print;
            #}

        #skip a line:

            #while (<>) {
                #/a/ && continue;
            #}

    ##get all lines from file to an array of lines:

        #open(FH,"<a.txt")           or die "Opening: $!";
        #my @ARRAY = <FH>;
            ##works beause of context
        #close(FH)                   or die "Closing: $!";

    ##modify file inline

        #open(FH, "+< FILE")                 or die "Opening: $!";
        #@ARRAY = <FH>;
        #foreach my $line (@array) {
                #$line =~ s/a/A/
        #}
        #seek(FH,0,0)                        or die "Seeking: $!";
        #print FH @ARRAY                     or die "Printing: $!";
        #truncate(FH,tell(FH))               or die "Truncating: $!";

##exit

    #Terminates the program.

    #Does not necessary reflect on the exit status of the perl executable.
    #Must use `POSIX::_exit($status)` for that.

##process call

    ##system

        #on background

        #cannot get stdout nor return status

            system("echo", "-n", "a", "b");

    ##qx

        #program waits for end

        #can get stdout and return status

            $a = qx(echo -n a b);
            $a = `echo -n a b`;

    ##$?

        #status of last process close

            `false`;
            print $?, "\n";
                #

            `true`;
            print $?, "\n";
