#! /usr/bin/bash

pushd "$( dirname "${BASH_SOURCE[0]}" )" > /dev/null

docker volume create --name proxy-certs
docker volume create --name proxy-conf
docker volume create --name proxy-vhost
docker volume create --name proxy-webroot

docker-compose up -d

popd > /dev/null
