# time

Measure process:

- real time
- user time
- system time

POSIX http://pubs.opengroup.org/onlinepubs/9699919799/utilities/time.html

Has a Bash built-in and GNU external implementations: http://stackoverflow.com/questions/8870333/shell-time-command-source-code

User and real time don't count sleeps:

    time sleep 1
