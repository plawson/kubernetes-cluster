FROM ubuntu:16.04

RUN set -ex \
    && apt-get update \
    && apt-get install -y openjdk-8-jre-headless tar curl \
    && apt-get install -y python2.7 \
    && apt-get install -y python3.5 \
    && apt-get install -y python3-pip \
    && ln -s /usr/bin/python3 /usr/bin/python

RUN set -ex \
    && curl -s http://apache.mediamirrors.org/storm/apache-storm-1.1.1/apache-storm-1.1.1.tar.gz | \
       tar zxf - -C /opt && \
       mv /opt/apache-storm-1.1.1 /opt/apache-storm

ADD configure.sh /
