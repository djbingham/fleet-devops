#!/usr/bin/env bash

units="$@"

pushd "$( dirname "${BASH_SOURCE[0]}" )/../units" > /dev/null

echo "Restarting ${units}"

fleetctl destroy ${units}
fleetctl submit ${units}
fleetctl load ${units}
fleetctl start ${units}

popd > /dev/null
