FROM phsong/rose-base:0.0.1
LABEL maintainer="sph <penghui.song@foxmail.com>"

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      mariadb-server \
      mariadb-client \
    && rm -rf /var/lib/apt/lists/*

#MYSQL
COPY mysql/init.sql /init.sql
RUN sed -i 's/bind-address/#bind-address/' /etc/mysql/mariadb.conf.d/50-server.cnf && \
service mysql restart && \
mysql -uroot < /init.sql

#HIVE
ARG HIVE_VERSION=2.3.7
ENV HIVE_HOME /usr/local/hive
ENV HIVE_CONF_DIR=/etc/hive
ENV PATH $PATH:$HIVE_HOME/bin
ADD hive-$HIVE_VERSION.tar.gz /usr/local/
RUN ln -s /usr/local/hive-$HIVE_VERSION $HIVE_HOME && \
ln -s $HIVE_HOME/conf $HIVE_CONF_DIR
COPY hive/* $HIVE_CONF_DIR/
COPY mysql-connector-java-5.1.6.jar $HIVE_HOME/lib/

RUN ls -s $HIVE_CONF_DIR/hive-site.xml $SPARK_CONF_DIR/

#KAFKA EAGLE
ARG KE_VERSION=2.0.3
ENV KE_HOME /usr/local/kafka-eagle
ENV KE_CONF_DIR=/etc/kafka-eagle
ENV PATH $PATH:$KE_HOME/bin
ADD kafka-eagle-bin-$KE_VERSION.tar.gz /usr/local/
RUN ln -s /usr/local/kafka-eagle-bin-$KE_VERSION $KE_HOME && \
ln -s $KE_HOME/conf $KE_CONF_DIR
COPY kafka-eagle/* $KE_CONF_DIR/

ADD run.sh /run.sh
CMD ["-c","/run.sh"]