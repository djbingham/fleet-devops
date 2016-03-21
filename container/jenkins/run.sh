#! /bin/bash

# Jenkins.
docker run \
	--name "jenkins" \
	-d \
    --restart always \
	--volumes-from "jenkins-data" \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v $(which docker):/usr/bin/docker \
    -v /usr/lib/libdevmapper.so.1.02:/usr/lib/libdevmapper.so.1.02 \
	-e VIRTUAL_HOST=ci.davidjbingham.co.uk \
	-e VIRTUAL_PORT=8080 \
	-e LETSENCRYPT_HOST=ci.davidjbingham.co.uk \
	-e LETSENCRYPT_EMAIL=davidjohnbingham@gmail.com \
	jenkins

# Jenkins slave for running Docker-reliant builds.
docker run \
    --name "jenkins-slave-docker" \
    -d \
    --restart always \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v $(which docker):/usr/bin/docker \
    -v /usr/lib/libdevmapper.so.1.02:/usr/lib/libdevmapper.so.1.02 \
    evarga/jenkins-slave

# Create SSH directory on jenkins and slave containers
docker exec jenkins mkdir /var/jenkins_home/.ssh
docker exec jenkins-slave-docker mkdir /home/jenkins/.ssh

# Create SSH keys for jenkins and slave containers
docker exec jenkins ssh-keygen -f /var/jenkins_home/.ssh/id_rsa -t rsa -N 'jenkins-master-91827364'
docker exec jenkins-slave-docker ssh-keygen -f /home/jenkins/.ssh/id_rsa -t rsa -N 'jenkins-slave-docker-91827364'

# Copy SSH public key from jenkins to slave container
docker exec jenkins-slave-docker touch /home/jenkins/.ssh/authorized_keys
docker exec jenkins-slave-docker chown -R jenkins:jenkins /home/jenkins/.ssh
docker exec jenkins-slave-docker bash -c "echo $(docker exec jenkins cat /var/jenkins_home/.ssh/id_rsa.pub) > /home/jenkins/.ssh/authorized_keys"

# Create docker user and group in Jenkins container with same ID as docker group on host machine
docker exec jenkins-slave-docker addgroup --gid $(ls -aln /var/run/docker.sock  | awk '{print $4}') docker
docker exec jenkins-slave-docker adduser --gecos --disabled-login --disabled-password --uid $(ls -aln /var/run/docker.sock  | awk '{print $3}') --ingroup docker docker

# Add jenkins user to docker group
docker exec jenkins-slave-docker adduser jenkins docker
