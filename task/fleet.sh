#!/usr/bin/env bash

command=$1

pushd "$( dirname "${BASH_SOURCE[0]}" )/../units" > /dev/null

units="reverse-proxy reverse-proxy-generator reverse-proxy-encrypt"
units="$units docker-registry docker-registry-web"
units="$units gogs"
units="$units toran-proxy"
units="$units jenkins-master jenkins-slave@1"

echo "Executing fleetctl $1 $units"

fleetctl $1 $units

popd > /dev/null
