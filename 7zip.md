# 7zip

Can do lots of formats:

- 7z format
- RAR with `p7zip-rar` installed
- zip

But *use only for 7z*, which it was made for.

With 7zip, you can open `.exe` files to extract their inner data.

## ISO extract

`7z` looks like the best option besides mounting a loop back device: <http://unix.stackexchange.com/questions/70738/what-is-the-fastest-way-to-extract-an-iso>

    7z -x a.iso
