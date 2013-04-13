#!/usr/bin/env bash

# perlexpre batch renaming

#1 general notes

#2 full path only

# please note that the rename acts on THE WHOLE full/relative path...
# and as far as I know there is no way to avoid this
#.
# so to act on the basename only with find output, (./ ./path/to ...) you
#
# must either do:
#
# (.*\/?)asdf/$1qwer
#
# or 
#
# \/asdf$\/\qwer
#
# if you do a simple * on bash you should be just fine whithout though

#2 -n makes dry run and prints the output

# i'm putting -n all the time to prevent myself from doing S***

#2 make output readable output

rename -n 's/original/renamed/g' | rename-readable
# will print as: (much more readable, unless you input contains a string ' renamed as ', then just cry)
#
# original 1
# renamed 1
#
# original 2
# renamed 2

#1 general

find . -print0 | xargs -0 rename -n 's/\s+/ /g' | rename-readable
# all whitespaces --> space
# multiple spaces --> single space

find . -print0 | xargs -0  rename -n 's/_/ /g' | rename-readable
# underline to space

#1 books

find . -name '* - * - *' -print0 | xargs -0 rename -n 's/^(.*?) - /$1. /g' | rename-readable
# Book Title - Book Subtitle - Author --> Book Title. Book Subtitle - Author
# does it only for those that contain two separators ' - '

find-books . | xargs -0 rename -n 's/(.*\/)(.*?) - (.*)\.(.*)/$1$3 - $2.$4/g' | rename-readable

#1 music

find-music . | xargs -0 rename -n 's/(.*\/)(\d\d)\.? ([^-])/$1$2 - $3/g' | rename-readable
# 01 Title --> 01 - Title
# 01. Title --> 01 - Title

find-music . | xargs -0 rename -n 's/(.*\/)(\d\d)\.([^ ])/$1$2 - $3/g' | rename-readable
# 01.Title --> 01 - Title

find-music . | xargs -0 rename -n 's/(.*\/)\d\d /$1/g' | rename-readable
# 01 Title --> Title
# useful for example in the numbering of a collection with many composers that you want to split up

find-music . | xargs -0 rename -n 's/(.*\/)\((\d\d)\) /$1$2 - /g' | rename-readable
# (01) Title --> 01 - Title

find-music . | xargs -0 rename -n 's/.MP3$/.mp3/g' | rename-readable
# .MP3 --> .mp3

#1 videos

's/([^(]*)\((\d*), ([^)]*)\)/$3 - $2 - $1/g'
's/\s+/ /g'
# Film title (1978, Director) --> Director - 1978 - Film title

find-videos . | xargs -0 's/^(\d\d) ([^-])/$1 - $2/g'
# 37 Name --> 37 - Name
