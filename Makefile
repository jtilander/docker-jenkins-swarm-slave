IMAGENAME?=jtilander/jenkins-swarm-slave
TAG?=latest
DEBUG?=0
MYNAME?=testhost

.PHONY: image clean run debug

ENVIRONMENT=-e MYNAME=$(MYNAME) -e DEBUG=$(DEBUG) -e SWARM_MASTER=$(SWARM_MASTER) -e SWARM_USERNAME=$(SWARM_USERNAME) -e SWARM_PASSWORD=$(SWARM_PASSWORD)


image:
	@docker build -t $(IMAGENAME):$(TAG) .
	@docker images $(IMAGENAME):$(TAG)

clean:
	@docker rmi `docker images -q $(IMAGENAME):$(TAG)`

run:
	@command docker run --rm $(ENVIRONMENT) $(IMAGENAME):$(TAG)

debug:
	@command docker run --rm -it $(ENVIRONMENT) $(IMAGENAME):$(TAG) bash
