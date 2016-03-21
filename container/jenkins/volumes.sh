#! /bin/bash

# Jenkins data volume.
docker run \
    --name "jenkins-data" \
    -v /var/jenkins_home \
    --entrypoint /bin/true \
    jenkins
