#!/usr/bin/env bash

set -u # error on undefined variable
set -e # stop execution if one command return != 0

outdir="_out"
copy_script="copy.sh"

F="$(basename "$0")"
usage()
{
  echo "generate and remove git test repos

EXAMPLES
  
  create tests:

    $F

  they are put inside a dir named: $outdir

  delete tests:

    $F clean

  the output dir is completelly removed.
" 1>&2
}

if [ $# -gt 0 ]; then
  if [ $1 = clean ]; then
    rm -rf "$outdir"
  else
    usage
    exit 1
  fi
else


  mkdir "$outdir"
  cp "$copy_script" "$outdir"
  cd "$outdir"
  chmod +x "$copy_script"

  #0
  
  mkdir 0
  cd 0
  git init
  echo 'a1' > a
  echo 'b1' > b
  cd ..

  #1

  cp -r 0 1
  cd 1
  git add *
  git commit -m 1
  cd ..

  #1u

  cp -r 1 1u
  cd 1u
  echo 'c1' > c
  cd ..

  #1b

  cp -r 1u 1ub
  cd 1ub
  git branch b
  cd ..

  #2

  cp -r 1 2
  cd 2
  echo 'a2' >> a
  echo 'b2' >> b
  git commit -am 2
  cd ..

  #2u

  cp -r 2 2u
  cd 2u
  echo -e 'c1' >> c
  cd ..

  #2b

  cp -r 1u 2b
  cd 2b
  git add c
  git commit -am '2'

  git checkout -b b HEAD~
  echo a2 >> a
  echo '' >> b
  echo d1 > d
  git add d
  git commit -am 'b2'
  git checkout master
  cd ..

  #3

  cp -r 2 3
  cd 3
  echo 'a3' >> a
  echo 'b3' >> b
  git commit -am 3
  cd ..

  #0bare

  mkdir 0bare
  cd 0bare
  git init --bare
  cd ..

  #multi

  mkdir multi
  cp -r 2b multi/a
  cd multi
  git clone --bare a ao
  git clone --bare ao bo
  git clone bo b

  cd a
  git remote add origin ../ao
  cd ..

  cd b
  git remote add upstream ../ao
  cd ..

  cd ..

  #multiu

  mkdir multiu
  cp -r multi/* multiu
  cd multiu

  cd a
  echo e1 > e
  git add e
  git commit -am e
  cd ..

  cd b
  echo f1 > f
  git add f
  git commit -am f
  cd ..
  
  cd ..

fi

exit 0
