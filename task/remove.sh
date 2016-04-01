#! /bin/bash

echo ""
echo "-- Removing reverse-proxy containers."
echo ""
. container/reverse-proxy/remove.sh

echo ""
echo "-- Removing Docker registry containers."
echo ""
. container/registry/remove.sh

echo ""
echo "-- Removing Gogs containers."
echo ""
. container/gogs/remove.sh

echo ""
echo "-- Removing Jenkins containers."
echo ""
. container/jenkins/remove.sh

echo ""
echo "-- Removing Toran Proxy containers."
echo ""
. container/toran-proxy/remove.sh
