#! /bin/bash

HOST=$1
TASK=$2
if [ "$3" == "" ]; then
	DOMAIN=$(echo $HOST | sed -e 's/^.*\@//')
else
	DOMAIN=$3
fi

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
	DOMAIN=$DOMAIN

	echo ""
	echo "-- Unpacking scripts on host."
	mkdir /tmp/containers
	tar -xf /tmp/containers.tar -C /tmp/containers

	pushd /tmp/containers > /dev/null
	. local.sh $TASK $DOMAIN
	popd > /dev/null

	echo "-- Removing scripts from host."
	rm -rf /tmp/containers.tar /tmp/containers
ENDSSH

echo "-- Removing compressed files from source."
rm containers.tar

echo "-- Deployment complete."
