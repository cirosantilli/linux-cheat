#Sandbox

How to run untrusted code in a sandboxed environment that limits its capabilities.

It appears that safe and low overhead virtualization is not yet a well achieved goal, and there is a log of work being put into it today. 

Every option has potential risks, even traditional Virtual Machines like VirtualBox have had vulnerabilities found.

Sample application: online C compiler service.

The following aspects must be either denied or give a quota to:

- disallow editing server files. Either lock user into a subdirectory, or create an entire virtual filesystem.
- hard disk usage
- RAM usage
- network usage
- CPU usage
- other devices and associated system resources: file descriptors (hard disk device availability), 

##Process limits

Linux and POSIX offer several per process limits. POSIX ones are documented with the `getrlimit` interface at <http://pubs.opengroup.org/onlinepubs/9699919799/functions/getrlimit.html>

For those limits to be useful, you need limit the maximum number of processes an user can run, possibly to 1. It seems that this can be done through PAM limits.

##Per user limits

###PAM

###/etc/security/limits.conf

TODO confirm this section.

Module that sets per user resource quotas.

<http://www.cyberciti.biz/tips/linux-limiting-user-process.html>

Allows for several useful limits, e.g. `nproc` for the number or processes.

    man limits.conf
    man pam_limits

## Docker

TODO

## Sources

There are tons of SO questions about this subject, each with a different requirement set:

- <http://stackoverflow.com/questions/437433/limit-in-the-memory-and-cpu-available-for-a-user-in-linux>
- <http://stackoverflow.com/questions/9506596/what-harm-can-a-c-asm-program-do-to-linux-when-run-by-an-unprivileged-user>
- <http://stackoverflow.com/questions/792764/secure-way-to-run-other-people-code-sandbox-on-my-server>
- <http://stackoverflow.com/questions/3859710/what-is-the-safest-way-to-run-an-executable-on-linux>
- <http://unix.stackexchange.com/questions/34334/how-to-create-a-user-with-limited-ram-usage>
- <http://unix.stackexchange.com/questions/85411/how-to-prevent-fork-bomb>
- <http://stackoverflow.com/questions/4249063/run-an-untrusted-c-program-in-a-sandbox-in-linux-that-prevents-it-from-opening-f>
