# Vagrant

Good intro tutorial: <http://gettingstartedwithchef.com/first-steps-with-chef.html>

Important terms:

- cookbook: contains one ore more recipes, template files, etc.

- recipe: specifies how to take an action.

- chef-solo: version of the program that runs on a single computer.

    Reads local configuration files and modifies the system.

- chef-client and chef-server: version of the program that runs in a client server system.

    Normally, the server offers configuration files requested by the client,
    which uses them to modify the system it runs on.

- knife: program that can:

    - create cookbook templates

        knife cookbook create $COOKBOOK_NAME

    - download recipes so that chef-solo can use them:

        knife cookbook site download $COOKBOOK_NAME

    Does not resolve recipe dependencies.

- berkshelf: downloads recipes like knife, but also manages dependencies.
