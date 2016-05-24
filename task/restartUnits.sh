#!/usr/bin/env bash

# Destroy, resubmit and start all units
pushd "$( dirname "${BASH_SOURCE[0]}" )/../units" > /dev/null

units="reverse-proxy reverse-proxy-generator reverse-proxy-encrypt"
units="$units docker-registry docker-registry-web"
units="$units gogs"
units="$units toran-proxy"
units="$units jenkins-master jenkins-slave@1"

echo "Restarting units: $units"

fleetctl destroy $units
fleetctl submit $units
fleetctl load $units
fleetctl start $units

popd > /dev/null
