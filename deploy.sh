#! /bin/bash

echo ""
echo "-- Compacting scripts."
tar -cf containers.tar ./*

echo ""
echo "-- Uploading scripts."
echo ""
scp containers.tar $HOST:/tmp/containers.tar
echo ""
echo "-- /Uploading scripts."
echo ""

ssh -T $HOST <<ENDSSH
	echo ""
	echo "-- Unpacking scripts on host."
	mkdir /tmp/containers
	tar -xf /tmp/containers.tar -C /tmp/containers

	echo ""
	echo "-- Running init.sh."

	pushd /tmp/containers > /dev/null
	. task/init.sh
	popd > /dev/null

	echo ""
	echo "-- /Running init.sh."
	echo ""

	echo "-- Removing scripts from host."
	rm -rf /tmp/containers.tar /tmp/containers
ENDSSH

echo "-- Removing compressed files from source."
rm containers.tar

echo "-- Deployment complete."
