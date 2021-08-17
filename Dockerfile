# DOCKER_IMAGE_VERSION 21.08-52-g1191f40
FROM ubuntu:18.04

ARG BRANCH=master
RUN echo "deb http://apt.flussonic.com/repo/ ${BRANCH}/" > /etc/apt/sources.list.d/flussonic.list
COPY gpg.key /etc/apt/trusted.gpg.d/flussonic.gpg
COPY provisioner.txt /opt/flussonic/lib/online/priv/provisioner.txt

RUN apt update && apt -y install \
  flussonic-erlang=24.0.3.9 \
  flussonic-transcoder=21.07.3 \
  flussonic=21.08-52-g1191f40 && \
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
