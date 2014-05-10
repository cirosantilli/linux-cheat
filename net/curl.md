CLI utility that does several web protocols, including HTTP, FTP, SMTP, DICT.

More powerful than `wget`: only use `wget` for recursive mirroring.

Not POSIX, and there is no POSIX 7 alternative: <http://stackoverflow.com/questions/9490872/is-wget-or-similar-programs-always-available-on-posix-systems>.

Ubuntu install:

    sudo aptitude install -y curl

#Basic usage

Make a `GET / HTTP/1.1` request to Google, wait for response, and print response:

    curl google.com

#Test cURL

cURL does not have a dry-run option built-in: <http://stackoverflow.com/questions/6180162/echo-curl-request-header-body-without-sending-it/6180363#6180363>

There are however a few options to visualize what it is doing:

-   `-v` and other verbosity options.
-   using `nc -l` and curl `-m 1`:

        nc -l localhost 8000 &
        curl -m 1 localhost:8000

#v

#trace

#trace-ascii

`-v` , `--trace "$FILE"`, `--trace-ascii "$FILE"`: increasing levels of log verbosity.

`-` to stdout.

Print all data IO and curl status:

    curl --trace - "$URL"

Good way to see what is going on.

    curl -Lv google.com

#m

#max-time

Timeout for entire operation.

#L

Follow redirects.

Omit redirect page if any.

Example:

    curl google.pn
    curl -L google.pn

Good example if you are not one of the 100 people who live in Pitcairn island =): Google redirects you to your countries domain.

With `-v` you can see the full transaction:

    curl -vL google.pn

#HTTP

##POST

##d

Make POST request:

    curl -d "a=1" "$URL"

Data from stdin with `-d @-`:

    echo 'a=1' | curl -d @- "$URL"

Multiple data are joined by an ampersand `&`:

    curl -d 'a=1' -d 'b=2' "$URL"

##form

##F

Multipart POST request like done from an HTML form by a browser:

    echo "Content of a.txt" > a.txt
    curl -F "key1=val1" -F "file1=@a.txt" "$URL"

##H

##header

Custom header.

Overrides default cURL headers.

    curl -d '{"a":"b"}' -H "Content-Type:application/json" "$URL"

##i

Show received HTTP header received.

Example:

    curl -i google.com

##I

Make HTTP HEAD request:

    curl -I google.com

Implies `-i` of course.

##X

Use custom HTTP method:

    curl -X 'GET' google.com

Many methods have an specific option for them.

##data-urlencode

Encode spaces and other signs for you:

    curl -d               "name=I%20am%20Ciro" $URL
    curl --data-urlencode "name=I am Ciro"     $URL

#a-z range

    curl ftp://ftp.uk.debian.org/debian/pool/main/[a-z]/

#FTP

Download:

    curl -u ftpuser:ftppass -O ftp://ftp_server/public_html/xss.php

Upload:

    curl -u ftpuser:ftppass -T myfile.txt ftp://ftp.testserver.com
    curl -u ftpuser:ftppass -T "{file1,file2}" ftp://ftp.testserver.com

#email

#SMTP

Send email:

    echo $'sent by curl!\n.' | curl --mail-from user@gmail.com --mail-rcpt user@gmail.com smtp://gmail.com

Body ends with a single dot `.` on a line.

#DICT

    curl dict://dict.org/show:db #dictionnaries
    curl dict://dict.org/d:bash #general
    curl dict://dict.org/d:bash:foldoc #computing

#Basic authentication

#u

Does Basic authentication.

`--digest` and `--ntlm` can be used together.

If no `:pass`, will ask for pass on command line.

Examples:

    curl          -u user:pass site.with.basic.auth.com
    curl --digest -u user:pass site.with.digest.auth.com

#x

Specify proxy server:

    curl -x proxysever.test.com:3128

#z

Download iff the file was modified after given date time:

    curl -z 01-Jan-00 google.com
