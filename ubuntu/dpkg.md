#dpkg

Lower level tool that `apt-get`: capable of listing, installing and removing individual
`.deb` packages, but not of managing dependencies.

`apt-get` is a front-end for `dpkg`

List all installed packages and greps for `foo`:

	dpkg -l | grep "$EXPRESSION"

The first two letters mean:

- `ii`: installed
- `rc`: configuration files only (`rc` means config such as in `bashRC`)

List files in installed package

	dpkg -L mysql

Install `.deb` file:

	dpkg -i a.deb

Remove previously installed package:

	dpkg -r a.deb

You don't need the `.deb` to uninstall it.

Automatically install updates without asking for confirmation:
<http://askubuntu.com/questions/9/how-do-i-enable-automatic-updates>

    sudo dpkg-reconfigure unattended-upgrades
