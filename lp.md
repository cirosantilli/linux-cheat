# lp

`cups-client` package.

## Basic usage

Print a file:

    lp a.txt

TODO what are the accepted formats? `txt`, `pdf` and raw stdin input work.

Also consider `lpr` from `cups-bsd`.

## P

Page ranges to print:

    lp -P 1,3-5 a.pdf

## o

Set printing options.

There are standard options for every printer described under `man lp`, and possibly custom ones given by `lpoptions -l`.

Default values can be set with `lpoptions`.

Example:

    lp -o landscape -o scaling=75 -o media=A4 a.pdf

For custom options:

    lpoptions -l:

Sample output:

    PageSize/Paper Size: 4X6FULL T4X6FULL 2L T2L *A4 TA4 L TL Postcard TPostcard INDEX5
    MediaType/Media Type: PMPHOTO_NORMAL PLATINA_NORMAL GLOSSYPHOTO_NORMAL GLOSSYCAST_NORMAL PMMATT_NORMAL *PLAIN_NORMAL RCPC_NORMAL
    Ink/Ink: *COLOR MONO

Then:

    lp -o landscape -o Ink=MONO a.pdf
