VERSION=5.6.4
PROJECT=localhost:5000/plawson

all: build

build:
	docker build -t ${PROJECT}/kubernetes-elasticsearch:latest .
	docker tag ${PROJECT}/kubernetes-elasticsearch:latest ${PROJECT}/kubernetes-elasticsearch:${VERSION}

push: build
	docker push ${PROJECT}/kubernetes-elasticsearch:${VERSION}
	docker push ${PROJECT}/kubernetes-elasticsearch:latest

.PHONY: all build push
