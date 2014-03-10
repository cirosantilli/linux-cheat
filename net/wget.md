Retrieve content from networks via several protocols.

Not POSIX, and there is no POSIX 7 alternative: <http://stackoverflow.com/questions/9490872/is-wget-or-similar-programs-always-available-on-posix-systems>

Use this for recursive site download only, and the more advanced curl for other tasks.

- `-O` output filename for the fetched data only.

    `-` for stdout.

    Defaults to the last path component, e.g.: `http://a.com/b.html` generates `b.html`.

- `-o` log filename.

    Defaults to stderr.

    Common usage to 

- `-E` `--adjust-extension`

    Converts for example `*.php?key=val` pages to `.php?key=val.html` while keeping `*.css` extension untouched

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

    Default: `5`

- `-L`: follow relative links only

- `--user-agent="Mozilla/5.0` (X11; U; Linux i686; en-US; rv:1.9.0.3) Gecko/2008092416 Firefox/3.0.3"

- `-A`: accept patterns.

    If *, ? or [] appear on expression, matches basename only

    Else, suffix (.mp3 will work)

- `-R`: reject, opposite of A

- `-X`: exclude dir

- `-I`: include dir

- `-N`: timestamping. Only down if newer than already downloaded.

#combos

Setup:

    u=""

Make local version of site

    wget -E -k -l inf -np -p -r "$u"

Run remote script:

    wget -o /dev/null -O "$u" | bash

Don't take PDFs, zips and RARs:

    wget -R *.pdf -R *.zip -R *.rar -E -k -l inf -np -p -r "$u"

Only take, html, css, and images

    wget -A *.html -A *.css -A *.php -A *.gif -A *.png -A *.jpg -E -k -l inf -np -p -r "$u"

Get all files of a given types

    wget -r -np -nH -A.au,.mp3 "$u"

