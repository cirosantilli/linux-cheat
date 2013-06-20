cheat on the apache server

test apache:

    firefox http://localhost/ &

# intro

apache is a web server

a web server listens to a port (default 80) for strings

theses strings are http requests

then it takes the http request, processes it, and then returns the request to the client

part of the processing may be passed to another program: typically a <#cgi> script

# test preparations

before doing anything, make this test dir:

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

finally move our test dir to the serve root:

    sudo mv test /var/www/

the default root for serving files is specified in the <#conf file>
by the `DocumentRoot` directive. In current ubuntu, it is `/var/www/`

the user under which the web server runs must have read access to this directory.

usually this user is a different user from `root` for sercurity.

# minimum conf file

the bare minimum is:

    Listen 80
    User www-data
    Group www-data
    ErrorLog /var/log/apache2/error.log

this way you can really learn what is going on!

# default operation

"web subdirs" map directly to local dirs

ubuntu default is currently `/var/www/`

open file /var/www/test/index.html:

    firefox localhost/test/index.html

going to a dir on the web browser opens the contained index.html file by default:

    firefox localhost/test/

this can be configured with the <#DirectoryIndex> directive

if no index is contained, apache generates an html index:

    firefox localhost/test/noindex/

# conf file

configurations only apply when you restart apache:

    sudo service apache2 restart

move our test dir to the serve root:

    sudo mv test /var/www/root

ubuntu default location:

    sudo vim /etc/apache2/apache2.conf

## DocumentRoot

set apache serve root at given dir:

    DocumentRoot "/var/www/root"

for this ot work, make sure `DocumentRoot` is not set anywhere else.
(by default it was included in the include files, `grep -r DocumenRoot` shows where)

for security concerns, only put things you want apache to serve directly inside DocumentRoot
such as html, css and images.

stuff that users should not see such as cgi scripts and *gasp* ssl certificates
are better to remain outside it, so that you don't serve them by mistake!

## Listen

listen those ports on all interfaces (for example, first wireless card, first ethernet card, etc...):

    Listen 80
    Listen 8000

this configuration is mandatory

listen those ports on given interfaces:

    Listen 192.0.2.1:80
    Listen 192.0.2.5:8000

access filename:

    AccessFileName .htaccess

allow overwride:

    TODO

include other files or entire dirs:

    Include file.conf
    Include conf-d

deny access from host

    Deny from 10.252.46.165
    Deny from host.example.com

## DirectoryIndex

what to do when user acesses a directory location:

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

### mod_autoindex

generates automatic html listings for dirs

turn off automatic listings for a given dir:

    <Directory /var/www/root/test/dontlist>
    Options -Indexes
    </Directory>

will simply give a not found

ignore certain files in the listing:

    IndexIgnore tmp* ..

add headers/footers before/after index:

    HeaderName header.html
    ReadmeName footer.html

same header/footer for every dir

    HeaderName header.html
    HeaderName /site/header.html
    ReadmeName /site/footer.html

use predefined styles:

    IndexOptions FancyIndexing HTMLTable

use given css style:

    IndexStyleSheet /css/autoindex.css

# sections

## sources

official manual: <http://httpd.apache.org/docs/2.2/sections.html#mergin>

## Files

acts on local filesystem

deny file permissions for files that match regex "^\.ht":

    <Files ~ "^\.ht">
    Order allow,deny
    Deny from all
    Satisfy all
    </Files>

Order says: first process all allow directives, then all deny directives.
since deny came last, it has precedence.

## Directory

acts on local filesystem

    <Directory /var/web/dir1>
    Options +Indexes
    </Directory>

## combine

    <Directory /var/web/dir1>
    <Files private.html>
    Order allow,deny
    Deny from all
    </Files>
    </Directory>

## Location

acts on webspace

    <LocationMatch ^/private>
    Order Allow,Deny
    Deny from all
    </LocationMatch>

## IfDefine

    <IfDefine ClosedForNow>
    Redirect / http://otherserver.example.com/
    </IfDefine>

## IfVersion

    <IfVersion >= 2.1>
    this happens only in versions greater or
    equal 2.1.0.
    </IfVersion>

# alias

you can create virtual paths to dirs and files

## sources

man: <http://httpd.apache.org/docs/2.2/mod/mod_alias.html>

create virtual directory:

    Alias /test/alias /var/www/test

    firefox localhost/test/alias &

also works for subdirs:

    firefox localhost/test/alias/a.html &
    firefox localhost/test/alias/a      &

also works for files:

    Alias /testfile/ /var/www/test/index.html

    firefox localhost/testfile &

also works outside of serve root:

    cd
    echo "TEST" > index.html

    Alias /test/alias-out-root/ /home/ciro/

    firefox localhost/test/alias-out-root

## first match takes precedence

    Alias /test/alias/a /var/www/test
    Alias /test/alias   /var/www/test

    firefox localhost/test/alias/  &

goes to `test/index.html`

    firefox localhost/test/alias/a &

goes to `test/a/index.html`

BAD: both go to test/index.html:

    Alias /test/alias   /var/www/test
    Alias /test/alias/a /var/www/test

    firefox localhost/test/alias/  &
    firefox localhost/test/alias/a &

## Redirect

precedence over aliases

    Alias /test/redir /test
    Redirect /test/redir http://www.google.com
    firefox localhost/test/redir &
goes to google

## cgi

### requires

<#http>

**cgi** is a protocol of how a server communicates with a cgi script

a cgi script is simply a script/executable that outputs the part of http response

this part includes some last header lines which the server delegates to it,
notably `content type`, followed by "\n\n" followed by the entire body.

the server passes information to the script through environment variables only.

### fastcgi

a faster version of cgi that does not start a new process pre request

implementations: mod_fastcgi vs mod_fcgid
<http://superuser.com/questions/228173/whats-the-difference-between-mod-fastcgi-and-mod-fcgid>

install mod_fastcgi:
    sudo aptitude install -y libapache2-mod-fastcgi

### ScriptAlias

the script:

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

#### status

optional, if not given suposes `200 OK`.

if given as error, server will simply give the error and no data.

uncomment the status line on the test script to see what happens.

#### alias to dir

cgi scripts must be in the dir specified by script alias:

    ScriptAlias /mycgi /usr/lib/cgi-bin

same as:

    Alias /mycgi /usr/lib/cgi-bin
    <Location /mycti >

tell server that all files inside this dir are cgi scripts:

    SetHandler cgi-script

tell server that all .pl and .py files in dire are cgi scripts:

    AddHandler cgi-script .cgi .pl

permit cgi execution for scripts in this dir:

    Options +ExecCGI
    </Location>

run it:

    firefox localhost/mycgi/test.pl

note how `ScriptAlias` created a virtual directory
not present in the actual filesystem.

can also make individual script:

    ScriptAlias /test/cgi-file /usr/lib/cgi-bin/test.pl

#### alias to script

all subdirs of testpl are generated by the given test.pl:

    ScriptAlias /test/testpl /usr/lib/cgi-bin/test.pl

    firefox localhost/testpl/       &
    firefox localhost/testpl/a.html &

### action

run script whenever an html file is accessed:

    Action test /cgi-bin/test.pl
    AddHandler test .html

TODO: i get `Action` directive undefined... solve this.

try it:

    firefox localhost/index.html

this is how php does it!

# modules

apache plugins are called modules

modules are compiled `.so` files

modules may define new directives

for modules to become effective they must be loaded in the config file

only do certain commands if module is exists:

    <IfModule mod_fastcgi.c>
    commands...
    </IfModule>

load a module:

    LoadModule fastcgi_module /usr/lib/apache2/modules/mod_fastcgi.so
    1              2

- 1: module identifier hard coded in module?
- 2: full path to .so

# handlers

part of the very default mime_module

determines filetypes and sets default actions accordingly

example:

    Action add-footer /cgi-bin/footer.pl
    AddHandler add-footer .html

- Action: defines a handler called add-footer
- AddHandler: uses the handler called add-footer for all html files

handlers can be defined in modules

# authentication

you must chose *both* one <#method> and one <#provider>!

## methods

### prerequisites

first understand http authentication.

what algorithm is used to store the passwords more or less safely.

### basic authentication

provided by `mod_auth_basic`

apache conf:

    LoadModule auth_basic_module /usr/lib/apache2/modules/mod_auth_basic.so
    <Directory "/var/www/test/auth/">
    AuthType Basic
    AuthName "private dir"
    AuthBasicProvider file
    AuthUserFile /var/.htpasswd
    Require valid-user
    AllowOverride None
    </Directory>

### digest

provided by `mod_auth_digest`

mod_auth_digest is better than mod_auth_basic, so use digest!

    LoadModule auth_digest_module /usr/lib/apache2/modules/mod_auth_digest.so
    <Directory "/var/www/test/auth/">
    AuthType Digest
    AuthName "private dir"
    AuthDigestProvider file
    AuthUserFile /var/.htpasswd
    Require valid-user
    AllowOverride None
    </Directory>

## provider

what type of storage is used for user password pairs

is specified by the `AuthBasicProvider` directive.

### file

a plain text file

safer to put outside serve root

#### htpasswd

generates `.htpasswd` files

generate user/pass pairs:

    sudo htpasswd -bc /var/www/.htpasswd u p

- -c: creates new file, destroying old one! necessary first time!*
- -b: use pass from command line. *less safe!!*
    sudo htpasswd -b /var/www/.htpasswd u2 p

lets take a look at the file:

    sudo cat /var/www/.htpasswd

note that the passwords are base64 enoded. See <#base64>

### dbd

sql database

# try it out!!

test:

    firefox localhost/test/auth &

try u and u2 pass p!

## browser cache

    firefox localhost/test/auth &
    firefox localhost/test/auth &
the second time, you may not be prompted for a password!

this is because firefox has cached your password for some time
and resent it automatically! there is no server state.

to avoid the cache use curl:
    curl -I localhost/test/auth
401 and WWW-Authenticate.

with pass:
    curl u:p@localhost/test/auth
    curl -u u:p localhost/test/auth
of course, better using the `-u` option
which could work also for different authentication methods.

# php

interpreter language almost always run from a server to generate web content.

dominates web today, but faces increasing concurrence python/ruby/perl.

test:

    sudo service apache2 restart
    echo '<?php phpinfo(); ?>' | sudo tee /var/www/testphp.php
    firefox http://localhost/testphp.php &

if you see php specs, it works!
