#!/bin/bash

docker build -t cloudopsengineer/kafka-base:2.2.0  .
docker build -f zookeeper.Dockefile -t cloudopsengineer/zookeeper:2.2.0 .
docker build -f kafka.Dockefile -t cloudopsengineer/kafka:2.2.0 .
docker build -f mirrormaker.Dockefile -t cloudopsengineer/mirrormaker:2.2.0 .