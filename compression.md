File compression formats and utilities.

The performance parameters are:

- compression ratio
- compression time
- can see and extracting single files
- support across OS
- ability to break into chunks
- keep file metadata such as permissions, hidden (windows), etc.

#ZIP

Most widely supported format.

Not so high compression rate.

Easy to view and extract single files.

Compresses dir file by file it seems.

ZIP file or directory:

    zip -r "$F".zip "$F"

`-r`: add dir recursively. Otherwise, adds only the top dir and not its contents.

Using it on a directory will keep the top directory in the ZIP. To avoid that and keep only the files in the directory, do:

    cd dir
    zip -r ../dir.zip .

If you don't have hidden files on the top level:

    zip -r dir.zip dir/*

Note that:

    zip -r dir.zip dir/.*

will not work by default for hidden files, since `.*` will also expand to `.` and `..` with default `bash` options.

`-e`: encrypt:

    zip -er "$F".zip "$F"

You can still see filenames, but not extract them!

List all files in zip file

    unzip -l "$F".zip

Extract files from zip:

    unzip "$F".zip

If has password, asks for it.

To a dir:

    unzip "$F".zip -d out

    for F in *; do echo "$F"; echo "$F".zip; zip "$F".zip "$F"; done

ZIP every file in cur dir to file.zip

#tb2

#tgz

#tar

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

#zlib

#gzip

#gunzip

#gz

Extension: `gz`.

Library name: zlib, GNU.

Popular wrapper: `gzip`, and `gunzip` to unzip.

Vs zip:

-   Completely different file types.

-   Both use the DEFLATE algorithm: <https://en.wikipedia.org/wiki/DEFLATE>, and therefore have very similar compression ratios and speeds.

-   The zlib library does not focus on directories: only single files. For this reason it is commonly used together with `tar` which only packs directories into a file. For convenience however, the command line executable can deal with `.tgz` files.

-   gzip seems to have very one dominant implementation: GNU zlib, so that gzip can refer to either the utility or format used by that utility.

    zip has many implementations: WinRAR, WinZip on closed source on Windows, Info-ZIP and libzip open source, Info-ZIP being the default one present on Ubuntu 12.04. Therefore the term zip usually only refers to the file format.

If a file is only `.gz` but not `.tgz` you cannot use tar to extract it.

Create `a.txt.gz` and `rm` `a.txt`:

    gzip a.txt

Extract `a.gz` and erase it if successful:

    gunzip a.gz

`.gz` all files under given directory recursively individually. Remove each original:

    gzip -r .

##gz file format

IETF standardized format: <https://www.ietf.org/rfc/rfc1952.txt>

##Hardlinks

##Keep original

Does not work if the file has any hard links, probably because that would not reduce memory usage as it breaks the hardlink. AKA: tries to be too smart and annoys us to hell!

Workaround: keep the original on the operations: <http://unix.stackexchange.com/questions/46786/how-to-tell-gzip-to-keep-original-file>

Workarounds: `-c` outputs to stdout:

    gzip -c a > a.gz

Read input from stdin:

    gzip < a > a.gz

And finally, `gzip` 1.6 (2013) has the `-k, --keep` option:

    gzip -k a
    gzip -kr .

#RAR

Proprietary `Roshal ARchive`, after it's creator Eugene Roshal.

Can do split archive.

Split archive extensions match the following Perl regexes:

- `.part\d+\.rar`
- `.r\d+`

Extract contents of `a.rar` to `./`

    unrar x a.rar

Before / after:

    a.rar
    /dir1/
    /dir1/f1
    /dir1/f2

    ===============

    a.rar
    dir1/f1
    dir1/f2

Out to `./out/` directory, creates this directory if necessary:

    unrar x a.rar out

Extract multipart RAR:

    unrar x a.r00
    unrar x a.part1.rar

Recursively find all files in `a.rar`, and outputs them to current dir with old basename possible name conflicts:

    unrar e a.rar

Sample output:

    a.rar
    /dir1/
    /dir1/f1
    /dir1/f2

    ===============

    a.rar
    f1
    f2

##Create RAR

`a` for add:

    rar a dir.rar dir

#7zip

Microsoft proprietary program.

Can do lots of formats:

- 7z format
- RAR with `p7zip-rar` installed
- zip

But *use only for 7z*, which it was made for.

With 7zip, you can open `.exe` files to extract their inner data.

#File roller

Very good GUI app to view inside multiple archive formats and extract them.
