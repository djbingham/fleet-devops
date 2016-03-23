#! /bin/bash

echo ""
echo "-- Starting reverse-proxy containers."
echo ""
. container/reverse-proxy/start.sh

echo ""
echo "-- Starting Docker registry containers."
echo ""
. container/registry/start.sh

echo ""
echo "-- Starting Gogs containers."
echo ""
. container/gogs/start.sh

echo ""
echo "-- Starting Jenkins containers."
echo ""
. container/jenkins/start.sh

echo ""
echo "-- Starting Toran Proxy containers."
echo ""
. container/toran-proxy/start.sh
