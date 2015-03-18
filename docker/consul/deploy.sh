#!/bin/bash

#
# Convenience script for starting up the image locally.
# Would not use this in production.
#

# Vars
DOCKER="/usr/bin/docker"
NAME="consul"
IMAGE="52.11.161.55:5000/sean/consul:latest"

# Stop any existing containers
$DOCKER stop $NAME >/dev/null 2>&1
$DOCKER rm -f $NAME >/dev/null 2>&1

# Output the command
echo "INFO: Single node consul cluster"

# Setup the command
cmd="${DOCKER} run -d \
    --name="${NAME}"
    -p 8300:8300 \
    -p 8301:8301 \
    -p 8301:8301/udp \
    -p 8302:8302 \
    -p 8302:8302/udp \
    -p 8400:8400 \
    -p 8500:8500 \
    -p 53:53/udp \
    -v /opt/consul/data:/var/consul \
    -e AGENT_TYPE=server \
    -e HOSTING_IP=$(hostname -I | cut -f 1 -d ' ') \
    ${IMAGE}"

# Output the command
echo "INFO: ${cmd}"

$cmd
