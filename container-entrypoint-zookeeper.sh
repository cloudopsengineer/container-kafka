#!/bin/sh

echo "\033[1;33m[Info]    \033[0m Setup zookeeper"

echo ${ZOOKEEPER_SERVER_ID} > /data/zookeeper/myid

$(which envsubst) < /opt/zookeeper/config/template/zookeeper.properties > /opt/zookeeper/config/zookeeper.properties

echo "${ZOOKEEPER_SERVER_IP_PORT_LIST}" | $(which awk) -F, '{for(i=1; i<=NF; i++) print "server."i"="$i}' ORS='\n' >> /opt/zookeeper/config/zookeeper.properties

echo "\033[1;33m[Info]    \033[0m Start zookeeper server"
bin/zookeeper-server-start.sh config/zookeeper.properties
