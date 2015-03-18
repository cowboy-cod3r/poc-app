FROM centos:7
MAINTAINER sean.humbarger@issinc.com

# Configuration
ADD scripts/run.sh /usr/local/bin/run

# Download Consul
ADD https://dl.bintray.com/mitchellh/consul/0.5.0_linux_amd64.zip /tmp/
#ADD https://dl.bintray.com/mitchellh/consul/0.5.0_web_ui.zip /tmp/

# Install Consul
RUN useradd -M -U -s /bin/bash consul && \
    mkdir -p /etc/consul.d && \
    mkdir -p /var/consul && \
    chown consul:consul /var/consul && \
    yum install -y unzip && \
    unzip /tmp/0.5.0_linux_amd64.zip -d /usr/local/bin && \
    chmod 755 /usr/local/bin/consul && \
    chown consul:consul /usr/local/bin/consul && \
    rm -f /tmp/0.5.0_linux_amd64.zip

ADD  /files/server.json /etc/consul.d/

# Ports
EXPOSE 8300 8301 8301/udp 8302 8302/udp 8400 8500 8600 53/udp

# Default command to execute
CMD run
