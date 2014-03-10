POSIX 7

Takes each line of stdin runs a command with that line as argument.

Great for combo with `find` to do a command on all files found.

#alternatives

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

#-I

What you will want to use 99% of the time are commands of the form:

    printf 'a\nb' | xargs -I'{}' echo '{}'

which will expand to:

    echo a
    echo b

This is so common that you should:

    alias xar xargs -I'{}'

`{}` could be anything, but it is standard practice to use `{}`, and a good one too as it is very unlikely to conflict with anything.

You should always to use `-I` because:

- it takes one line at a time.

    By default, **XARGS TAKES MULTIPLE LINES AND FEEDS THEM ALL TO THE COMMAND AT ONCE**, so:

        printf 'a\nb\n' | xargs echo

    Likely expands to a single `echo a b`, because by default it took 2 lines at once.

    This is seldom what we want.

    `-I` solves this because it implies `-L1`, which tells it to take one line at a time.

- you can escape filenames properly (considering they have no newlines...).

    By default, xargs does not quote arguments for you:

        printf '1\n2\n' | xargs -L2 printf '%d %d'

    correctly prints `1 2`, so it did not quote as `'1 2'`.

    Therefore, always quote yourself when you want one command per line:

        printf 'a\nb\n' | xargs -I'{}' echo '{}'

#-0

Read up to NUL char instead of newline char.

Allows for files with spaces, and even newlines!

    printf 'a\nb\0c\n' | xargs -0

Combo with `find -print0`:

    find . -print0 | xargs -0

#detailed operation

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

#multiple commands

The only way to do multiple commands per line is using `xargs bash` technique:

    printf 'a\nb\n' | xargs -I'{}' bash -c "echo 1: '{}'; echo 2: '{}'"

Outputs:

    1: a
    2: a
    1: b
    2: b

Only use this for very simple commands, or you are in for an escaping hell!

If you feel the need to do this, it is likely that you should consider a "read while" technique instead or a Python script.

#interactive commands

`xargs` takes its arguments from stdin, so it does not allow you to run commands that require stdin interaction such as `aspell`. The following fails:

    find . -iname '*.md' | xargs -I'{}' aspell -c '{}'

One workaround is to open a new terminal for each command:

    find . -iname '*.md' | xargs -I'{}' xterm -e aspell -c '{}'

#applications

Find and replace in files found with perl regex:

    find . -type f | xargs perl -pie 's/a/A/g'

##find files whose path differ from other files only by case

Useful when copying from Linux to a system that does not accept files that differ only by case (Mac OS X and Windows)

    find . | sort -f | uniq -di

Remove them:

    find . | sort -f | uniq -di | xargs -I'{}' rm '{}'

#parallel

TODO GNU xargs that does jobs in parallel? Looks promising.
