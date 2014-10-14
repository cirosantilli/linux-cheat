# Ncurses constantly updated process list with CPU and memory usage.

# Interface:

# - h: help
# - q: quit
# - f: chose which fields to show
# - F: chose by which field to sort
# - O: move sort field left right
# - k: kill process
# - arrow keys: move view

# Sample first line:

  23:00:13 up 12:00, 3 users, load average: 0.72, 0.66, 0.6
  ^^^^^^^^ up ^^^^^, ^ users, load average: ^^^^, ^^^^, ^^^
  1      2    3            4   5   6

# Meanings:

# - 1: cur time
# - 2: how long the system has been up for
# - 3: how many users are logged
# - 4: load average for past  1 minute
# - 5:                        5 minutes
# - 6:                       15 minutes

# Not possible to show more processes:
# http://unix.stackexchange.com/questions/36222/how-to-see-complete-list-of-processes-in-top
# Use `htop`.

##load average

  #0.75: 0.75 as many scheduled tasks as your cpu can run
    #rule of thumb maximum good value
  #1  :    as many scheduled tasks as your cpu can run
    #break even point
    #risky, a littly more and you are behind schedule
  #5  : 5x
    #system critically overloaded

  # Does not take into account how many cores you have!
  # E.g.: for a dual core, breakeven at 2.0!
