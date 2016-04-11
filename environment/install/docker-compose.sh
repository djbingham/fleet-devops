#! /usr/bin/bash

# Install docker-compose
mkdir -p /opt/bin
curl --progress-bar -s -L https://github.com/docker/compose/releases/download/${docker_compose_version}/docker-compose-`uname -s`-`uname -m` > /opt/bin/docker-compose
chmod +x /opt/bin/docker-compose
