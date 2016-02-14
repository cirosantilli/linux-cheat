## IRC

  # internet relay chat

  # servers have channels

  # log into a server, join a channel

  # messages can be seen

    # - by all people on channel
    # - certain people you write to only

  # you cannot see read old messages
  # sent when you were not logged in!!

  # it is also possible to send files to people

  ## commands

    # Intro: http://www.irchelp.org/irchelp/irctutorial.html

    # Full list: http://en.wikipedia.org/wiki/List_of_Internet_Relay_Chat_commands

    # /connect <server>

    ## private message

    ## ubuntu channel

        ## register

          xdotool type "/msg nickserv register $password $email"

        ## verify registration

          #go to your email and get the registration code

          regcode=
          xdotool type "/msg nickserv verify register $uname $regcode"

  ## clients

    ## pidgin

      # Good because integrates with other ims.

      ## Create account

        # IRC server + username on that server == a pidgin account.

        # Add account > irc.

        # Enter server username and pass.

      ## join/create channel:

        # an irc channel == a pidgin chat

        # chats appear on the buddy list like buddies

        # buddies > join a chat > choose server, enter a #channel_name

        # if you don't know the name and want to list the available channels,
        # enter any #name, and then /list there

        # a chat window appear, mapping to the chosen channel on chosen sever

        # if you close the chat window, it will not be on your buddy list anymore

      ## add channel to buddy list permanently:

        # buddies > add a group. name it "irc".

        # buddies > show > empty groups

        # buddies > add a chat. choose type irc, server, channel.

  ## irssi

    #s ncurses
