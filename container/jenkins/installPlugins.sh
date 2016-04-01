#! /bin/bash

# Create Jenkins CLI container for running Jenkins commands outside the web interface.
docker run \
	-d \
	--name jenkins-cli \
	--workdir /var/jenkins_home \
	--entrypoint bash \
	jenkins

# Create SSH key for Jenkins CLI and add it to Jenkins authorized keys.
docker exec --user "jenkins" jenkins-cli ssh-keygen -f /var/jenkins_home/.ssh/id_rsa -t rsa -N ""
docker exec --user "jenkins" jenkins bash -c "echo $(docker exec jenkins-cli cat /var/jenkins_home/.ssh/id_rsa.pub) >> /var/jenkins_home/.ssh/authorized_keys"

# Download jenkins-cli.jar to Jenkins CLI container.
docker exec jenkins-cli wget $JENKINS_DOMAIN/jnlpJars/jenkins-cli.jar

# Install Jenkins plugins.
docker exec jenkins java -jar jenkins-cli.jar -s $JENKINS_DOMAIN install-plugin git
docker exec jenkins java -jar jenkins-cli.jar -s $JENKINS_DOMAIN install-plugin pipeline

# Restart Jenkins.
docker exec jenkins-cli java -jar jenkins-cli.jar -s $JENKINS_DOMAIN restart

# Remove up Jenkins CLI container, since we've finished with it.
docker rm -v jenkins-cli
