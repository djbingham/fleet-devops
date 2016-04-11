#! /bin/bash

HOST=$1
TASK=$2
if [ "$3" == "" ]; then
	DOMAIN=$(echo $HOST | sed -e 's/^.*\@//')
else
	DOMAIN=$3
fi

. config.sh

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
	# Transfer variables into host
	DOMAIN=$DOMAIN
	SCRIPTS_FOLDER=$SCRIPTS_FOLDER

	echo ""
	echo "-- Preparing scripts folder on host."
	[[ -d $SCRIPTS_FOLDER ]] && rm -rf $SCRIPTS_FOLDER
	mkdir $SCRIPTS_FOLDER

	echo ""
	echo "-- Unpacking scripts on host."
	tar -xf /tmp/containers.tar -C $SCRIPTS_FOLDER

	pushd $FOLDER > /dev/null
	. local.sh $TASK $DOMAIN
	popd > /dev/null

	echo "-- Removing scripts from host."
	rm -rf /tmp/containers.tar
ENDSSH

echo "-- Removing compressed files from source."
rm containers.tar

echo "-- Deployment complete."
