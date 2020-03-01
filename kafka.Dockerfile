FROM cloudopsengineer/kafka-base:2.2.0 as base

FROM openjdk:8

# RMI_PORT must be JMX_PORT + 1
ENV RMI_PORT 9394
ENV JMX_PORT 9393

ENV KAFKA_BROKER_PLAIN_PORT=9092
ENV KAFKA_BROKER_ID=100
ENV KAFKA_ZOOKEEPER_CONNECT=zookeeper:2181
ENV KAFKA_ADVERTISED_LISTENERS=${HOSTNAME}
ENV KAFKA_HEAP_OPTS "-Xmx1G -Xms1G"

COPY --from=base --chown=1000:100 /opt/kafka /opt/kafka
COPY container-entrypoint-kafka.sh /usr/local/bin/container-entrypoint-kafka

RUN mkdir -p /data/kafka && chown 1000:100 /data/kafka

WORKDIR /opt/kafka

USER 1000
VOLUME [ "/data/kafka" ]

EXPOSE ${KAFKA_BROKER_PLAIN_PORT} ${JMX_PORT}
ENTRYPOINT [ "/bin/sh", "/usr/local/bin/container-entrypoint-kafka" ]