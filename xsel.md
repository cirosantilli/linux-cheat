# xsel

Manipulate the x selection and clipboard

Set the x selection:

    echo a | xsel

Get the x selection

    assert [ `xsel` = a ]

    echo a | xsel
    echo b | xsel -a
    assert [ "`xsel`" = $'a\nb\n' ]

## x clipboard

Set and get the clipboard (control c control v access):

    echo a | xsel -b
    assert [ `xsel -b` = a ]

## follow

Follows standard input as it grows

    echo a > f
    xsel -f < f
    assert [ "`xsel`" = $'a\n' ]
    echo b >> f
    assert [ "`xsel`" = $'a\nb\n' ]

## stop

    echo a | xsel
    echo c > f
    assert [ "`xsel`" = $'a\n' ]
