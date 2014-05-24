Cheat on the apache server.

Test apache:

    firefox http://localhost/ &

#Introduction

Apache is a web server

A web server listens to a port (default 80) for strings

Theses strings are http requests

Then it takes the http request, processes it, and then returns the request to the client

Part of the processing may be passed to another program: typically a <#cgi> script

#Test preparations

Before doing anything, make this test dir:

    mkdir test
    cd test
    echo '<html><body><h1>index.html</h1></body></html>' > index.html
    echo '<html><body><h1>a.html</h1></body></html>' > a.html

    mkdir a
    cd a
    echo '<html><body><h1>a/index.html</h1></body></html>' > index.html
    echo '<html><body><h1>a/a.html</h1></body></html>' > a.html
    cd ..

    mkdir auth
    cd auth
    echo '<html><body><h1>auth/index.html</h1></body></html>' > index.html
    echo '<html><body><h1>auth/a.html</h1></body></html>' > a.html
    cd ..

    mkdir noindex
    cd noindex
    echo '<html><body><h1>noindex/a.html</h1></body></html>' > a.html
    echo '<html><body><h1>noindex/b.html</h1></body></html>' > b.html
    cd ..

    cd ../..

Finally move our test dir to the serve root:

    sudo mv test /var/www/

The default root for serving files is specified in the <#conf file> by the `DocumentRoot` directive. In current ubuntu, it is `/var/www/`

The user under which the web server runs must have read access to this directory. *This is the default on Ubuntu*, where the apache server runs as user `www-root`!

Usually this user is a different user from `root` for sercurity.

#conf file

Ubuntu default location for the configuration file:

    sudo vim /etc/apache2/apache2.conf

This file may include others, and for example in Ubuntu the default template does include:

    IncludeOptional conf-enabled/*.conf
    IncludeOptional sites-enabled/*.conf

so that local configurations can be managed in separate files.

Ubuntu default also creates `*-available` directories, which contain possible configuration files. Those should be symlinked to the `enabled` directories to enable them.

Configurations only apply when you restart apache:

    sudo service apache2 restart

#minimum conf file

The bare minimum conf file to get a file served is:

    Listen 80
    User www-data
    Group www-data
    ErrorLog /var/log/apache2/error.log

This conf may be useful for testing server configuration.

#default operation

"web subdirs" map directly to local dirs.

Ubuntu default is currently `/var/www/`

Open file /var/www/test/index.html:

    firefox localhost/test/index.html

Going to a dir on the web browser opens the contained index.html file by default:

    firefox localhost/test/

This can be configured with the `DirectoryIndex` directive

If no index is contained, apache generates an html index:

    firefox localhost/test/noindex/

##DocumentRoot

Set Apache serve root at given dir:

    DocumentRoot "/var/www/root"

For this to work, make sure `DocumentRoot` is not set anywhere else. (by default it was included in the include files, `grep -r DocumenRoot` shows where)

For security concerns, only put things you want apache to serve directly inside DocumentRoot such as HTML, CSS and images.

Stuff that users should not see such as cgi scripts and *gasp* ssl certificates are better to remain outside it, so that you don't serve them by mistake!

##Listen

Listen those ports on all interfaces (for example, first wireless card, first ethernet card, etc...):

    Listen 80
    Listen 8000

This configuration is mandatory.

Listen those ports on given interfaces:

    Listen 192.0.2.1:80
    Listen 192.0.2.5:8000

##AccessFileName

Name of the file which can modify access properties of a directory.

    AccessFileName .htaccess

##AllowOverride

Allows the `.htaccess` to override certain directives of earlier conf files.

Allow to override all directives:

    AllowOverride All

Allow to override no directories (the ifle is ignored):

    AllowOverride None

##Include

Copy paste Include other apache conf files or entire directories
into the current configuration:

    Include file.conf
    Include conf-d

##Deny

Deny access from given host

    Deny from 10.252.46.165
    Deny from host.example.com

##DirectoryIndex

What to do when user acesses a directory location:

    DirectoryIndex index.html index.php /cgi-bin/index.pl

SAME:

    DirectoryIndex index.html
    DirectoryIndex index.php
    DirectoryIndex /cgi-bin/index.pl

with this, for the entire site, first looks in order for:

- `index.html`
- `index.php`
- `/cgi-bin/index.pl`

note how you can specify a script outside of that dir

in case none of those actions match, the default is for
`mod_autoindex` to generate an html directory listing

for specific dirs, use the `Directory` directive

###mod_autoindex

Generates automatic html listings for dirs

Turn off automatic listings for a given dir:

    <Directory /var/www/root/test/dontlist>
    Options -Indexes
    </Directory>

Will simply give a not found

Ignore certain files in the listing:

    IndexIgnore tmp* ..

Add headers/footers before/after index:

    HeaderName header.html
    ReadmeName footer.html

Same header/footer for every dir

    HeaderName header.html
    HeaderName /site/header.html
    ReadmeName /site/footer.html

Use predefined styles:

    IndexOptions FancyIndexing HTMLTable

Use given CSS style:

    IndexStyleSheet /css/autoindex.css

#VirtualHost

Allows to host many DNS names on a single IP.

#sections

Sections are commands which restrict the scope of application of other configurations.

The official manual page: <http://httpd.apache.org/docs/2.2/sections.html#mergin>

##Files

Acts on local filesystem.

Deny file permissions for files that match regex `"^\.ht"`:

    <Files ~ "^\.ht">
    Order allow,deny
    Deny from all
    Satisfy all
    </Files>

Order says: first process all allow directives, then all deny directives. Since `Deny` came last, it has precedence.

##Directory

Acts on local filesystem

    <Directory /var/web/dir1>
    Options +Indexes
    </Directory>

##Location

Applies configuration to URL addresses:

    <LocationMatch ^/private>
        Order Allow,Deny
        Deny from all
    </LocationMatch>

##combine sections

It is possible to combine multiple section scopes:

    <Directory /var/web/dir1>
        <Files private.html>
            Order allow,deny
            Deny from all
        </Files>
    </Directory>

##IfDefine

    <IfDefine ClosedForNow>
        Redirect / http://otherserver.example.com/
    </IfDefine>

##IfVersion

    <IfVersion >= 2.1>
        this happens only in versions greater or
        equal 2.1.0.
    </IfVersion>

#alias

Allow to create virtual paths to dirs and files.

##sources

Man: <http://httpd.apache.org/docs/2.2/mod/mod_alias.html>

Create virtual directory:

    Alias /test/alias /var/www/test

    firefox localhost/test/alias &

Also works for subdirs:

    firefox localhost/test/alias/a.html &
    firefox localhost/test/alias/a      &

Also works for files:

    Alias /testfile/ /var/www/test/index.html

    firefox localhost/testfile &

Also works outside of serve root:

    cd
    echo "TEST" > index.html

    Alias /test/alias-out-root/ /home/ciro/

    firefox localhost/test/alias-out-root

##first match takes precedence

    Alias /test/alias/a /var/www/test
    Alias /test/alias   /var/www/test

    firefox localhost/test/alias/  &

Goes to `test/index.html`

    firefox localhost/test/alias/a &

Goes to `test/a/index.html`

BAD: both go to `test/index.html`:

    Alias /test/alias   /var/www/test
    Alias /test/alias/a /var/www/test

    firefox localhost/test/alias/  &
    firefox localhost/test/alias/a &

##Redirect

Returns a redirect HTTP response. Takes precedence over aliases.

    Alias /test/redir /test
    Redirect /test/redir http://www.google.com

The following goes to google:

    firefox localhost/test/redir &

##CGI

**CGI** is a protocol of how a server communicates with a CGI script.

A CGI script is simply a script/executable that outputs the part of HTTP response.

This part includes some last header lines which the server delegates to it, notably `content type`, followed by "\n\n" followed by the entire body.

The server passes information to the script through environment variables only.

###fastcgi

A faster version of CGI that does not start a new process pre request

Implementations: mod_fastcgi vs mod_fcgid <http://superuser.com/questions/228173/whats-the-difference-between-mod-fastcgi-and-mod-fcgid>

###ScriptAlias

The script:

    echo '#!/usr/bin/perl
    print "Content-type: text/html";
    first output line must be "Content-type: text/html\n\n"
    print "Status: 500  Internal Server Error"
    print "\n\n"
    print "<html><body><h1>environment</h1>"
    foreach $key (keys %ENV) {
        print "$key --> $ENV{$key}<br>";
    }
    print "</body></html>"
    ' > sudo tee /usr/lib/cgi-bin/test.pl
    sudo chmod +x /usr/lib/cgi-bin/test.pl

####status

Optional, if not given supposes `200 OK`.

If given as error, server will simply give the error and no data.

Uncomment the status line on the test script to see what happens.

####alias to dir

CGI scripts must be in the dir specified by script alias:

    ScriptAlias /mycgi /usr/lib/cgi-bin

Same as:

    Alias /mycgi /usr/lib/cgi-bin
    <Location /mycti >

Tell server that all files inside this dir are cgi scripts:

    SetHandler cgi-script

Tell server that all .pl and .py files in dire are cgi scripts:

    AddHandler cgi-script .cgi .pl

Permit CGI execution for scripts in this dir:

    Options +ExecCGI
    </Location>

Run it:

    firefox localhost/mycgi/test.pl

Note how `ScriptAlias` created a virtual directory not present in the actual filesystem.

Can also make individual script:

    ScriptAlias /test/cgi-file /usr/lib/cgi-bin/test.pl

####alias to script

All subdirs of `testpl` are generated by the given `test.pl`:

    ScriptAlias /test/testpl /usr/lib/cgi-bin/test.pl

    firefox localhost/testpl/       &
    firefox localhost/testpl/a.html &

###action

Run script whenever an HTML file is accessed:

    Action test /cgi-bin/test.pl
    AddHandler test .html

TODO: i get `Action` directive undefined... solve this.

Try it:

    firefox localhost/index.html

This is how PHP does it!

#modules

Apache plugins are called modules

Modules are compiled `.so` files

Modules may define new directives

For modules to become effective they must be loaded in the config file

Only do certain commands if module is exists:

    <IfModule mod_fastcgi.c>
        commands...
    </IfModule>

Load a module:

    LoadModule fastcgi_module /usr/lib/apache2/modules/mod_fastcgi.so
    1          2

- 1: module identifier hard coded in module?
- 2: full path to .so

##a2enmodule

Apache2 ENable Module.

Utility that enables modules easily.

Probably adds `LoadModule` somewhere.

List options:

    a2enmod

Enable a module:

    sudo a2enmod $MODULE_NAME

#handlers

Part of the very default mime_module

Determines file types and sets default actions accordingly

Example:

    Action add-footer /cgi-bin/footer.pl
    AddHandler add-footer .html

- `Action`: defines a handler called add-footer
- `AddHandler`: uses the handler called add-footer for all html files

Handlers can be defined in modules

#authentication

You must chose *both* one <#method> and one <#provider>!

##methods

###prerequisites

First understand HTTP authentication.

What algorithm is used to store the passwords more or less safely.

###basic authentication

Provided by `mod_auth_basic`

Apache conf:

    LoadModule auth_basic_module /usr/lib/apache2/modules/mod_auth_basic.so
    <Directory "/var/www/test/auth/">
        AuthType Basic
        AuthName "private dir"
        AuthBasicProvider file
        AuthUserFile /var/.htpasswd
        Require valid-user
        AllowOverride None
    </Directory>

###digest

Provided by `mod_auth_digest`.

`mod_auth_digest` is better than `mod_auth_basic`, so use digest!

    LoadModule auth_digest_module /usr/lib/apache2/modules/mod_auth_digest.so
    <Directory "/var/www/test/auth/">
        AuthType Digest
        AuthName "private dir"
        AuthDigestProvider file
        AuthUserFile /var/.htpasswd
        Require valid-user
        AllowOverride None
    </Directory>

##provider

What type of storage is used for user password pairs

Is specified by the `AuthBasicProvider` directive.

###file

A plain text file

Safer to put outside serve root

####htpasswd

Generates `.htpasswd` files

Generate user/pass pairs:

    sudo htpasswd -bc /var/www/.htpasswd u p

- `-c`: creates new file, destroying old one! *Necessary first time!*
- `-b`: use pass from command line. *Less safe!*

        sudo htpasswd -b /var/www/.htpasswd u2 p

Lets take a look at the file:

    sudo cat /var/www/.htpasswd

Note that the passwords are base64 encoded.

###dbd

SQL database

#Try it out!!

Test:

    firefox localhost/test/auth &

Try u and u2 pass p!

##browser cache

    firefox localhost/test/auth &
    firefox localhost/test/auth &

The second time, you may not be prompted for a password!

This is because Firefox has cached your password for some time and resent it automatically! there is no server state.

To avoid the cache use curl:

    curl -I localhost/test/auth

`401` and `WWW-Authenticate`.

With pass:

    curl u:p@localhost/test/auth
    curl -u u:p localhost/test/auth

of course, better using the `-u` option which could work also for different authentication methods.

#PHP

Interpreter language almost always run from a server to generate web content.

Dominates web today, but faces increasing concurrence `python/ruby/perl`.

Test:

    sudo service apache2 restart
    echo '<?php phpinfo(); ?>' | sudo tee /var/www/testphp.php
    firefox http://localhost/testphp.php &

If you see PHP specs, it works!
