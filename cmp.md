# cmp

GNU Diffutils package.

Compares F and G byte by byte, until first difference is found.

    cmp "$F" "$G"

If equal, print nothing.

Else, print location of first difference.

## s

Silent

Return status `0` if equal, `1` otherwise.

Prints nothing.

    cmp -s "$F" "$G"
    if [ $? -eq 1 ]; then
      echo neq
    else
      echo eq
    fi
