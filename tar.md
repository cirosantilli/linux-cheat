# tar

# tb2

# tgz

Name origin: `Tape ARchive`.

The tar *format* is specified by POSIX 7 together with the `pax` utility: <http://pubs.opengroup.org/onlinepubs/9699919799/utilities/pax.html#tag_20_92>

The `tar` is a GNU implementation, and is not specified by POSIX.

tar only turns a dir into file, but does no compression.

It is a popular option to transform directories in to files in Nix systems, as the format natively stores and preserves ext filesystem metadata such as:

- ownership
- permissions
- symlinks
- timestamps

Since tar offers no compression, it is often coupled with `gz` and `bz2`: those are files compressors.

tar end compressions are used so commonly together that shorthand extensions exist for them:

- `tgz` == `tar.gz`
- `txz` == `tar.xz`
- `tb2` == `tbz` == `tar.bz2`

General GNU interface:

- single char options don't start with hyphen
- every single letter option has a corresponding double hyphen multi char version

Create tar:

    tar vcf "$F".tar "$F"
    tar vczf "$F".tgz "$F"
    tar vcjf "$F".tbz "$F"
    tar vcJf "$F".txz "$F"

- `c`: create
- `f`: set output file to next argument. If not given, outputs to stdout.
- `z`: `gzip`
- `j`: `bzip2`
- `v`: verbose

If the output file exists, it is overwritten.

Create from tar with multiple files:

    tar vcf a.tar f1 f2

`r`: append file to existing tar, or create new tar:

    tar rcf a.tar f

Extract:

    tar vxf "$F".tar
    tar vxzf "$F".tgz
    tar vxjf "$F".tbz

## Keep hardlinks

Does not work if the file has any hard links, probably because that would not reduce memory usage as it breaks the hardlink. AKA: tries to be too smart and annoys us to hell!

Workaround: keep the original on the operations: <http://unix.stackexchange.com/questions/46786/how-to-tell-gzip-to-keep-original-file>

Workarounds: `-c` outputs to stdout:

    gzip -c a > a.gz

Read input from stdin:

    gzip < a > a.gz

And finally, `gzip` 1.6 (2013) has the `-k, --keep` option:

    gzip -k a
    gzip -kr .
