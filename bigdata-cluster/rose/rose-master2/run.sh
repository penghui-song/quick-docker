#!/usr/bin/env bash
"$HADOOP_HOME"/bin/hdfs --config "$HADOOP_CONF_DIR" secondarynamenode &

/entrypoint.sh -d rose-master:50070,rose-master:2181 -c "$HBASE_HOME/bin/hbase-daemon.sh --config $HBASE_CONF_DIR start master-backup &"

while true
do
      sleep 10000000000000
done