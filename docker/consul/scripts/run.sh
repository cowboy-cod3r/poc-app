#!/bin/bash

#
# Helper Startup Script
#

# Vars
CONSUL_USER="consul"
CONSUL="/usr/local/bin/consul agent"
CONSUL_CONFD="/etc/consul.d"
CONSUL_VAR="/var/consul"
TMP_FILE="/tmp/consul_servers.txt"
AGENT_TYPE=${AGENT_TYPE:-client}

echo "INFO: Agent Type - ${AGENT_TYPE}"

# Case statement
case $AGENT_TYPE in
    client)
        CONF_FILE="client.json"
        CONSUL_CONF="${CONSUL_CONFD}/${CONF_FILE}"
        ;;
    server)
        # Error Checking
        : ${HOSTING_IP:?"ERROR: The HOSTING_IP environment variable must be set hosting IP address."}
        
        CONF_FILE="server.json"
        CONSUL_CONF="${CONSUL_CONFD}/${CONF_FILE}"

        # Conf file updates
        if [[ -z ${CONSUL_SERVERS} ]];then
          echo "INFO: No other consul servers provided, assuming a single consul server."
          echo "WARN: This is not a recommended configuration for production use."
        
          # Implies there is only one server in the clust
          CONSUL_SERVERS="${HOSTING_IP}"
          SERVER_COUNT=1
        else
          echo "${CONSUL_SERVERS}" > "${TMP_FILE}"
          sed -i -e "s|,|\",\"|g" "${TMP_FILE}"
          CONSUL_SERVERS="\"$(cat "${TMP_FILE}")\""
          SERVER_COUNT=$(echo "${CONSUL_SERVERS}" | awk -F"," "{ print NF }")
          rm -f "${TMP_FILE}"
        fi

        # Replace values
        sed -i -e "s|REPLACE_SERVER_COUNT|${SERVER_COUNT}|g" "${CONSUL_CONF}"
        sed -i -e "s|REPLACE_CONSUL_SERVERS|${CONSUL_SERVERS}|g" "${CONSUL_CONF}"
        sed -i -e "s|REPLACE_HOSTING_IP|${HOSTING_IP}|g" "${CONSUL_CONF}"
        ;;
#    bootstrap)
#        # Error Checking
#        : ${HOSTING_IP:?"ERROR: The HOSTING_IP environment variable must be set hosting IP address."}
#
#        CONF_FILE="bootstrap.json"
#        CONSUL_CONF="${CONSUL_CONFD}/${CONF_FILE}"
#
#        sed -i -e "s|REPLACE_HOSTING_IP|${HOSTING_IP}|g" "${CONSUL_CONF}"
#        ;;
    *)
        echo "ERROR: You specified an unknown agent type.  Please use 'client', 'server', or 'bootstrap'"
        exit 1
esac

## Start consul
echo "INFO: Attempting to start consul"
chown -R "${CONSUL_USER}:${CONSUL_USER}" "${CONSUL_VAR}"
su "${CONSUL_USER}" -c "${CONSUL} -config-dir ${CONSUL_CONF}"
