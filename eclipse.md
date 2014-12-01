#Eclipse

Programming IDE.

##Comparison to Vim

Advantages over Vim:

- everything coded in Java

Downside:

- whatever you want to do you must click 50 menu items and there is no way to automate it
- many windows are not buffers. In Vim, everything is a buffer, e.g., a file browser, so you can reuse all file editing shortcuts.
- obtrusive interface: not possible to remove the bottom bar, huge warning on left

##Install Eclipse

Install Eclipse as a regular user, not as root or via package managers like `apt-get` because:

- you will get a much more updated version
- apt-get install crashes on Ubuntu 12.04!
- you need to open Eclipse with sudo to install packages. This causes other problems of its own.

##Preferences

Preferences, settings are under Window > Preferences

Keyboard shortcuts are under: General > Keys

##Plugins

###Install

Install and search plugins through the Eclipse Marketplace.

From the IDE: Help > Eclipse Marketplace

The website: <http://marketplace.eclipse.org/>

###Good plugins

Add Vim like editing to eclipse: <http://vrapper.sourceforge.net/update-site/stable>.

C and C++: #http://download.eclipse.org/tools/cdt/releases/indigo/

Python: <http://pydev.org/updates>

HTML, Javascript, PHP: <http://download.eclipse.org/webtools/repository/indigo/>

####LaTeX

<http://texlipse.sourceforge.net>

Forward search to Okular:

Inverse search from Okular: Settings > Configure Okular > Editor

    Editor: custom text editor,
    Command: gvim --remote +%l %f

###Color themes

Best place to find color themes: <http://eclipse-color-theme.github.com/update>. It already comes with many color themes.

The best way is to install the Color Theme plug-in and install new plugins with General > Appearance > Color Theme

Otherwise to install epf themes: File > Import > Preferences > Select *.epf

Good dark theme: <http://www.eclipsecolorthemes.org/?view=theme&id=7915>

For the GUI, Appearance > Classic worked best for Ubuntu Unity.

###Git

EGit comes on the most recommended install.

Configure: Preferences > Team

Parses git configure files as key value pairs and shows them on Eclipse. Doesn't even suggest possible key values.
