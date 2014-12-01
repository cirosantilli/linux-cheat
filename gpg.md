#GPG

GNU Private Guard encryption.

Encrypt data and verify identities through algorithms sch as RSA.

Interface based on the 1991 commercial Pretty Good Privacy (PGP). The interface has been open sourced as `OpenPGP`.

##Sources

- <https://alexcabal.com/creating-the-perfect-gpg-keypair/>
- <http://www.spywarewarrior.com/uiuc/gpg/gpg-com-4.htm>
- <http://www.madboa.com/geek/gpg-quickstart/>
- <https://help.ubuntu.com/community/GnuPrivacyGuardHowto>

##Test preparation

    F=a
    echo a > "$F"

##Encryption without keys

Encryption and digital signing.

Create a `"$F".gpg` password only encrypted file:

    gpg -c "$F"

Good combo with `tar.gz`.

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

##tar combos

`tar.gz` encrypt `"$F"` to `F.tgz.gpg`, remove original:

    E=tgz.gpg
    tar cz "$F" | gpg -o "$F"."$E" -c && rm -rf "$F"

`tar.gz` decrypt `"$F"`

    gpg -d "$F" | tar xz && rm "$F"

##Encryption with keys

You have to understand the very basics of asymmetric encryption such as RSA before reading this.

Generate pub/private pair:

    gpg --gen-key

You will be prompted for the key configuration.

###User id

UID can either be any case insensitive substring of the key name or email that only one user has:

    U="me"
    U="me@mail.com"

If you enter your name and email at key creation time, your email servers as UID.

###Key id

Is an identifier of the key:

    K=12345678

To get it, use:

    gpg --list-keys

TODO: how is it calculated this id?

###Files

Stored under `~/gnupg/`:

- `secring.gpg`: private keys. **NEVER SHARE THIS FILE**.
- `pubring.gpg`: public keys. This is what you will share with others.
- `trustdb.gpg`: keys that you trust.

`.asc` extension is used for ASCII key files.

Each key file (`.asc` or `.gpg`) may contain many keys.

###list-keys

List pub keys which you trust:

    gpg --list-keys

Sample output:


    gpg: checking the trustdb
    gpg: 3 marginal(s) needed, 1 complete(s) needed, PGP trust model
    gpg: depth: 0  valid:   1  signed:   0  trust: 0-, 0q, 0n, 0m, 0f, 1u
    /home/you/.gnupg/pubring.gpg
    -----------------------------
    pub   1234R/12345678 2000-01-01
    uid                  Your Name <you@mail.com>
    sub   1234R/87654321 2000-01-01

Meaning of fields: TODO

- `pub`: public key.
- `sub`: subkey for corresponding public key.
- `12345678`: key id, `name` in the manual
- `1234R`: TODO

###edit-key

Add extra information to keys:

    gpg --edit-key you@mail.com

This opens up a REPL interface.

Add a picture to your key:

    addphoto

Should be a very small (32x32) JPEG.

Now `--list-keys` says:

    pub   1234R/12345678 2000-01-01
    uid                  Your Name <you@mail.com>
    uid                  [jpeg image of size 783]
    sub   1234R/87654321 2000-01-01


---

Add pubkey to the trust list:

    gpg --import

Remove public key:

    gpg --delete-key $K

If you have they corresponding private key, GPG will require you to delete the private first:

    gpg --delete-secret-keys $K


###fingerprint

Same as `list-keys`, but also show key fingerprints.

Fingerprints are hashes of keys, used to identify them uniquely.

Sample output:

    /home/you/.gnupg/pubring.gpg
    -----------------------------
    pub   1234R/12345678 2000-01-01
        Key fingerprint = AAAA AAAA AAAA AAAA AAAA  AAAA AAAA AAAA AAAA AAAA
    uid                  user <email>
    sub   1234R/87654321 2000-01-01

###subkey

There can be multiple subkeys per pub key.

Application: <http://blog.dest-unreach.be/wp-content/uploads/2009/04/pgp-subkeys.html>

TODO

###Encrypt and decrypt

Create a `"$F".gpg` pubkey encrypted file:

    gpg -r "$U" -e "$F"

Only the person who knows the corresponding private key will be able to decrypt it.

Decrypt file for which you own the private key:

    gpg -o "$F".out -e "$F"

###Verify file

Create a `"$F"` verification file:

    gpg -ab "$F"

Verify file with its verification file:

    gpg --verify "$F".asc "$F"

Only works of course if the key is in you keyring.

###clearsign

Analogous to signing a document, scanning and uploading it:

- you assert that you have read it and agree to its terms
- anyone can see the document

Usage:

    gpg --clearsign UbuntuCodeofConduct-2.0.txt
    cat UbuntuCodeofConduct-2.0.txt.asc

Sample output:


    -----BEGIN PGP SIGNED MESSAGE-----
    Hash: SHA1

    <THE MESSAGE>
    -----BEGIN PGP SIGNATURE-----
    Version: GnuPG v1.4.11 (GNU/Linux)

    <BASE64 signature data>
    -----END PGP SIGNATURE-----

##Publish you pubkey

So that others can:

- encrypt stuff so that you can read it.
- verify you are the creator of files.

As binary:

    gpg -o a.gpg --export "$U"

This could be sent on an email attachment.

As ASCII:

    gpg -a -o a.gpg --export "$U"

This could be sent on an email body or as an attachment.

View keys in a key file (`.asc` or `.gpg`):

    gpg a.gpg

###keyserver

The best method to publish your pubkey. People only have to know your keyserver, and they can look for your key themselves.

Of course, nothing prevents you from signing as `Bill Gates`, and then you need some way to prove that that is your real identity.

Well known servers:

    S="http://pgp.mit.edu/"
    S="https://keyserver.pgp.com/"
    S="hkp://keyserver.ubuntu.com"

You don't even need to create an account there to add your key:

    gpg  --keyserver "$S" --send-keys "$K"

You need to use the key id, not the user id, since one user can have many keys.

Search for someone's key on a server:

    gpg --search-keys "$U" --keyserver "$S"

TODO not working

##hkp protocol

HTTP Keyserver Protocol (HKP), used for example to publish keys.
