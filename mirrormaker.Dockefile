FROM cloudopsengineer/kafka-base:2.2.0 as base

FROM openjdk:8

# RMI_PORT must be JMX_PORT + 1
ENV RMI_PORT 9397
ENV JMX_PORT 9396

ENV KAFKA_CONSUMER_BOOTSTRAP_SERVERS localhost:9092
ENV KAFKA_PRODUCER_BOOTSTRAP_SERVERS localhost:9092
ENV KAFKA_CONSUMER_GROUP_NAME mirrormaker
ENV NUM_STREAMS 1

COPY --from=base --chown=1000:100 /opt/kafka /opt/kafka
COPY container-entrypoint-mirrormaker.sh /usr/local/bin/container-entrypoint-mirrormaker

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -y && apt-get install apt-utils gettext-base -y

WORKDIR /opt/kafka

COPY config/consumer.properties config/template/consumer.properties
COPY config/producer.properties config/template/producer.properties

ENTRYPOINT [ "/bin/sh", "/usr/local/bin/container-entrypoint-mirrormaker" ]