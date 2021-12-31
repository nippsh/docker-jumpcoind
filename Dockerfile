FROM ubuntu:16.04
LABEL maintainer="nippsh <mail@nipp.sh>"

# install requirements
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install software-properties-common -y \
    && add-apt-repository ppa:bitcoin/bitcoin -y \
    && apt-get update \
    && apt-get install gosu wget unzip nano git build-essential libtool autotools-dev autoconf automake libssl-dev libboost-all-dev libdb4.8-dev libdb4.8++-dev libminiupnpc-dev libqt4-dev libprotobuf-dev protobuf-compiler libqrencode-dev -y \
    && apt-get install git qt5-default qt5-qmake qtbase5-dev-tools qttools5-dev-tools build-essential libboost-dev libboost-system-dev libboost-filesystem-dev libboost-program-options-dev libboost-thread-dev libdb++-dev libminiupnpc-dev libqrencode-dev -y \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /jumpcoin

#create folder + get jumpcoind + execute jumpcoind
RUN mkdir .jumpcoin \
    && wget https://github.com/Jumperbillijumper/jumpcoin/releases/download/1/jumpcoind \
    && chmod 777 jumpcoind \
    && ./jumpcoind 

ENTRYPOINT ["docker-entrypoint.sh"]
ENV HOME /jumpcoin
EXPOSE 31550 31551
VOLUME ["/jumpcoin/.jumpcoin"]

ARG GROUP_ID=1000
ARG USER_ID=1000
RUN groupadd -g ${GROUP_ID} jumpcoin \
    && useradd -u ${USER_ID} -g jumpcoin -d /jumpcoin jumpcoin

RUN ln -sv /jumpcoin/* /usr/local/bin

COPY ./bin ./docker-entrypoint.sh /usr/local/bin/

CMD ["jump_oneshot"]
