# TODO convert to md.

# Chat utilities, specially command line ones.

# Write messages to other users on the system.

## mseg

  # Enable/disable messages:

    mseg n
    mseg
      #n
    mseg y
    mseg
      #y

## write

  # Write to a user in a TTY:

    u=
    write $u tty3

  # Now:

  # - type you message
  # - type enter, and it is sent
  # - hit Ctrl + D and its over

    u=
    h=
    sudo write $h@$u tty2

## wall

  # Write to all:

    wall

  # Type you message. It is only sent after you ctrl+d

  # Sends to all even if disabled:

    sudo wall

  # Play with it:

    #go to tty3. on ubuntu: ctrl+alt+f3
    #login as user u
    mesg y
    #go to tty7 (xserver). on ubuntu: ctrl+alt+f7
    sudo write u tty3
    #write
    #go to tty3
    #your message is there!

## talk

  # Commandline chat program.

  # POSIX, but not intall on Ubuntu by default:

    #sudo aptitude install -y talk
