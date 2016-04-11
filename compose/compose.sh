#! /usr/bin/bash

pushd "$( dirname "${BASH_SOURCE[0]}" )" > /dev/null

pushd reverse-proxy > /dev/null && docker-compose up -d && popd > /dev/null
pushd gogs > /dev/null && docker-compose up -d && popd > /dev/null
pushd jenkins > /dev/null && docker-compose up -d && popd > /dev/null
pushd registry > /dev/null && docker-compose up -d && popd > /dev/null
pushd toran-proxy > /dev/null && docker-compose up -d && popd > /dev/null

popd > /dev/null
