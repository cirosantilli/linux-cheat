# readlink

Coreutils.

Get target of symlink.

Not POSIX, even though POSIX defines a C function with that name.

    touch a
    ln -s a b
    ln -s b c

    [ "$(readlink c)" = 'b' ] || exit 1
    [ "$(readlink b)" = 'a' ] || exit 1

Recursive:

    [ "$(readlink -f c)" = 'a' ] || exit 1
