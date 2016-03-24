#! /bin/bash

docker run \
	--name "toran-proxy-data" \
	-v /data/toran-proxy \
    --entrypoint /bin/true \
	cedvan/toran-proxy
