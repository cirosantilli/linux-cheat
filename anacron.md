# anacron

- <http://serverfault.com/questions/52335/job-scheduling-using-crontab-what-will-happen-when-computer-is-shutdown-during>
- <http://www.thegeekstuff.com/2011/05/anacron-examples/>

Ubuntu `anacron` package, installed by default.

## anacrontab

Configures anacron.

Line format:

    period delay job-identifier command

Fields separated by tabs or spaces.

Every day as soon as anacron starts:

    1 0 test.daily sleep 3 && date >> /tmp/anacrontest

### Command run environment

Try:

    1 0 test (date; id; pwd; env) >> /tmp/anacrontest

Runs:

- as user `root`
- from directory `/`

If we do a:

    pstree

and start killing things, we see that;

- `anacron` is the parent of the processes it spawns
- killing anacron does not kill it's children
- when all children exit, anacron then exits

## anacron command

Run anacron commands that haven't been run yet on their time-slots:

    sudo anacron

`sudo` is mandatory, I think because jobs run as root.

For execution of jobs now, even before their time:

    sudo anacron -f

### s

By default, each anacron line is run asynchronously. Try:

    1 0 test1 sleep 3 && echo a >> /tmp/anacrontest
    1 0 test2 sleep 1 && echo b >> /tmp/anacrontest

and then:

    sudo anacron -f

Then `/tmp/anacrontest` contains:

    b
    a

But if we had done:

    sudo anacron -fs

it would contain instead:

    sudo anacron -

## Ubuntu implementation

In Ubuntu 15.10, `cron` calls `anacron` periodically via the crontab entries:

    # m h dom mon dow user	command
    17 *	* * *	root    cd / && run-parts --report /etc/cron.hourly
    25 6	* * *	root	test -x /usr/sbin/anacron || ( cd / && run-parts --report /etc/cron.daily )
    47 6	* * 7	root	test -x /usr/sbin/anacron || ( cd / && run-parts --report /etc/cron.weekly )
    52 6	1 * *	root	test -x /usr/sbin/anacron || ( cd / && run-parts --report /etc/cron.monthly )

Those take care of the case where the computer has been left running for a long time, and run things in the morning.

Anacron is also run whenever the computer starts up, or resumes from sleep. I think those implemented by the files:

    /etc/apm/event.d/anacron
    /etc/init/anacron.conf

which the `anacron` package installs.

By default, anacron does on Ubuntu:

    1	5	cron.daily	run-parts --report /etc/cron.daily
    7	10	cron.weekly	run-parts --report /etc/cron.weekly

So packages can use files in those directories to install anacron scripts.

## /var/spool/anacron

Stores the date in which commands were last run:

    sudo tail -n+1 /var/spool/anacron/*

Sample output:

    ==> /var/spool/anacron/cron.daily <==
    20151207

    ==> /var/spool/anacron/cron.monthly <==
    20151202

    ==> /var/spool/anacron/cron.weekly <==
    20151207

    ==> /var/spool/anacron/test.daily <==
    20151207

    ==> /var/spool/anacron/test1 <==
    20151207

    ==> /var/spool/anacron/test2 <==
    20151207
