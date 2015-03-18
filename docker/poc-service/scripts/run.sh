#!/bin/bash

# Start poc-service
poc-service run --log=/var/log/poc-service.log

# Log
tail -f /var/log/poc-service.log
