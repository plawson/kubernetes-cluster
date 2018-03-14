VERSION=1.2.1
PROJECT=localhost:5000/plawson

all: build

build:
	docker build -t ${PROJECT}/kubernetes-storm-worker:latest .
	docker tag ${PROJECT}/kubernetes-storm-worker:latest ${PROJECT}/kubernetes-storm-worker:${VERSION}

push: build
	docker push ${PROJECT}/kubernetes-storm-worker:${VERSION}
	docker push ${PROJECT}/kubernetes-storm-worker:latest

.PHONY: all build push
