FROM ubuntu:18.04

ARG BRANCH=master

RUN apt-get update && apt-get -y install wget gnupg
RUN echo "deb http://apt.flussonic.com/repo/ ${BRANCH}/" > /etc/apt/sources.list.d/erlyvideo.list
RUN wget -q -O - http://apt.flussonic.com/binary/gpg.key | apt-key add -

RUN apt update && apt -y install flussonic

ARG LICENSE
RUN echo "$LICENSE" > /etc/flussonic/license.txt

VOLUME ["/var/log/flussonic"]
VOLUME ["/var/run/flussonic"]
VOLUME ["/etc/flussonic"]

EXPOSE 80 1935 554

