# Like find and grep, but with some features specialized to programming,
# and more convenient in general.

# Nice filename/line/match highlight output.

# Ignores .git .svn, backup, swap files by default.

# Can detect and filter by filetype via extension and shebangs.

## install

    sudo aptitude install -y ack-grep
  # `ack` package was already taken by a kanji converter!

  # this begs for an alias:
    alias ack="ack-grep"

# Recursive find grep for perl_regex in python files only, detects shebangs:

  ack --py perl_regex

# Adds all python files git. shebang aware:

  ack -f --py --print0 | xargs -0 -I '{}' git add '{}'

# Print only include names in cpp files

  ack --cc '#include\s+<(.*)>' --output '$1'

# --sh for bash

# `-k`: search in all known filetypes.

# There seems to be no way to search into *all* files.
# Well, we have GNU `grep -r` for that...

## -f

  # List all filenames of known types:

    ack -f

## -g

  # List files of known types that match regex:

    ack -g '\.py$'

# Easter egg: bill the cat:

  ack --thpppt

## combos

  # find lines in files:

    ack -f | xargs grep 'find'

  # dry run replace in files with regex::

    ack -f | xargs -lne 'print if s/a/A/g'

  # only prints modified lines

  # non-dry run replace in files:

    ack -f | xargs perl -pie 's/z/Z/g'

