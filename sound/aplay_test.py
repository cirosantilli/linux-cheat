#!/usr/bin/env python

import itertools
from math import sin, pi
import os
import sys
import subprocess

R = 8000.0;     #sample rate (samples per second)
C = 261.625565; #frequency of middle-C (hertz)
F = R/256.0;    #bytebeat frequency of 1*t due to 8-bit truncation (hertz)
V = 255;        #a volume constant

def pure_c(t, mult = 1.0):
    return( sin( t * 2 * pi / R * C * mult ) + 1 ) * V

def saw_c(t):
    return t / F * C;

def viznut(t):
    return ( t * 5 & t >> 7 ) | ( t * 3 & t >> 10 )

def two_notes(t):
    if t / 500:
        return pure_c(t)
    else:
        return pure_c(t,)

if __name__ == "__main__":

    if( len( sys.argv ) > 1 ):
        tune = sys.argv[1]
    else:
        tune = "0"

    print tune

    if tune == "0":
        f = pure_c
    elif tune == "1":
        f = saw_c
    elif tune == "2":
        print "here"
        f = viznut
    else:
        f = pure_c

    process = subprocess.Popen(
        "aplay",
        stdin = subprocess.PIPE,
    )

    for t in itertools.count():
        #print f(t)
        process.stdin.write( str(f(t)) + "\n" )
