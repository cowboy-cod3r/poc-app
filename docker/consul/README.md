# consul

## Overview

Consule is a Service and Discovery tool that can help scale services, provide health information, and store configuration
for your service.

Read about it [here](https://consul.io).

## Recommended Architecture

* In production it is recommended to use no less that three consul servers to avoid data loss and provide high availability.
* When the consul servers are started, the servers will elect a leader unless you explicitly specify a leader.
* In production it is recommended to have an **odd** number of servers to avoid stalemate issues during leader elections.

## Ports

The excerpt below was taken from [here](http://www.consul.io/docs/agent/options.html)

Consul requires up to 5 different ports to work properly, some on TCP, UDP, or both protocols. Below we document the requirements for each port.

* Server RPC (Default 8300). This is used by servers to handle incoming requests from other agents. TCP only.
* Serf LAN (Default 8301). This is used to handle gossip in the LAN. Required by all agents. TCP and UDP.
* Serf WAN (Default 8302). This is used by servers to gossip over the WAN to other servers. TCP and UDP.
* CLI RPC (Default 8400). This is used by all agents to handle RPC from the CLI. TCP only.
* HTTP API (Default 8500). This is used by clients to talk to the HTTP API. TCP only.
* DNS Interface (Default 8600). Used to resolve DNS queries. TCP and UDP.

## Run Single Server Cluster (Development Only)

This should only be used for development purposes since the recommended architecture is to provide no less than 3 
consul servers.

        docker run \ 
          --name="consul"
          -d  \
          -p 8300:8300 \
          -p 8301:8301 \
          -p 8301:8301/udp \
          -p 8302:8302 \
          -p 8302:8302/udp \
          -p 8400:8400 \
          -p 8500:8500 \
          -p 53:53/udp \
          -v /opt/consul/data:/var/consul
          -e AGENT_TYPE=server \
          -e HOSTING_IP=$(hostname -I | cut -f 1 -d ' ') \
        <docker-socket>/sean/consul:latest
        
## Run Multi-Server Server Cluster (Development Only)
          
This should only be used for development purposes since the recommended architecture is to provide no less than 3 
consul servers.

        docker run \
          --name="consul"
          -d  \
          -p 8300:8300 \
          -p 8301:8301 \
          -p 8301:8301/udp \
          -p 8302:8302 \
          -p 8302:8302/udp \
          -p 8400:8400 \
          -p 8500:8500 \
          -p 53:53/udp \
          -v /opt/consul/data:/var/consul
          -e AGENT_TYPE=server \
          -e HOSTING_IP=$(hostname -I | cut -f 1 -d ' ') \
          -e CONSUL_SERVERS=ip1,ip2,ip3,ip4,ip5
        <docker-socket>/sean/consul:latest
