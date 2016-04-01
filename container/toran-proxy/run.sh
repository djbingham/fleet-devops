#! /bin/bash

docker pull cedvan/toran-proxy

# Toran-Proxy data volume.
if [ ! "$(docker ps -a --filter 'name=toran-proxy-data')" == "" ]; then
	docker run \
		--name "toran-proxy-data" \
		-v /data/toran-proxy \
	    --entrypoint /bin/true \
		cedvan/toran-proxy
fi

# Toran-Proxy.
docker run \
	--name "toran-proxy"\
	-d \
	--restart always \
	--volumes-from "toran-proxy-data" \
	-e TORAN_CRON_TIMER=minutes \
	-e VIRTUAL_HOST="$TORAN_DOMAIN" \
	-e VIRTUAL_PORT=8080 \
	-e LETSENCRYPT_HOST="$TORAN_DOMAIN" \
	-e LETSENCRYPT_EMAIL="$SSL_EMAIL" \
	cedvan/toran-proxy
