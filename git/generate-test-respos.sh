#!/usr/bin/env bash

outdir="_gitignore"

if [ $# -gt 0 ]; then

  rm -rf "$outdir"

else

  mkdir "$outdir"
  cd _gitignore

  #0
  
  mkdir 0
  cd 0
  git init
  echo 'a1' > a
  echo 'b1' > b
  cd ..

  #1


fi
