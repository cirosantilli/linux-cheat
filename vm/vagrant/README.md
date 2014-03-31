Vagrant makes it really fast to create new virtual machines for SSH usage.

For a Vagrant template see: 

Vagrant is a frontend to *providers* like VirtualBox (default) or VMware, so you should get those working before using Vagrant.

First create a working directory:

    mkdir vagrant
    cd vagrant

View available local base boxes:

    vagrant box list

This does not list boxes which you have modified the state. There seems to be no interface way of doing that, except going into `.vagrant` and hacking IDs of config files based on IDs you see on your provider's interface.

Add a box:

    vagrant box add name url

where name can be anything you wish, for example:

    vagrant box add precise32 http://files.vagrantup.com/precise32.box

A fine list of third party free boxes can be found at: <http://www.vagrantbox.es/>

Create an init file for a vagrant project with an existing box:

    vagrant init precise32

The Vagrantfile file will contain:

    config.vm.box = "precise32"

But not the box URL.

Also specify the URL, and download box if it is not present:

    vagrant init precise32 http://files.vagrantup.com/precise32.box

The Vagrantfile file will contain:

    config.vm.box = "precise32"
    config.vm.box_url = "http://files.vagrantup.com/precise32.box"

so that if anyone else uses this Vagrantfile, `vagrant up` will automatically download the box from the URL.

For this reason you should always specify the URL in your Vagrantfile.

Boot the box configured in current dir:

    vagrant up

The machine is running on the background.

Access the box configured in current dir via SSH:

    vagrant ssh

You are now in a virtual shell inside the virtual machine. To exit it do a `Ctrl+D`.

The new machine will have:

- a regular user named vagrant, who can `sudo` without password
- a `/vagrant` directory which is the host's directory containing the Vagrantfile mounted.

Stop the machine from running to save CPU:

    vagrant suspend

The machine state is unchanged.

Resume a suspend:

    vagrant resume

Shutdown the virtual machine:

    vagrant halt

The machine's persistent state such as hard disk remains.

`halt` + `up`:

    vagrant reload

View the running status of the machine:

    vagrant status

Destroy machine, including persistent state like hard disk:

    vagrant destroy

Does not remove the vagrant configuration files in current directory.

#provision

Provisioning is automatically running commands on the box when it is first upped, typically to install programs.

To provision with a sh file use:

    config.vm.provision :shell, :path => "bootstrap.sh"

where the path is relative to the directory containing the Vagrantfile.

Use script from a string:

    config.vm.provision :shell, :inline => <<EOF
        touch /tmp/shell-provision
    EOF

Vagrant also supports specialized provisioners such as Ansible, Chef and Puppet.

Provision running box:

    vagrant provision

Up without provisioning:

    vagrant up --no-provision

#port forwarding

Add the following to your configuration file:

    config.vm.network :private_network, ip: "192.168.3.4"
    config.vm.network :forwarded_port, guest: 3000, host: 3000

Now requests on the host `192.168.3.4:3000` will be redirected to the guest at `192.168.3.4:3000`. This way you can run a server on the guest, and test it on your browser from the host!

Vagrant forwards by default the host's `localhost:2222` to the guest's `localhost:22`, and `8080` to `80`. This way, from any directory in the host is is possible to connect to the guest via SSH by doing `ssh -p 2222 vagrant@localhost` and then entering the password for user `vagrant` which is `vagrant by default`.

#plugins

Plugins are installed on the host and give extra capabilities to Vagrant.

List installed plugins:

    vagrant plugin list

#shared folders

See synced folders.

#synced folders

Synced folders are simply mounted from host to guest:

    config.vm.synced_folder "shared_home", "/dir"

The directory must exist on the host, but is automatically created if it does not exist on the guest.

If you share the vagrant home or its parents, you cannot ssh into the machine anymore because the `.ssh` will disappear.

#box location

The base boxes (added via `add`) are stored under `~/.vagrant.d/boxes`. These are not the actual state machines, whose directory depends on which provider you use.

To actually get the box state, it seems that the only way is to do provider specific things.

#package

Create new box

##From another box

The typical workflow is to:

- start with the officially supported `precise32` box
- create a script / Chef Recipe / Puppet Recipe that installs everything that needs to be installed
- once satisfied, package the box because

    - other people can download it faster because it is a single file rather than multiple GET requests to different servers
    - installations may fail, for example due to Internet failures.

To package the box, simply do:

    vagrant package --base name --output path/to/output.box

where name is:

- optionally set with:

        config.vm.provider "virtualbox" do |v|
        v.customize [
            'modifyvm', :id,
            '--name', name
          ]
        end

    It is a good idea to always use that.

- found under the box GUI as shown at: http://abhishek-tiwari.com/hacking/creating-a-new-vagrant-base-box-from-an-existing-vm

And we are done!

A good place to store open source boxes for download as of 2014-03 is Source Forge, which allows fast unlimited downloads, soft 5Gb disk space, and does not mind if your source is hosted on GitHub: <http://sourceforge.net/blog/github-projects-downloads-are-welcome>. For large files such as VMs, you will need to use a `scp` upload: <https://sourceforge.net/apps/trac/sourceforge/wiki/SCP>, and it takes around 20 hours to complete.

##From scratch

Will be much harder, as it requires you to install necessary dependencies to Vagrant.

Only do this if you really have no alternative.
