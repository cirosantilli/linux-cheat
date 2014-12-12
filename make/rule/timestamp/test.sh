#!/usr/bin/env bash

## in out

#create `in`:
make change_in
#create `out`:
make out
#nothing happens because `in` is not newer than out:
make out
make change_in
#out happens because `in` is newer than `out`:
make out
make clean

## nodep

#runs:
make nodep
make change_nodep
#does not run because `nodep` exists:
make nodep
make clean

## phony

#runs:
make phony
make change_phony
#also runs, because phony is PHONY:
make phony
make clean
