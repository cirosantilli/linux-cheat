# LightDM

Default display manager for Ubuntu.

Sources

-   <https://wiki.ubuntu.com/LightDM>

    Ubuntu docs

Desktop chosen on last login:

    echo $GDMSESSION

Configuration file:

    less /etc/lightdm/lightdm.conf

Don't edit the configuration file directly, use this instead:

    sudo /usr/lib/lightdm/lightdm-set-defaults --hide-users true

Options:

-   allow-guest

-   `--autologin-user <username>`: auto-login the given user at startup without asking for password.

        sudo /usr/lib/lightdm/lightdm-set-defaults --autologin "$USER"

-   `--session <session>`: which session to log into. Examples: Ubuntu, LXDE, etc.

    The possibilities can be found at:

        ls /usr/share/xsessions

-   `display-setup-script=[script|command]`

-   `--hide-users <true-false>`: if false, don't show user list to select from.

    This prevent users from discovering the names of all users on the system.

Restart LightDM:

    sudo restart lightdm

Also restarts X. Closes all your programs that have windows.

Only do this on a tty, not on an xterminal probably because your terminal is going to die in the middle of the operation

## log files

When things go wrong... First go to a TTY with Ctrl + Alt + F2, then check:

- `/var/log/lightdm/lightdm.log`: last session
- `/var/log/lightdm/lightdm.log.old`: before last session

And also check `/var/log/Xorg.X.log`, as X problems can cause login to fail.

<http://askubuntu.com/questions/396957/meaning-of-files-in-var-log-lightdm-and-how-to-properly-read-lightdm-log-file>
