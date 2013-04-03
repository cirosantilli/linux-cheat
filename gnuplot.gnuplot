#!/usr/bin/env gnuplot

##uses its own scripting language

  #the awk of plotting: very domain specific language.

  #can get specific jobs done in seconds with amazing golfing.
  
  #but if you get slightly away from its intended usage
  #it becomes insane or impossible to get the task done.

#install:

  #sudo aptitude install gnuplot-x11

##command line

  #execute scrip from a file

    #gnuplot file.gnuplot

  ##-e

    #execute from string

      #gnuplot -e 'p sin(x)'

##datafiles

  ##single blank line

    #are ingored

  ##comments

    #start with `#`

  ##data block

    #each data block in a file is separated by a two newlines

##set

  #set plot parameters

    set xrange [-1:1]
    set yrange [-1:1]

  #if not set, gnuplot is free to choose a good value

##unset

    unset xrange

##Plot

    p sin(x)
    p sin(x), cos(x)
    p "a.dat", "b.dat"

  #Using
  
    #select data columns
    
    #only columns 2 and 3:

    p "a.dat" u 2:3

  ##With

    #plot style

    #Line:

      p sin(x) w l 

  ##EVery

    #select ranges, increases and datablocks

    #plot only the first column up to the 10th:

      p fp ev ::1::10

  ##Line Width

      p sin(x) lw 0.25
      p sin(x) lw 25

##stats

  #view and get data info

  #view:

    fp = 'a.dat'
    stats fp

  #get number of rows *after doing a stats*:

    print STATS_records

##pause

  #pause one second:

    pause 1

  #pause gnuplot until any character is input by user:

    pause -1

##minimal programming language

    a = 1
    print 1 + 1
    print 1 * 1
    print 1.0 / 2.0
    print "as"."df"
    print a
    print 1 < 2
    print 1 > 2
    print 1 != 1
    if( 1 ){ print "1" }
    if( 0 ){ print "0" }
    do for[i=1:5:2]{ print i }
    do for[i=1:5:2]{ print i }

##combos

  ##plot solution of a 2nd order ode as an animation

    #data is of form: x x'

      set xrange []
      set yrange []
      fp = ""
      stat fp
      do for [i=1:STATS_records]{ p fp ev ::1::i; pause 0.1  }
