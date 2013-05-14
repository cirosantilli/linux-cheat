video formats, viewer and manipulation tools

# definitions

*ripping* is taking the dvd from the dvd to files in computer

*trancoding*, is encoding the dvd on some smaller format.

*containers* are filetypes that turn video, audio and subtitles in a single files. Ex:

- mkv
- avi

## subtitles

subtitles are often stored as images inside of containers in the format pair: idx + sub.

If you want srts, which is a text-only, smaller and human editable format, use a tool [vobsub2srt][]

# DVD

DVDs have regions

http://en.wikipedia.org/wiki/DVD_region_code

this serves only to control copyright

dvd readers have a limited number of region changes, sometimes around 5

for certain dvd readers, after this number of changes, YOU CANNOT CHANGE IT ANYMORE!!!!

# vlc

great cross plaform video player

# handbrake

transcode

supported containers: mkv, mpeg4

first check this for some good info: <http://msdn.microsoft.com/en-us/library/windows/desktop/dd388582%28v=vs.85%29.aspx>

It stores audio in the AAC, MP3, or Vorbis formats. It can also pass through the Dolby Digital 5.1 (AC3) and Digital Theater Systems (DTS) surround sound formats used by DVDs.

It supports chapters, as well as Variable Frame Rate video.

It can include "soft" subtitles that can be turned on or off, instead of always being hard burned into the video frame. These can either be bitmap images of the subtitles included on a DVD (known as vobsub) or text.

it seems though that it can't produce srt

get command line version of course

    i=/media/
    s=1,2
    t=1

scans only to get info on all titles and tracks:

    HandBrakeCLI -t 0 -i "$i"

1000 Kbps MPEG-4 Visual video and 160 Kbps AAC-LC audio in an MP4 container:

    HandBrakeCLI -B 160 -e x264 -f mkv -i "$i" -m -o 1.mkv -q 22 -s "$s" -t "$t"

- f container format (mkv|mp4)
- m extract title markers
- e x264 : video encode format x264/ffmpeg4/ffmpeg2/theora.
- q 20 : CRF constant quality 0 .. 50. with x264: 22 for dvd, 22 for bluray.
- B 160 : sound kbps
- s 1,2,3 : subtitles to keep
- t 1: title 1. A DVD can contain many titles, which are usually independent films or tracks

In an MKV, you can store MPEG-4 video created by ffmpeg or x264, or Theora video.

- CRF ~2hrs film:
- CRF off = 1214 MB
- CRF 26 = 926 MB
- CRF 24 = 1205 MB
- CRF 22 = 1586 MB
- CRF 20 = 2141 MB
- CRF 16 = 4503 MB

my results:

    HandBrakeCLI -B 160 -e x264 -f mkv -i /media/DVDVolume -m -o ~/out.mkv -q 20 -s 1,2,3

- initial length: 2:16
- conversion time: 4 hours
- final size: 2Gb
- quality: same as original

    HandBrakeCLI -B 160 -e x264 -f mkv -i /media/DVDVolume -m -o ~/out.mkv -q 22 -s 1,2,3

- initial length: 2:16
- conversion time: 2:23
- final size: 2Gb
- quality: same as original

to get subtitles: must extract the image subtitles with some other tool and do OCR

# mkvtools

see info about a:

    mkvinfo 1.mkv

extracts tracks 3 and 4:

    t="3:ita 4:eng"
    mkvextract tracks 1.mkv $t

save 3 to eng.$ext or str, 3 to `chi.$ext`

where ext is the extension of the contained audio

we know those are subtitles from mkinfo

- 3:asdf means track 3, asdf is the output name

the type is that contained in the tracks, not necessarily srt,

maybe vobsub idx + sub if you want srt from vobsub, try vobsub2srt

# vobsub2srt

uses tesseract for the ocr: this means you must install tesseract lanugages

for chinese, must symlink

see tesseract for installing the languages

    vobsub2srt --langlist 1 #view available languages inside a.sub a.idx pair
    l=en
    f=
    vobsub2srt --lang "$l" "$f"

takes `eng.sub` and `eng.idx` and makes `eng.srt` with ocr

`en` or `0` were taken from `--langlist`

don't know what to do if two subs for the same language such as
    simplified and traditional chinese, both of which get zh
output goes to a.str.

don't forget to rename output as as a.eng.srt before going to the next language.

# srtmerge

merge two srt files

    suto pip install srtmerge

subtitles that happen at the same time are put one on top of the other

great for language learning if you have multisubs

    srtmerge a b ab

# guvcview

record video/audio with webcam
