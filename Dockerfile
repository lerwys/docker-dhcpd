FROM ubuntu:xenial

MAINTAINER Robin Smidsrød <robin@smidsrod.no>

ARG DEBIAN_FRONTEND=noninteractive

RUN echo "nameserver 10.0.0.71" >> /etc/resolv.conf \
 && apt-get -q -y update \
 && apt-get -q -y -o "DPkg::Options::=--force-confold" -o "DPkg::Options::=--force-confdef" install \
    apt-utils \
    isc-dhcp-server \
    man \
 && apt-get -q -y autoremove \
 && apt-get -q -y clean \
 && rm -rf /var/lib/apt/lists/*

COPY util/dumb-init_1.2.0_amd64 /usr/bin/dumb-init
COPY util/entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
