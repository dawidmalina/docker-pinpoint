# DESCRIPTION       Pinpoint APM Agent Volume
# TO_BUILD          docker build -t pinpoint-agent .
# TO_RUN            docker run --name=pinpoint-agent pinpoint-agent

FROM alpine:3.2

ENV PINPOINT_VERSION 1.1.1

RUN apk add --update curl bash

RUN mkdir -p /opt/app \
    && curl -L -O -k "https://github.com/naver/pinpoint/releases/download/$PINPOINT_VERSION/pinpoint-agent-$PINPOINT_VERSION.tar.gz" -o pinpoint-agent.tar.gz \
    && gunzip pinpoint-agent-$PINPOINT_VERSION.tar.gz \
    && tar -xf pinpoint-agent-$PINPOINT_VERSION.tar -C /opt/app \
    && rm pinpoint-agent-$PINPOINT_VERSION.tar

ADD configure.sh /configure.sh
RUN chmod a+x /configure.sh

VOLUME /opt/app/pinpoint-agent

CMD ["/configure.sh"]
