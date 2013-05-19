find files recursivelly

very powerful

posix 7, however breaks almost all of of posix and gnu command line interface standards! =):

- multichar options starting with single hyphen: `-iname` and without short version
- file list *before* options: `find . -iname .`

there are 3 parts to a find:

    find <where> <what> <do-what-with-finds>

find all files under current dir:

    find . -name '*' -print

same as above:

    find .

therefore:

- default match criteria is to match anything (*)
- default action is to print

find in given dirs:

    mkdir d d2
    touch d/a d/b d2/a d2/a
    find d d2

note how output also includes the dirs `d` and `d2`!

# search criteria

## name and iname

match ENTIRE basenames posix expression:

    find . -name 'README'

finds files named **EXACTLY** `README`. does *not* match `README.txt`

finds ENRTIRE basenames that match posix regex (not extended):

    find . -name '*.txt'

same as -name but case insensitive:

    find . -iname '*.mp?'

## path

looks at entire  file path posix regular expression:

find anything under current dir:

    find . - path './*'

Note how relative paths all start with a dot slash './'

finds only paths are either hidden or have a hidden parent.

    find . -path '*/.*'

also consider [prune][] for this.

    find . -path './.vim/*'

finds anything under ./.vim folder. same as find ./vim

## regex

find regexes

can specify regex type with `-regextype`. Default is EMACS regex!!! ...
but posix ere is also available

    find . -regex '^/home/.*\.txt$'

finds paths under /home, that end in .txt

## type

    find . -type f

files only

    find . -type d

directories only

## mindepth

same as find but no `.`:

    find . -mindepth 1

## maxdepth

find in current dir only:

    find . -maxdepth 1

find in current dir and direct children dirs

    find . -maxdepth 2

find in current and direct sons only

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

## -samefile

    find . -samefile file1

find all content (HASH) duplicates of file1

    find . -xdev file1

do not go into other devices ( for instance, inode operations! )

you can concatenate multiple criteria logically.

## not

    find . -iname '*.pdf'

find paths which are pdf and which are files. the and is implicit

## and -a implicit when no criteria is specified

    find . -type f -iname '*.pdf'

find paths which are pdf and which are files. the and is implicit

    find . -type f -a -iname '*.pdf'

same as above. the and is explicit here

## or -o

    find . -iname '*.pdf' -o -iname '*.djvu'

paths either terminated by pdf or djvu extension

    find . -type f -iname '*.pdf' -o -iname '*.djvu'

files only, either pdf of djvu extension. Therfore or has higher precedence over and.

## parenthesis

you can change logical operation precedence with parenthesis.

do not forget to escape your parenthesis!

    find . \( -type f -iname '*.pdf' \) -o -iname '*.djvu'

either files with extension pdf of paths (includes dirs) with extension djvu. Parenthesis are used to change precendence order.

# actions

you can do things with the files you find. There are two main ways to do that: -exec and -print0 | xargs.

xargs tends to be more flexible

    find . -iname '*.tex' -exec pdflatex '{}' +

compile all tex under current dir.
{} gets expanded to the found path by -exec, and the commands ends when a trailling '+' is found

    find . -iname '*.tex' -print0 | xargs -0 -I '{}' pdflatex '{}'

does the same as above.
-print0 prints files null (\0) terminated. this avoids problems since filenames that can contain newlines, but not null chars.
-0 tells xargs that the input is null separated
-I '{}' tells xargs that {} should be substituted by each arg one at a time

    find . -iname '*.tex' -print0 | xargs -0 -I '{}' sh -c "bibtex '{}'; pdflatex '{}'"

execute multiple commands for each argument of xargs. must use sh -c, it is the only way without an explicit loop.
use this only for very simple multiple commands, or you are going to go crazy with quoting. for larger commands use an explicit loop as in next example.

NOTE: i don't know why exaclty, but the following fails:

    find . | xargs echo `basename {}`

this is probably because `basename {}` gets evaluated before {} is replaced by the find result
basename {} returns {}, and AFTER THAT {} gets expanded to the find result ( not just the basename therefore )
if you want to do stuff like that, a better solution is the 

    find . -print0 | while read -d '' FILE;
        do echo "$FILE";
        echo asdf;
    done

THIS is THE more flexible stable way of doing lots of operations in bash I could find

# useful calls that use the basic things above

## good bye Windows... 

    find . -name 'Thumbs.db' -delete 

remove all Thumbs.db

    find . -name 'AlbumArt*Large.jpg' -exec mv -n '{}' Front.jpg +
    find . -name 'AlbumArt*' -delete

remove AlbumArt from music.
first make a copy of the cover with name 'Front' if you don't have one yet
notice the irony, not only you kill Windows, but you first use their good (but somewhat ugly named and spreading two many files) service of downloading covers for you!
