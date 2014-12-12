# logrotate

A log file is a file that stores notifications, often automatically made by programs that run on the background like servers or the kernel.

Log file for system wide utilities are often stored under `/var/log`.

Log files contain information that can be useful to debug the system.

Most applications simply append to the end of a single log file.

This has two problems:

- you can run out of disk space
- opening each file takes a very long time

It would be easy to solve those two problems if it were possible to write to the beginning of a file efficiently: applications could just do that and truncate the file to a size, keeping the most recent messages at the top. Unfortunately there is no efficient way of writing to the beginning of a file: you would have to move everything forward to make up space.

Logrotate solves both of those problems with the premise that more recent logs are more important.

For example, you can configure logrotate to do the following:

-   if log the file `a.log` is larger than 100Kb, zip it into `a.log.1.gz`.

    This will make up room for the application to create a new log file.

-   if `a.log.1.gz` already exists, create `a.log.2.gz`, and so on, up to a configurable limit, like `a.log.4.gz`.

    After that, the `.gz` would be removed.

This is why it is called logrotate: at the same time, it transforms:

- remove `a.log.4.gz`
- rename `a.log.3.gz` into `a.log.4.gz`
- ...
- rename `a.log.1.gz` into `a.log.2.gz`
- zip `a.log` into `a.log.1.gz`
- remove `a.log`

Most distributions run logrotate by default from cron.
