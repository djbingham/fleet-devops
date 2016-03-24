#! /bin/bash

# Volume for SSL certificates
docker run \
    --name "proxy-encrypt-data" \
    -v /etc/nginx/certs \
    --entrypoint /bin/true \
    nginx

# Volumes for Nginx proxy
docker run \
    --name "proxy-data" \
    -v /etc/nginx/conf.d  \
    -v /etc/nginx/vhost.d \
    -v /usr/share/nginx/html \
	--entrypoint /bin/true \
    nginx
