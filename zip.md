# ZIP

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

## Implementations

### Snappy

### Zippy

Zippy is the old name.

Google, open sourced in 2011.

Design goal: very high compression speed, at the cost of slightly lower compression ratios, usually around 20% to 100% lower.
