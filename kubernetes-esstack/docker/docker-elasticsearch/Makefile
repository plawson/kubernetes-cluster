VERSION=5.6.4
PROJECT=localhost:5000/plawson

all: build

build:
	docker build -t ${PROJECT}/docker-elasticsearch:latest .
	docker tag ${PROJECT}/docker-elasticsearch:latest ${PROJECT}/docker-elasticsearch:${VERSION}

push: build
	docker push ${PROJECT}/docker-elasticsearch:${VERSION}
	docker push ${PROJECT}/docker-elasticsearch:latest

.PHONY: all build push
