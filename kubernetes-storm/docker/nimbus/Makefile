VERSION=1.2.1
PROJECT=localhost:5000/plawson

all: build

build:
	docker build -t ${PROJECT}/kubernetes-storm-nimbus:latest .
	docker tag ${PROJECT}/kubernetes-storm-nimbus:latest ${PROJECT}/kubernetes-storm-nimbus:${VERSION}

push: build
	docker push ${PROJECT}/kubernetes-storm-nimbus:${VERSION}
	docker push ${PROJECT}/kubernetes-storm-nimbus:latest

.PHONY: all build push
