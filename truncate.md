# truncate

GNU Coreutils.

Sets file to given size.

If greater, pads with 0s.

If smaller, data loss.

Operates inline without mercy, only works on files.

    printf 'ab' > /tmp/a
    truncate -s 1 /tmp/a
    [ "$(cat f)" = 'a' ] || exit 1

Negative values truncate up to from the end:

    echo abc > f
    truncate -s -1 f
    [ `cat f` = ab ] || exit 1

*Must* have a space: `-s -1`, *not* `-s-1`.
