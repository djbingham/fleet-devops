#! /usr/bin/bash

function readArguments {
	declare -g COMMAND
	declare -g -A NAMED_ARGUMENTS
	declare -g UNNAMED_ARGUMENTS

	local key
	local name
	local value

	while [[ $# > 0 ]]
	do
		key=$1
		shift
		case $key in
			--*=*)
				name=${key%=*}
				name=${name#--}
				value=${key#*=}
				NAMED_ARGUMENTS["$name"]="${value}"
				;;
			*)
				if [ "$TASK" == "" ]; then
					COMMAND="$key"
				elif [ "$ARGUMENTS" == "" ]; then
					UNNAMED_ARGUMENTS="$key"
				else
					UNNAMED_ARGUMENTS="$ARGUMENTS $key"
				fi
				;;
		esac
	done
}
