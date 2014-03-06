Vagrant makes it really fast to create new virtual machines.

It relies on other Virtual machines to do most of the work.

By default, it relies on virtualbox, so you should get it working before
using vagrant.

First create a working directory:

    mkdir vagrant
    cd vagrant

View available local boxes:

    vagrant box list

Addd a box:

    vagrant box add name url

where name can be anyhting you wish, for example:

    vagrant box add precise32 http://files.vagrantup.com/precise32.box

A fine list of third party free boxes can be found at: <http://www.vagrantbox.es/>

Create an init file for a vagrant project with an existing box:

    vagrant init precise32

The config file will contain:

    config.vm.box = "precise32"

But not the box URL.

Also specify the URL, and download box if it is not present:

    vagrant init precise32 http://files.vagrantup.com/precise32.box

The config file will contain:

    config.vm.box = "precise32"
    config.vm.box_url = "http://files.vagrantup.com/precise32.box"

so that if anyone else uses this Vagrantfile,
`vagrant up` will automatically download the box from the URL.

For this reason you should always specify the URL in your Vagrantfile.

Boot the box configured in current dir:

    vagrant up

The machine is running on the background.

Access the box configured in current dir via ssh:

    vagrant ssh

You are now in a virtual shell inside the virtual machine.
To exit it do a `Ctrl+D`.

The new machine will have:

- a regular user named vagrant, who can `sudo` without password
- a `/vagrant` directory which is a shared directory with the directory containing the Vagrantfile.

Stop the machine from running to save CPU:

    vagrant suspend

The machine state is unchanged.

Resume a suspend:

    vagrant resume

Shutdown the virtual machine:

    vagrant halt

The machine's persistent state such as hard disk remains.

Same as `halt` + `up`:

    vagrant reload

View the running status of the machine:

    vagrant status

Destroy machine, including persistent state like hard disk:

    vagrant destroy

Does not remove the vagrant configuration files in current directory.

#provision

Provisioning is automatically running commands on the box when it is first upped,
typically to install programs.

To provision with a sh file use:

    config.vm.provision :shell, :path => "bootstrap.sh"

where the path is realtive to the directory containing the Vagrantfile.

Use script from a string:

    config.vm.provision :shell, :inline => <<EOF
        touch /tmp/shell-provision
    EOF

Vagrant also supports specialized provisioners such as Ansible, Chef and Puppet.

Provision runing box:

    vagrant provision

Up without provisioning:

    vagrant up --no-provision

#port forwarding

Add the following to your config file:

    config.vm.network :private_network, ip: "192.168.3.4"
    config.vm.network :forwarded_port, guest: 3000, host: 3000

Now requests on the host `192.168.3.4:3000` will be redirected to the guest at `192.168.3.4:3000`.
This way you can run a server on the guest, and test it on your browser from the host!

Vagrant forwards by default the host's `localhost:2222` to the guest's `localhost:22`, and 
`8080` to `80`. This way, from any directory in the host is is possible to connect to the guest
via ssh by doing `ssh -p 2222 vagrant@localhost` and then entering the password for user
`vagrant` which is `vagrant by default`.

#plugins

Plugins are installed on the host and give extra capabilities to Vagrant.

List installed plugins:

    vagrant plugin list
