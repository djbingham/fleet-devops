#! /usr/bin/bash

docker_compose_version="1.6.2"

pushd "$( dirname "${BASH_SOURCE[0]}" )" > /dev/null

. install/bashrc.sh
. install/docker-compose.sh
. install/docker-bash-completion.sh
. install/ssh-key.sh

popd > /dev/null
