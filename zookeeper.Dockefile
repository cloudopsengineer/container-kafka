FROM cloudopsengineer/kafka-base:2.2.0 as base

FROM openjdk:8

# RMI_PORT must be JMX_PORT + 1
ENV RMI_PORT 9396
ENV JMX_PORT 9395

# Configure JAVA Heap
ENV KAFKA_HEAP_OPTS "-Xmx1G -Xms1G"

# ZOOKEEPER CONFIGURATION ENV
ENV ZOOKEEPER_MAX_CLIENT_CNXNS 60
ENV ZOOKEEPER_TICK_TIME 2000
ENV ZOOKEEPER_INIT_LIMIT 10
ENV ZOOKEEPER_SYNC_TIME 5

#set ZOOKEEPER_SERVER_IP_LIST as ip1:leader_port:leader_election_port,ip2:leader_port:leader_election_port,....
ENV ZOOKEEPER_SERVER_ID 1
ENV ZOOKEEPER_SERVER_IP_PORT_LIST ${HOSTNAME}:2888:3888

# ZOOKEEPER PORT ENV
ENV ZOOKEEPER_SERVER_PORT=2181
ENV ZOOKEEPER_SERVER_PORT_LEADER=2888
ENV ZOOKEEPER_SERVER_PORT_LEADER_ELECTION=3888

COPY --from=base --chown=1000:100 /opt/kafka /opt/zookeeper
COPY container-entrypoint-zookeeper.sh /usr/local/bin/container-entrypoint-zookeeper

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -y && apt-get install apt-utils gettext-base -y

RUN mkdir -p /data/zookeeper && chown 1000:100 /data/zookeeper

WORKDIR /opt/zookeeper

COPY config/zookeeper.properties config/template/zookeeper.properties

USER 1000
VOLUME ["/data/zookeeper"]

EXPOSE ${ZOOKEEPER_SERVER_PORT} ${ZOOKEEPER_SERVER_PORT_LEADER} ${ZOOKEEPER_SERVER_PORT_LEADER_ELECTION} ${JMX_PORT}
ENTRYPOINT [ "/bin/sh", "/usr/local/bin/container-entrypoint-zookeeper" ]