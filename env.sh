# POSIX 7

# Shows all environment variables and their values:

  env

# Change environment for a single command:

  a=b
  env a=c echo $a
  #c
  echo $a
  #b

# In bash it is also possible to do (not sure about portability):

  a=b
  a=c echo $a
  #c
  echo $a
  #b

##-i

  #exec in a clean environment:

    [ "`env -i a=b env`" = "a=b" ] || exit 1

  ##start a subshell in the cleanest env possible

    #don't forget: subshells inherit all exported vars

      env -i bash --noprofile --norc
      env
      #some default vars might still be there!
      #I get: SHLVL, PWD
      exit
