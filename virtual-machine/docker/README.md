#Docker

<https://github.com/dotcloud/docker>

Relies on Linux Kernel namespaces to solve dependency hell.

Upsides:

- fast
- each VM (container) takes very little disk space.

Downsides:

- only works on Linux. Currently does not support i386 hosts: only x86_64: <https://github.com/dotcloud/docker/issues/136>. Has plans to support it in the future.
- more complicated than VMs because less general. Carefully emulates small parts of the system. Consequences: one single process per virtualization.
- written in Go, yet another language. Rationale: <http://www.slideshare.net/jpetazzo/docker-and-go-why-did-we-decide-to-write-docker-in-go>. C is old and lacks basic expected of modern languages: package management.

Good getting started: <http://docs.docker.io/introduction/working-with-docker/>

Docker was developed by a company called dotCloud Inc, and open sourced. dotCloud was renamed to Docker Inc. in 2014.

##help

List all commands:

    sudo docker help

Get help on one command:

    sudo docker help build

Good info on the manpages:

    man docker
    man docker-run

##Images

Public image index at <https://index.docker.io/>.

Search for image:

    sudo docker search nginx

Sample output:

    NAME                            DESCRIPTION                              STARS  OFFICIAL  TRUSTED
    dockerfile/nginx                Trusted Nginx (http://nginx.org/)  ...   27               [OK]
    dockerfiles/django-uwsgi-nginx  Dockerfile and configuration files ...   7                [OK]
    paintedfox/nginx-php5           A docker image for running Nginx wi...   5                [OK]

TODO: how is `TRUSTED` determined?

Download image:

    sudo docker pull ubuntu
    sudo docker pull dockerfile/nginx

List images available locally:

    sudo docker images

Sample output:

    REPOSITORY         TAG      IMAGE ID      CREATED         VIRTUAL SIZE
    myUserName/nginx   latest   a0d6c70867d2  41 seconds ago  578.8 MB
    nginx              latest   173c2dd28ab2  3 minutes ago   578.8 MB
    ubuntu             13.10    5e019ab7bf6d  3 weeks ago     180 MB
    ubuntu             saucy    5e019ab7bf6d  3 weeks ago     180 MB
    ubuntu             12.04    74fe38d11401  3 weeks ago     209.6 MB
    ubuntu             precise  74fe38d11401  3 weeks ago     209.6 MB

`TAG` is the version of the box, much like Git tags. Tags can be specified as: `ubuntu:14.04`.

Remove image:

    sudo docker rmi image_name

No existing container, including stopped, must be using it. Can force with `-f` (TODO does it prevent from using the container then?).

Interesting images include:

- [dockerfile/ubuntu](https://github.com/dockerfile/ubuntu/blob/master/Dockerfile): Ubuntu 14.04 with a few basic packages added like Git and cURL.


##run

*Create* a new container and run command on it. Use `start` to reuse a container created with `run`.

The most useful command is of the form:

    id="$(sudo docker run -d -p 127.0.0.1:8000:80 dockerfile/nginx)"

which will run Nginx on port `8000` of the host. It can be stopped with:

    sudo docker stop "$id"

This presupposes that the image's `dockerfile/nginx` Dockerfile contains a `CMD` line.

Run single command on starting from image `ubuntu`:

    sudo docker run ubuntu /usr/bin/id -un
    sudo docker run 5e019ab7bf6d /usr/bin/id -un

Output:

    root

If not present, the image is downloaded.

If the image's Dockerfile has `CMD`, then the command can be omitted and `CMD` is used. This is the case for the official Nginx image:

    sudo docker run dockerfile/nginx

which automatically starts running Nginx.

Run multiple commands:

    sudo docker run ubuntu /bin/bash -c 'sleep 2 && id -un'

Docker binds the terminals from container into host terminal and only exits when the command exits.

Start interactive shell with `-it`:

    sudo docker run -it ubuntu /bin/bash

TODO why does it not work without `-it`, considering that it also occupies the stdin / stdout?

`-p`: map port `80` of container to port `8000` of host:

    sudo docker run -p 127.0.0.1:8000:80 dockerfile/nginx

And now from the host:

    firefox localhost:8000

`--name`: give a name to a container:

    sudo docker run --name container_name ubuntu /usr/bin/id -un

If you don't do this, you will have to refer to the container by its ID. This allows you to run on another terminal things like:

    sudo docker attach container_name
    sudo docker stop container_name

The name must be unique, including across stopped containers.

It is only possible to run a single process inside a container, but it is possible to have a process that runs many others: <http://docs.docker.io/examples/using_supervisord/>. This is why the following fails to run on the host TODO confirm:

    sudo docker run -p 8000:80 -it ubuntu /bin/bash
    apt-get install -y nginx
    service apache2 nginx

Same goes for a bare `CMD nginx`, since by default Nginx turns itself into a background process. This is why `daemon off` is required on the Nginx configuration as stated at: <http://stackoverflow.com/questions/18861300/how-to-run-nginx-within-docker-container-without-halting>.

`-d`: run detached container and print it ID:

    id="$(sudo docker run -d -p 127.0.0.1:8000:80 dockerfile/nginx)"
    sudo docker stop "$id"

###volume

###v

Share directory between guest and host:

    sudo docker run -v /tmp ubuntu date > /tmp/docker
    cat /tmp/docker

    date > /tmp/docker
    sudo docker run -v /tmp ubuntu cat /tmp/docker

Can only take absolute paths. Efficient for large files, unlike some VM schemes.

##ps

List running containers:

    sudo docker ps

List all containers, including those previously stopped:

    sudo docker ps -a

Sample output:

    CONTAINER ID        IMAGE                     COMMAND                CREATED              STATUS                          PORTS               NAMES
    e676beb2500b        ubuntu:14.04              /bin/bash -c 'sleep    About a minute ago   Exited (0) About a minute ago                       silly_perlman
    b7876bb06c7d        ubuntu:14.04              /bin/bash              3 minutes ago        Exited (1) 3 minutes ago                            prickly_albattani
    3426d733883a        ubuntu:14.04              /bin/bash -c 'sleep    5 minutes ago        Exited (0) 5 minutes ago                            insane_fermat

Some fields such as mapped ports and name only appear of they are not empty:

    sudo docker run --name name0 --expose 8000 -i -p 127.0.0.1:8000:8000 -t dockerfile-test bash
    sudo docker ps

---

Stop container:

    sudo docker stop ubuntu

Restart container that was stopped / finished executing detached:

    sudo docker run --name start_test ubuntu date
    sudo docker start start_test

Since it is detached by default it will only print its ID, not the stdout.

Attach:

    sudo docker start -a start_test

Remove a container:

    sudo docker rm 3e552code34a

Remove all containers <http://stackoverflow.com/questions/17236796/how-to-remove-old-docker-io-containers>:

    sudo docker rm $(sudo docker ps -aq --no-trunc)

##attach

Attach to a running container:

    sudo docker run -it --name name0 ubuntu bash

On another terminal:

    sudo docker attach name0

Now stdin and stdout of both terminals are attached: whatever you do on one shows on both.

Detach with `Ctrl-p + Ctrl-q`. Doing `Ctrl-d` would terminate the shell and the container. You can detach even if you are in the last TTY.

##Dockerfile

Dockerfiles use yet another programming language.

A good way to learn their most important features is by looking at key Dockerfiles such as:

- https://github.com/dockerfile/ubuntu/blob/master/Dockerfile
- https://github.com/dockerfile/nginx/blob/master/Dockerfile

Documentation at: <http://docs.docker.io/reference/builder/>

Build is *very* efficient. Each step generates a new cached machine. Next machines pick up from those caches. So if you run `apt-get install biglib` and `build` twice, it will only download the library once! Downside: no state is kept between builds.

##build

Generate a container from the Dockerfile in the current directory with given name:

    sudo docker build -t name .
    sudo docker run -it name bash
