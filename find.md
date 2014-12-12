# find

Find files recursively under given directories.

Very powerful.

POSIX 7, however breaks almost all of of POSIX and GNU command line interface standards:

- multi character options starting with single hyphen: `-iname` and without short version
- file list *before* options: `find . -iname .`

Consider `locate` if you are going to look in the entire file system.

## General syntax

There are 3 parts to a find:

    find <search-roots> <criteria> <actions>

This is actually only a simplified version because of multiple actions that can be used with or `-o`, but is a good model to start with

For example, to find all files named `sh` under either current dir or `/bin` and print their names to stdout do:

    find /bin . -type f -name 'sh' -print -delete

So in the example:

- `/bin .` are the search roots

- `-type f -name 'a.txt'` are the criteria

    - `-type f` says that we want only Files, not directories
    - `-name 'a.txt'` says that we want only files with basename `a.txt`

- `-print` is the action, it tells find what to do with the files found, in the case of print, it prints files found to stdout

Both the criteria and the actions have default values:

- `criteria`: `-name '*'`, finding all files
- `action`: `-print`, is the default action

The search roots however have no default, and you must give at least one.

Therefore, the minimal find command is:

    find .

which finds all files and directories under the current dir

## Criteria

Say *what* find should find

### name

Match **entire** basenames POSIX RE:

    find . -name 'README'

Finds files named **exactly** `README`. does *not* match `README.txt`

It is a POSIX BRE:

    find . -name '*.mp?'

Therefore the previous finds both `mp3` and `mp4` files (and `mp5` if that exists):

### iname

Same as -name but case insensitive:

### path

Looks at *entire* file path filtering by POSIX BRE.

Find anything under current directory:

    find . - path './*'

Relative paths *must* start with a dot slash `./`.

Finds only paths are either hidden or have a hidden parent.

    find . -path '*/.*'

Also consider [prune][] for this.

Finds anything under `./.vim` folder. Same as `find ./vim`:

    find . -path './.vim/*'

### type

Files only:

    find . -type f

Directories only:

    find . -type d

### perm

Find by permissions.

Exact match:

    find . -perm 444
    find . -perm u+4,g+4,o+4

Finds only files that have permission exactly `444`.

Either match:

    find . -perm +111

Finds files that are readable by either u, g or o.

Applications:

Give `g+x` to all files that have `u+x`:

    find . -type f -perm +100 | xargs chmod g+x

### prune

Do not search into directories that match what comes before prune.

This is more efficient than using path to cut out directories.

Do not forget the `-o` operator after each prune.

Find all files that are neither hidden themselves, nor children of a hidden parent:

    find . -path '*/.*' -prune -o ! -name '.' -print

### depth

Entries of the directory are acted upon before the directory.

The default is first the directory.

Useful if you want to rename both the containing directory and the files inside it, in which case you must first rename the files and later the directory.

This nullifies `prune`.

### xdev

Do not go into other devices:

    find . -xdev file1

## multiple criteria

You can combine criteria with boolean operations to make your search finer.

### and

`-a` all conditions must be satisfied.

Implicit when no criteria is specified.

Find paths which are PDF and which are files:

    find . -type f -iname '*.pdf'

Same as above with explicit and:

    find . -type f -a -iname '*.pdf'

### not

Find all paths which are not files:

    find . ! -type f

### or

Paths with either PDF or DjVu extension:

    find . -iname '*.pdf' -o -iname '*.djvu'

or has higher precedence over and, therefore:

    find . -type f -iname '*.pdf' -o -iname '*.djvu'

which is the same as:

    find . -type f -a -iname '*.pdf' -o -iname '*.djvu'

is also the same as:

    find . -type f -a \( -iname '*.pdf' -o -iname '*.djvu' \)

and finds PDF or DjVu files only.

But there is a big gotcha: if the first part of an `or` fails, the second is not executed,
including its action!

For example, you could print all PDF files, and delete all djvu files with:

    find . -type f -iname '*.pdf' -print -o -iname '*.djvu' -delete

and if you do:

    find . -type f -iname '*.pdf' -o -iname '*.djvu' -print

**only the djvu files will get printed**, and pdf files will have no associated action!

To explicitly print both, you must to:

    find . -type f \( -iname '*.pdf' -o -iname '*.djvu' \) -print

Which is the same as the original:

    find . -type f -iname '*.pdf' -o -iname '*.djvu'

### Parenthesis

You can change logical operation precedence with parenthesis.

Do not forget to escape your parenthesis!

    find . \( -type f -iname '*.pdf' \) -o -iname '*.djvu'

Either files with extension pdf of paths (includes dirs) with extension djvu. Parenthesis are used to change precendence order.

## Actions

You can do things with the files you find.

### print

The default action is to print found files to stdout.

Find also offers a few other actions

Remove the trailing `./`: <stackoverflow.com/questions/2596462/how-to-strip-leading-in-unix-find>

As of POSIX 7, no clear way to do it.

Best GNU option:

    find -type f -printf '%P\n'

Best POSIX 7 option:

    find . | sed "s|^\./||"

### delete

Deletes matching files.

    find . -iname '*.tmp' -delete

### exec

Executes shell command on each found file.

`'{}'` gets expanded to the found path by `-exec`, and the commands ends when a trailing '+' is found.

Ex: compile all TeX files under current dir:

    find . -iname '*.tex' -exec pdflatex '{}' +

Same with xargs:

    find . -iname '*.tex' -print0 | xargs -0 -I '{}' pdflatex '{}'

Same with a read while loop:

    find . -print0 | while read -d '' FILE; do
        pdflatex "$FILE";
    done

Consider using a read while loop if you are going to do more than on command.

TODO understand better `{}` + vs `;` ending.

TODO: why does the following fail:

    find . | xargs echo `basename {}`

This is probably because `basename {}` gets evaluated before `{}` is replaced by the find result basename `{}` returns `{}`, and AFTER THAT `{}` gets expanded to the find result ( not just the basename therefore )

## Combos

Remove all `Thubs.db` files (aka good bye Windows Media Player):

    find . -name 'Thumbs.db' -delete

Find all files with one of the given extensions:

    find . -type f -iname '*.pdf' -o -iname '*.djvu'

Remove all empty directories under given dir POSIX compliant:

    find . -depth -type d -exec rmdir {} \; 2>/dev/null

With GNU you get the better:

    find . -depth -empty -type d -exec rmdir {} \; 2>/dev/null

which avoids calling `rmdir` on non empty directories.

### Multiple actions

If you want to take multiple actions, the sanest way is to use the POSIX:

    find . | while read FILE; do
      echo "$FILE"
      echo
    done

Or the newline immune GNU:

    find . -print0 | while read -d '' FILE; do
      echo "$FILE"
      echo
    done

## GNU extensions

### Criteria GNU extensions

#### mindepth

Same as find but no `.`:

    find . -mindepth 1

[it seems that](http://stackoverflow.com/questions/13525004/how-to-exclude-this-current-dot-folder-from-find-type-d/17389439#17389439) the best way to do that in POSIX is currently:

    find . ! -path .

#### maxdepth

find in current dir only:

    find . -maxdepth 1

find in current dir and direct children dirs

    find . -maxdepth 2

find in current and direct sons only

#### samefile

Find all content duplicates of `file1`:

    find . -samefile file1

Usese hash comparison.

#### regex

Find regexes.

Looks for *entire paths* instead of basenames.

The match must be for the *entire* path, and not just any substring.

Relative paths *must* start with `./`.

Can specify regex type with `-regextype`. Default is **EMACS** regex!!! ... (remember that this is a GNU extension and EMACS is the gnu pet editor) but POSIX ere is also available.

Finds paths under `/home`, that end in .txt:

    find . -regex '^/home/.*\.txt$'

#### iregex

Regex case insensitive.

#### empty

Find empty files and directories:

    find . -empty

### GNU extensions actions

#### print0

Prints outputs ended in null character instead of newline.

Allows files to contain newlines.

Begs for a combo with `xargs -0`.

Example:

    find . -iname '*.tex' -print0 | xargs -0 -I '{}' sh -c "bibtex '{}'; pdflatex '{}'"

- `-print0` prints files null (\0) terminated. this avoids problems since filenames that can contain newlines, but not null chars.
- `-0` tells xargs that the input is null separated
- `-I '{}'` tells xargs that `{}` should be substituted by each arg one at a time

POSIX 7 mentions that this is included in several implementations, but was not adopted since it requires every utility that takes it as input to add a new `-0` option.

GNU utils which support NUL termination:

    sort -z

#### printf

Print formated data about files found. Format:

- `%p`: filename, including name(s) of directory the file is in
- `%m`: permissions of file, displayed in octal.
- `%f`: displays the filename, no directory names are included
- `%g`: name of the group the file belongs to.
- `%h`: display name of directory file is in, filename isn't included.
- `%u`: username of the owner of the file

Example:

    find . -printf '%f'
