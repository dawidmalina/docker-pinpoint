#!/bin/bash
set -e
set -x

CLUSTER_ENABLE=${CLUSTER_ENABLE:-false}
CLUSTER_ZOOKEEPER_ADDRESS=${CLUSTER_ZOOKEEPER_ADDRESS:-localhost}
CLUSTER_WEB_TCP_PORT=${CLUSTER_WEB_TCP_PORT:-9997}

ENABLE_APPLICATION_INSPECTOR=${ENABLE_APPLICATION_INSPECTOR:-false}

ADMIN_PASSWORD=${ADMIN_PASSWORD:-admin}

HBASE_HOST=${HBASE_HOST:-localhost}
HBASE_PORT=${HBASE_PORT:-2181}

DISABLE_DEBUG=${DISABLE_DEBUG:-true}
DISABLE_ANALYTICS=${DISABLE_ANALYTICS:-true}

cp /assets/pinpoint-web.properties /usr/local/tomcat/webapps/ROOT/WEB-INF/classes/pinpoint-web.properties
cp /assets/hbase.properties /usr/local/tomcat/webapps/ROOT/WEB-INF/classes/hbase.properties

sed -i "s/cluster.enable=true/cluster.enable=${CLUSTER_ENABLE}/g" /usr/local/tomcat/webapps/ROOT/WEB-INF/classes/pinpoint-web.properties
sed -i "s/cluster.zookeeper.address=localhost/cluster.zookeeper.address=${CLUSTER_ZOOKEEPER_ADDRESS}/g" /usr/local/tomcat/webapps/ROOT/WEB-INF/classes/pinpoint-web.properties

sed -i "s/config.show.applicationStat=false/config.show.applicationStat=${ENABLE_APPLICATION_INSPECTOR}/g" /usr/local/tomcat/webapps/ROOT/WEB-INF/classes/pinpoint-web.properties

sed -i "s/admin.password=admin/admin.password=${ADMIN_PASSWORD}/g" /usr/local/tomcat/webapps/ROOT/WEB-INF/classes/pinpoint-web.properties

sed -i "s/hbase.client.host=localhost/hbase.client.host=${HBASE_HOST}/g" /usr/local/tomcat/webapps/ROOT/WEB-INF/classes/hbase.properties
sed -i "s/hbase.client.port=2181/hbase.client.port=${HBASE_PORT}/g" /usr/local/tomcat/webapps/ROOT/WEB-INF/classes/hbase.properties

if [ "$CLUSTER_WEB_TCP_PORT" != "" ]; then
    sed -i "/cluster.web.tcp.port=/ s/=.*/=${CLUSTER_WEB_TCP_PORT}/" /usr/local/tomcat/webapps/ROOT/WEB-INF/classes/pinpoint-web.properties
fi

if [ "$DISABLE_DEBUG" == "true" ]; then
    sed -i 's/level value="DEBUG"/level value="INFO"/' /usr/local/tomcat/webapps/ROOT/WEB-INF/classes/log4j.xml
fi

if [ "$DISABLE_ANALYTICS" == "true" ]; then
    sed -i 's/config.sendUsage.*/config.sendUsage=false/' /usr/local/tomcat/webapps/ROOT/WEB-INF/classes/pinpoint-web.properties
fi

exec /usr/local/tomcat/bin/catalina.sh run
