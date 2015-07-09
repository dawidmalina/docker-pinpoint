# DESCRIPTION       Pinpoint APM HBase (Data Storage)
# TO_BUILD          docker build -t pinpoint-hbase .
# TO_RUN            docker run -d --net=host -p 2181:2181 -p 60000:60000 -p 60010:60010 -p 60020:60020 -p 60030:60030 --name=pinpoint-hbase pinpoint-hbase

FROM java:8-jdk

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
ENV HBASE_VERSION 1.0.1.1
ENV HBASE_HOME /opt/hbase/hbase-$HBASE_VERSION
ENV PINPOINT_VERSION 1.1.0

RUN mkdir -p /opt/hbase && \
    cd /opt/hbase && \
    curl -SL "http://apache.mirrors.pair.com/hbase/$HBASE_VERSION/hbase-$HBASE_VERSION-bin.tar.gz" -o hbase.tar.gz && \
    tar xfvz hbase.tar.gz && \
    rm -rf hbase.tar.gz

ADD hbase-site.xml /opt/hbase/hbase-$HBASE_VERSION/conf/hbase-site.xml

RUN curl -SL "https://raw.githubusercontent.com/naver/pinpoint/$PINPOINT_VERSION/scripts/hbase-create.hbase" -o /opt/hbase/hbase-create.hbase && \
    $HBASE_HOME/bin/start-hbase.sh && \
    sleep 10 && \
    $HBASE_HOME/bin/hbase shell /opt/hbase/hbase-create.hbase && \
    $HBASE_HOME/bin/stop-hbase.sh

VOLUME /home/pinpoint/hbase
VOLUME /home/pinpoint/zookeeper

# zookeeper
EXPOSE 2181
# HBase Master API port
EXPOSE 60000
# HBase Master Web UI
EXPOSE 60010
# Regionserver API port
EXPOSE 60020
# HBase Regionserver web UI
EXPOSE 60030

CMD /opt/hbase/hbase-$HBASE_VERSION/bin/hbase master start
