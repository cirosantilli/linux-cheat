#!/usr/bin/env bash

#this script is meant to be put on the same dir as the test repos.

set -u # error on undefined variable
set -e # stop execution if one command return != 0

#examples:

F="$(basename "$0")"
usage()
{
  echo "copy and remove the standard git test repos

EXAMPLES

  copy dir 1 as dir t:

    ./$F 1

  remove old t/ and copy dir multi as t:

    ./$F multi
" 1>&2
}

if [ $# -eq 1 ]; then
  R="$1"
else
  usage
  exit 1
fi

rm -rf t
cp -r $R t
cd t
exec bash
