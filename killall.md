# killall

Send signals to all process by name

psmisc package on Ubuntu 14.04.

Application: Firefox/Skype hanged. `ps -A | grep -i firef`, confirm that the name is `firefox` and that it is the only one with that name, and then:

    killall firefox

This sends SIGTERM, which programs may be programmed to handle, so the program may still hang ( and in theory be trying to finish nicely, although in practice this never happens... )

Kill it without mercy:

    killall -9 name

This sends SIGINT, which processes cannot handle, so they die.
