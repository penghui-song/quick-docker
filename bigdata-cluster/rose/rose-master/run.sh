#!/usr/bin/env bash
service mysql start
if [ ! -d "/var/lib/hadoop/data/tmp" ]; then
  "$HADOOP_HOME"/bin/hdfs --config "$HADOOP_CONF_DIR" namenode -format "dev"
fi

"$HADOOP_HOME"/bin/hdfs --config "$HADOOP_CONF_DIR" namenode &
"$HADOOP_HOME"/bin/yarn --config "$HADOOP_CONF_DIR" resourcemanager &
"$HADOOP_HOME"/bin/yarn --config "$HADOOP_CONF_DIR" historyserver &
"$HADOOP_HOME"/sbin/mr-jobhistory-daemon.sh start historyserver &

"$SPARK_HOME"/sbin/start-master.sh &
/entrypoint.sh -d rose-master:50070 -c "hadoop fs -mkdir -p /usr/spark/log"
"$SPARK_HOME"/sbin/start-history-server.sh &

schematool -dbType mysql -initSchema
hive --service metastore &
hive --service hiveserver2 &

"$ZOOKEEPER_HOME"/bin/zkServer.sh start &

/entrypoint.sh -d rose-master:50070,rose-master:2181 -c "$HBASE_HOME/bin/hbase-daemon.sh --config $HBASE_CONF_DIR start master &"
/entrypoint.sh -d rose-master:2181 -c "$KE_HOME/bin/ke.sh start &"

while true
do
      sleep 10000000000000
done
