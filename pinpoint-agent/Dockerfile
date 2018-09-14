# DESCRIPTION       Pinpoint APM Agent Volume
# TO_BUILD          docker build -t pinpoint-agent .
# TO_RUN            docker run --name=pinpoint-agent pinpoint-agent

FROM alpine:3.7

ENV PINPOINT_VERSION=1.8.0

ADD configure-agent.sh /usr/local/bin/

RUN apk add --update curl bash \
    && chmod a+x /usr/local/bin/configure-agent.sh \
    && mkdir -p /assets/pinpoint-agent \
    && curl -SL https://raw.githubusercontent.com/naver/pinpoint/$PINPOINT_VERSION/agent/src/main/resources-release/pinpoint.config -o /assets/pinpoint.config \
    && curl -SL https://github.com/naver/pinpoint/releases/download/$PINPOINT_VERSION/pinpoint-agent-$PINPOINT_VERSION.tar.gz -o pinpoint-agent-$PINPOINT_VERSION.tar.gz \
    && gunzip pinpoint-agent-$PINPOINT_VERSION.tar.gz \
    && tar -xf pinpoint-agent-$PINPOINT_VERSION.tar -C /assets/pinpoint-agent \
    && curl -SL https://raw.githubusercontent.com/naver/pinpoint/$PINPOINT_VERSION/agent/src/main/resources-release/lib/log4j.xml -o /assets/pinpoint-agent/lib/log4j.xml \
    && sed -i 's/DEBUG/INFO/' /assets/pinpoint-agent/lib/log4j.xml \
    && rm pinpoint-agent-$PINPOINT_VERSION.tar \
    && apk del curl \
    && rm /var/cache/apk/*

VOLUME ["/assets/pinpoint-agent"]

ENTRYPOINT ["/usr/local/bin/configure-agent.sh"]
CMD ["tail", "-f", "/dev/null"]
