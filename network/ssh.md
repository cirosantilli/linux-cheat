Protocol like telnet, but encrypted

Predominant implementation: OpenSSH, open source.

For ssh to work you will need:

- a ssh server running on a machine.
- a ssh client running on another machine.

It is possible to do tests using `localhost` on a single machine.

Per user configurations for both the server and the client are contained under `~/.ssh`

#Server

Known as `sshd`, which stands for ssh daemon.

Must be installed and running on a machine for users from other computers to log into that machine.

The server part of ssh is called `sshd`.

Configuration:

    sudo cp  /etc/ssh/sshd_config{,.bak}
    sudo vim /etc/ssh/sshd_config

For the server to work, the following configuration is minimal:

    Host *                  #config for all hosts
    Port 22                 #open port 22
    AllowUsers user1 user2  #allow the given users

The server is often started as part of the `initrd` system.

Therefore, to get it running you will probably use:

    sudo service ssh start

and to stop it:

    sudo service ssh stop

and to check its status:

    sudo service ssh status

The default log file for the server is: `/var/log/auth.log`, which is shared by other utilities such as `sudo`. If things fail, that is where you should look! Try `sudo grep sshd /var/log/auth.log` for the relevant log lines.

#client

The client connects to a server to give shell access on the server.

Make sure that the configuration file is correct:

    sudo cp  /etc/ssh/ssh_config{,.bak}
    sudo vim /etc/ssh/ssh_config

Get the version of your ssh client:

    ssh -V

For local tests, use localhost and the current user:

    host=localhost
    user=`id -un`

Connect to hostname with your current username:

    ssh $host

Get debug level information if things don't work:

    ssh -v $host
    ssh -vv $host
    ssh -vvv $host

For this to work you need:

- your host (computer) is allowed. See ssh server.
- your user is allowed. See ssh server.
- your user exists as a regular user in the *server* computer. See `useradd`.

There are two main methods of connection:

-   using an authorized public RSA id, which does not require a password, unless your password is locally encrypted by a password, which is recommended.

    This method is used if the key is allowed.

-   using the same password as the user on the server has.

    This method is only used if there is not authorized key on the local machine.

Connect to hostname with the given username:

    ssh $user@$host

or:

    ssh -l $user $host

Choose port:

    p=22
    ssh -p $p $h

The default is 22 specified by IANA, so don't change it if you can avoid it.

It is *not* possible to set ports via the common URL syntax: `ssh host:22`.

#authorized_keys

For this method to work, the server must have your public RSA key authorized.

The default location for authorized keys is `~/.ssh/authorized_keys`. This location can be configured on the server.

This means that to login as user `u`, the file `/home/u/.ssh/authorized_keys` must contain your public key. With that you will only be able to login into the account of user `u`.

This file contains one public key per line, which may be preceded by some options, typically to restrict what the session can do, for example:

    from="ok.com",no-port-forwarding,no-X11-forwarding,
    no-agent-forwarding,no-pty ssh-rsa <key> <comment>

Non-obvious options above include:

- only connections coming from `ok.com` will be accepted

Options are documented with the server at `man sshd` since they are only used by the server.

*Never* put your private key there!

Next, your client will only connect to a server if its key is in known hosts. Security is useless if someone is impersonating the message receiver. If the server's public identity is not in the known hosts file, ssh will ask is you want to add it.

SSH is by default very fussy about the permissions of this file which should be:

    chmod 700 ~/.ssh
    chmod 600 ~/.ssh/authorized_keys

and not more permissive. If you really want that, you can do configure SSH to be less safe via `StrictModes no`.

#ssh-keygen

Generates public and private key pairs for use with ssh.

Generate an RSA public private pair:

    ssh-keygen -t rsa -C "you@email.com"

By default the keys are put under `~/.ssh` with names `id_rsa` for the private and `id_rsa.pub` and have length 1024 bits.

*Do* use a passphrase, otherwise anyone that gets his hand on your `id_rsa` file owns your identity.

*Never* share your private key! It is like a password that allows you to connect to servers.

There can be only one key per file.

The formats are for the public key:

    ssh-<type> <public-key> <comment>

For the private key:

    -----BEGIN RSA PRIVATE KEY-----
    <key>
    -----END RSA PRIVATE KEY-----

The actual data format a bit more involved. Discussion [here](http://stackoverflow.com/questions/12749858/rsa-public-key-format). Basically the data is Base64 encoded, and it also contains some necessary algorithm metadata.

Often used to determine if a key is present or not is the key's fingerprint, which are just hashes of the keys.

Fingerprints are often displayed on the following format:

    43:51:43:a1:b5:fc:8b:b7:0a:3a:a9:b1:0f:66:73:a8

with the colons added for only readability.

You can get the fingerprint or all the fingerprints present on a file via:

    ssh-keygen -lf ~/.ssh/id_rsa
    ssh-keygen -lf ~/.ssh/id_rsa.pub
    ssh-keygen -lf ~/.ssh/known_hosts

#Usage

Once you log in, it is as if you had a shell on the given ssh server computer!

You cannot copy files between computer with ssh directly, but you can use `scp` or `sftp` to do it.

Note how you appear on the who list:

    who

To close your connection:

    logout

or enter `CTRL-D`.

#GUI applications

It is possible to run X applications remotely, but it may be that the default configurations don't allow you to do that.

To allow X, make sure that the line:

    ForwardX11 yes

is present and uncommented on both client and server configuration files.

Now you can do:

    firefox

and it should work.

If you forget to let `ForwardX11 yes`, you would get errors like:

    Error: can't open display
    Error: display not specified

#scp

`cp` via SSH.

Get a file:

    p= #path to local file
    d= #destination directory
    u=
    h=
    scp $u@$h:$p $d

Send a file to server:

    scp $p $u@$h:$d

Send recursively for directories:

    scp -r $u@$h:$p

Send multiple files or directories:

    scp -r $u@$h:"$p1" $u@$h:"$p2"

You cannot do a direct SSH, e.g. on Google Cloud you need to use `gcutil` as front-end, you can just do:

    echo 'cp /remove/path/to/file' | gcutil parameters > out

And then remove trash lines.

#sftp

FTP with SSH encryption
