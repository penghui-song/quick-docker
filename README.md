# quick-docker

通过docker快速构建开发环境。

### bigdata-cluster

#### rose

`rose`集群分为`rose-master`,`rose-master2`,`rose-client`,各节点运行应用如下：

- rose-master
  - hadoop namenode
  - hadoop resourcemanager
  - hadoop historyserver
  - spark master
  - spark historyserver
  - hbase master
  - hive metastore
  - hive hiveserver2
  - zookeeper node
  - kafka eagle
- rose-master2
  - hadoop secondarynamenode
  - hbase master-backup
- rose-client
  - hadoop datanode
  - hadoop nodemanager
  - spark worker
  - hbase regionserver
  - kafka node

##### build image

```shel
cd bigdata-cluster/rose
make build
```

##### start container

```shell
cd bigdata-cluster/rose
docker-compose up -d
```