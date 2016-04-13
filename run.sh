#! /usr/bin/bash

# This script will run any other bash script in this project.
# The first unnamed argument must be the name of the command script to execute.
# The command should be a path to a bash script, excluding the ".sh" extension).
# Any remaining unnamed arguments will be passed through to the task that is run, in the exact format and order given.
# Named arguments will be read and assigned to variables by this script.
# Variables assigned by this script will be available to the command script.

pushd "$( dirname "${BASH_SOURCE[0]}" )" > /dev/null

. ./bash-functions/readArguments.sh

readArguments $@

# Assert that a command has been passed
if [ "$COMMAND" == "" ]; then
	echo "A command is required."
	exit 1
fi

# Set defaults for optional named arguments
HOST=""
HOST_DIR="/home/core/containers"

# Override defaults for any optional arguments provided
[[ "${NAMED_ARGUMENTS['host']}" == "" ]] || HOST="${NAMED_ARGUMENTS['host']}"
[[ "${NAMED_ARGUMENTS['hostDir']}" == "" ]] || HOST_DIR="${NAMED_ARGUMENTS['hostDir']}/containers"

if [ "$HOST" == "" ]; then
	(
		. config.sh
		pushd $HOST_DIR > /dev/null
		. $COMMAND.sh $UNNAMED_ARGUMENTS
		popd > /dev/null
	)
else
	(
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
			HOST_DIR=$HOST_DIR
			NAMED_ARGUMENTS=$NAMED_ARGUMENTS
			UNNAMED_ARGUMENTS=$UNNAMED_ARGUMENTS

			echo ""
			echo "-- Preparing scripts folder on host."
			[[ -d $HOST_DIR ]] && rm -rf $HOST_DIR
			mkdir $HOST_DIR

			echo ""
			echo "-- Unpacking scripts on host."
			tar -xf /tmp/containers.tar -C $HOST_DIR

			pushd $HOST_DIR > /dev/null
			. config.sh
			. $COMMAND.sh $UNNAMED_ARGUMENTS
			popd > /dev/null

			echo "-- Removing scripts from host."
			rm -rf /tmp/containers.tar
ENDSSH

		echo "-- Removing compressed files from source."
		rm containers.tar

		echo "-- Deployment complete."
	)
fi

popd > /dev/null
