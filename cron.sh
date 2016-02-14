## cron

  # Tell the computer to do things at specified times automatically.

  ## crontab

    # POSIX 7.

    # Utility to manage crobjobs.

    # It is basically a frontend for the `/etc/crontab` file which an be edited directly.

    # It is not possible launch graphical applications via cron!

    # Edit user cron jobs in vim

      crontab -e

    # Sample line:

      1 2 3 4 5 /path/to/cmd.sh arg1 arg2 >/dev/null 2>&1

    # Fields:

    # - 1: Minute (0-59)
    # - 2: Hours (0-23)
    # - 3: Day (0-31)
    # - 4: Month (0-12 [12 == December])
    # - 5: Day of the week(0-7 [7 or 0 == sunday])
    # - /path/to/command - Script or command name to schedule#

    # Special notations:

    # - * : every
    # - */5 : every five
    # - 1,3,6 : several
    # - 1-5 : ranges

    # Convenient altenatives to the fields:

    # - @reboot	Run once, at startup.
    # - @yearly	Run once a year, "0 0 1 1 *".
    # - @annually	(same as @yearly)
    # - @monthly	Run once a month, "0 0 1 * *".
    # - @weekly	Run once a week, "0 0 * * 0".
    # - @daily	Run once a day, "0 0 * * *".
    # - @midnight	(same as @daily)
    # - @hourly	Run once an hour, "0 * * * *".

    # Example:

      @daily /path/to/cmd.sh arg1 arg2 >/dev/null 2>&1

    # `>/dev/null 2>&1` prevents cron from sending notification emails.

    # Otherwise if you want them add:

      #MAILTO="vivek@nixcraft.in"

    # to the config file.

    # List all cronjobs:

      crontab -l

    # List all cronjobs for a given user:

      crontab -u user -l

    # Erase all cronjobs:

      crontab -r

    # Erase all cronjobs for a given user only

      crontab -r -u username

  ## batch

    # POSIX 7

    # Superset of `at`.

    # Execute only when system load average goes below 1.5,
    # starting from now!

      cd "`mktemp -d`"
      echo "touch a" | batch

    # Same, but with at you can change to any time:

      echo "touch a" | at -q b now

  ## at

    # Schedule job at a single specified time.

    # Not for a periodic jobs.

      cd "`mktemp -d`"
      echo "touch a" | at now + 1 minutes
        #in one minute `test -f a`
      echo "echo a" | at now + 1 minutes
        #nothing happens!
        #of course, job does not run in current shell
      echo "xeyes" | at now + 1 minutes
        #nothing happens

    # List jobs:

      atq

    # Remove job with id 1:

      atrm 1

    # Id can be found on atq output.

    #inner workings

      echo "touch a" | at now + 10 minutes
      d=/var/spool/cron/atjobs
      sudo cat "$d/$(sudo ls "$d" | head -n 1)"
        #note how the entire environment
        #and current dir are saved and restored

      sudo cat /usr/lib/cron/at.allow
        #if exists, only listed users can `at`
      sudo cat /usr/lib/cron/at.deny
        #if allow exists, this is ignored!
        #if not, denies only to listed users

  ## Concurrency

    # Jobs run concurrently:
    # http://unix.stackexchange.com/questions/58481/can-a-crontab-job-run-concurrently-with-itself
