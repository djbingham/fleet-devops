#! /bin/bash

docker pull jenkins
docker pull evarga-jenkins-slave

# Jenkins data volume.
if [ ! "$(docker ps -a --filter 'name=jenkins-data')" == "" ]; then
	docker run \
	    --name "jenkins-data" \
	    -v /var/jenkins_home \
	    --entrypoint /bin/true \
	    jenkins
fi

# Jenkins slave data volume.
# Workspace must be mounted from the host in order to be mountable with Docker commands inside Jenkins builds.
if [ ! "$(docker ps -a --filter 'name=jenkins-slave-data')" == "" ]; then
	docker run \
	    --name "jenkins-slave-data" \
	    -v /home/jenkins \
	    --entrypoint /bin/true \
    	evarga/jenkins-slave

	# Change owner of volume directory to jenkins user
	docker run \
		--rm \
		--volumes-from "jenkins-slave-data" \
		--entrypoint chown \
		jenkins \
		-R jenkins:jenkins /home/jenkins
fi

# Jenkins.
docker run \
	--name "jenkins" \
	-d \
    --restart always \
	--volumes-from "jenkins-data" \
	-e VIRTUAL_HOST="$JENKINS_DOMAIN" \
	-e VIRTUAL_PORT="8080" \
	-e LETSENCRYPT_HOST="$JENKINS_DOMAIN" \
	-e LETSENCRYPT_EMAIL="$SSL_EMAIL" \
	jenkins

# Jenkins slave for running Docker-reliant builds.
docker run \
    --name "jenkins-slave" \
    -d \
    --restart always \
	--workdir "/home/jenkins" \
	--volumes-from "jenkins-slave-data" \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v $(which docker):/usr/bin/docker \
    -v /usr/lib/libdevmapper.so.1.02:/usr/lib/libdevmapper.so.1.02 \
    evarga/jenkins-slave
