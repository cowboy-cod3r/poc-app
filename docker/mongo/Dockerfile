FROM centos:7
MAINTAINER sean.humbarger@issinc.com

# Configuration
ADD files/mongodb.repo /etc/yum.repos.d/mongodb.repo
ADD scripts/run.sh /usr/local/bin/run

# Copy the sidecar to /usr/local/bin
RUN yum -y install wget unzip mongodb-org vim

# Configuration
RUN mkdir -p /data/db && \
    chown mongod:mongod /data/db && \
    sed -i "s|bind_ip=127\.0\.0\.1|#bind_ip=127\.0\.0\.1|" /etc/mongod.conf && \
    sed -i "s|/var/lib/mongo:/bin/false|/var/lib/mongo:/bin/bash|" /etc/passwd

# Volumes
VOLUME /data/db
VOLUME /var/log/mongodb

# Ports
EXPOSE 27017 27018

# Default command to execute
CMD run
