tells linux which interpreter to use to run the program

she: name for '#', bang: name for '!'

*must* be first char of first line

#what it does exactly

try `./print_args_shebang c d` to really understand what happens

the following happens:

- `print_args` runs
- its command line arguments are:

    - 0: `print_args`
    - 1: `a b`
    - 2: `./print_args_shebang`

how this works for a python shebang (try `./python_env.py`):

- `#!/bin/python` runs
- its command line arguments are:

    - 0: `/usr/bin/python`
    - 1:
    - 2: `./python_env.py`

which for the python interpreter means:

- execute `./python_env.py`

- ignore lines that start with `#` (comments).

    Therefore: the shebang line is ignored by `/bin/python`.

    Therefore: all interpreted languages should have `#` as their comment character!

#env

you could use `!#/bin/bash` instead but if you go on a system where bash is located
at `/usr/bin/bash`, your script breaks.

Therefore: **always** use `env`.

with env, path is used instead, so if `bash` is in the users $PATH,
and `/usr/bin/env` exists it works.

##why it works

`env cmd` simply executes a program in current environment

in our case, the bash program

the advantage of this is that:

- env is more often located in `/usr/bin` than bash in `/usr` across *NIX TODO check
- all you interpreters

#why not determine interpreter from extension

in windows, interpreter is determined by extension

###advantage os extension

easier to spot program type from file browser

###disadvantage os extension

you need an extra EXT env var that says: you can execute `a.py` as py, `a.sh` as a

what if you want to specify a different version of the interpreter?
only a shebang can handle that

it is important to execute `a.sh` as `a` because if someday you decide that
it sould be written in python instead, you don't break all dependant programs
by using `a.py`. Of course, you could work around that by symlinking `a` to `a.sh`,
and changing the target to `a.py` when you move to python.
