# Debugging

## Things to Check

* RAM utilization -- jumpcoind is very hungry and typically needs in excess of 1GB.  A swap file might be necessary.
* Disk utilization -- The jumpcoin blockchain will continue growing and growing and growing.  Then it will grow some more.  At the time of writing, 40GB+ is necessary.

## Viewing jumpcoind Logs

    docker logs jumpcoind-node

## Running Bash in Docker Container

*Note:* This container will be run in the same way as the jumpcoind node, but will not connect to already running containers or processes.

    docker run -v jumpcoind-data:/jumpcoin --rm -it nippsh/jumpcoind bash -l

You can also attach bash into running container to debug running jumpcoind

    docker exec -it jumpcoind-node bash -l


