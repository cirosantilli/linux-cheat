# Shows:

# - jobspec   : a local job id.
# - status    : runnning, stopped, done
# - invocation  : exact program call, including command line args. Ex: `ls ~`

  jobs

# Show pids of background jobs:

  jobs -p

## jobspecs

  # Local job id, found by using <#jobs>

  # Certain commands such as `kill`, `fg` them in addition to pids.

  # They are:

  # - %N	Job number [N]
  # - %S	Invocation (command line) of job begins with string S
  #  If several matches, ambiguous, and does nothing.
  # - ?S	Invocation (command line) of job contains within it string S
  # - %%	"current" job (last job stopped in foreground or started in background)
  # - %+	"current" job (last job stopped in foreground or started in background)
  # - %-	last job

# It is possible to use jobspecs directly with certain bash built-ins that could also take PID.
# For example, to kill process by jobspec `%1`:

  #kill %1

# Note that `kill` also usually exists as an external executable, and that the external executable
# cannot kill by jobspec since this information is only known by bash itself.

# `help kill` states that one of the reasons why `kill` is implemented as a bash built-in is to be
# able to write `kill %1`.

#ls &
#sleep 100 &
#sleep 100 &
#sleep 100 &
  #runs on background
  #
  #[1] 12345678
  #means local id 1
  #process number 12345678
  #
  #when process ends, it prints ``[n] 1234`` and disappears
  #
  #stdout continues to go to cur terminal, even if in bg
