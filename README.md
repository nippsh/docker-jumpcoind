Jumpcoind for Docker
===================

Docker image that runs the Jumpcoin jumpcoind node in a container for easy deployment.

Requirements
------------

* Physical machine, cloud instance, or VPS that supports Docker (i.e. [Vultr](http://bit.ly/1HngXg0), [Digital Ocean](http://bit.ly/18AykdD), KVM or XEN based VMs) running Ubuntu 14.04 or later (*not OpenVZ containers!*)
* At least 100 GB to store the block chain files (and always growing!)
* At least 1 GB RAM + 2 GB swap file

Quick Start
-----------

1. Create a `jumpcoind-data` volume to persist the jumpcoind blockchain data, should exit immediately.  The `jumpcoind-data` container will store the blockchain when the node container is recreated (software upgrade, reboot, etc):

        docker volume create --name=jumpcoind-data
        docker run -v jumpcoind-data:/jumpcoin/.jumpcoin --name=jumpcoind-node -d \
            -p 8333:8333 \
            -p 127.0.0.1:8332:8332 \
            nippsh/jumpcoind

2. Verify that the container is running and jumpcoind node is downloading the blockchain

        $ docker ps
        CONTAINER ID        IMAGE                         COMMAND             CREATED             STATUS              PORTS                                              NAMES
        d0e1076b2dca        nippsh/jumpcoind:latest       "jump_oneshot"      2 seconds ago       Up 1 seconds        127.0.0.1:8332->8332/tcp, 0.0.0.0:8333->8333/tcp   jumpcoind-node

3. You can then access the daemon's output thanks to the [docker logs command]( https://docs.docker.com/reference/commandline/cli/#logs)

        docker logs -f jumpcoind-node

4. Install optional init scripts for upstart and systemd are in the `init` directory.

Documentation
-------------

* Additional documentation in the [docs folder](docs).
