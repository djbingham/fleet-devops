#! /bin/bash

pushd "$( dirname "${BASH_SOURCE[0]}" )/.." > /dev/null

echo ""
echo "Initialising reverse-proxy containers."
. container/reverse-proxy/run.sh

echo ""
echo "Initialising Docker registry containers."
. container/registry/run.sh

echo ""
echo "Initialising Gogs containers."
. container/gogs/run.sh

echo ""
echo "Initialising Jenkins containers."
. container/jenkins/run.sh

echo ""
echo "Initialising Toran Proxy containers."
. container/toran-proxy/run.sh

echo ""
echo "Configuring Jenkins containers."
. container/jenkins/configure.sh

popd > /dev/null
