include make_env

NS ?= preconcieved-notions
VERSION ?= 0.1

IMAGE_NAME ?= ashamed-nostradamus
CONTAINER_NAME ?= IMAGE_NAME
CONTAINER_INSTANCE ?= d

.PHONY: pipeline build push shell run test start stop reload rm clean release

build: Dockerfile
	docker build -t $(NS)/$(IMAGE_NAME):$(VERSION) -f Dockerfile .

buildgpu: Dockerfile.gpu
	docker build -t $(NS)/$(IMAGE_NAME):$(VERSION) -f Dockerfile.gpu .


push:
	docker push $(NS)/$(IMAGE_NAME):$(VERSION)

shell:
	docker run --rm --runtime=nvidia --name=$(CONTAINER_NAME)-$(CONTAINER_INSTANCE) -i -t $(PORTS) $(VOLUMES) $(ENV) $(NS)/$(IMAGE_NAME)\:$(VERSION) /bin/bash

run:
	docker run --rm --runtime=nvidia --name=$(CONTAINER_NAME)-$(CONTAINER_INSTANCE) -i -t $(PORTS) $(VOLUMES) $(ENV) $(NS)/$(IMAGE_NAME):$(VERSION)


runit:
	docker run --rm --runtime=nvidia --name=$(CONTAINER_NAME)-$(CONTAINER_INSTANCE) -i -t $(PORTS) $(VOLUMES) $(ENV) --entrypoint=/bin/bash $(NS)/$(IMAGE_NAME):$(VERSION)

test: build
	docker run --rm--runtime=nvidia --name=$(CONTAINER_NAME)-$(CONTAINER_INSTANCE) -t -i $(PORTS) $(VOLUMES) $(ENV) $(NS)/$(IMAGE_NAME):$(VERSION) $(TEST)


stop:
	docker stop $(CONTAINER_NAME)-$(CONTAINER_INSTANCE)

reload: stop
	make run

rm:	stop
	docker rm $(CONTAINER_NAME)-$(CONTAINER_INSTANCE)

clean:
	echo "WRITE CLEAN"

release: build
	 make push -e VERSION=$(VERSION)


default: build

