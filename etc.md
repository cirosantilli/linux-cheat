#/etc/issue

Contains the message that is printed before login shells (Ubuntu Ctrl + Alt + 1).

See:

    man issue

<http://unix.stackexchange.com/questions/84280/is-etc-issue-common-file>

Of course, since this is meant to be shown to end users,
it serves as a broadcast message for CLI only environments,
and should not be used to identify the distribution even though
it usually contains the distribution ID by default.
