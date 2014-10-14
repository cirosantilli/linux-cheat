# POSIX 7

# Make a process that continues to run even if calling bash dies:

  nohup firefox >'/dev/null' 2>&1 &
  echo "$!" >'/tmp/firefox.pid'
  exit

# This would send a HUP signal to Firefox, which kills most programs.

# Firefox still lives! it would be killed if it were not for nohup.

# When you do this, you will often want to store the PID of the program to kill it later with:

  kill "$(cat firefox.pid)"

# Consequences of `nohup`:

# - if stdin came from terminal (not pipe for example),
#     sdtin comes from `/dev/null` (you have no stdin!) instead
#
# - if stdout would go to terminal (not pipe for example)
#     it is *appended to* `./nohup.out`, and if not possible from `$HOME/nohup.out`
#     instead
#
#     If no stdout is generated, `nohup.out` is not created
#
#     you can also redirect stdout to any file you want via `nohup cmd > file`
#     for example `nohup cmd > /dev/null` to ignore output
# - the program is still visible in `jobs`, and may be killed with `kill %+`
# - if you don't use `&`, it runs on foreground, preventing you from using bash

# How to test all this:

  nohup bash -c 'for i in {1..10}; do echo $i; sleep 1; done'

# Try:

  #append `> f` to command
  #append `&`  to command

  jobs
  cat nohup.out

