#! /bin/bash

# Install git in Jenkins slave
docker exec jenkins-slave apt-get update
docker exec jenkins-slave apt-get upgrade -y
docker exec jenkins-slave apt-get install git -y

# Create SSH directory on Jenkins and slave container
docker exec --user "jenkins" jenkins mkdir /var/jenkins_home/.ssh
docker exec --user "jenkins" jenkins-slave mkdir /home/jenkins/.ssh
docker exec --user "jenkins" jenkins-slave mkdir /home/jenkins/.ssh

# Create SSH key for jenkins user and add it to authorized keys in slave container
docker exec --user "jenkins" jenkins ssh-keygen -f /var/jenkins_home/.ssh/id_rsa -t rsa -N ""
docker exec --user "jenkins" jenkins-slave bash -c "echo $(docker exec jenkins cat /var/jenkins_home/.ssh/id_rsa.pub) >> /home/jenkins/.ssh/authorized_keys"

# Copy SSH key to slave container so that both master and slave use the same credentials for git clone, etc.
docker exec --user "jenkins" jenkins-slave bash -c "echo '$(docker exec jenkins cat /var/jenkins_home/.ssh/id_rsa.pub)' > /home/jenkins/.ssh/id_rsa.pub"
docker exec --user "jenkins" jenkins-slave bash -c "echo '$(docker exec jenkins cat /var/jenkins_home/.ssh/id_rsa)' > /home/jenkins/.ssh/id_rsa"
docker exec --user "jenkins" jenkins-slave bash -c "chmod 600 /home/jenkins/.ssh/id_rsa"

# Create docker user and group in Jenkins slave container with same ID as docker group on host machine
docker exec jenkins-slave addgroup --gid $(ls -aln /var/run/docker.sock  | awk '{print $4}') docker
docker exec jenkins-slave adduser --gecos --disabled-login --disabled-password --uid $(ls -aln /var/run/docker.sock  | awk '{print $3}') --ingroup docker docker

# Add jenkins user to docker group in slave container
docker exec jenkins-slave adduser jenkins docker

# Restart slave container to ensure that user/group changes are picked up
docker restart jenkins-slave
