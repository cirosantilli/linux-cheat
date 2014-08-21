#!/usr/bin/env gnuplot

#Install:

  #sudo aptitude install gnuplot-x11

##Review

  ##Uses its own scripting language

    #the awk of plotting: very domain specific language.

    #can get specific jobs done in seconds with amazing golfing.
    
    #but if you get slightly away from its intended usage
    #it becomes insane or impossible to get the task done.

  ##Limitations

    #- cannot draw primitives like points or lines
    #- cannot draw vector flow plots from functions
    #- no c api, only via pipes...

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

    #each data block in a file is separated by **two empty lines**

  ##non nummeric

    #is an error

##set

  #set plot parameters

  #if not set, gnuplot is free to chooses a good value

  ##xrange ##yrange

    #view area:
  
      set xrange [-1:1]
      set yrange [-1:1]

  ##key

    #legends

    #turn off:

      set key off

##unset

    unset xrange

##Plot

  #function:

    p sin(x)
    p sin(x), cos(x)

  #set xrange:

    p [-5:5] sin(x)

  ##data file

      p "a.dat", "b.dat"

    #must be in format: x y\nx y\n ...

    ##Using
    
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

  ##Line Color

      p sin(x) lc rgb "red"
      p sin(x) lc rgb "blue"

##SPlot

  #3d plot

    sp x+y

##CLear

  #clear plot screen

    p sin(x)
    cl

##REPlot

  #adds to existing plot without clearing first:

    p sin(x)
    rep cos(x)
    rep cos(x+1)

  #must have a previous plot

##STats

  #view and get data info

  #view:

    fp = 'a.dat'
    st fp

  #get number of rows *after doing a stats*:

    pr STATS_records

##pa

  #pa one second:

    pa 1

  #pa gnuplot until any character is input by user:

    pa -1

##minimal programming language

    a = 1
    pr a
    pr pi

  ##functions

    #define:

      f(x) = cos(x) + sin(x) + exp(-x**2) + abs(x)

    #use: 
    
      pr f(1)
      p f(x)

    ##piecewise

        step(x) = x>a ? 1 : 0
        p f(x)*(x<0.8) +  g(x)*(x>=0.8)
          #disadvantage: both parts are always evaluated

    pr 1 + 1
    pr 1 * 1
    pr 1.0 / 2.0

    pr 1 < 2
    pr 1 > 2
    pr 1 != 1

    pr "as"."df"

    if( 1 ){ pr "1" }
    if( 0 ){ pr "0" }

    do for[i=1:5:2]{ pr i }
    do for[i=1:5:2]{ pr i }

  ##not possible in 4.6:

    #- use command line arguments
    #- define non mathematical functions (`f(){p sin(x); rep cos(x)}`)

##save image

    p abs(x)

  #save the image

    set term gif
    set output "out.gif"
    rep

  #jpeg, png, svg, postscript also possile

  #return to normal plotting mode in linux:

    set output
    set term x11

  ##save gif video

      set key off
      set term gif animate
      set out "out.gif"
      p sin(x)
      n = 20
      for [i=1:n]{ rep sin(x+i*2*pi/n) }

    #now whatever you plot will go to a gif video file!

##SAve session

  #save current session:
  #- variables
  #- functions
  #- last plot/splot command

    sa ses.gnuplot

  ##LOad

    #load something saved with `save`

      lo ses.gnuplot

##examples

  ##plot state space evolution of a 2nd order ode as an 2d animation

    #data is of form: x x'

      fp = "ode.dat"
      stat fp
      set key off
      p fp lw 0.5 lc rgb "red"
      do for [i=1:STATS_records]{ rep fp ev ::i::i lw 5 lc rgb "blue"; pa 0.05  }
