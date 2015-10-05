#!/bin/bash
set -e
set -x

COLLECTOR_IP=${COLLECTOR_IP:-}

sed -i 's/profiler.collector.ip=127.0.0.1/profiler.collector.ip='"${COLLECTOR_IP}"'/' /opt/app/pinpoint-agent/pinpoint.config
