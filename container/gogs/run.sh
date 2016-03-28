#! /bin/bash

cp -r resource/gogs /home/core/resource/gogs

docker pull gogs/gogs

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
