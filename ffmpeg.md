# ffmpeg

CLI front-end for the FFmpeg library. Can do tons of conversions and streaming.

Tested on Ubuntu 15.10.

List codecs: <http://stackoverflow.com/questions/3377300/what-are-all-codecs-supported-by-ffmpeg>

    ffmpeg -codecs

## stdin and stdout operations

ffmpeg can detect file types from both file names and contents. But if you want to be explicit, remember the `man ffmpeg` signature:

    ffmpeg [global_options] {[input_file_options] -i input_file} ... {[output_file_options] output_file} ...

So the `-f` before `-i` is for the input format, and the `-f` after `-i` is the output.

Example: stream your desktop and play it:

    ffmpeg -video_size 640x480 -framerate 25 -f x11grab -i :0.0+100,200 -f h264 - | ffplay -f h264 -

## Extract raw streams

### VP9

Freedom!

    ffmpeg -framerate 4 -pattern_type glob -i '*.jpeg' -c:v vp9 out.webm

TODO: quality is bad.

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

## ffprobe

Get information about video and audio files:

    ffprobe a.webm

### Get frame count

- <http://stackoverflow.com/questions/2017843/fetch-frame-count-with-ffmpeg>
- <http://superuser.com/questions/84631/how-do-i-get-the-number-of-frames-in-a-video-on-the-linux-command-line>

Not easy because it is not stored on the video, it requires decoding.

### Get index of all key frames

<http://superuser.com/questions/885452/extracting-the-index-of-key-frames-from-a-video-using-ffmpeg>

    ffprobe -select_streams v \
        -show_frames \
        -show_entries frame=pict_type \
        -of csv \
        tmp.h264

generates something like:

    frame,I
    frame,B
    frame,P
    frame,B
    frame,P
    frame,B
    frame,P
    frame,B
    frame,P
    frame,B
    frame,I

where `I`, `B`, and `P` are defined at: <https://en.wikipedia.org/wiki/Video_compression_picture_types>

From there on, Bash it up.

## Images to video

- <http://superuser.com/questions/624567/ffmpeg-create-a-video-from-images>
- <http://askubuntu.com/questions/380199/converting-images-into-video>
- <http://stackoverflow.com/questions/16315192/avconv-make-a-video-from-a-subset-on-images>
- <https://trac.ffmpeg.org/wiki/Create%20a%20video%20slideshow%20from%20images>

Just works:

    ffmpeg -framerate 4 -pattern_type glob -i '*.jpg' -c:v libx264 out.mp4

### Smooth transitions

- <http://stackoverflow.com/questions/7565962/ffmpeg-fade-effects-between-frames>
- <http://superuser.com/questions/778762/crossfade-between-2-videos-using-ffmpeg>
- <http://superuser.com/questions/223678/how-to-convert-single-images-into-a-video-with-blending-transition>

## ffplay

Minimalistic video preview tool.

    ffplay video.mp4

No controls, no nothing, just a window with the video.

Exit when file is over: <http://ffmpeg-users.933282.n4.nabble.com/ffplay-does-not-exit-automatically-after-the-file-has-completed-playing-td2969254.html>

    ffplay -autoexit video.mp4

Loop infinitely:

    ffplay -loop -1 video.mp4

Raw audio file:

    ffplay -autoexit -f u16be -ar 44100 -ac 1 in.raw

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
