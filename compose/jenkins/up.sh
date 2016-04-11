#! /usr/bin/bash

pushd "$( dirname "${BASH_SOURCE[0]}" )" > /dev/null

docker volume create --name jenkins-master-data
docker volume create --name jenkins-slave-data

docker-compose up -d

docker run --rm -v jenkins-master-data:/var/jenkins_home --user root --entrypoint chown jenkins -R jenkins:jenkins /var/jenkins_home

popd > /dev/null
