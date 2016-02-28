# HandBrake

Open source transcoder.

Comes both in GUI and CLI versions.

Supported containers: mkv, mpeg4.

First check this for some good info: <http://msdn.microsoft.com/en-us/library/windows/desktop/dd388582%28v=vs.85%29.aspx>

It stores audio in the AAC, MP3, or Vorbis formats. It can also pass through the Dolby Digital 5.1 (AC3) and Digital Theater Systems (DTS) surround sound formats used by DVDs.

It supports chapters, as well as Variable Frame Rate video.

It can include "soft" subtitles that can be turned on or off, instead of always being hard burned into the video frame. These can either be bitmap images of the subtitles included on a DVD (known as vobsub) or text.

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

- `B 160`: sound bit rate in kbps
- `a 1,2,3`: Audio tracks to keep. Default: first only.
- `e x264`: video Encode format x264/ffmpeg4/ffmpeg2/theora.
- `f fmt`: container Format. Currently can only be `mkv` or `mp4`.
- `m`: extract title markers.
- `q 22`: CRF constant quality in the [0 .. 50] interval. With x264 a recommended value is 22, which takes around 1h for 2h film producing an output file of 2GB with almost imperceptible quality loss.
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
