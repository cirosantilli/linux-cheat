# lpstat

`cups-client` package.

## a

List all printers and their status:

    lpstat -a

Sample output:

    XP-202-203-206-Series accepting requests since Wed 22 Apr 2015 10:19:16 AM CEST

## d

Get the default printer:

    lpstat -d

Sample output:

    system default destination: XP-202-203-206-Series

## R

List all jobs:

    lpstat -R

Sample output if there are two jobs enqueue with `lp` before they were done:

    0 XP-202-203-206-Series-27 ciro              1024 Wed 22 Apr 2015 12:44:38 PM CEST
    1 XP-202-203-206-Series-28 ciro              1024 Wed 22 Apr 2015 12:49:08 PM CEST

After they are done, they disappear.

<http://askubuntu.com/questions/37247/is-there-an-easy-way-to-view-the-print-queue/612409#612409> Also consider: `lpq` from.
