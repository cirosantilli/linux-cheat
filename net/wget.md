Download content form servers into local files.

Use this for recursive site download only, and the more advanced curl for other tasks.

- `-E` `--adjust-extension`

    Converts for example `*.php?key=val` pages to `.php?key=val.html`
    while keeping `*.css` extension untouched

- `--cut-dirs=2`: similar to -nd, but only does nd up to given level.

- `-k`: convert links to local if local has been downloaded.

- `-l` 5: `-r` depth

- `-l` inf.

- `-m`: mirror options. same as "-r -N -l inf --no-remove-listing".

- `-nd`: don't make sub directories, even if they existed on original site.

- `-np`: don't recurse into parent dirs.

- `-nH`: don't make a dir structure starting at host.

    Default: `wget http://www.abc.com/a/b/c`

    Creates: `www.abc.com/a/b/c` file structure.

    On the other hand:

        `wget -nH http://www.abc.com/a/b/c`

    Creates only: a/b/c

- `-p`: page requisites: CSS, images.

- `-r`: follow links on page and downloads them.

    default max depth of 5

- `-L`: follow relative links only

- `--user-agent="Mozilla/5.0` (X11; U; Linux i686; en-US; rv:1.9.0.3) Gecko/2008092416 Firefox/3.0.3"

- `-A`: accept patterns.

    If *, ? or [] appear on expression, matches basename only

    Else, suffix (.mp3 will work)

- `-R`: reject, opposite of A

- `-X`: exclude dir

- `-I`: include dir

- `-N`: timestamping. only down if newer than already downloaded

#combos

Make local version of site

    u=
    wget -E -k -l inf -np -p -r $u

Don't take pdfs, zips and rars:

    wget -R *.pdf -R *.zip -R *.rar -E -k -l inf -np -p -r $u

Only take, html, css, and images

    wget -A *.html -A *.css -A *.php -A *.gif -A *.png -A *.jpg -E -k -l inf -np -p -r $u

Get all files of a given types

    wget -r -np -nH -A.au,.mp3 $u
