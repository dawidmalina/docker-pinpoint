# DESCRIPTION       Pinpoint APM Agent Volume
# TO_BUILD          docker build -t pinpoint-agent .
# TO_RUN            docker run --name=pinpoint-agent pinpoint-agent

FROM java:8-jdk

ENV PINPOINT_VERSION 1.1.1

#RUN opkg-install bash curl

RUN mkdir -p /opt/app \
    && curl -L -O -k "https://github.com/naver/pinpoint/releases/download/$PINPOINT_VERSION/pinpoint-agent-$PINPOINT_VERSION.tar.gz" -o pinpoint-agent.tar.gz \
    && gunzip pinpoint-agent-$PINPOINT_VERSION.tar.gz \
    && tar -xf pinpoint-agent-$PINPOINT_VERSION.tar -C /opt/app \
    && rm pinpoint-agent-$PINPOINT_VERSION.tar

RUN sed -i 's/profiler.collector.ip=127.0.0.1/profiler.collector.ip=192.168.59.103/' /opt/app/pinpoint-agent/pinpoint.config

ENTRYPOINT ["bash"]
