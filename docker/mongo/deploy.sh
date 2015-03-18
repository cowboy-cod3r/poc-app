#!/bin/bash

#
# Convenience script for starting up the mongo image locally.
# Would not use this in production.

# Binaries
DOCKER="/usr/bin/docker"

# Image Name
MONGO_NAME="mongodb"

# Image Identifier
MONGO_ID="mongodb"

# Stop any existing containers and then start it up
$DOCKER stop $MONGO_NAME >/dev/null 2>&1
$DOCKER rm -f $MONGO_NAME >/dev/null 2>&1
cmd="${DOCKER} run -d --name="${MONGO_NAME}" -p 27017:27017 -p 27018:27018 ${MONGO_ID}"
echo "INFO: ${cmd}"
$cmd
