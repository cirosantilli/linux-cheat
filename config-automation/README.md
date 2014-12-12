# Configuration automation

This is about systems that help you automate system configuration.

One of the major application of such systems is in web development to consistently
create many identical versions of a system to run and test a web app.

Aspects that such systems can automate include:

- software installation
- user creation
- config file manipulation

A good way to test out those systems is by using virtual machines,
in special together with `vagrant`.

The main advantage of such systems over shell scripts that do something like `sudo apt-get install` are:

- increased portability
