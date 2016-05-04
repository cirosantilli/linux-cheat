# Video codecs

A program capable of `COmpressing and DECompressing` certain formats.

The term is often used in phrases as: "Do you have the codec for XXX to watch" in which it means, do you have the program that does the decoding?

## Trivia

<https://en.wikipedia.org/wiki/Comparison_of_video_container_formats>

### History

<http://stevencrowley.com/2012/08/14/new-video-compression-standard-doubles-efficiency/>

CPU power also limits compression: a super encoded file is useless if CPUs / GPUs aren't fast enough to decode in real time.

## H.264

## MPEG-4 Part 10

Not free, dominates in 2015.

<https://en.wikipedia.org/wiki/H.264/MPEG-4_AVC#Patent_licensing>

One of the major implementations: <http://www.videolan.org/developers/x264.html>

Many profiles, which are parameters that determine how encoding / decoding is to be done exactly: <https://en.wikipedia.org/wiki/H.264/MPEG-4_AVC#Profiles> Algorithm changes widely between profiles.

MPEG LA patent pool.

### Network Abstraction Layer

### NAL Units

<https://en.wikipedia.org/wiki/Network_Abstraction_Layer>

<http://stackoverflow.com/questions/6858991/in-h264-nal-units-means-frame>

So it seems H.264 also specifies the stream format. Must it be followed, or can we just send chunks of any size?

Some libraries must be fed such variable sized pages to work (Android 5 `MediaCodec`), while others can just take fixed sized chunks and deal with it (FFmpeg `doc/examples/decoding_encoding.c`).

## H.265

## HEVC

Non-free proposed successor to H.264.

<https://en.wikipedia.org/wiki/High_Efficiency_Video_Coding>

MPEG LA patent pool.

## VP8

## VP9

Free, by Google, for the web.

Implemented by `libvpx`.

## Daala

Free by Xiph and Mozilla.

<https://xiph.org/daala/>

## Thor

<https://en.wikipedia.org/wiki/Thor_%28video_codec%29>

Free, by Cisco.

## M-JPEG

Video version of JPEG.

<https://en.wikipedia.org/wiki/Motion_JPEG>

## MPEG-1

<https://en.wikipedia.org/wiki/MPEG-1>

Looks like a codec, for both audio and video, which is often encapsulated into <https://en.wikipedia.org/wiki/MPEG-4_Part_14> with extension `.mpg` or `.mp4`.

Extended from: JPEG, H.261

Extended to: MPEG-2.

## MPEG-2

<https://en.wikipedia.org/wiki/MPEG-2>

H.222/H.262. TODO: why two names?

Extended from: MPEG-1.

Inferior to H.264.

## Codec agnostic concepts

<https://en.wikipedia.org/wiki/Video_compression_picture_types>

- Intra-coded: key-frame.
- Predicted: uses previous. Some algorithms may use even more than 1 previous frame.
- Bi-predictive: uses previous and next
