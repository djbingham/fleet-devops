#! /bin/bash

# Gogs git repository.
docker run \
	--name "gogs" \
	-d \
    --restart always \
	--volumes-from "gogs-data" \
	-p 2200:22 \
	-e VIRTUAL_HOST="$GOGS_DOMAIN" \
	-e VIRTUAL_PORT="3000" \
	gogs/gogs
