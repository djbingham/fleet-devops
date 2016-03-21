#! /bin/bash

pushd "$( dirname "${BASH_SOURCE[0]}" )/.." > /dev/null

echo ""
echo "Copying resources to user home directory."
cp -r resources /home/core/resources

echo ""
echo "Initialising reverse-proxy containers."
. container/reverseProxy/volumes.sh
. container/reverseProxy/run.sh

echo ""
echo "Initialising Docker registry containers."
. container/dockerRegistry/volumes.sh
. container/dockerRegistry/run.sh

echo ""
echo "Initialising Gogs containers."
. container/gogs/volumes.sh
. container/gogs/run.sh

echo ""
echo "Initialising Jenkins containers."
. container/jenkins/volumes.sh
. container/jenkins/run.sh

popd > /dev/null
