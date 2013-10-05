HTTP is the protocol which browsers use to request pages from servers.

HTTP is part of the application layer.

Its default port is 80/tcp.

In general, it can be used to request just about anything from a server.

A major application is to request that a server send a webpage.

#sources

Best way to start: <http://www.jmarshall.com/easy/http/#structure>

#headers

##content-type

Specifies Internet media type

For huge list see: <http://en.wikipedia.org/wiki/Internet_media_type#Type_text>

Common examples:

- text/html: browsers interprets body as html and renders it
- text/plain: browser pastes to screen, no html rendering. So you will see tags like `<h1>` on screen.
- text/css
- application/pdf
- application/javascript

#status line

The first line of the response indicates the type of the response.

#status codes

All staus codes can be found here: <http://en.wikipedia.org/wiki/List_of_HTTP_status_codes>

Some of the more interesting ones are commented here.

##304

Not modified.

The browser used pressed the refresh key on an open page.
It would be a shame if the browser had to refecth the exact same page if it was not modified since it last loaded.
304 exists to avoid just that.

If the client already has an older version of the resource cached,
it can send in the request one of the fields `If-Modified-Since` or `If-Match`
conataining the date at which the resource was obtained.

The server sees if the resource has been updated since that date, and if not can return a 304.

This makes things faster for everyone: the server returns a small message quickly,
and the client quickly uses its cache.

##401

Server should include a `WWW-Authenticate` field specifying what kind of authentication is required.

Try this with:

    curl -I localhost/location/that/requires/auth

I get for example:

    WWW-Authenticate: Basic realm="AuthName value"

so the type is Basic

`AuthName value` is a any descriptive string
set by the server operators.
in Apache it is given by the `AuthName` directive

###401 vs 403

<http://stackoverflow.com/questions/3297048/403-forbidden-vs-401-unauthorized-http-responses>

#https

Assymetric key encryption between server and client.

Encrypts both body and headers.

Downside: encrypt/decrypt costs time.

Main usage: security critical operations such as password exchanges.

#http authentication

Authentication that is sent over the HTTP header.

##sources

<http://www.httpwatch.com/httpgallery/authentication/>

Comparison to form auth, nice diagrams: <http://docs.oracle.com/javaee/1.4/tutorial/doc/Security5.html>

great post: <http://stackoverflow.com/questions/549/the-definitive-guide-to-forms-based-website-authentication>

##downsides of http auth

Parameters are left to the browser:

- the appearance of the login page

- the time for which the user stays authenticated
    (time for which browser keeps resending `user:pass` automatically)

You might have seen this on a website in which your browser just opens up a weird looking window
and asks you for username / password.

therefore, you cannot cusomize them
and users will get different interfaces on different browsers, bad user interface consistency

For those reasons, form authentication is used on most large sites today.

##updside of http auth

Simple.

##basic authentication

Authentication is sent on the header *unencrypted*!

Example:

    curl -vu u:p google.com

You see the header line:

    Authorization: Basic dTpw
    ^^^^^ ^^^^
    1     2

where:

- 1: auth type
- 2: base 64 of u:p. not encryption!!

just checking:

    assert [ "`echo dTpw | base64 -d`" = "u:p" ]

###url convention

Many programs accept urls strings with user/pass included:

    curl -v u:p@google.com

This is however just a convention, since programs that accept it
parse the string to extract the `u:p` part, and then send it
on the header.

##digest authentication

Pretty cool concept

See: <http://en.wikipedia.org/wiki/Digest_access_authentication>

Authentication is sent on the header md5 hashed:

    curl --digest -vu u:p google.com

###why it works

data is appended to the authentication with `:` before hashing:

- domain (www.google.com)
- method (GET, POST, etc.)
- nonce
- nonce is sent to client from server.
- *nonces can only be used once per client*!!
- nonce prevents requests from being repeated with an old captured hashed string!
- also increases the difficulty of cracking each user/pass

This way, the unknown user and pass get mixed up with the extra data
in the hash and it is very hard to separate them.
and the nonce makes sure requests cannot be remade by resending the hash.

Merits:

- simpler than a full SSL

##ntml

Safer than digest: replay attacks impossible.

Requires server state, so http 1.1 only.

Little current support/usage.
