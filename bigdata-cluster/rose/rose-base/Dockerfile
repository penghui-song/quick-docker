FROM debian:9
LABEL maintainer="sph <penghui.song@foxmail.com>"

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      openjdk-8-jdk \
      net-tools \
      curl \
      netcat \
      gnupg \
      libsnappy-dev \
      vim \
      procps \
    && rm -rf /var/lib/apt/lists/*

#JAVA
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/

#SCALA
ARG SCALA_VERSION=2.11.12
ENV SCALA_HOME /usr/local/scala
ADD scala-$SCALA_VERSION.tgz /usr/local/
RUN ln -s /usr/local/scala-$SCALA_VERSION $SCALA_HOME
ENV PATH $PATH:$SCALA_HOME/bin

#HADOOP
ARG HADOOP_VERSION=2.10.1
ENV HADOOP_HOME /usr/local/hadoop
ENV HADOOP_CONF_DIR /etc/hadoop
ENV PATH $PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin
ADD hadoop-$HADOOP_VERSION.tar.gz /usr/local/
RUN ln -s /usr/local/hadoop-$HADOOP_VERSION $HADOOP_HOME && \
ln -s $HADOOP_HOME/etc/hadoop $HADOOP_CONF_DIR
ADD hadoop/* $HADOOP_CONF_DIR/

#SPARK
ARG SPARK_VERSION=2.4.6
ENV SPARK_HOME /usr/local/spark
ENV SPARK_CONF_DIR /etc/spark
ENV PATH $PATH:$SPARK_HOME/bin
ADD spark-"$SPARK_VERSION"-bin-hadoop2.7.gz /usr/local/
RUN ln -s /usr/local/spark-"$SPARK_VERSION"-bin-hadoop2.7 $SPARK_HOME && \
ln -s $SPARK_HOME/conf $SPARK_CONF_DIR
ADD spark/* $SPARK_CONF_DIR/

#ZOOKEEPER
ARG ZOOKEEPER_VERSION=3.6.2
ENV ZOOKEEPER_HOME /usr/local/zookeeper
ENV ZOOKEEPER_CONF_DIR /etc/zookeeper
ENV PATH $PATH:$ZOOKEEPER_HOME/bin
ADD apache-zookeeper-"$ZOOKEEPER_VERSION"-bin.tar.gz /usr/local/
RUN ln -s /usr/local/apache-zookeeper-"$ZOOKEEPER_VERSION"-bin $ZOOKEEPER_HOME && \
ln -s $ZOOKEEPER_HOME/conf $ZOOKEEPER_CONF_DIR && \
mkdir -p /var/lib/zookeeper
ADD zookeeper/* $ZOOKEEPER_CONF_DIR/

#HBASE
ARG HBASE_VERSION=1.6.0
ENV HBASE_HOME /usr/local/hbase
ENV HBASE_CONF_DIR /etc/hbase
ENV PATH $PATH:$HBASE_HOME/bin
ADD hbase-"$HBASE_VERSION".tar.gz /usr/local/
RUN ln -s /usr/local/hbase-"$HBASE_VERSION" $HBASE_HOME && \
ln -s $HBASE_HOME/conf $HBASE_CONF_DIR && \
mkdir -p /var/lib/hbase
ADD hbase/* $HBASE_CONF_DIR/


#FLINK
ARG FLINK_VERSION=1.12.0
ENV FLINK_HOME /usr/local/flink
ENV FLINK_CONF_DIR /etc/flink
ENV PATH $PATH:$FLINK_HOME/bin
ADD flink-"$FLINK_VERSION"-bin-scala_2.11.tgz /usr/local/
RUN ln -s /usr/local/flink-"$FLINK_VERSION" $FLINK_HOME && \
ln -s $FLINK_HOME/conf $FLINK_CONF_DIR && \
mkdir -p /var/lib/flink
ADD flink/* $FLINK_CONF_DIR/

ADD entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]