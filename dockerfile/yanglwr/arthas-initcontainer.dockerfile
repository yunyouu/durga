FROM alpine:3

ENV ARTHAS_VERSION=3.7.1

ADD https://github.com/alibaba/arthas/releases/download/arthas-all-${ARTHAS_VERSION}/arthas-bin.zip /

RUN unzip -d /arthas-bin /arthas-bin.zip && rm -rf /arthas-bin.zip
