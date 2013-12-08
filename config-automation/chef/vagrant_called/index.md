On this example, Vagrant invokes chef automatically at Vagrant up.

All the chef configs including the `-j a.json` and `-c a.rb` files are inside `Vagrantfile`.

Vagrant automatically installs chef-solo on the guest.

This way you can focus on the cookbooks, and run them automatically at system up.

This is the main cheat for cookbook recipes.

To get a clean system use `vagrant reload`. To rerun chef on an existing running system, use `vagrant provision`.
