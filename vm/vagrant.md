Vagrant makes it really fast to create new virtual machines.

It relies on other Virtual machines to do most of the work.

By default, it relies on virtualbox, so you should get it working before
using vagrant.

First create a working directory:

    mkdir vagrant
    cd vagrant

Create an init file and download Ubuntu 12.04 (precise) 32 bits:

    vagrant init precise32 http://files.vagrantup.com/precise32.box

Boot the box configured in current dir:

    vagrant up

The machine is running on the background.

Access the box configured in current dir via ssh:

    vagrant ssh

You are now in a virtual shell inside the virtual machine.
To exit it do a `Ctrl+D`.

The new machine will have a regular user named vagrant.

Stop the machine from running to save CPU:

    vagrant suspend

The machine state is unchanged.

Resume a suspend:

    vagrant resume

Shutdown the virtual machine:

    vagrant halt

The machine's persistent state such as hard disk remains.

View the running status of the machine:

    vagrant status

Destroy machine, including persistent state like hard disk:

    vagrant destroy

Does not remove the vagrant configuration files in current directory.
