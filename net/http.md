HTTP is the protocol which browsers use to request pages from servers.

HTTP is part of the application layer.

The port is 80/TCP.

It is the main way that applications talk to servers.

HTTP does not find a server: it only determines exactly which characters must be passed to a server to get the data what one wants.

A major application is to request that a server send a web page. Such requests are made by browsers whenever you open a web page.

There are however many other applications outside browsers: any program can send an HTTP request. One important example are REST interfaces, which allows programs to talk to servers. One example of a REST interface is the GitHub API <https://developer.github.com/v3>, which allows programs to do anything that can be done through the browser on GitHub. This can be used to create applications that interact with GitHub's data such as third party analytics tools like <http://osrc.dfm.io/cirosantilli/>.

#Standards

HTTP is specified by W3C.

There are currently two main versions HTTP/1.0 and HTTP/1.1 which is the most popular one today.

The HTTP/1.1 specification can be found at RFC 2616 <http://www.w3.org/Protocols/rfc2616/rfc2616.html> (1999).

Some modifications have since been made through other RFCs:

- PATCH method <https://tools.ietf.org/html/rfc5789>

#Request and response

A sample GET request that a browser can send to a server looks like:

    TODO

A sample POST request that a browser can send to a server looks like:

    TODO

#First line

The first line is different for requests and responses.

##Initial request line

An initial request line looks something like:

    GET /path/to/file.html HTTP/1.0
    1   2                  3

Or:

    POST /path/to/resource HTTP/1.1
    1    2                 3

Where:

1. method
2. path
3. HTTP version

##Initial response line

###Method

Determines in general terms what the request is about.

RFC 2616 specifies the following methods:

- `GET`:    get information from server
- `HEAD`:   only get header information from server
- `POST`:   send data to server to create new objects
- `PUT`:    update entire objects on server
- `DELETE`: remove objects from server
- `TRACE`:
- `CONNECT`:

There are also proposed methods in other RFCs:

-   `PATCH` in RFC 5789 <https://tools.ietf.org/html/rfc5789>

    Update object on server.

    Vs `PUT`: only attributes of the objects which are sent are modified.

    In `PUT`, attributes not given assume default values.

##Status line

An initial response line looks something like:

    HTTP/1.0 200 OK
    1        2   3

Or:

    HTTP/1.1 404 Not Found
    1        2   3


where:

1. HTTP version
2. status code
3. status code name. There is only one possible name for every status code.

###Status code

All status codes can be found here: <http://en.wikipedia.org/wiki/List_of_HTTP_status_codes>

Some of the more interesting ones are commented here.

###304

Not modified.

The browser used pressed the refresh key on an open page.

It would be a shame if the browser had to refecth the exact same page if it was not modified since it last loaded. 304 exists to avoid just that.

If the client already has an older version of the resource cached, it can send in the request one of the fields `If-Modified-Since` or `If-Match` containing the date at which the resource was obtained.

The server sees if the resource has been updated since that date, and if not can return a 304.

This makes things faster for everyone: the server returns a small message quickly, and the client quickly uses its cache.

###401

Server should include a `WWW-Authenticate` field specifying what kind of authentication is required.

Try this with:

    curl -I localhost/location/that/requires/auth

I get for example:

    WWW-Authenticate: Basic realm="AuthName value"

so the type is Basic

`AuthName value` is a any descriptive string set by the server operators. in Apache it is given by the `AuthName` directive

####401 vs 403

<http://stackoverflow.com/questions/3297048/403-forbidden-vs-401-unauthorized-http-responses>

#Headers

##accept-type

The MIME type that the client wants.

It is possible that a single URL is able to return several types.

In this case this field can be used to determine the requested type.

##content-type

Specifies Internet media type (aka MIME type).

For huge list see: <http://en.wikipedia.org/wiki/Internet_media_type#Type_text>

- `text/html`: browsers interprets body as html and renders it
- `text/plain`: browser pastes to screen, no html rendering. So you will see tags like `<h1>` on screen.
- `text/css`
- `application/pdf`
- `application/javascript`

#HTTPS

Asymmetric key encryption between server and client.

Encrypts both body and headers.

Downside: encrypt/decrypt costs time.

Main usage: security critical operations such as password exchanges.

#HTTP authentication

Authentication that is sent over the HTTP header.

##Sources

<http://www.httpwatch.com/httpgallery/authentication/>

Comparison to form auth, nice diagrams: <http://docs.oracle.com/javaee/1.4/tutorial/doc/Security5.html>

great post: <http://stackoverflow.com/questions/549/the-definitive-guide-to-forms-based-website-authentication>

##Downsides of HTTP auth

Parameters are left to the browser:

- the appearance of the login page
- the time for which the user stays authenticated (time for which browser keeps resending `user:pass` automatically).

You might have seen this on a website in which your browser just opens up a weird looking window and asks you for username / password.

Therefore, you cannot customize them and users will get different interfaces on different browsers, bad user interface consistency.

For those reasons, form authentication is used on most large sites today.

##Updside of HTTP auth

Simple.

##Basic authentication

Authentication is sent on the header *unencrypted*!

Example:

    curl -vu u:p google.com

You see the header line:

    Authorization: Basic dTpw
    ^^^^^ ^^^^
    1     2

where:

- 1: authentication type
- 2: base 64 of u:p. not encryption!

Just checking:

    assert [ "`echo dTpw | base64 -d`" = "u:p" ]

###URL convention

Many programs accept URLs strings with user/pass included:

    curl -v u:p@google.com

This is however just a convention, since programs that accept it
parse the string to extract the `u:p` part, and then send it
on the header.

##Digest authentication

Pretty cool concept

See: <http://en.wikipedia.org/wiki/Digest_access_authentication>

Authentication is sent on the header md5 hashed:

    curl --digest -vu u:p google.com

###Why it works

Data is appended to the authentication with `:` before hashing:

- domain (<www.google.com>)
- method (GET, POST, etc.)
- nonce
- nonce is sent to client from server.
- *nonces can only be used once per client*!!
- nonce prevents requests from being repeated with an old captured hashed string!
- also increases the difficulty of cracking each user/pass

This way, the unknown user and pass get mixed up with the extra data in the hash and it is very hard to separate them. and the nonce makes sure requests cannot be remade by resending the hash.

Merits:

- simpler than a full SSL

##NTML

Safer than digest: replay attacks impossible.

Requires server state, so HTTP 1.1 only.

Little current support/usage.

#Sources

Good intro tutorial: <http://www.jmarshall.com/easy/http/#structure>
