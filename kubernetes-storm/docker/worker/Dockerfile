FROM localhost:5000/plawson/kubernetes-storm-base

ADD start.sh /

EXPOSE 6700 6701 6702 6703

WORKDIR /opt/apache-storm

ENTRYPOINT ["/start.sh"]
