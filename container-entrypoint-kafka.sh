#!/bin/sh

echo "\033[1;33m[Info]    \033[0m Start Kafka server"
bin/kafka-server-start.sh config/server.properties \
  --override zookeeper.connect=${KAFKA_ZOOKEEPER_CONNECT} \
  --override broker.id=${KAFKA_BROKER_ID} \
  --override log.dirs=/data/kafka \
  --override advertised.listeners=PLAINTEXT://${KAFKA_ADVERTISED_LISTENERS}:9092 \
  $@
