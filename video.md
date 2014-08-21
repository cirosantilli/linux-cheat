#Base Concepts

##ripping

Taking the DVD from the DVD to files in computer.

##Transcoding

Transforming the DVD contents to another, generally smaller and single file, format such as `avi`.

Transcoding may be a time consuming process, since it means to do complete data format conversion usually on large files and as of 2013 takes times in the 1h - 4h range.

##Title

A DVD can contain one or many titles. Usually each title contains one entire continuous film sequence such as the main film or an extra such as an interview with the director.

##Codec

A program capable of `COmpressing and DECompressing` certain formats.

The term is often used in phrases as: "Do you have the codec for XXX to watch" in which it means, do you have the program that does the decoding?

##Subtitles

Subtitles are often stored in DVDs as images the format pair: idx + sub.

If you want srts, which is a text-only, smaller and human editable format on a text editor, first extract the VobSub pairs from the container (via mkvextract for example for mkv containers) and then use a tool such as `vobsub2srt` which will do OCR on the images.

##Multiplexing

TODO

#Containers

Are file types that wrap video, audio and subtitles in a single files.

Popular container formats include:

##mkv

Open standard.

##ogv

##ogg

Open standard by <Xiph.Org>.

Before 2007, used for audio only or audio video.

Since 2007, <Xiph.Org> recommends using it only for audio only Vorbis, and using ogv for video.

##mpg

One of the extensions for MPEG-1 video.

It is possible to concatenate `mpg` files directly via `cat` to get a larger one.

##MPEG-4 Part 14

##mp4

More linked to Apple.

##avi

Created by Microsoft.

#DVD regions

DVDs have regions: <http://en.wikipedia.org/wiki/DVD_region_code>

This serves only to control copyright.

DVD readers have a limited number of region changes, sometimes around 5.

For certain DVD readers, after this number of changes, *you cannot change it anymore*!

#Capture

##guvcview

View and record video audio from a webcam.

#Players

##VLC

Great cross platform video player

#Editors

All editors we have tried so far were buggy. Good luck!

##PiTiV

GNOME based.

Less buggy of the options we tried so far.

Latest release 0.93 is the first that leaves alpha and enters beta.

##OpenSHOT

Generally simple good. Downsides:

- video preview refreshes too slowly.
- corrupted ogv inputs on the combined output

##Cinelerra

Fails to open ogv.

Very non standard interface, four separate windows...

#Formats

##MPEG-1

<http://en.wikipedia.org/wiki/MPEG-1>

Lossy.

Audio and video standard family.

Extensions:

- `.mp3` for audio
- `.mpg` for audio / video

##H.264/MPEG-4 AVC

Lossy.

An important open source library implementation is the x264 library.

##Theora

Free lossy compression format: no patents by the <http://en.wikipedia.org/wiki/Xiph.Org_Foundation>

Often used with other patent free formats Vorbis and the Ogg container.

#Utilities and libraries

Many utilities are front-ends to libraries provided by a single project.

##libav

##ffmpeg

Large open source project to offer tools that deal with many, many video formats and containers.

Also the name of an utility to convert between formats,
which has been renamed to `avconv` and deprecated the old name,
presumably because it does much more than mpeg now, and is linked to `libav`.

###avconv utility

In Ubuntu, the `ffmpeg` and `avconv` utilities are contained in the `libav-tools` package.

Includes a version of the library `libav`.

Convert `ogg` into `mpg`:

    avconv -i input.ogv -f 24 output.mpg

You must specify frame rate, as the following fails because MPEG does not support the default 15fps:

    avconv -i input.ogv output.mpg

##mkvtools

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

##Ogg Video Tools

Tools for ogg manipulation.

Ubuntu package name: `oggvideotools`

Concatenate ogv containers:

    oggCat output.ogv a.ogv b.ogv

Broken on Ubuntu 12.04, claims to have been corrected on 12.10: <https://bugs.launchpad.net/ubuntu/+source/oggvideotools/+bug/944444>

##x264

Codec library for the `H.264/MPEG-4 AVC` format.

#Rip utilities

##HandBrake

Open source transcoder.

Comes both in GUI and CLI versions.

Supported containers: mkv, mpeg4.

First check this for some good info: <http://msdn.microsoft.com/en-us/library/windows/desktop/dd388582%28v=vs.85%29.aspx>

It stores audio in the AAC, MP3, or Vorbis formats. It can also pass through the Dolby Digital 5.1 (AC3) and Digital Theater Systems (DTS) surround sound formats used by DVDs.

It supports chapters, as well as Variable Frame Rate video.

It can include "soft" subtitles that can be turned on or off,
instead of always being hard burned into the video frame.
These can either be bitmap images of the subtitles included on a DVD (known as vobsub) or text.

It seems that it can't produce srt.

The following parameters usually vary between invocations:

    i=/media/
    s=1,2
    a=1
    t=1

Scan only and output info on titles and tracks:

    HandBrakeCLI -t 0 -i "$i"

Useful to decide which title, audio and subtitle tracks are to be extracted.

Recommended usage: 1000 kbps MPEG-4 Visual video and 160 kbps AAC-LC audio in an mkv container:

    HandBrakeCLI -B 160 -a "$a" -e x264 -f mkv -i "$i" -m -o 1.mkv -q 22 -s "$s" -t "$t"

- `B 160`:   sound bit rate in kbps
- `a 1,2,3`: Audio tracks to keep. Default: first only.
- `e x264`:  video Encode format x264/ffmpeg4/ffmpeg2/theora.
- `f fmt`:   container Format. Currently can only be `mkv` or `mp4`.
- `m`:       extract title markers.
- `q 22`:    CRF constant quality in the [0 .. 50] interval. With x264 a recommended value is 22, which takes around 1h for 2h film producing an output file of 2GB with almost imperceptible quality loss.
- `s 1,2,3`: subtitle tracks to keep in the container. Default: none.
- `t <title>`: title to encode. Can only encode one title per container.

In an `.mkv`, you can store MPEG-4 video created by ffmpeg, x264, or Theora video.

- CRF ~2hrs film:
- CRF off = 1214 MB
- CRF 26 = 926 MB
- CRF 24 = 1205 MB
- CRF 22 = 1586 MB
- CRF 20 = 2141 MB
- CRF 16 = 4503 MB

#Subtitle utilities

##vobsub2srt

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

##srtmerge

Merge two srt files.

Install via pip:

    suto pip install srtmerge

Subtitles that happen at the same time are put one on top of the other.

Great for language learning.

    srtmerge a b ab
