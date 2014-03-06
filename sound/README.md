sound and music players, editors and generators

#players

##cplay

CLI

Has a file browser.

    cplay

#manipulation

##lame

Encode, decode and modify mp3.

Increases volume 5x:

    lame --scale 5 a.mp3

##id3tool

Get id3 tags info (for mp3 for example):

    TITLE="`id3tool "$1" | grep '^Song Title:' | awk '{ for (i=3;i<=NF;i++) { printf $i; printf " " } }'`"
    ARTIST="`id3tool "$1" | grep '^Artist:' | awk '{ for (i=2;i<=NF;i++) { printf $i; printf " " } }'`"
    ALBUM="`id3tool "$1" | grep '^Album:' | awk '{ for (i=2;i<=NF;i++) { printf $i; printf " " } }'`"
    YEAR="`id3tool "$1" | grep '^Year:' | awk '{ for (i=2;i<=NF;i++) { printf $i; printf " " } }'`"
    TRACKNUM="`id3tool "$1" | grep '^Year:' | awk '{ print $2 }'`"

    install -D "$1" /music/mp3/"$ARTIST-$ALBUM-$YEAR"/"$TRACKNUM-$ARTIST-$TITLE".mp3

##cut up flac cue into multiple files

###flacon

GUI.

###shntool

Single APE and CUE in dir, FLAC output, formatted as number, author, track

    shntool split -f *.cue -o flac *.ape -t '%n - %p - %t'

##sox

Set of utilities record, play and modify files via CLI.

Interactive front end for libSoX.

Must install available formats separatelly.

Record from microphone into `a.wav` file:

    rec a.wav

`ctrl+c` to stop recording.

Plays `a.wav` file:

    play a.wav

Terminates when over. Good option to play an alarm signal after a very long command:

    sleep 5 && play long-sound.wav

#alsa

Advanced Linux Sound API.

Replaced OSS in 2008 when OSS when went proprietary.
OSS came back to open source, but it lost much momentum.

The kernel sound subsystem is called ALSA.

There are a few tools that interact with it.

##alsamixer

ncurses interface to view/control sound parameters

    alsamixer

Commands:

- left/right : change active parameter
- up/down    : change active parameter value

##amixer

CLI for sound control.

View available controls:

    amixer scontrols

Set master volume to 50%:

    amixer sset 'Master' 50%

Unmute sound:

    amixer -D pulse set Master 1+ unmute

##aplay

Command line tool that takes numeric input from stdin and generate sound.

#pulseaudio

##pacmd

Command line control to pulseaudio.

#rip

##abcde

###cli

Rip from dvd:

    abcde

Automatically finds right configurations on most systems.

Creates dir in cur dir and saves rip out as `.ogg` in it.
