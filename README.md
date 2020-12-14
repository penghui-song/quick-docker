# Quick-docker

通过docker快速构建开发环境。

### Bigdata-cluster

#### Rose cluster

`rose`集群分为`rose-master`,`rose-master2`,`rose-client`,`rose-other`,各节点运行应用如下：

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
- rose-other
  - redis
  - rabbitmq
  - sqlserver
  - portainer

##### Component version

| Component   | Version      |
| ----------- | ------------ |
| jdk         | openjdk-8    |
| scala       | 2.11.12      |
| hadoop      | 2.10.1       |
| spark       | 2.4.6        |
| mysql       | mariadb-10.1 |
| hive        | 2.3.7        |
| zookeeper   | 3.6.2        |
| hbase       | 1.6.0        |
| kafka       | 2.4.1        |
| kafka eagle | 2.0.3        |
| redis       | latest       |
| rabbitmq    | management   |
| sqlserver   | 2017-latest  |
| portainer   | latest       |

##### Component port

- rose-master

| Comonent    | Node              | Port  | Desc                                                  |
| ----------- | ----------------- | ----- | ----------------------------------------------------- |
| HDFS        | NameNode          | 8020  | 接收Client连接的RPC端口，用于获取文件系统metadata信息 |
| HDFS        | NameNode          | 50070 | http服务的端口                                        |
| HDFS        | NameNode          | 50470 | https服务的端口                                       |
| YARN        | ResourceManager   | 8088  | http服务端口                                          |
| YARN        | JobHistory Server | 19888 | http服务端口                                          |
| Mysql       | Server            | 3306  | 服务端口                                              |
| Hive        | Metastore         | 9083  | 服务端口                                              |
| Hive        | HiveServer2       | 10000 | 服务端口                                              |
| HBase       | Master            | 16010 | http服务端口                                          |
| ZooKeeper   | Server            | 2181  | 服务端口                                              |
| ZooKeeper   | AdminServer       | 28080 | http服务端口                                          |
| Spark       | Master            | 8080  | http服务端口                                          |
| Spark       | Job               | 4040  | Job运行服务端口                                       |
| Spark       | History Server    | 18080 | http服务端口                                          |
| Kafka Eagle | Server            | 8048  | http服务端口                                          |
| Flink       | JobManager        | 8091  | http服务端口                                          |

- rose-master2

| Component | Node              | Port  | Desc         |
| --------- | ----------------- | ----- | ------------ |
| HDFS      | SecondaryNameNode | 50090 | http服务端口 |

- rose-client

| Component | Node         | Port  | Desc         |
| --------- | ------------ | ----- | ------------ |
| HDFS      | DataNode     | 50075 | http服务端口 |
| YARN      | NodeManager  | 8042  | http服务端口 |
| HBase     | RegionServer | 16030 | http服务端口 |
| Spark     | Worker       | 8081  | http服务端口 |

- rose-other

| Component | Node   | Port  | Desc         |
| --------- | ------ | ----- | ------------ |
| redis     | Server | 6379  | 服务端口     |
| rabbitmq  | Server | 15672 | http服务端口 |
| sqlserver | Server | 1433  | 服务端口     |
| portainer | Server | 9000  | http服务端口 |

##### Build image

```shel
cd bigdata-cluster/rose
make build
```

##### Start container

```shell
cd bigdata-cluster/rose
docker-compose up -d
```

##### Stop container

```shell
cd bigdata-cluster/rose
docker-compose down
```

##### Run command

```shell
# 例如执行hive,其它同此
docker exec -it rose-master hive
```

##### Questions & Solution

- 镜像构建失败: `Temporary failure resolving 'deb.debian.org'`

  ```shell
  # 添加dns解析
  cat /etc/docker/daemon.json
  {
  "dns": ["8.8.8.8", "114.114.114.114"]
  }
  ```

- 本机或程序访问集群

  ```shell
  # 配置域名映射：宿主机ip rose-master
  cat /etc/hosts
  xxx.xxx.xxx.xxx rose-master
  ```

  