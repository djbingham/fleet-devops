#! /bin/bash

echo ""
echo "-- Stopping containers."
echo ""
docker stop jenkins-slave-docker jenkins registry-web registry gogs proxy-encrypt proxy-generator proxy

echo ""
echo "-- Starting containers."
echo ""
# Start containers one by one to ensure Docker can setup hosts correctly in each
docker start proxy
docker start proxy-generator
docker start proxy-encrypt
docker start registry-web
docker start jenkins-slave-docker
docker start gogs
docker start registry
docker start jenkins
