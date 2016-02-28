# ffmpeg

CLI front-end for the FFmpeg library. Can do tons of conversions and streaming.

Tested on Ubuntu 15.10.

List codecs: <http://stackoverflow.com/questions/3377300/what-are-all-codecs-supported-by-ffmpeg>

    ffmpeg -codecs

## Extract raw streams

### H264

- <http://stackoverflow.com/questions/10380045/is-there-any-easy-way-to-extract-h-264-raw-stream-in-annexb-format>
- <http://stackoverflow.com/questions/19300350/extracting-h264-raw-video-stream-from-mp4-or-flv-with-ffmpeg-generate-an-invalid>

Works:

    ffmpeg -i in.mp4 -vcodec copy -bsf h264_mp4toannexb -an -f h264 out.h264

VLC cannot open that output file, but `ffplay` can. TODO: is the `-bsf` really needed?

    ffmpeg -i in.mts -vcodec copy -an -f h264 out.h264

### AAC

<http://superuser.com/questions/186465/extract-audio-aac-from-mp4>

    ffmpeg -i in.mp4 -c copy -map 0:a:0 out.aac

## Webcam

<https://trac.ffmpeg.org/wiki/Capture/Webcam>

First install `v4l2`, then:

    ffmpeg -f v4l2 -framerate 25 -video_size 640x480 -i /dev/video0 -f v8 output.mkv

## ffplay

Minimalistic video preview tool.

    ffplay video.mp4

No controls, no nothing, just a window with the video.

Loop infinitely:

    ffplay -loop -1 video.mp4

## Stream

<https://trac.ffmpeg.org/wiki/StreamingGuide>

## ffserver

<https://trac.ffmpeg.org/wiki/ffserver>

TODO: what is the IO format: RTMP of HTTP? How is video sent over HTTP?

Note: this project seems very unmaintained, and there are better ones out there.

Server configuration file:

    /etc/ffserver.conf

Use a custom one and show server debug:

    ffserver -d -f ~/ffserver.conf

Start server:

    ffserver

Send video to it. Must edit the `VideoFrameRate` to something larger than 3... <https://lists.ffmpeg.org/pipermail/ffmpeg-user/2016-January/030111.html>:

    ffmpeg -f v4l2 -s 320x240 -r 25 -i /dev/video0 -f alsa -ac 2 -i hw:1 http://localhost:8090/feed1.ffm

Watch it. Must edit ACL inside `feed` <http://stackoverflow.com/a/13977181/895245> or else access denied:

    ffplay http://localhost:8090/test1.mpg

TODO: video has a huge delay from starting up to playing, see: <https://trac.ffmpeg.org/wiki/StreamingGuide#Latency>

A few URLs that can be accessed from the browser:

- <http://localhost:8090/stat.html>: show server status
- <http://localhost:8090/>: redirect to what is fixed at `<Redirect index.html>` of the config file
- <http://localhost:8090/test1.mpg>: TODO what happens? Firefox sees a video file type, and redirects to a video app, then when I kill the server the video player plays all that has happened as if from a file.

## udp protocol

An FFmpeg invention it seems: <http://stackoverflow.com/questions/27930879/what-is-ffmpegs-udp-protocol>
