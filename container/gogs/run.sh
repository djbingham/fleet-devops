#! /bin/bash

if [ ! -d "/home/core/resource" ]; then
	mkdir /home/core/resource
fi
cp -r resource/gogs /home/core/resource

docker pull gogs/gogs

# Gogs data volume.
if [ ! "$(docker ps -a --filter 'name=gogs-data')" == "" ]; then
	docker run \
	    --name "gogs-data" \
	    --entrypoint /bin/true \
	    gogs/gogs
fi

# Gogs git repository.
docker run \
	--name "gogs" \
	-d \
    --restart always \
	--volumes-from "gogs-data" \
	-v /home/core/resource/gogs/app.ini:/data/gogs/conf/app.ini:ro \
	-p 2200:22 \
	-e VIRTUAL_HOST="$GOGS_DOMAIN" \
	-e VIRTUAL_PORT="3000" \
	-e LETSENCRYPT_HOST="$GOGS_DOMAIN" \
	-e LETSENCRYPT_EMAIL="$SSL_EMAIL" \
	gogs/gogs
