#!/usr/bin/env perl

#perl cheat

#use use perl on a golfing one liner focus

#python for more involved applications

use strict;
use warnings;

##variables

    my $i = 1;
    my ($i2 = 1, $i3);
    my $count;
    my $line;
    #my $i = 1;
        #can only declare once
    my $s = 'string';
    my @s = (1,3,'string');
    my @i; #works but is bad practice

##stdout

    ##print

        print 'string';
        print 's1', 's2', 123;

##numbers

    print 1;
    print 4.4;
    print 1.2e10;

    print 1 + 2 - 3*(10/5) ** 4;

##booleans

    print !0;
    print !1 + 0;
    print !'string that converts to 1' + 0;
    print !'';

    print 1 && 'adsf';
    print 1 && '';

    print 0 || 1;
    print 0 || 0;

##compairison

    print 1 == 1;
    print '11' == '11';
    print '11' == '12';
    print '1' == 1;
    print 1 eq 1;
    print 1 eq 0;

    #==	!= <	<= >  >=
    #eq	ne lt	le gt ge

##strings

    print 'as' . 'df';
    print 'as' x 3;
    print length 'foo';
    print substr 'foo', 1, 2;
    print index 'foo', 'o';
    print rindex 'foo', 'o'; #last occurence

    print "as $i df $s\n";
    print 'as $i df $s\n';

    print "1" + 1;
    print 1 . 2;
    print "a" . (1+2);

    ##chomp

        $s = "chomp\n\n";
        chomp $s;
        print $s; #remove trailling \n

    ##join

        print join (',',(1,2,3));

##lists

    print (1, 2, 'asdf', (1,2) );
    print (1 .. 5);

##array

    my @array = (1, 2, 3);
    #array = ();

    print $array[2];
    print $#array; #last index

    push @array, 4; #put at ent
    print @array;

    pop @array; #remove
    print @array;

    shift @array; #left shift
    print @array;

    unshift @array, 0;
    print @array;

    #context magic
        my @array2 = @array; # list context
        print @array2;

        my $length = @array; # scalar context
        print $length;

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

            if (1)
            {
                    print 'Hello';
            }
            elseif (1)
            {
                    print 'Bye';
            }
            else
            {
                    print 'Neither';
            }

    ##unless

        #``unless``, ``&&`` and ``and`` are exact same as
        #``if``, ``||`` and ``or`` but negated.

        print 'a' unless 0;
        unless(0)
        {
            print 'a'
        }
        0 || print 'a'
        1 || print 'b'
        0 or print 'a'
        1 or print 'b'
        0 || 0 || print 'a'
        0 or 0 or print 'a'

    ##for

        ##single line

            print for (1 .. 10);

    ##foreach

        #example:
            foreach my $e (1 .. 3)
            {
                    print $e;
            }

        #default argument:
            foreach (1..3)
            {
                    print;
            }

        #single line:
            print foreach (1 .. 3)
        #like if, only single command (no ``;`` allowed)

        #uses references:
            @a = (1 .. 5);
            foreach (@a)
            {
                    $_ *= 2;
            }
            print @a[0]

    ##while

        #example:
            $i = 10;
            while ( $i > 0 )
            {
                print $i;
                $i = $i - 1;
            }

        ##last = break

            $i = 0;
            while ( $i < 100 )
            {
                    last if $i == 10;
                    print $i;
                    $i = $i + 1;
            }

        ##single line

            $count = 0;
            print $count, " " while ++$count <= 10;
            print "\n";

##regex

    my $mystring;
    my @myarray;

    $mystring = "Hello world!";
    print "m" if $mystring =~ m/World/;
    print "m" if $mystring =~ m/WoRlD/i; #ignore case

    $mystring = "[2004/04/13] The date of this article.";
    print "The first digit is $1." if $mystring =~ m/(\d)/

    $mystring = "[2004/04/13] The date of this article.";
    print "The first number is $1." if $mystring =~ m/(\d+)/

    $mystring = "[2004/04/13] The date of this article.";
    while($mystring =~ m/(\d+)/g) {
        print "Found number $1.";
    }

    $mystring = "[2004/04/13] The date of this article.";
    @myarray = ($mystring =~ m/(\d+)/g);
    print join(",", @myarray);

    $mystring =~ s/world/mom/;
    print $mystring;
    print $mystring if $mystring =~ s/mom/world/; #returns if replaced

    #\A - Matches only at the beginning of a string
    #\Z - Matches only at the end of a string or before a newline
    #\z - Matches only at the end of a string
    #\G - Matches where previous m//g left off

    #capture group

    $r = a.
    || assert

#defalut variables

    ##sources

    #<http://www.kichwa.com/quik_ref/spec_variables.html>

    ##$_

        #default arg to functions:

            $_ = 'Hello';
            print;
                #prints hello

        #gets modified by functions:

    ##$.

        #line numeber of last handle read

    ##input record reparator

        #char at which perl stops reading from handle

        $/ = ':';
        print $/;

    ##output record reparator

        #what goes after print

        $\ = "a"; #output record separator for print

        print ''
            #a

    ##$,

        #output field separator for print when printing lists

        $, = ", ";
        print 1..3
            #1, 2, 3

    ##$#

        #output format for numbers in print

    ##$$

        #cur process number

            print $$;

    ##$0

        #name of file of script being executed

            print $0;

    ##regex

        #$1..$9 #nth capturing group of last regex match
        #$& #entire last regex match
        #$`
        #$'
        #$+

    ##command line arguments

            print $ARGV[0];

    ##environment

            foreach $key (keys %ENV)
            {
                print "$key --> $ENV{$key}\n";
            }

##functions

    #called **subprocess**

        sub f
        {
            my($a,$b) = @_;
            $a+$b;
                #return value is value of last evaluated expression
            return $a+$b
                #can also use return statement
        }

        print f(1,2);
        print f 1,2;

##file io

    ##file handles

        #readonly:
            open(FH,"<path/to/file.txt")           or die "Opening: $!";
            while(<FH>){print}
            close(FH)                              or die "Closing: $!";

        #writeonly:
            open(FH,">path/to/file.txt")           or die "Opening: $!";
            print FH a, "\n"
            print FH b, "\n"
            close(FH)                              or die "Closing: $!";

        ##default

            #STDOUT:
                print STDOUT "stdout"

            #STDERR:
                print STDERR "stderr"

            #STDIN:
                print STDERR "stderr"

    ##readline

        #read from handle up to next line terminator char

        #all the same:
            $_ = readline(STDIN)
            $_ = readline
            $_ = <STDIN>
            $_ = <>

    ##diamond

        #read from filehandle linewise

        #if no filehandle given:
        #- if ARGV not empty, treat $ARGV[i] as files and read from them
        #- else, read from STDIN filehandle.
            #As usual, if no pipe is comming in, wait for user input.

            @ARGV = ("file1.txt", "file2.txt");
            while(<>)
            {
                    print;
            }

            #perl -ne 'YOUR CODE HERE'
                while ( <> )
                {
                    #YOUR CODE HERE
                }

            #perl -pe 'YOUR CODE HERE'
                while ( <> )
                {
                    #YOUR CODE HERE
                    print;
                }

        ##skip a line:

                while ( <> )
                {
                    /a/ && continue;
                }

    ##get all lines from file to an array of lines:

        open(FH,"<a.txt")           or die "Opening: $!";
        @ARRAY = <FH>;
            #works beause of context
        close(FH)                   or die "Closing: $!";

    ##modify file inline

        #open(FH, "+< FILE")                 or die "Opening: $!";
        #@ARRAY = <FH>;
        #foreach my $line (@array) {
                #$line =~ s/a/A/
        #}
        #seek(FH,0,0)                        or die "Seeking: $!";
        #print FH @ARRAY                     or die "Printing: $!";
        #truncate(FH,tell(FH))               or die "Truncating: $!";

##process call

    ##system

        #on background

        #cannot get stdout nor return status

        system("echo", "-n", "a", "b");

    ##qx

        #program waits for end

        #can get stdout and return status

        my $a = qx(echo -n a b);
        my $a = `echo -n a b`;

    ##$?

        #status of last process close

            `false`;
            print $?, "\n";
                #

            `true`;
            print $?, "\n";
