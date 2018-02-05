VERSION=1.1.1
PROJECT=localhost:5000/plawson

all: build

build:
	docker build -t ${PROJECT}/kubernetes-storm-base:latest .
	docker tag ${PROJECT}/kubernetes-storm-base:latest ${PROJECT}/kubernetes-storm-base:${VERSION}

push: build
	docker push ${PROJECT}/kubernetes-storm-base:${VERSION}
	docker push ${PROJECT}/kubernetes-storm-base:latest

.PHONY: all build push
