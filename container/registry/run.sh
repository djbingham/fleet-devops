#! /bin/bash

docker pull registry

# Web accessible container (ports 80 and 443) required on registry domain for let's encrypt certificate generation.
docker run \
    --name "registry-web" \
    -d \
    --restart always \
    --expose 80 \
    --expose 443 \
    --volumes-from "proxy-data" \
	-e VIRTUAL_HOST="$REGISTRY_DOMAIN" \
	-e LETSENCRYPT_HOST="$REGISTRY_DOMAIN" \
	-e LETSENCRYPT_EMAIL="$SSL_EMAIL" \
    nginx

# Docker registry.
docker run \
    --name "registry" \
    -d \
    --restart always \
    -p 5000:5000 \
    --volumes-from "registry-data" \
    -e REGISTRY_HTTP_TLS_CERTIFICATE=/etc/nginx/certs/docker.$DOMAIN.crt \
    -e REGISTRY_HTTP_TLS_KEY=/etc/nginx/certs/docker.$DOMAIN.key \
    -e REGISTRY_HTTP_SECRET=my_registry_secret_1343y57134134141ml9 \
    registry:2
