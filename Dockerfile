FROM openjdk:8
LABEL mantainer "https://github.com/cloudopsengineer"
LABEL author "Giuseppe Iannelli"

ARG KAFKA_MIRROR_URL=http://www-eu.apache.org/
ARG KAFKA_VERSION=2.2.0
ARG SCALA_VERSION=2.12

ENV DEBIAN_FRONTEND noninteractive
# RMI_PORT must be JMX_PORT + 1
ENV RMI_PORT 10000
ENV JMX_PORT 9999

ENV _JAVA_OPTIONS="-Djava.net.preferIPv4Stack=true -DXms=512M -DXmx=1G"

WORKDIR /tmp
#DOWNLOAD KAFKA
RUN wget ${KAFKA_MIRROR_URL}/dist/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz ${KAFKA_MIRROR_URL}/dist/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz.asc
#VERIFY KAFKA PACKAGES
RUN wget http://kafka.apache.org/KEYS
RUN gpg --import KEYS
RUN gpg --verify kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz.asc kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz

RUN tar -xvzf kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz && mv /tmp/kafka_${SCALA_VERSION}-${KAFKA_VERSION} /opt/kafka

WORKDIR /opt/kafka

