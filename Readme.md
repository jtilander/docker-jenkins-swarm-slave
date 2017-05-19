# Jenkins Swarm Docker Client

This is a docker image that can be spun up to join any Jenkins cluster that supports swarm.

This aims to have the most basic of tools installed under the Jenkins user.

E.g. 

* make
* git

The rest of the toolset should pulled in Docker images that you derive from this one.

# Configuration

|Name|Default|Notes|
|----|-------|-----|
|DEBUG|0|Show more diagnostics|
|SWARM_MASTER|http://jenkins:8080|Where is the jenkins server?|
|SWARM_USERNAME||Connect as this user to the jenkins server, empty for no auth|
|SWARM_PASSWORD|password||
|SWARM_EXECUTORS|1|How many parallel executors we will have on this node|
|SWARM_LABELS|docker linux swarm amd64|Space separated list of labels for this node|
|JENKINS_MEMORY|200M|Amount of memory the jenkins swarm slave can use|
|MYNAME|`hostname`|Display name of the swarm client in jenkins UI|

