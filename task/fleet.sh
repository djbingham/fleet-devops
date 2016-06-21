#!/usr/bin/env bash

command=$1

pushd "$( dirname "${BASH_SOURCE[0]}" )/../units" > /dev/null

units="reverse-proxy reverse-proxy-generator reverse-proxy-encrypt"
units="$units docker-registry"
units="$units gogs"
units="$units toran-proxy"
units="$units jenkins-master jenkins-slave@1"
units="$units shipyard-controller shipyard-db swarm-manager swarm-agent@1"

echo "Executing fleetctl $1 $units"

fleetctl ${command} ${units}

popd > /dev/null
