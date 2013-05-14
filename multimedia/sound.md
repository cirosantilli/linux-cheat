# players

## cplay

cli

has a file browser

    cplay

# manipulation

## lame

encode, decode and modify mp3

increases volume 5x:

    lame --scale 5 a.mp3

## id3tool

get id3 tags info (for mp3 for example)

    TITLE="`id3tool "$1" | grep '^Song Title:' | awk '{ for (i=3;i<=NF;i++) { printf $i; printf " " } }'`"
    ARTIST="`id3tool "$1" | grep '^Artist:' | awk '{ for (i=2;i<=NF;i++) { printf $i; printf " " } }'`"
    ALBUM="`id3tool "$1" | grep '^Album:' | awk '{ for (i=2;i<=NF;i++) { printf $i; printf " " } }'`"
    YEAR="`id3tool "$1" | grep '^Year:' | awk '{ for (i=2;i<=NF;i++) { printf $i; printf " " } }'`"
    TRACKNUM="`id3tool "$1" | grep '^Year:' | awk '{ print $2 }'`"

    install -D "$1" /music/mp3/"$ARTIST-$ALBUM-$YEAR"/"$TRACKNUM-$ARTIST-$TITLE".mp3

## cut up flac cue into multiple files

### flacon

has gui

### shntool

single ape and cue in dir, flac output, formatted as number, author, track

    shntool split -f *.cue -o flac *.ape -t '%n - %p - %t'

## sox

record, play and modify files cli

interactive front end for libSoX

must install available formats separatelly

record from microphone into `a.wav` file:

    rec a.wav

`ctrl+c` : stop recording

plays `a.wav` file:

    play a.wav

terminates when over

# system parameters

## alsamixer

ncurses interface to view/control sound parameters

    alsamixer

commands:

- left/right : change active parameter
- up/down    : change active parameter value

## amixer

cli for sound control

view available controls:

    amixer scontrols

set master volume to 50%:

    amixer sset 'Master' 50%

# rip

## abcde

### cli

rip:

    abcde

automatically starts ripping correctly on most systems!!

creates dir in cur dir and saves rip out as `.ogg` in it
