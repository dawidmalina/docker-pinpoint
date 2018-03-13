#!/bin/bash
set -e
set -x

PINPOINT_AGENT_HOME=${PINPOINT_AGENT_HOME:-/assets/pinpoint-agent}

COLLECTOR_IP=${COLLECTOR_IP:-}
COLLECTOR_TCP_PORT=${COLLECTOR_TCP_PORT:-}
COLLECTOR_UDP_STAT_LISTEN_PORT=${COLLECTOR_UDP_STAT_LISTEN_PORT:-}
COLLECTOR_UDP_SPAN_LISTEN_PORT=${COLLECTOR_UDP_SPAN_LISTEN_PORT:-}

PROFILER_SAMPLING_RATE=${PROFILER_SAMPLING_RATE:10}

PROFILER_APPLICATIONSERVERTYPE=${PROFILER_APPLICATIONSERVERTYPE:-}
PROFILER_TOMCAT_CONDITIONAL_TRANSFORM=${PROFILER_TOMCAT_CONDITIONAL_TRANSFORM:-}

PROFILER_JSON_GSON=${PROFILER_JSON_GSON:-}
PROFILER_JSON_JACKSON=${PROFILER_JSON_JACKSON:-}
PROFILER_JSON_JSONLIB=${PROFILER_JSON_JSONLIB:-}

DISABLE_DEBUG=${DISABLE_DEBUG:-true}

if [ "$COLLECTOR_IP" != "" ]; then
    sed -i "/profiler.collector.ip=/ s/=.*/=${COLLECTOR_IP}/" ${PINPOINT_AGENT_HOME}/pinpoint.config
fi
if [ "$COLLECTOR_TCP_PORT" != "" ]; then
    sed -i "/profiler.collector.tcp.port=/ s/=.*/=${COLLECTOR_TCP_PORT}/" ${PINPOINT_AGENT_HOME}/pinpoint.config
fi
if [ "$COLLECTOR_UDP_STAT_LISTEN_PORT" != "" ]; then
    sed -i "/profiler.collector.stat.port=/ s/=.*/=${COLLECTOR_UDP_STAT_LISTEN_PORT}/" ${PINPOINT_AGENT_HOME}/pinpoint.config
fi
if [ "$COLLECTOR_UDP_SPAN_LISTEN_PORT" != "" ]; then
    sed -i "/profiler.collector.span.port=/ s/=.*/=${COLLECTOR_UDP_SPAN_LISTEN_PORT}/" ${PINPOINT_AGENT_HOME}/pinpoint.config
fi
if [ "$PROFILER_SAMPLING_RATE" != "" ]; then
    sed -i "/profiler.sampling.rate=/ s/=.*/=${PROFILER_SAMPLING_RATE}/" ${PINPOINT_AGENT_HOME}/pinpoint.config
fi
if [ "$PROFILER_APPLICATIONSERVERTYPE" != "" ]; then
    sed -i "/#profiler.applicationservertype=/ s/=.*/=${PROFILER_APPLICATIONSERVERTYPE}/" ${PINPOINT_AGENT_HOME}/pinpoint.config
fi
if [ "$PROFILER_TOMCAT_CONDITIONAL_TRANSFORM" != "" ]; then
    sed -i "/profiler.tomcat.conditional.transform=/ s/=.*/=${PROFILER_TOMCAT_CONDITIONAL_TRANSFORM}/" ${PINPOINT_AGENT_HOME}/pinpoint.config
fi
if [ "$PROFILER_JSON_GSON" != "" ]; then
    sed -i "/profiler.json.gson=/ s/=.*/=${PROFILER_JSON_GSON}/" ${PINPOINT_AGENT_HOME}/pinpoint.config
fi
if [ "$PROFILER_JSON_JACKSON" != "" ]; then
    sed -i "/profiler.json.jackson=/ s/=.*/=${PROFILER_JSON_JACKSON}/" ${PINPOINT_AGENT_HOME}/pinpoint.config
fi
if [ "$PROFILER_JSON_JSONLIB" != "" ]; then
    sed -i "/profiler.json.jsonlib=/ s/=.*/=${PROFILER_JSON_JSONLIB}/" ${PINPOINT_AGENT_HOME}/pinpoint.config
fi

if [ "$DISABLE_DEBUG" == "true" ]; then
    sed -i 's/level value="DEBUG"/level value="INFO"/' ${PINPOINT_AGENT_HOME}/lib/log4j.xml
fi

exec "$@"
