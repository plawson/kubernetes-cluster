FROM localhost:5000/plawson/kubernetes-storm-base

RUN set -ex \
    && apt-get install -y dnsutils

ADD start.sh /
ADD update_hosts.sh query_dns.py /

RUN set -ex \
    && chmod 755 /start.sh /update_hosts.sh /query_dns.py

EXPOSE 6700 6701 6702 6703

WORKDIR /opt/apache-storm

ENTRYPOINT ["/start.sh"]
