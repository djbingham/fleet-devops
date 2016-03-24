#! /bin/bash

docker run \
	--name "toran-proxy"\
	-d \
	--restart always \
	--volumes-from "toran-proxy-data" \
	-e TORAN_CRON_TIMER=minutes \
	-e VIRTUAL_HOST="$TORAN_DOMAIN" \
	-e VIRTUAL_PORT=8080 \
	cedvan/toran-proxy
