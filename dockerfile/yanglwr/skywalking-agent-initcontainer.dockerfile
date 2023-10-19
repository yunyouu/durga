FROM alpine:3

ENV SKYWALKING_AGENT_VERSION=9.0.0

ADD https://dlcdn.apache.org/skywalking/java-agent/${SKYWALKING_AGENT_VERSION}/apache-skywalking-java-agent-${SKYWALKING_AGENT_VERSION}.tgz /

RUN tar -zxvf /apache-skywalking-java-agent-${SKYWALKING_AGENT_VERSION}.tgz && \
    rm -rf /apache-skywalking-java-agent-${SKYWALKING_AGENT_VERSION}.tgz
