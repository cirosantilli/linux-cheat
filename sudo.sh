##su

  # Become another user, such as root:

    su otheruser
      #enter otheruser pass
    whoami
      #otheruser

  # Start a login shell as user a:

    su - a

  # Without this starts a non-login shell.

  ##don't use from script

    # You probably don't want to use this on a script, only on interactive sessions.

    # Doing:

      printf 'echo a\nsu a\necho b' | bash -x

    # Gives:

      su: must be run from a terminal

    # Doing:

      echo 'echo a
      su git
      echo b
      ' > a.sh
      bash a.sh -x

    # Stops the script and puts you on an interactive session.

    # Workarounds for scripts: <http://stackoverflow.com/questions/1988249/how-do-i-use-su-to-execute-the-rest-of-the-bash-script-as-that-user>

    # TODO understand behaviour precisely.

  ##become root

    #BAD: never become root, as it is dangerous.

    #Give root a pass so people can log into it:

      sudo passwd root

    #On some systems such as ubuntu, sudo has no pass by default.

      su
        #enter root pass
      whoami
        #root

  ##login

    #TODO0 login vs su?

##sudo ##sudoers

  # Do next single command as another user or super user.

  # Safer than becoming root with su.

  # Configuration file:

    sudo cat /etc/sudoers

  # Use `HOME` as the user changed to (root/ if no `-u`) instead of current user:

    sudo env | grep -E '^HOME='
    sudo -H env | grep -E '^HOME='

  # Note that it appears not to work if you do:

    sudo -Hu git echo $HOME

  # because `HOME` got replaced too early, but in fact it did work:

    sudo -Hu git sh -c 'echo $HOME'

  # because the home gets overwritten before.

  ##visudo

    # Should only be edited with visudo, analogous to vipw.

      sudo visudo

  # Syntax:

    # After any user enters a pass, he can sudo without pass for 15 mins:

      #Defaults:ALL timestamp_timeout=15

    # Turn it off. Better for safety.

      #Defaults:ALL timestamp_timeout=0

    #main lines:
      #user  hostip=(runas)NOPASSWD ALL
      #%group hostip=(runas)    :/bin/ls,/bin/cat
        #user: who will get sudo premissions
          #add '%' for group: ex: %group ...
          #can be ALL
        #runas: who can he sudo as
        #NOPASSWD: if present, must enter target user's password
        #/bin/ls,/bin/cat: list of comma separated bins he can run, or ALL

    ##Aliases

      # User:

        #User_Alias FUSE_USERS = andy,ellz,matt,jamie
        #FUSE_USERS ALL=(root):/usr/bin/the-application

      # Host:

        #Host_Alias HOST = jaunty
        #%admin HOST=(ALL)

      # Runas:

        #Runas_Alias USERS = root,andy,ellz,matt,jamie
        #%admin ALL=(USERS) ALL

      # Command:

        #Cmnd_Alias APT   = /usr/bin/apt-get update,/usr/bin/apt-get upgrade
        #Cmnd_Alias USBDEV = /usr/bin/unetbootin,/usr/bin/gnome-format
        #ALL_PROGS = APT,USBDEV
        #%admin ALL=(ALL) ALL

  # Common combos:

  # Allow given user to sudo without password:

    #username ALL=(ALL) NOPASSWD: ALL

  # CLI:

    #sudo sh -c "echo '$(id -un) ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers"

  ##redirection

    # sudo passes its stdin to the called program:

      echo a | sudo cat
        #a

    # Cannot "echo to a file" directly without permission

      su a
      mkdir b
      chown b b
      #fails:
      sudo echo a > b/a

    # The reason why this fails is that bash gives sudo two arguments: `echo` and `a`.

    # sudo does `echo a`, produces `a`, and then *bash* attempts the redirection by writing
    # `a` to `b/a`, which of course fails because bash does not the necessary permissions.

    # Workarounds for that include:

    # Put everything inside a single bash command:

      sudo bash -c 'echo a > b/a'

    # This works, but may lead to quoting hell.

    # sudo a tee and let it do the work:

      echo a | sudo tee b/a

    # And if we want to append to the file instead:

      echo a | sudo tee -a b/a

    # The resaon this works is because `sudo` redirects its stdin
    # to the stdin of the program it will call.

    # `-e` to edit a file as sudo:

      sudo -e /etc/file.conf

    # Multiline sudo via EOF:

      sudo tee /some/path <<EOF
EOF

  ##ubuntu default sudo config

    # In Ubuntu, sudo group allows members to sudo whatever they want as root

      groups
        #sudo is in my groups!
      sudo whoami
        #root
      sudo -u test whoami
        #test
      sudo -l
        #find cur user sudo permissions
      sudo env
        #you don't have your cur users env anymore
        #you are root now!
      sudo env PATH=$PATH env
        #use your user's path on sudo
      #alias sudo='sudo env PATH=$PATH'
        #tempting, but it will make options fail!
        #sudo -L --> sudo env PATH=$PATH -l
        #env thinks -l is his option
