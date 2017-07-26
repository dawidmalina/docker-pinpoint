# DESCRIPTION       Pinpoint APM Collector
# TO_BUILD          docker build -t pinpoint-collector .
# TO_RUN            docker run -d --net=host -e HBASE_HOST=<HOST_IP> -e HBASE_PORT=2181 -e COLLECTOR_TCP_PORT=9994 -e COLLECTOR_UDP_STAT_LISTEN_PORT=9995 -e COLLECTOR_UDP_SPAN_LISTEN_PORT=9996 -p 9994:9994 -p 9995:9995/udp -p 9996:9996/udp --name=pinpoint-collector pinpoint-collector

FROM tomcat:8-jre8

ENV PINPOINT_VERSION=1.6.2

ADD start-collector.sh /usr/local/bin/

RUN chmod a+x /usr/local/bin/start-collector.sh \
    && mkdir -p /assets \
    && curl -SL https://raw.githubusercontent.com/naver/pinpoint/$PINPOINT_VERSION/collector/src/main/resources/pinpoint-collector.properties -o /assets/pinpoint-collector.properties \
    && curl -SL https://raw.githubusercontent.com/naver/pinpoint/$PINPOINT_VERSION/collector/src/main/resources/hbase.properties -o /assets/hbase.properties \
    && curl -SL https://github.com/naver/pinpoint/releases/download/$PINPOINT_VERSION/pinpoint-collector-$PINPOINT_VERSION.war -o pinpoint-collector.war \
    && rm -rf /usr/local/tomcat/webapps \
    && mkdir -p /usr/local/tomcat/webapps \
    && sed -i -e 's/8005/9005/' /usr/local/tomcat/conf/server.xml \
    && sed -i -e 's/8080/9080/' /usr/local/tomcat/conf/server.xml \
    && sed -i -e 's/8009/9009/' /usr/local/tomcat/conf/server.xml \
    && sed -i -e 's/8443/9443/' /usr/local/tomcat/conf/server.xml \
    && unzip pinpoint-collector.war -d /usr/local/tomcat/webapps/ROOT \
    && rm -rf pinpoint-collector.war

EXPOSE 9994 9995 9996

ENTRYPOINT ["/usr/local/bin/start-collector.sh"]
