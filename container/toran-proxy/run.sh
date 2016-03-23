#! /bin/bash

docker run \
	--name "toran-proxy"\
	-d \
	--restart always \
	--volumes-from "toran-proxy-data" \
	-e TORAN_CRON_TIMER=minutes
	-e VIRTUAL_HOST=toran.davidjbingham.co.uk \
	-e VIRTUAL_PORT=8080 \
	-e LETSENCRYPT_HOST=toran.davidjbingham.co.uk \
	-e LETSENCRYPT_EMAIL=davidjohnbingham@gmail.com \
	cedvan/toran-proxy
