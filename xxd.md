# xxd

`od` alternative.

`vim-common` package, thus perfect to do from Vim:

    vim binary-file
    :%!xxd

Killer feature: reverse hexdump:

    printf 'ab' | xxd | xxd -r

Which allows you to do in Vim:

    %!xxd

You can then edit the output of `xxd`. When done, use:

    %!xxd -r
    w

And the binary file has been modified.

## p

Use a plain-text format:

    echo {a..z} | xxd -p
    6120622063206420652066206720682069206a206b206c206d206e206f20
    70207120722073207420752076207720782079207a0a

Other hexdump tools cal also do it with a custom format string, but `xxd` can also reverse it easily.

## Reverse hexdump format

The reverse is quite flexible: it deals with minor formatting issues (spaces, separators, base) intelligently.

Without `-p`, left-hand line numbers and right-hand ASCII representation are ignored: only byte pairs matter.

It is not possible to remove or add bytes without `-p`: <http://stackoverflow.com/questions/27086771/how-to-make-a-valid-input-for-xxd-r-in-vim> But note that many binary formats take literal offsets, so changing byte counts is much more likely to break them.
