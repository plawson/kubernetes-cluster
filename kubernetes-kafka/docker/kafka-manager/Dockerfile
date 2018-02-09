FROM openjdk:8-jdk-alpine

# Install required packages
RUN apk add --no-cache \
    bash \
    su-exec \
    unzip

    ENV KAFKA_USER=kafka

    RUN set -ex; \
        adduser -D "$KAFKA_USER";

    ARG DISTRO_NAME=kafka-manager-1.3.3.15
    ARG DISTRO_VERSION=1.3.3.15

    # Download Apache Kafka Manager
    RUN set -ex; \
        wget -q "https://github.com/yahoo/kafka-manager/archive/$DISTRO_VERSION.tar.gz"; \
        tar xzf $DISTRO_VERSION.tar.gz; \
	chown -R "$KAFKA_USER:$KAFKA_USER" $DISTRO_NAME; \
        cd $DISTRO_NAME/; \
	./sbt clean dist; \
	cd target/universal/; \
	unzip $DISTRO_NAME.zip

    WORKDIR $DISTRO_NAME/target/universal/$DISTRO_NAME

    EXPOSE 9000

    COPY docker-entrypoint.sh /
    ENTRYPOINT ["/docker-entrypoint.sh"]
    CMD ["./bin/kafka-manager"]
