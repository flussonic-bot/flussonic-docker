# DOCKER_IMAGE_VERSION 21.04.1-12-g1305cf0
FROM ubuntu:18.04

ARG BRANCH=master

RUN apt-get update && apt-get -y install wget gnupg
RUN echo "deb http://apt.flussonic.com/repo/ ${BRANCH}/" > /etc/apt/sources.list.d/flussonic.list
RUN wget -q -O - http://apt.flussonic.com/binary/gpg.key | apt-key add -

RUN apt update && apt -y install flussonic-erlang=22.3.14
RUN apt -y install flussonic-transcoder-base=20.11.6
RUN apt -y install flussonic=21.04.1-12-g1305cf0

VOLUME ["/var/log/flussonic"]
VOLUME ["/var/run/flussonic"]
VOLUME ["/etc/flussonic"]

EXPOSE 80 443 1935 554

WORKDIR /opt/flussonic
CMD ["/opt/flussonic/bin/run", \
  "--debug", \
  "-p", "/var/run/flussonic/pid", \
  "-l", "/var/log/flussonic", \
  "-noinput"]
