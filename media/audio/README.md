#Directories

On most systems, sound will be kept under:

    /usr/share/sounds

They are put under `share` because that is where arch independent files used by applications should be put.

You can also create `~/share/sounds` for you favorite sounds.

A good technique is to define an alias as:

    alias playa='paplay ~/share/sounds/alert.ogg' # play Alert

so you can play it after commands end:

    sleep 2 && playa

If you want to have some real good fun try:

    find /usr/share/sounds -type f -iname '*.ogg' | sort | xargs -I'{}' play '{}'

#Players

##paplay

Pulse Audio play.

Comes by default on Ubuntu 12.04.

Play file once and exit:

    play a.wav

Terminates when over. Good option to play an alarm signal after a very long command:


    sleep 5 && play ~/share/sounds/alert.*

##aplay

ALSA player.

Comes with Ubuntu 12.04, but did not work very well.

##play

SoX package. Similar to `paplay`.

##cplay

ncurses CLI.

Has a file browser.

    cplay

#Manipulation

##lame

Encode, decode and modify MP3.

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

##Cut up FLAC CUE into multiple files

###flacon

GUI.

###shntool

Single APE and CUE in dir, FLAC output, formatted as number, author, track

    shntool split -f *.cue -o flac *.ape -t '%n - %p - %t'

##SoX

Set of utilities record, play and modify files via CLI.

Interactive front end for libSoX.

Must install available formats separatelly.

Record from microphone into `a.wav` file:

    rec a.wav

`ctrl+c` to stop recording.

#ALSA

Advanced Linux Sound API.

Replaced OSS in 2008 when OSS when went proprietary. OSS came back to open source, but it lost much momentum.

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
