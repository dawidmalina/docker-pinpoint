# DESCRIPTION       Pinpoint APM Agent Volume
# TO_BUILD          docker build -t pinpoint-agent .
# TO_RUN            docker run --name=pinpoint-agent pinpoint-agent

FROM alpine:3.5

ENV PINPOINT_VERSION=1.6.0

ADD configure-agent.sh /usr/local/bin/

RUN apk add --update curl bash \
    && chmod a+x /usr/local/bin/configure-agent.sh \
    && mkdir -p /assets \
    && curl -SL https://raw.githubusercontent.com/naver/pinpoint/$PINPOINT_VERSION/agent/src/main/resources/pinpoint.config -o /assets/pinpoint.config \
    && curl -SL https://github.com/naver/pinpoint/releases/download/$PINPOINT_VERSION/pinpoint-agent-$PINPOINT_VERSION.tar.gz -o pinpoint-agent-$PINPOINT_VERSION.tar.gz \
    && gunzip pinpoint-agent-$PINPOINT_VERSION.tar.gz \
    && tar -xf pinpoint-agent-$PINPOINT_VERSION.tar -C /assets \
    && if test -d /assets/pinpoint-agent-$PINPOINT_VERSION; then mv /assets/pinpoint-agent-$PINPOINT_VERSION /assets/pinpoint-agent; fi \
    && sed -i 's/DEBUG/INFO/' /assets/lib/log4j.xml \
    && rm pinpoint-agent-$PINPOINT_VERSION.tar \
    && apk del curl \
    && rm /var/cache/apk/*

VOLUME /assets/pinpoint-agent

ENTRYPOINT ["/usr/local/bin/configure-agent.sh"]
