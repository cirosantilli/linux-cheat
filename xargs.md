# xargs

POSIX 7

Takes each line of stdin runs a command with that line as argument.

Great for combo with `find` to do a command on all files found.

## Alternatives

Downsides of xargs:

- max number of arguments
- escaping madness for multiple commands

Upsides of xargs:

- golfing!

In scripts, always use the more versatile (and slightly more verbose) read while technique:

    while read f; do
      echo "$f";
    done < <(find .)

Or do yourself a favor and use Python.

## Default operation

## L

The default of operation of `xargs` is undetermined and thus insane. When you do:

    printf 'a\nb\nc\n' | xargs echo

any one of following things can happen:

    echo a
    echo b
    echo c

or:

    echo a b
    echo c

or more likely since the input is small, but not certainly:

    echo a b c

To see an actual example where line breaks are added on Ubuntu 14.04, try:

    echo {a..z}{a..z}{a..z}{a..z} | xargs echo | wc

which give me 18 lines.

This happens because there is a maximum number of stdin bytes that get pasted on each command line.

To fix this number, use `-L`, or better, `-I{}` which implies `-L1`.

With `-L` we can be sure that:

    [ "$(printf 'a\nb\nc\n' | xargs -L1 echo)" = "$(printf 'a\nb\nc')" ] || exit 1
    [ "$(printf 'a\nb\nc\n' | xargs -L2 echo)" = "$(printf 'a b\nc')"  ] || exit 1
    [ "$(printf 'a\nb\nc\n' | xargs -L3 echo)" = "$(printf 'a b c')"   ] || exit 1

## I

What you will want to use 95% of the time are commands of the form:

    printf 'a\nb\n' | xargs -I'{}' echo '{}' ASDF

which is equivalent to:

    echo a
    echo b

`echo` is called multiple times.

This is so common that you should:

    alias xar xargs -I'{}'

`{}` could be anything, but it is standard practice to use `{}` because it is:

- very unlikely to conflict with anything
- the same as the default syntax for `find -exec echo '{}'`

You should always to use `-I` because:

-   it takes one line at a time.

    By default, **XARGS TAKES MULTIPLE LINES AND FEEDS THEM ALL TO THE COMMAND AT ONCE**, so:

        [ printf 'a\nb\n' | xargs echo ]

    Likely expands to a single `echo a b`, because by default it took 2 lines at once.

    This is seldom what we want.

    `-I` solves this because it implies `-L1`, which tells it to take one line at a time.

-   you can escape filenames properly (considering they have no newlines...).

    By default, xargs does not quote arguments for you:

        printf '1\n2\n' | xargs -L2 printf '%d | %d'

    correctly prints `1 | 2`, so it did not quote as `'1 2'`.

    Therefore, always quote yourself when you want one command per line:

        printf 'a\nb\n' | xargs -I'{}' echo '{}'

**This will still fail for filenames with quotes**! Must use `-0` in that case. E.g.:

    echo "'" | xargs

Gives an error:

    xargs: unmatched single quote; by default quotes are special to xargs unless you use the -0 option

## -0

Read up to NUL char instead of newline char.

Allows for files with spaces, newlines and quotes.

The only reason we do not recommend you *always* use it is that the utility producing the list of files might not be able to use NUL termination.

    printf 'a\nb\0c\n' | xargs -0I'{}' echo '{}'

Classic combo with `find -print0`:

    find . -print0 | xargs -0I'{}' echo '{}'

Using `-0` is the most robust form.

## Detailed operation

Read line from stdin, append as argument to the given command

Does not automatically quote for you!

The default command is echo, which is basically useless:

    printf 'a\nb\n' | xargs -L1

Outputs:

    a
    b

Same with explicit echo:

    printf 'a\nb\n' | xargs -L1 echo

Multiple input lines can be treated at once:

    printf 'a\nb\n' | xargs

So the above likely expands to `echo a b` and outputs `a b` (no newline).

`-L` limits the number of lines to be passed. Most common value is `1`:

    printf 'a\nb\n' | xargs -L1 echo

The above will certainly expand to:

    echo a
    echo b

However, `-L1` is implied by `-I`, which you almost ways want to use for the quoting, so you rarely see `-L1`.

Empty lines are ignored:

    printf 'a\n\nb\n' | xargs -L1

Outputs:

    a
    b

## Multiple commands

The only way to do multiple commands per line is using `xargs bash` technique:

    printf 'a\nb\n' | xargs -I'{}' bash -c "echo 1: '{}'; echo 2: '{}'"

Outputs:

    1: a
    2: a
    1: b
    2: b

Only use this for very simple commands, or you are in for an escaping hell!

If you feel the need to do this, it is likely that you should consider a "read while" technique instead or a Python script.

## Interactive commands

`xargs` takes its arguments from stdin, so it does not allow you to run commands that require stdin interaction such as `aspell`. The following fails:

    find . -iname '*.md' | xargs -I'{}' aspell -c '{}'

One workaround is to open a new terminal for each command:

    find . -iname '*.md' | xargs -I'{}' xterm -e aspell -c '{}'

## Applications

Find and replace in files found with perl regex:

    find . -type f | xargs perl -pie 's/a/A/g'

### Find files whose path differ from other files only by case

Useful when copying from Linux to a system that does not accept files that differ only by case (Mac OS X and Windows)

    find . | sort -f | uniq -di

Remove them:

    find . | sort -f | uniq -di | xargs -I'{}' rm '{}'

## P

Run tasks in parallel, much like GNU `parallel`, with up to N threads:

    seq 10 | xargs -p4 -I'{}' echo '{}'

Whatever you do, don't use `-P0`! It is a fork bomb.

<http://stackoverflow.com/a/19618159/895245>
