#Shebang

Shebang is the `#!` thing at the top of many Linux scripts.

Tells Linux which interpreter to use to run the program.

- "she": name for `#`
- "bang": name for `!`

*must* be first char of first line.

The shebang is not specified by POSIX, so don't try to do fancy things with it
like passing command line arguments to the interpreter:
<http://stackoverflow.com/questions/4303128/how-to-use-multiple-arguments-with-a-shebang-i-e>

##What it does exactly

Try `./print_args_shebang c d` to really understand what happens

the following happens:

-   `print_args` runs

-   its command line arguments are:

    - 0: `print_args`
    - 1: `a b`
    - 2: `./print_args_shebang`

how this works for a python shebang (try `./python_env.py`):

-   `#!/bin/python` runs

-   its command line arguments are:

    - 0: `/usr/bin/python`
    - 1:
    - 2: `./python_env.py`

which for the Python interpreter means:

-   execute `./python_env.py`

-   ignore lines that start with `#` (comments).

    Therefore: the shebang line is ignored by `/bin/python`.

    Therefore: all interpreted languages should have `#` as their comment character!

##env

You could use `!#/bin/bash` instead but if you go on a system
where bash is located at `/usr/bin/bash`, your script breaks.

Therefore: **always** use `env`.

With `env`, path is used instead, so if `bash` is in the user's `PATH`,
and `/usr/bin/env` exists it works.

###Why it works

`env cmd` simply executes a program in current environment

In our case, the bash program.

The advantage of this is that:

- `env` is more often located in `/usr/bin` than bash in `/usr` across *NIX TODO check
- all you interpreters

##Why not determine interpreter from extension

In Windows, interpreter is determined by extension.

####Advantage of extension

Easier to spot program type from file browser.

####Disadvantage of extension

You need an extra EXT `env` var that says: you can execute `a.py` as `py`, `a.sh` as `a`.

If you want to specify a different version of the interpreter, only a shebang can handle that.

It is important to execute `a.sh` as `a` because if someday you decide
that it should be written in python instead, you don't break
all dependent programs by using `a.py`.
Of course, you could work around that by symlinking `a` to `a.sh`,
and changing the target to `a.py` when you move to python.
