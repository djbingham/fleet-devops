#! /bin/bash

ssh -T $HOST <<ENDSSH
	echo ""
	echo "-- Stopping containers"
	echo ""
	docker ps -aq | xargs docker stop

	echo ""
	echo "-- Removing containers"
	echo ""
	docker ps -aq | xargs docker rm -v

	echo ""
	echo "-- Removing scripts"
	echo ""
	rm -rf containers containers.tar
ENDSSH

echo "-- Purge complete."
