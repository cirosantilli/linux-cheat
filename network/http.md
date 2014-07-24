HTTP is the protocol which browsers use to request pages from servers.

HTTP is part of the application layer.

The port is 80/TCP.

It is the main way that applications talk to servers.

HTTP does not find a server: it only determines exactly which characters must be passed to a server to get the data what one wants.

A major application is to request that a server send a web page. Such requests are made by browsers whenever you open a web page.

There are however many other applications outside browsers: any program can send an HTTP request. One important example are REST interfaces, which allows programs to talk to servers. One example of a REST interface is the GitHub API <https://developer.github.com/v3>, which allows programs to do anything that can be done through the browser on GitHub. This can be used to create applications that interact with GitHub's data such as third party analytics tools like <http://osrc.dfm.io/cirosantilli/>.

You can use the `nc` utility to both send and receive low level HTTP requests to understand what is going on.

#Standards

HTTP is specified by W3C.

There are currently two main versions HTTP/1.0 and HTTP/1.1 which is the most popular one today.

The HTTP/1.1 specification can be found at RFC 2616 <http://www.w3.org/Protocols/rfc2616/rfc2616.html> (1999).

Some modifications have since been made through other RFCs:

- PATCH method <https://tools.ietf.org/html/rfc5789>
- `multipart/form-data` `content-type` <http://www.ietf.org/rfc/rfc2388>

#Newlines

Every newline is a CRLF. Tools such as `curl` convert `\n` to `\r\n`.

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

- `GET`:     get information from server
- `HEAD`:    only get header information from server
- `POST`:    send data to server to create new objects. E.g.: you click on the submit button of an HTML `form` with `method="post"`.
- `PUT`:     update or create entire objects on server. Both PUT and POST can be used to create object, but `PUT` is *idempotent*: receiving multiple `PUT` requests is the same as receiving a single one.
- `DELETE`:  remove objects from server
- `TRACE`:
- `CONNECT`:

There are also proposed methods in other RFCs:

-   `PATCH` in RFC 5789 <https://tools.ietf.org/html/rfc5789>

    Update object on server.

    Vs `PUT`: only attributes of the objects which are sent are modified.

    In `PUT`, attributes not given are set to default values.

    In `PATCH`, attributes not given are not modified.

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

####3xx

Redirect to another page for a given reason.

All of those statuses require the `Location` header that indicates where to redirect to.

It is also common to offer an HTML redirect page in case the user agent does not follow redirects.
Most browsers do so by default, and don't ever show Moved pages.

    HTTP/1.1 301 Moved Permanently
    Location: http://www.example.org/
    Content-Type: text/html
    Content-Length: 174

    <html>
    <head>
    <title>Moved</title>
    </head>
    <body>
      <h1>Moved</h1>
      <p>This page has moved to <a href="http://www.example.org/">http://www.example.org/</a>.</p>
    </body>
    </html>

Good discussion on <http://stackoverflow.com/questions/4764297/difference-between-http-redirect-codes>

TODO what happens on circular redirects?

#####301

Permanent redirect: the page has been moved forever.

Next time, UAs can cache this redirect, and may not even bother sending a request to the first location.

Only works for `GET` requests.

TODO how to revert this if you change your mind later?
<http://getluky.net/2010/12/14/301-redirects-cannot-be-undon/>
suggests it is impossible.

#####302

Hell.

In the spec, exact same as 307.

In practice, implemented exactly as 303, even on 2014 browsers,
and nothing can be done to change that without breaking things.

Still the most common response promoted by 2014 web frameworks.
TODO why? Compatibility with HTTP 1.0 which does not have 303 and 307?

#####304

Not modified.

Application:

The user pressed the refresh key on an open browser page.

It would be wasteful to refecth the current page if it was not modified since it last fetched. `304` exists to avoid just that.

If the client already has an older version of the resource cached, it can send in the request one of the fields `If-Modified-Since` or `If-Match` containing the date at which the resource was obtained.

The server sees if the resource has been updated since that date, and if not can return a 304.

#####307

In the spec, exact same as 302.

Introduced in HTTP 1.1 with 303 because all browsers treat 302 as 303,
and nothing can be done to change it now.

This time we hope browsers will follow the spec.

####401

Server should include a `WWW-Authenticate` field specifying what kind of authentication is required.

Try this with:

    curl -I localhost/location/that/requires/auth

I get for example:

    WWW-Authenticate: Basic realm="AuthName value"

so the type is Basic

`AuthName value` is a any descriptive string set by the server operators. in Apache it is given by the `AuthName` directive

#####401 vs 403

<http://stackoverflow.com/questions/3297048/403-forbidden-vs-401-unauthorized-http-responses>

#Headers

Certain headers can only be used on requests, other only on responses, and a few on both.

Headers are case insensitive. A common style is to capitalize the first letter of each word.

##Request headers

###Host

Mandatory.

With `curl http://localhost:8000`:

    Host: localhost:8000

With `curl http://google.com`

    Host: google.com

###User-Agent

Description of the user agent that sent the request.

Request counterpart of `Server`.

Firefox 29:

    User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:29.0) Gecko/20100101 Firefox/29.0

Curl 7.22:

    User-Agent: curl/7.22.0 (i686-pc-linux-gnu) libcurl/7.22.0 OpenSSL/1.0.1 zlib/1.2.3.4 libidn/1.23 librtmp/2.3

###Accept

A comma separated list of MIME type that the client wants as a response.

Specified on the response by the `Content-Type` header.

It is possible that a single URL is able to return several types.

In this case this field can be used by the server to determine the type to serve.

Firefox 29:

    Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8

The `q=` are the quality factors, that indicate the level of preference for each listed media type: <http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.1>

###Accept-Language

Comma separated list of accepted `Content-Language` for the response.

Firefox 29:

    Accept-Language: en-US,en;q=0.5

###Accept-Encoding

Comma separated list of accepted `Content-Encoding` for the response.

Firefox 29:

    Accept-Encoding: gzip, deflate

###Connection

`keep-alive`: TODO

##Response headers

###Content-Type

The MIME type of the data being sent on the body.

Large list with simple explanations: <http://en.wikipedia.org/wiki/Internet_media_type#Type_text>

-   `text/html`: HTML document. Browsers interpret body as HTML and renders it.

-   `application/xhtml+xml`: XHTML.

-   `text/plain`: browser pastes to screen, no HTML rendering. So you will see tags like `<h1>` on screen.

-   `application/x-www-form-urlencoded`: key value pairs in the same format that can be given on an URL.

    The default `content-type` for `method="post"` on HTML forms.

    The `content-type` can be modified via the `enctype` `form` attribute.

-   `application/json`: popular choice for rest APIs. Used on the GitHub API.

-   `text/css`

-   `application/pdf`

-   `application/javascript`

###Content-Length

Length of the body in bytes.

Very important when body is present because it allows the receiver to allocate memory at once.

TODO mandatory if body is present?

###Content-Encoding

Must be one of the request `Accept-Encoding` values.

-   `gzip`: the content was gzipped before sending it to the browser.

    Supported by almost all modern browsers: Firefox sends it by default, Apache has `mod_gzip` which gzips everything when possible.

###Content-Disposition

Suggests to the browser what to do to certain types of data, specially content types different from HTML:

`attachment` suggest to the browser to download the file with given filename:

    Content-Disposition: attachment; filename=genome.jpeg;

`inline` suggest to the browser to show the content inline if it has that capability:

    Content-Disposition: inline

In Firefox, the browser preferences under `Edit > Preferences > Application` determine what to do for each MIME type, and overrirides this header.

###Server

Software that sent the response.

- `google.com`: `gws`. Google Web Server, closed source.
- `twitter.com`: `tfe`

Not mandatory: Facebook does not return it.

###multipart/form-data

Specified at RFC 2388 <http://www.ietf.org/rfc/rfc2388>.

Encapsulates multiple header / body pairs into one body HTTP body.

Advantage of `multipart/form-data`:

-   Huge memory savings for binary files, in which:

    - many bytes would have to be URL encoded for `application/x-www-form-urlencoded` (3 bytes per encoded byte).

    - the size would be 33% larger with `application/x-www-form-urlencoded` + `base64` encode.

Disadvantages of `multipart/form-data`:

-   Each field has a data overhead for the boundary and the sub headers.

    This is easily overcome by memory gains of using it if there is a file.

Therefore: use it iff upload of a binary file is possible on the request.

Sample request: <http://stackoverflow.com/a/23518189/895245>

####boundary

This is the only type of request does not have an empty line after the headers: `boundary` comes directly.

`boundary` specifies a sequence of bytes which separates each of the bodies.

The boundary is always surrounded by CRLFs which are not part of the data.

The boundary cannot appear inside the data: the user agent must chose it appropriately.

The trailing hyphens of the boundary are often added for partial backward compatibility with older multipart RFCs, and to improve readability. TODO are they mandatory?

##CORS headers

The following headers are used for CORS requests:

###Origin

###Access-Control-Allow-Origin: http://api.bob.com

###Access-Control-Allow-Credentials: true

###Access-Control-Expose-Headers: FooBar

##Custom headers

<http://stackoverflow.com/questions/3561381/custom-http-headers-naming-conventions>

In the past, prefix by `X-`.

After 2012: cross your fingers and pick a name.

#Body

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

##CSRF

##Cross site request forgery

The attacker Bob posts on a website:

    http://bank.com?transfer-ammount=10000&to=bob

Alice clicks on the disguised link, her browser sends the authentication cookies,
authenticates and makes the request.

How to prevent it:
<https://www.owasp.org/index.php/Cross-Site_Request_Forgery_%28CSRF%29_Prevention_Cheat_Sheet>

###Synchronizer Token Pattern.

The most popular prevention mechanism.

Send extra randomly generated data with valid forms.

Generation can be per session or per form, which is more secure but less efficient
and may have usability impact.

The method relies on the same origin policy:
if it did not exist the attacker would be able to obtain the token.

This method is implemented by default in most web frameworks,
either by adding a hidden form field (Django) or `meta` elements like Rails:

    <meta content="authenticity_token" name="csrf-param" />
    <meta content="asdfqwerASDFQWER12345678" name="csrf-token" />

###Reauthenticate

Ask user for password again before critical operations.

Used in all online banking systems.

Inconvenient for users since an extra action is required before an authentic request.

#Sources

Good intro tutorial: <http://www.jmarshall.com/easy/http/#structure>
