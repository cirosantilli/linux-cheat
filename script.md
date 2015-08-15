# script

util-linux package.

Dump everything that goes in and out of the shell to a file.

The format of the file is `typescript`. TODO why does the file has such special filetype? Isn't it just a bunch of character with ANSI escape colors?

Example:

    script
    echo a

Then hit `Ctrl + D`.

Now:

    less typescript

shows

    ~/test/script
    ciro@ciro$  echo a
    a

So it contains the entire session, including PS1, commands you've typed, and stdout / stderr.

Note that you must use `less` or another viewer, because the output will contain escape characters. `cat typescript` does not work properly for example.
