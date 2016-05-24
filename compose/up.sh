#! /usr/bin/bash

pushd "$( dirname "${BASH_SOURCE[0]}" )" > /dev/null

. gogs/up.sh
. jenkins/up.sh
. registry/up.sh
. reverse-proxy/up.sh
. toran-proxy/up.sh

popd > /dev/null
