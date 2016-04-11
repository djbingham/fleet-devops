#! /usr/bin/bash

pushd "$( dirname "${BASH_SOURCE[0]}" )" > /dev/null

docker volume create --name registry-data

docker-compose up -d

popd > /dev/null
