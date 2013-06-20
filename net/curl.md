does several web protocols

only use wget for recursive mirroring

    sudo aptitude install -y curl

make GET request, reponse body to stdout:

    curl amazon.com

# -d

makes POST request

    curl -Ld "q=asdf" $URL
    curl -L "google.com?q=asdf" $URL

## --data-urlencode

encodes spaces and other signs for you:

    curl -d               "name=I%20am%20Ciro" $URL
    curl --data-urlencode "name=I am Ciro"     $URL

resume download from where it stopped

    curl -C - -O http://www.gnu.org/software/gettext/manual/gettext.html

# a-z range

example:

    curl ftp://ftp.uk.debian.org/debian/pool/main/[a-z]/

# protocols

## ftp

download:

    curl -u ftpuser:ftppass -O ftp://ftp_server/public_html/xss.php

upload:

    curl -u ftpuser:ftppass -T myfile.txt ftp://ftp.testserver.com
    curl -u ftpuser:ftppass -T "{file1,file2}" ftp://ftp.testserver.com

## mail

send mail:

    echo $'sent by curl!\n.' | curl --mail-from user@gmail.com --mail-rcpt user@gmail.com smtp://gmail.com

body ends with a single dot '.' on a line

## dict

    curl dict://dict.org/show:db #dictionnaries
    curl dict://dict.org/d:bash #general
    curl dict://dict.org/d:bash:foldoc #computing

-v , --trace $FILE, --trace-ascii $FILE: increasing levels of output showing

    curl -Lv google.com

# -L

follows redirects

ommits redirect page if any:

    curl google.pn
    curl -L google.pn

good example if you are not one of the 100 people who live in Pitcairn island.
google redirects you to your country domain.

with `-v` you can see the full transaction:

    curl -vL google.pn

# -u user:pass

does <#basic authentication>

`--digest` and `--ntlm` can be used together

if no `:pass`, will ask for pass on command line.

examples:

    curl          -u user:pass site.with.basic.auth.com
    curl --digest -u user:pass site.with.digest.auth.com

# -x

specifies proxy server

example:

    curl -x proxysever.test.com:3128

# -z

download iff it is modified after given date time (sounds like crawlers!)

example:

    curl -z 01-Jan-00 google.com

I assure you, it has changed since then =).

# -i

show received http header received. see: <#http>

example:

    curl -i google.com

# -I

make http HEAD request. see: <#http>

implies `-i` of course

example:

    curl -I google.com

# -X

make custom request

example:
    curl -X $'GET / HTTP/1.1\n\n' google.com

