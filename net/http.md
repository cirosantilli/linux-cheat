http is the protocol which browsers use to request pages from servers.

in general, it can be used to request just about anything from a server.

#sources

best way to start: <http://www.jmarshall.com/easy/http/#structure>

#headers

##Content-type

specifies Internet media type

for huge list see: <http://en.wikipedia.org/wiki/Internet_media_type#Type_text>

common examples:

- text/html: browsers interprets body as html and renders it
- text/plain: browser pastes to screen, no html rendering. So you will see tags like `<h1>` on screen.
- text/css
- application/pdf
- application/javascript

#http authentication

##sources

goode one: <http://www.httpwatch.com/httpgallery/authentication/>
comparison to form auth, nice diagrams: <http://docs.oracle.com/javaee/1.4/tutorial/doc/Security5.html>

##form authentication

form authentication is the other form athentication

###sources

great post: <http://stackoverflow.com/questions/549/the-definitive-guide-to-forms-based-website-authentication>

###downsides of http

parameters are left to the browser. So for example:

- the appearance of the login page
- the time for which the user stays authenticated

(time for which browser keeps resending user:pass automatically)
therefore, you cannot cusomize them
and users will get different interfaces on different browsers, bad user interface consistency

###updside of http

simple.

for those reasons, form authentication is used on most large sites today.

##401

server should include a `WWW-Authenticate` field specifying what kind of authentication is required.

try this with:
    curl -I localhost/location/that/requires/auth

I get for example:

    WWW-Authenticate: Basic realm="AuthName value"

so the type is Basic

`AuthName value` is a any descriptive string
set by the server operators.
in Apache it is given by the `AuthName` directive

###401 vs 403

<http://stackoverflow.com/questions/3297048/403-forbidden-vs-401-unauthorized-http-responses>

##basic authentication

authentication is sent on the header *unencrypted*!

example:
    curl -vu u:p google.com

you see the header line:
    Authorization: Basic dTpw
    ^^^^^ ^^^^
    1     2
1: auth type
2: base 64 of u:p. not encryption!!

just checking:
    assert [ "`echo dTpw | base64 -d`" = "u:p" ]

###url convention

many programs accept urls strings with user/pass included:
    curl -v u:p@google.com

this is however just a convention, since programs that accept it
parse the string to extract the `u:p` part, and then send it
on the header.

##digest authentication

pretty cool concept

see: <http://en.wikipedia.org/wiki/Digest_access_authentication>

authentication is sent on the header md5 hashed

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

this way, the unknown user and pass get mixed up with the extra data
in the hash and it is very hard to separate them.
and the nonce makes sure requests cannot be remade by resending the hash.

merits:

- simples than a full ssl to authenticate

##ntml

safer than digest: replay attacks impossible.

requires server state, so http 1.1 only.

little current support/usage.

#https

assymetric key encryption between server and client.

encrypts both body and headers

downside: encrypt/decrypt costs time.

main usage: security critical operations such as authentication or payments.
