# Display manager

<https://en.wikipedia.org/wiki/X_display_manager_(program_type)>

Concept well defined in terms of an X11 API it seems, may not apply to other windowing systems.

Shows the initial login screen where you can:

- enter your username and password
- shutdown the computer
- select which desktop environment to run (GNOME, Unity, KDE Plasma, etc.)

Some implementations:

- LightDM (lightweight), Ubuntu
- KDM, KDE
- GDM (gnome) fedora

Find your default X display manager:

    cat /etc/X11/default-display-manager

Log out from the graphical TTY and go back to the display manger login screen <http://askubuntu.com/questions/180628/how-can-i-logout-from-the-gui-using-cli>:

    kill -9 -1

`man kill` tells us that here:

- `-9` is for signal number 9, `SIGKILL`
- `-1` is a special number, which means all PIDs except for init and the kill process itself.

## How to write a minimal display manager

For X11: <https://www.gulshansingh.com/posts/how-to-write-a-display-manager/>
