# tac

`cat` reversed line-wise.

Coreutils.

    [ "$(printf "a\nb\n" | tac)" = "$(printf "b\na")" ] || exit 1

Things get messy if the input does not end in newline:

    [ "$(printf "a\nb" | tac)" = "$(printf "ba")" ] || exit 1
