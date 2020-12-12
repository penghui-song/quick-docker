FROM phsong/rose-base:0.0.1
LABEL maintainer="sph <penghui.song@foxmail.com>"

#KAFKA
ARG SCALA_VERSION=2.11
ARG KAFKA_VERSION=2.4.1
ENV KAFKA_HOME /usr/local/kafka
ENV KAFKA_CONF_DIR /etc/kafka
ENV PATH $PATH:$KAFKA_HOME/bin
ADD kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz /usr/local/
RUN ln -s /usr/local/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION" $KAFKA_HOME && \
ln -s $KAFKA_HOME/config $KAFKA_CONF_DIR && \
mkdir -p /var/lib/kafka
ADD kafka/* $KAFKA_CONF_DIR/

RUN id=$((RANDOM%999999+1)) && sed -i "s/broker.id=0/broker.id=${id}/" $KAFKA_CONF_DIR/server.properties

ADD run.sh /run.sh
CMD ["-c","/run.sh"]