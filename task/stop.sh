#! /bin/bash

echo ""
echo "-- Stopping reverse-proxy containers."
echo ""
. container/reverse-proxy/stop.sh

echo ""
echo "-- Stopping Docker registry containers."
echo ""
. container/registry/stop.sh

echo ""
echo "-- Stopping Gogs containers."
echo ""
. container/gogs/stop.sh

echo ""
echo "-- Stopping Jenkins containers."
echo ""
. container/jenkins/stop.sh

echo ""
echo "-- Stopping Toran Proxy containers."
echo ""
. container/toran-proxy/stop.sh
