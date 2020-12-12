#!/usr/bin/env bash
"$SPARK_HOME"/sbin/start-slave.sh &
"$HADOOP_HOME"/bin/hdfs --config "$HADOOP_CONF_DIR" datanode &
"$HADOOP_HOME"/bin/yarn --config "$HADOOP_CONF_DIR" nodemanager &

"$HBASE_HOME"/bin/hbase-daemons.sh --config "${HBASE_CONF_DIR}" start regionserver &
export JMX_PORT=9999
"$KAFKA_HOME"/bin/kafka-server-start.sh  -daemon "$KAFKA_CONF_DIR"/server.properties &

while true
do
      sleep 10000000000000
done
