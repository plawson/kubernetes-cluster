VERSION=1.2.1
PROJECT=localhost:5000/plawson

all: build

build:
	docker build -t ${PROJECT}/kubernetes-storm-ui:latest .
	docker tag ${PROJECT}/kubernetes-storm-ui:latest ${PROJECT}/kubernetes-storm-ui:${VERSION}

push: build
	docker push ${PROJECT}/kubernetes-storm-ui:${VERSION}
	docker push ${PROJECT}/kubernetes-storm-ui:latest

.PHONY: all build push
