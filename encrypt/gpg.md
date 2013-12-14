GNU private guard encryption.

#sources

- good tut: <http://www.spywarewarrior.com/uiuc/gpg/gpg-com-4.htm>
- good tut: <http://www.madboa.com/geek/gpg-quickstart/>
- <https://help.ubuntu.com/community/GnuPrivacyGuardHowto>

#test preparation

    F=a
    echo a > "$F"

#encryption without keys

Encryption and digital signing.

Create a "$F".gpg password only encrypted file:

    gpg -c "$F"

Good combo with tar.gz.

Create from stdin:

    cat "$F" | gpg -o "$F".gpg -c

Decrypt to F:

    gpg "$F".gpg

Decrypt to stdout:

    gpg -d "$F".gpg

Decrypts to F:

    gpg -o "$F" -d "$F".gpg

Decrypt from stdin:

    cat "$F".gpg | gpg -o "$F" -d

#tar combos

Targz encrypt `"$F"` to `F.tgz.gpg`, remove original:

    E=tgz.gpg
    tar cz "$F" | gpg -o "$F"."$E" -c && rm -rf "$F"

targz decrypt `"$F"`

    gpg -d "$F" | tar xz && rm "$F"

#encryption with keys

You have to understand the very basics of assymetric encryption
such as RSA before reading this.

##user id

UID can either be any case insensitive substring of the key name or email
that only one user has:

    U="me@mail.com"
    U="me"

##key id

Is an identifier of the key:

    K=12345678

To get it, use:

    gpg --list-keys

TODO: how is it calculated this id?

##files

private keys is kept under `~/.gnupg/secring.gpg`. **NEVER SHARE THIS FILE**

public  keys that you trust are kept under `~/.gnupg/secring.gpg`.

the keys here are called keyring

`.asc` extension is used for ascii key files

each key file (`.asc` or `.gpg` may contain many keys)

##genarate pub/private pair

    gpg --gen-key

##manage keys

list pub keys which you trust

    gpg --list-keys

sample output:

    pub   1234R/12345678 2000-01-01
    uid                  user <mail>
    sub   1234R/87654321 2000-01-01

pub: public key
sub: corresponding private pair
`12345678`: key id
`1234R`: ???

add pubkey ot the trust list:

    gpg --import

##publicate you pubkey

- so that they can encrypt stuff so that you can read it.
- so that they can verify you are the creator of files.

as binary:

    gpg -o a.gpg --export "$U"

this could be sent on an email attachment.

as ascii:

    gpg -a -o a.gpg --export "$U"

this could be sent on an email body or as an attachment.

view keys in a key file (`.asc` or `.gpg`):

    gpg a.gpg

###keyserver

this is the best method, people only have to know your keyserver,
and they can look for your key themselves.

of course, nothing prevents you from signing as `Bill Gates`,
and then you need some way to prove that that is your real identigy..

well known servers:

    S="http://pgp.mit.edu/"
    S="https://keyserver.pgp.com/"

you don't even need to create an account there to add your key:

    gpg --send-keys "$K" --keyserver "$S"

note that you need to use the key id, not the user id!
since one user can have many keys.

search for someone's key on a server:

    gpg --search-keys "$U" --keyserver "$S"

TODO not working

##encrypt decrypt

finnally!

create a "$F".gpg pubkey encrypted file:

    gpg -r "$U" -e "$F"

only the person who knows the corresponding private key
will be able to decrypt it.

decrypt file for which you own the private key:

    gpg -o "$F".out -e "$F"

##verify file

prove that a file comes from who he claims to:

create a "$F" verification file:

    gpg -a -b "$F"

verify file with its verification file:

    gpg --verify "$F".asc "$F"

only works of course if the key is in you keyring.

