FROM hypriot/rpi-alpine:3.5
MAINTAINER Jim Tilander

RUN apk add --no-cache \
		openjdk8 \
		curl \
		git \
		make \
		bash \
		docker

ENV SWARM_VERSION=3.4 \
    GOSU_VERSION=1.10

RUN curl --create-dirs -sSLo /usr/share/jenkins/swarm-client-${SWARM_VERSION}.jar https://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/swarm-client/${SWARM_VERSION}/swarm-client-${SWARM_VERSION}.jar \
  && chmod 755 /usr/share/jenkins

RUN curl -SsL https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-armhf > /sbin/gosu && chmod a+x /sbin/gosu

ENV MYHOME=/home/jenkins \
	UID=999
RUN adduser -S -D -u $UID jenkins && \
	mkdir -p $MYHOME && chmod g+rwx $MYHOME

ENV JENKINS_MEMORY=200M

ENV SWARM_MASTER=http://jenkins:8080
ENV SWARM_EXECUTORS=1
ENV SWARM_USERNAME=
ENV SWARM_PASSWORD=password
ENV SWARM_LABELS="docker linux swarm arm armhf"
ENV MYTIMEZONE="America/Los_Angeles"
ENV JAVA_OPTS="-Xms$JENKINS_MEMORY -Xmx$JENKINS_MEMORY -Djava.awt.headless=true -Duser.timezone=$MYTIMEZONE -Dorg.apache.commons.jelly.tags.fmt.timeZone=$MYTIMEZONE"

WORKDIR $MYHOME
VOLUME ["$MYHOME"]

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["swarm"]
