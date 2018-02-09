VERSION=1.0-10.2.1
PROJECT=localhost:5000/plawson

all: build

build:
	docker build -t ${PROJECT}/kubernetes-kafka:latest .
	docker tag ${PROJECT}/kubernetes-kafka:latest ${PROJECT}/kubernetes-kafka:${VERSION}

push: build
	docker push ${PROJECT}/kubernetes-kafka:${VERSION}
	docker push ${PROJECT}/kubernetes-kafka:latest

.PHONY: all build push
