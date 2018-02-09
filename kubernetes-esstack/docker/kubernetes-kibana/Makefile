VERSION=5.6.4
PROJECT=localhost:5000/plawson

all: build

build:
	docker build -t ${PROJECT}/kubernetes-kibana:latest .
	docker tag ${PROJECT}/kubernetes-kibana:latest ${PROJECT}/kubernetes-kibana:${VERSION}

push: build
	docker push ${PROJECT}/kubernetes-kibana:${VERSION}
	docker push ${PROJECT}/kubernetes-kibana:latest

.PHONY: all build push
