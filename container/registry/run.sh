#! /bin/bash

# Web accessible container (ports 80 and 443) required on registry domain for let's encrypt certificate generation.
docker run \
    --name "registry-web" \
    -d \
    --restart always \
    --expose 80 \
    --expose 443 \
    --volumes-from "proxy-data" \
	-e VIRTUAL_HOST=docker.davidjbingham.co.uk \
	-e LETSENCRYPT_HOST=docker.davidjbingham.co.uk \
	-e LETSENCRYPT_EMAIL=davidjohnbingham@gmail.com \
    nginx

# Docker registry.
docker run \
    --name "registry" \
    -d \
    --restart always \
    -p 5000:5000 \
    --volumes-from "registry-data" \
    -e REGISTRY_HTTP_TLS_CERTIFICATE=/etc/nginx/certs/docker.davidjbingham.co.uk.crt \
    -e REGISTRY_HTTP_TLS_KEY=/etc/nginx/certs/docker.davidjbingham.co.uk.key \
    -e REGISTRY_HTTP_SECRET=my_registry_secret_1343y57134134141ml9 \
    registry:2
