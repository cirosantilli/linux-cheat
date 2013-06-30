find files recursivelly

very powerful

posix 7, however breaks almost all of of posix and gnu command line interface standards! =):

- multichar options starting with single hyphen: `-iname` and without short version
- file list *before* options: `find . -iname .`

# general syntax

there are 3 parts to a find:

    find <search-roots> <criteria> <actions>

this is actually only a simplified version because of multiple actions that can be used with or `-o`,
but is a good model to start with

for example, to find all files named `sh` under either current dir or `/bin` and print their names to stdout do:

    find /bin . -type f -name 'sh' -print -delete

so in the example:

- `/bin .` are the search roots

- `-type f -name 'a.txt'` are the criteria

    - `-type f` says that we want only Files, not directories
    - `-name 'a.txt'` says that we want only files with basename `a.txt`

- `-print` is the action, it tells find what to do with the files found,
    in the case of print, it prints files found to stdout

both the criteria and the actions have default values:

- `criteria`: `-name '*'`, finding all files
- `action`: `-print`, is the default action

the search roots however have no default, and you must give at least one.

therefore, the minimal find command is:

    find .

which finds all files and directories under the current dir

# criteria

say *what* find should find

## name

match **entire** basenames posix RE:

    find . -name 'README'

finds files named **exactly** `README`. does *not* match `README.txt`

it is a posix RE:

    find . -name '*.mp?'

therefore the previous finds both `mp3` and `mp4` files (and `mp5` if that exists):

## iname

same as -name but case insensitive:

## path

looks at *entire* file path posix RE

find anything under current dir:

    find . - path './*'

relative paths *must* start with a dot slash './'

finds only paths are either hidden or have a hidden parent.

    find . -path '*/.*'

also consider [prune][] for this.

    find . -path './.vim/*'

finds anything under ./.vim folder. same as find ./vim

## type

    find . -type f

files only

    find . -type d

directories only

## prune

do not search into directories that match what comes before prune.

this is more efficient than using path to cut out directories.

do not the -o 'or' operator after each prune.

    find . -path '*/.*' -prune -o -type f -iname '*.txt'

finds files that end in '.txt'
does not go into directories whose -path '*/.*' is true (hidden dirs)
INCLUDES hidden directories and hidden files themselfves which are not inside hidden directories!!! check next example for the correct method to avoid hiden files

    find . '*/.*' -prune -o ! -name '.*'

finds all files that are neither hidden themselves, nor are a child of a hidden parent. =)

    find . '*/.*' -prune -o ! -name '.*'

prunes with multiple criteria

### depth

entries of the directory are acted upon before the directory

the default is first the directory

useful if you want to rename both the containing directory and the files inside it,
in which case you must first rename the files and later the directory

this nullifies `prune`

## gnu extensions

### mindepth

same as find but no `.`:

    find . -mindepth 1

[it seems that](http://stackoverflow.com/questions/13525004/how-to-exclude-this-current-dot-folder-from-find-type-d/17389439#17389439) the best way to do that in posix is currently:

    find . ! -path .

### maxdepth

find in current dir only:

    find . -maxdepth 1

find in current dir and direct children dirs

    find . -maxdepth 2

find in current and direct sons only

### samefile

    find . -samefile file1

find all content (HASH) duplicates of file1

    find . -xdev file1

do not go into other devices ( for instance, inode operations! )

you can concatenate multiple criteria logically.

### regex

find regexes

looks for *entire paths* instead of basenames

the match must be for the *entire* path, and not just any substring

relative paths *must* start with `./`

can specify regex type with `-regextype`. Default is **EMACS** regex!!! ...
(remember that this is a GNU extension and EMACS is the gnu pet editor)
but posix ere is also available

finds paths under `/home`, that end in .txt:

    find . -regex '^/home/.*\.txt$'

# multiple criteria

you can combine criteria with boolean operations to make your search finer

## and

`-a` all conditions must be satisfied

implicit when no criteria is specified

find paths which are pdf and which are files. the and is implicit

    find . -type f -iname '*.pdf'

same as above with explicit and:

    find . -type f -a -iname '*.pdf'

## not

find all paths which are not files:

    find . ! -type f

## or

paths with either pdf or djvu extension

    find . -iname '*.pdf' -o -iname '*.djvu'

or has higher precedence over and, therefore:

    find . -type f -iname '*.pdf' -o -iname '*.djvu'

which is the same as

    find . -type f -a -iname '*.pdf' -o -iname '*.djvu'

is also the same as:

    find . -type f -a \( -iname '*.pdf' -o -iname '*.djvu' \)

and finds pdf or djvu files only

but there is a big gotcha: if the first part of an `or` fails, the second is not executed,
including its action!

for example, you could print all pdf files, and delete all djvu files with:

    find . -type f -iname '*.pdf' -print -o -iname '*.djvu' -delete

and if you do:

    find . -type f -iname '*.pdf' -o -iname '*.djvu' -print

**only the djvu files will get printed**, and pdf files will have no associated action!

to explicitly print both, you must to:

    find . -type f \( -iname '*.pdf' -o -iname '*.djvu' \) -print

which is the same as the original:

    find . -type f -iname '*.pdf' -o -iname '*.djvu'

## parenthesis

you can change logical operation precedence with parenthesis.

do not forget to escape your parenthesis!

    find . \( -type f -iname '*.pdf' \) -o -iname '*.djvu'

either files with extension pdf of paths (includes dirs) with extension djvu. Parenthesis are used to change precendence order.

# actions

you can do things with the files you find. There are two main ways to do that: -exec and -print0 | xargs.

xargs tends to be more flexible

'{}' gets expanded to the found path by -exec, and the commands ends when a trailling '+' is found

ex: compile all tex under current dir:

    find . -iname '*.tex' -exec pdflatex '{}' +

does the same as above.

    find . -iname '*.tex' -print0 | xargs -0 -I '{}' pdflatex '{}'

- `-print0` prints files null (\0) terminated. this avoids problems since filenames that can contain newlines, but not null chars.
- `-0` tells xargs that the input is null separated
- `-I '{}'` tells xargs that {} should be substituted by each arg one at a time

    find . -iname '*.tex' -print0 | xargs -0 -I '{}' sh -c "bibtex '{}'; pdflatex '{}'"

execute multiple commands for each argument of xargs. must use sh -c, it is the only way without an explicit loop.
use this only for very simple multiple commands, or you are going to go crazy with quoting. for larger commands use an explicit loop as in next example.

NOTE: i don't know why exaclty, but the following fails:

    find . | xargs echo `basename {}`

this is probably because `basename {}` gets evaluated before {} is replaced by the find result
basename {} returns {}, and AFTER THAT {} gets expanded to the find result ( not just the basename therefore )
if you want to do stuff like that, a better solution is:

    find . -print0 | while read -d '' FILE;
        do echo "$FILE";
        echo asdf;
    done

this is a *much* more flexible way of doing lots of operations in bash I could find

# combos

remove all `Thubs.db` files (aka good bye Windows Media Player):

    find . -name 'Thumbs.db' -delete

find all files with one of the given extensions:

    find . -type f -iname '*.pdf' -o -iname '*.djvu'
