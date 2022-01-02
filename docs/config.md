jumpcoind config tuning
======================

You can use environment variables to customize config ([see docker run environment options](https://docs.docker.com/engine/reference/run/#/env-environment-variables)):

        docker run -v jumpcoind-data:/jumpcoin/.jumpcoin --name=jumpcoind-node -d \
            -p 31242:31242 \
            -p 127.0.0.1:31240:31240 \
            -e DISABLEWALLET=1 \1
            -e PRINTTOCONSOLE=1 \
            -e RPCUSER=mysecretrpcuser \
            -e RPCPASSWORD=mysecretrpcpassword \
            -e RPCPORT=31240 \
            nippsh/jumpcoind

Or you can use your very own config file like that:

        docker run -v jumpcoind-data:/jumpcoin/.jumpcoin --name=jumpcoind-node -d \
            -p 31242:31242 \
            -p 127.0.0.1:31240:31240 \
            -v /etc/myjumpcoin.conf:/jumpcoin/.jumpcoin/jumpcoin.conf \
            nippsh/jumpcoind
