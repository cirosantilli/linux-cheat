# Send signals to all process by name

# On Ubuntu, comes from the psmisc package.

# Application: firefox/skype hanged. `ps -A | grep -i firef',
# confirm that the name is firefox and that it is the only one with that name, and then:

  killall firefox

# This sengs SIGTERM, which programs may be programmed to handle,
# so the progrma may still hang ( and in theory be trying to finish nicelly, although in practice this never happens... )

# Kill it without mercy:

  killall -s 2

# which sends SIGINT, which processes cannot handle, so they die.
