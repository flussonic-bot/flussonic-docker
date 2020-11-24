# DOCKER_IMAGE_VERSION 3267ecb9
FROM ubuntu:18.04

ARG BRANCH=master

RUN apt-get update && apt-get -y install wget gnupg
RUN echo "deb http://apt.flussonic.com/repo/ ${BRANCH}/" > /etc/apt/sources.list.d/flussonic.list
RUN wget -q -O - http://apt.flussonic.com/binary/gpg.key | apt-key add -

RUN apt update && apt -y install flussonic flussonic-transcoder-base

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
  
