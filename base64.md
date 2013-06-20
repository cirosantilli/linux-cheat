`-d` to decode:

    assert [ "`echo abc | base64 | base64 -d`" = abc ]

to understand see wiki: <http://en.wikipedia.org/wiki/Base64#Examples>

# application

transforms binary data which may contain non printable bytes like 0
into data that contain only printed bytes.

this makes it easier for humans input the data

tradeoff: data gets larger

## why 64?

there are 64 printable chars, but not 128.

possible alternative: use base 16. Much easier for humans, but data would get much larger.
