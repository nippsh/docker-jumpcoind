# Smallest base image, latests stable image
# Alpine would be nice, but it's linked again musl and breaks the bitcoin core download binary
#FROM alpine:latest

FROM ubuntu:latest as builder

# Testing: gosu
#RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing/" >> /etc/apk/repositories \
#    && apk add --update --no-cache gnupg gosu gcompat libgcc
RUN ./jumpcoind_install.sh

FROM ubuntu:latest
LABEL maintainer="nippsh <mail@nipp.sh>"

ENTRYPOINT ["docker-entrypoint.sh"]
ENV HOME /jumpcoin
EXPOSE 31240 31242
VOLUME ["/jumpcoin/.jumpcoin"]
WORKDIR /jumpcoin

ARG GROUP_ID=1000
ARG USER_ID=1000
RUN groupadd -g ${GROUP_ID} jumpcoin \
    && useradd -u ${USER_ID} -g jumpcoin -d /jumpcoin jumpcoin

CMD ["jump_oneshot"]