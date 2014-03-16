CLI utility that does several web protocols. More powerful than `wget`: only use `wget` for recursive mirroring

Not POSIX, and there is no POSIX 7 alternative: <http://stackoverflow.com/questions/9490872/is-wget-or-similar-programs-always-available-on-posix-systems>

Ubuntu install:

    sudo aptitude install -y curl

Make GET request, response body to stdout:

    curl amazon.com

#d

Make POST request:

    curl -Ld "q=asdf" $URL
    curl -L "google.com?q=asdf" $URL

##data-urlencode

Encode spaces and other signs for you:

    curl -d               "name=I%20am%20Ciro" $URL
    curl --data-urlencode "name=I am Ciro"     $URL

Resume download from where it stopped:

    curl -C - -O http://www.gnu.org/software/gettext/manual/gettext.html

#a-z range

    curl ftp://ftp.uk.debian.org/debian/pool/main/[a-z]/

#protocols

##FTP

Download:

    curl -u ftpuser:ftppass -O ftp://ftp_server/public_html/xss.php

Upload:

    curl -u ftpuser:ftppass -T myfile.txt ftp://ftp.testserver.com
    curl -u ftpuser:ftppass -T "{file1,file2}" ftp://ftp.testserver.com

##mail

Send mail:

    echo $'sent by curl!\n.' | curl --mail-from user@gmail.com --mail-rcpt user@gmail.com smtp://gmail.com

Body ends with a single dot '.' on a line.

##dict

    curl dict://dict.org/show:db #dictionnaries
    curl dict://dict.org/d:bash #general
    curl dict://dict.org/d:bash:foldoc #computing

`-v` , `--trace $FILE`, `--trace-ascii $FILE`: increasing levels of log verbosity:

    curl -Lv google.com

#L

Follows redirects.

Omits redirect page if any:

    curl google.pn
    curl -L google.pn

Good example if you are not one of the 100 people who live in Pitcairn island =). Google redirects you to your countries domain.

With `-v` you can see the full transaction:

    curl -vL google.pn

#u user:pass

Does Basic authentication.

`--digest` and `--ntlm` can be used together

If no `:pass`, will ask for pass on command line.

Examples:

    curl          -u user:pass site.with.basic.auth.com
    curl --digest -u user:pass site.with.digest.auth.com

#x

Specify proxy server:

    curl -x proxysever.test.com:3128

#z

Download iff the file was modified after given date time (sounds like crawlers!):

    curl -z 01-Jan-00 google.com

I assure you, it has changed since then =).

#i

Show received HTTP header received.

Example:

    curl -i google.com

#I

Make HTTP HEAD request:

    curl -I google.com

Implies `-i` of course.

#X

Make custom request:

    curl -X $'GET / HTTP/1.1\n\n' google.com
