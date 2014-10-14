# - -20: highest priority
# - 20: lowest priority

# Mnemonic: the nicest you are, the more you let others run!

# POSIX 7

# Therefore the concept of niceness is included in POSIX.

# View nice of all processes:

    ps axl

# Run program with a nice of 10:

    nice -10 ./cmd

#- 10:

    sudo nice --10 ./cmd

# You need sudo to decrease nice

# Change priority of process by PID:

    renice 16 -p 13245
