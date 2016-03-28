#! /bin/bash

pushd "$( dirname "${BASH_SOURCE[0]}" )/.." > /dev/null

echo ""
echo "Initialising reverse-proxy containers."
. container/reverse-proxy/volumes.sh
. container/reverse-proxy/run.sh

echo ""
echo "Initialising Docker registry containers."
. container/registry/volumes.sh
. container/registry/run.sh

echo ""
echo "Initialising Gogs containers."
. container/gogs/volumes.sh
. container/gogs/run.sh

echo ""
echo "Initialising Jenkins containers."
. container/jenkins/volumes.sh
. container/jenkins/run.sh

echo ""
echo "Initialising Toran Proxy containers."
. container/toran-proxy/volumes.sh
. container/toran-proxy/run.sh

popd > /dev/null
