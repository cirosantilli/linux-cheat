# Codecs

## AAC

<https://en.wikipedia.org/wiki/Advanced_Audio_Coding>

Free to distribute, but not develop with.

## Vorbis

<https://en.wikipedia.org/wiki/Vorbis>

## Speex

<https://en.wikipedia.org/wiki/Speex>

Vorbis predecessor.

## MP3

<https://en.wikipedia.org/wiki/MP3>

MPEG-1 or MPEG-2 Audio Layer III.

## MP2

<https://en.wikipedia.org/wiki/MPEG-1_Audio_Layer_II>

More popular than MP3 for broadcasting. TODO why?

MPEG-1 Audio Layer II or MPEG-2 Audio Layer II.

Synthetic generation of pure tone + to PCM FFmpeg C API decode example: <https://github.com/FFmpeg/FFmpeg/blob/1ec7a703806049265991723a8826bd61555edef4/doc/examples/decoding_encoding.c>

## Raw formats

### Raw

No metadata, just bytes.

<https://en.wikipedia.org/wiki/Raw_audio_format>

This leaves the format unspecified: you should at least specify:

- sampling rate
- number of bits per byte
- endianess
- number of channels
- type of data (signed, unsigned, floating-point, mu-law, a-law, ...)

`ffplay` from FFmpeg and `play` from SoX can play it.

- <http://stackoverflow.com/questions/20314739/how-to-play-pcm-sound-file-in-ubuntu>
- <http://superuser.com/questions/76665/playing-a-pcm-file-on-a-unix-system>

### WAV

IBM, Windows. Widely Linux implemented.

<https://en.wikipedia.org/wiki/WAV>

Is a RIFF format <https://en.wikipedia.org/wiki/Resource_Interchange_File_Format>

Contains metadata, so unlike RAW it contains enough data for players to play it properly.

### PCM

TODO? vs raw?

<https://en.wikipedia.org/wiki/Pulse-code_modulation>

Decoded from MP2: <https://github.com/FFmpeg/FFmpeg/blob/1ec7a703806049265991723a8826bd61555edef4/doc/examples/decoding_encoding.c>

### AIFF

Apple, derived from IFF (Acorn).

<https://en.wikipedia.org/wiki/Audio_Interchange_File_Format>

## Theory

44100 Hz is a common sampling frequency: <https://en.wikipedia.org/wiki/44,100_Hz>

Humans hear between 20 and 20k Hz.

https://en.wikipedia.org/wiki/Nyquist–Shannon_sampling_theorem implies that at least 40k is needed on a perfect system.

## MIDI

TODO what is this?
