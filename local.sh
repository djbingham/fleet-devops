#! /bin/bash

TASK=$1
DOMAIN=$2

if [ $TASK == "" ]; then
	echo "A task is required as the first argument"
elif [ $DOMAIN == "" ]; then
	echo "A domain is required as the second argument"
fi

echo ""
echo "-- Setting config."
. config.sh

echo ""
echo "-- Running script $TASK.sh."

pushd /tmp/containers > /dev/null
. $TASK.sh
popd > /dev/null

echo ""
echo "-- /script $TASK.sh."
echo ""
