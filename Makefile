NS ?= xymox
VERSION ?= 0.1
REPOSITORY ?= quay.io

IMAGE_NAME ?= ubi8-debug-toolkit
DOCKER = podman

.PHONY: build push shell release

build: Dockerfile.ubi8
	$(DOCKER) build --rm --no-cache -t $(REPOSITORY)/$(NS)/$(IMAGE_NAME):$(VERSION) -f Dockerfile.ubi8 . 

push:
	$(DOCKER) push $(REPOSITORY)/$(NS)/$(IMAGE_NAME):$(VERSION)

shell:
	$(DOCKER) run --rm --name $(IMAGE_NAME) -ti $(REPOSITORY)/$(NS)/$(IMAGE_NAME):$(VERSION) /bin/bash

release: build
	make push -e VERSION=$(VERSION)

default: build
