# Video

## Base Concepts

### ripping

Taking the DVD from the DVD to files in computer.

### Transcoding

Transforming the DVD contents to another, generally smaller and single file, format such as `avi`.

Transcoding may be a time consuming process, since it means to do complete data format conversion usually on large files and as of 2013 takes times in the 1h - 4h range.

### Title

A DVD can contain one or many titles. Usually each title contains one entire continuous film sequence such as the main film or an extra such as an interview with the director.

### Subtitles

Subtitles are often stored in DVDs as images the format pair: idx + sub.

If you want srts, which is a text-only, smaller and human editable format on a text editor, first extract the VobSub pairs from the container (via mkvextract for example for mkv containers) and then use a tool such as `vobsub2srt` which will do OCR on the images.

### Multiplexing

TODO

## DVD regions

DVDs have regions: <http://en.wikipedia.org/wiki/DVD_region_code>

This serves only to control copyright.

DVD readers have a limited number of region changes, sometimes around 5.

For certain DVD readers, after this number of changes, *you cannot change it anymore*!

## Capture

### guvcview

View and record video audio from a webcam.

## Players

### VLC

Great cross platform video player

## Editors

All editors we have tried so far were buggy. Good luck!

### PiTiV

GNOME based.

Less buggy of the options we tried so far.

Latest release 0.93 is the first that leaves alpha and enters beta.

### OpenSHOT

Generally simple good. Downsides:

- video preview refreshes too slowly.
- corrupted ogv inputs on the combined output

### Cinelerra

Fails to open ogv.

Very non standard interface, four separate windows...

## Formats

### MPEG-1

<http://en.wikipedia.org/wiki/MPEG-1>

Lossy.

Audio and video standard family.

Extensions:

- `.mp3` for audio
- `.mpg` for audio / video

### H.264/MPEG-4 AVC

Lossy.

An important open source library implementation is the x264 library.

### Theora

Free lossy compression format: no patents by the <http://en.wikipedia.org/wiki/Xiph.Org_Foundation>

Often used with other patent free formats Vorbis and the Ogg container.

## Utilities and libraries

Many utilities are front-ends to libraries provided by a single project.

### libav

### ffmpeg

Large open source project to offer tools that deal with many, many video formats and containers.

Also the name of an utility to convert between formats, which has been renamed to `avconv` and deprecated the old name, presumably because it does much more than MPEG now, and is linked to `libav`.

### mkvtools

See info about a:

    mkvinfo 1.mkv

Extracts tracks 3 and 4:

    mkvextract tracks 1.mkv 3:ita 4:eng

Save 3 to `eng.$ext` or str, 3 to `chi.$ext`

Where ext is the extension of the contained audio

We know those are subtitles from `mkinfo`.

- `3:asdf` means track 3, `asdf` is the output name

The type is that contained in the tracks, not necessarily srt,

The output may be an VobSub idx + sub or srt depending on what is contained in the mkv. If you want srt from VobSub, try vobsub2srt.

### Ogg Video Tools

Tools for ogg manipulation.

Ubuntu package name: `oggvideotools`

Concatenate ogv containers:

    oggCat output.ogv a.ogv b.ogv

Broken on Ubuntu 12.04, claims to have been corrected on 12.10: <https://bugs.launchpad.net/ubuntu/+source/oggvideotools/+bug/944444>

### x264

Codec library for the `H.264/MPEG-4 AVC` format.

## Subtitle utilities

### vobsub2srt

Uses Tesseract for the OCR: this means you must install Tesseract languages.

Make sure that the `lang` name matches that of the Tesseract languages installed. For example, for Chinese, there was confusion between `zh` and `ch` and it may be necessary to do some corrective symlinking.

For a language to be recognized, you must have the Tesseract language installed.

List available languages inside `eng.sub` and `eng.idx` pair:

    vobsub2srt --langlist eng

TODO: a sub idx pair can contain multiple languages? Id contains metadata indicating the language?

Convert an `eng.sub` and `eng.idx` to `eng.srt`:

    vobsub2srt --lang en eng

`en` or `0` were taken from `--langlist`

Don't know what to do if two subs for the same language such as simplified and traditional Chinese, both of which get `zh` output goes to `a.str`.

Don't forget to rename output as as a.eng.srt before going to the next language.

### srtmerge

Merge two srt files.

Install via pip:

    suto pip install srtmerge

Subtitles that happen at the same time are put one on top of the other.

Great for language learning.

    srtmerge a b ab

## Get video information

<http://askubuntu.com/questions/249828/command-to-see-media-file-info-in-terminal>

http://stackoverflow.com/questions/3199489/meaning-of-ffmpeg-output-tbc-tbn-tbr

## Step frames

## Take screenshot of current frame

<http://askubuntu.com/questions/468457/how-can-i-scrub-through-a-video-for-saving-screengrabs-frame-by-framie>
