#!/bin/sh

echo "\033[1;33m[Info]    \033[0m Setup mirrormaker"

$(which envsubst) < /opt/kafka/config/template/consumer.properties > /opt/kafka/config/consumer.properties
$(which envsubst) < /opt/kafka/config/template/producer.properties > /opt/kafka/config/producer.properties

echo "\033[1;33m[Info]    \033[0m Start mirrormaker"
bin/kafka-mirror-maker.sh \
      --consumer.config /opt/kafka/config/consumer.properties \
      --producer.config /opt/kafka/config/producer.properties \
      --num.streams ${NUM_STREAMS} \
      --whitelist $@
