VERSION=1.3.3.15
PROJECT=localhost:5000/plawson

all: build

build:
	docker build -t ${PROJECT}/kubernetes-kafka-manager:latest .
	docker tag ${PROJECT}/kubernetes-kafka-manager:latest ${PROJECT}/kubernetes-kafka-manager:${VERSION}

push: build
	docker push ${PROJECT}/kubernetes-kafka-manager:${VERSION}
	docker push ${PROJECT}/kubernetes-kafka-manager:latest

.PHONY: all build push
