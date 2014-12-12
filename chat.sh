# TODO convert to md.

# Chat utilities, specially command line ones.

## mseg write wall

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

  # POSIX.

    sudo aptitude install -y talk

## IRC

  #internet relay chat

  #servers have channels

  #log into a server, join a channel

  #messages can be seen

    #- by all people on channel
    #- certain people you write to only

  #you cannot see read old messages
  #sent when you were not logged in!!

  #it is also possible to send files to people

  ## commands

    #intro: <http://www.irchelp.org/irchelp/irctutorial.html>

    #full list: <http://en.wikipedia.org/wiki/List_of_Internet_Relay_Chat_commands>

    #/connect <server>

    ## ubuntu channel

        ## register

          xdotool type "/msg nickserv register $password $email"

        ## verify registration

          #go to your email and get the registration code

          regcode=
          xdotool type "/msg nickserv verify register $uname $regcode"

  ## clients

    ## pidgin

      #good because integrates with other ims

      ## create account

        #irc server + username on that server == a pidgin account

        #add account > irc

        #enter server username and pass

      ## join/create channel:

        #an irc channel == a pidgin chat

        #chats appear on the buddy list like buddies

        #buddies > join a chat > choose server, enter a #channel_name

        #if you don't know the name and want to list the available channels,
        #enter any #name, and then /list there

        #a chat window appear, mapping to the chosen channel on chosen sever

        #if you close the chat window, it will not be on your buddy list anymore

      ## add channel to buddy list permanently:

        #buddies > add a group. name it "irc".

        #buddies > show > empty groups

        #buddies > add a chat. choose type irc, server, channel.

  ## irssi

    #ncurses
