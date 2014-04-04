Transforms binary data which may contain non printable bytes like ASCII 0 into data that contain only printable bytes non space chars.

This makes it easier for humans to view and input the data.

Downside: data gets larger.

To understand see Wikipedia: <http://en.wikipedia.org/wiki/base64#examples>

`-d` to decode:

    assert [ "`echo abc | base64 | base64 -d`" = abc ]

# Why 64?

There are at least 64 printable chars, but not 128.

# Why not use hexadecimal?

Even simpler for humans, but data gets much larger Ks the base is smaller.
