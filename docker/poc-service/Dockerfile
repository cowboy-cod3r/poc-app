FROM centos:7
MAINTAINER sean.humbarger@issinc.com

# Configuration
ADD scripts/run.sh /usr/local/bin/run

# Install the poc service
RUN yum install -y make gcc-c++ ruby ruby-devel && \
    /bin/bash -l -c "gem sources -a http://52.11.161.55:9292/" && \
    /bin/bash -l -c "gem install poc-server --no-rdoc --no-ri"

# Ports
EXPOSE 4242

# Default command to execute
CMD run
