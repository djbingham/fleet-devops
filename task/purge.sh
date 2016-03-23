#! /bin/bash

echo ""
echo "-- Stopping containers"
echo ""
docker ps -aq | xargs docker stop

echo ""
echo "-- Removing containers"
echo ""
docker ps -aq | xargs docker rm -v

echo ""
echo "-- Purge complete."
echo ""
