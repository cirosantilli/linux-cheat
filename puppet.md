# Puppet

Cross platform system configuration manager.

Allows to easily check and ensure presence of:

- files
- packages (software)
- user
- group
- cronjobs
- services

across multiple computers.

To do that, puppet creates an abstraction interface over all of those resources that allows to represent them on multiple different platforms.

Next, each platform in which it is implemented must implement those resources, by implementing for example methods to check and create those resources on the system.

For example, on all POSIX systems, puppet can implement user and group resources via `useradd` programs, while a resource such as packages has to be implemented differently on different Linux distros (apt-get on Ubuntu, yum on Fedora, etc.).

New resources can be installed via plugins, or made available in newer versions of puppet.

Good intro: <http://docs.puppetlabs.com/learning/index.html>

## describe subcommand

Get info on currently installed resources:

    puppet describe -l          # List all of the resource types available on the system.
    puppet describe -s user     # Print short information about a type, without describing every attribute
    puppet describe user        # Print long information, similar to what appears in the type reference.

## resource subcommand

View or modify resources.

View all currently present user resources:

    puppet resource user

View resource `user` named `root`:

    puppet resource user root
