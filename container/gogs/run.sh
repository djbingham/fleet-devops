#! /bin/bash

# Gogs git repository.
docker run \
	--name "gogs" \
	-d \
    --restart always \
	--volumes-from "gogs-data" \
	-p 2200:22 \
	-e VIRTUAL_HOST=git.davidjbingham.co.uk \
	-e VIRTUAL_PORT=3000 \
	-e LETSENCRYPT_HOST=git.davidjbingham.co.uk \
	-e LETSENCRYPT_EMAIL=davidjohnbingham@gmail.com \
	gogs/gogs
