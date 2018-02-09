VERSION=8u131_alpine_nov
PROJECT=localhost:5000/plawson

all: build

build:
	docker build -t ${PROJECT}/docker-jre:latest .
	docker tag ${PROJECT}/docker-jre:latest ${PROJECT}/docker-jre:${VERSION}

push: build
	docker push ${PROJECT}/docker-jre:${VERSION}
	docker push ${PROJECT}/docker-jre:latest

.PHONY: all build push
