IMAGENAME?=jtilander/jenkins-swarm-slave
TAG?=arm
DEBUG?=0
MYNAME?=testhost

.PHONY: image clean run debug

ENVIRONMENT=-e MYNAME=$(MYNAME) -e DEBUG=$(DEBUG) -e SWARM_MASTER=$(SWARM_MASTER) -e SWARM_USERNAME=$(SWARM_USERNAME) -e SWARM_PASSWORD=$(SWARM_PASSWORD)
VOLUMES=-v /tmp/jenkins:/home/jenkins

image:
	@docker build -t $(IMAGENAME):$(TAG) .
	@docker images $(IMAGENAME):$(TAG)

clean:
	@docker rmi `docker images -q $(IMAGENAME):$(TAG)`

run:
	@mkdir -p /tmp/jenkins
	@chmod a+w /tmp/jenkins
	@docker run --rm $(ENVIRONMENT) $(VOLUMES) $(IMAGENAME):$(TAG)

debug:
	@docker run --rm -it $(ENVIRONMENT) $(IMAGENAME):$(TAG) bash
