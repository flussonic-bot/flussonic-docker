# DOCKER_IMAGE_VERSION 21.07.2-77-gc3754e9
FROM ubuntu:18.04

ARG BRANCH=master

RUN apt-get update && apt-get -y install wget gnupg
RUN echo "deb http://apt.flussonic.com/repo/ ${BRANCH}/" > /etc/apt/sources.list.d/flussonic.list
RUN wget -q -O - http://apt.flussonic.com/binary/gpg.key | apt-key add -

RUN apt update && apt -y install \
  flussonic-erlang=24.0.3.9 \
  flussonic-transcoder=21.07.3 \
  flussonic=21.07.2-77-gc3754e9 && \
  echo dockerhub > /opt/flussonic/lib/online/priv/provisioner.txt && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

VOLUME ["/var/log/flussonic"]
VOLUME ["/var/run/flussonic"]
VOLUME ["/etc/flussonic"]

EXPOSE 80 443 1935 554

WORKDIR /opt/flussonic
CMD ["/opt/flussonic/bin/run", \
  "--debug", \
  "-l", "/var/log/flussonic", \
  "-noinput"]
