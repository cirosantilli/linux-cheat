## su

  # Become another user, such as root:

    su otheruser
      #enter otheruser pass
    whoami
      #otheruser

  # Start a login shell as user a:

    su - a

  # Without this starts a non-login shell.

  ## don't use from script

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

  ## become root

    #BAD: never become root, as it is dangerous.

    #Give root a pass so people can log into it:

      sudo passwd root

    #On some systems such as ubuntu, sudo has no pass by default.

      su
        #enter root pass
      whoami
        #root

  ## login

    #TODO0 login vs su?

